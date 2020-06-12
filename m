Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB1EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62C2C20792
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgFLMw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:52:56 -0400
Received: from foss.arm.com ([217.140.110.172]:35894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgFLMwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 08:52:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D4360D6E;
        Fri, 12 Jun 2020 05:52:54 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 258763F6CF;
        Fri, 12 Jun 2020 05:52:53 -0700 (PDT)
Date:   Fri, 12 Jun 2020 13:52:50 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        hsinyi@chromium.org, joelaf@google.com, peterz@infradead.org,
        drinkcat@chromium.org, gwendal@chromium.org, qperret@google.com,
        ctheegal@codeaurora.org, Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cros_ec_spi: Even though we're RT priority, don't bump
 cpu freq
Message-ID: <20200612125250.7bwjfnxhurdf5bwj@e107158-lin.cambridge.arm.com>
References: <20200610151818.1.I666ecd9c6f3c6405bd75831a21001b8109b6438c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200610151818.1.I666ecd9c6f3c6405bd75831a21001b8109b6438c@changeid>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/20 15:18, Douglas Anderson wrote:
> The cros_ec_spi driver is realtime priority so that it doesn't get
> preempted by other taks while it's talking to the EC but overall it
> really doesn't need lots of compute power.  Unfortunately, by default,
> the kernel assumes that all realtime tasks should cause the cpufreq to
> jump to max and burn through power to get things done as quickly as
> possible.  That's just not the correct behavior for cros_ec_spi.
> 
> Switch to manually overriding the default.
> 
> This won't help us if our work moves over to the SPI pump thread but
> that's not the common code path.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> NOTE: This would cause a conflict if the patch
> https://lore.kernel.org/r/20200422112831.870192415@infradead.org lands
> first
> 
>  drivers/platform/chrome/cros_ec_spi.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
> index debea5c4c829..76d59d5e7efd 100644
> --- a/drivers/platform/chrome/cros_ec_spi.c
> +++ b/drivers/platform/chrome/cros_ec_spi.c
> @@ -709,8 +709,11 @@ static void cros_ec_spi_high_pri_release(void *worker)
>  static int cros_ec_spi_devm_high_pri_alloc(struct device *dev,
>  					   struct cros_ec_spi *ec_spi)
>  {
> -	struct sched_param sched_priority = {
> -		.sched_priority = MAX_RT_PRIO / 2,
> +	struct sched_attr sched_attr = {
> +		.sched_policy	= SCHED_FIFO,
> +		.sched_priority	= MAX_RT_PRIO / 2,
> +		.sched_flags	= SCHED_FLAG_UTIL_CLAMP_MIN,
> +		.sched_util_min	= 0,

Hmm I thought Peter already removed all users that change RT priority directly.

https://lore.kernel.org/lkml/20200422112719.826676174@infradead.org/

>  	};
>  	int err;
>  
> @@ -728,8 +731,7 @@ static int cros_ec_spi_devm_high_pri_alloc(struct device *dev,
>  	if (err)
>  		return err;
>  
> -	err = sched_setscheduler_nocheck(ec_spi->high_pri_worker->task,
> -					 SCHED_FIFO, &sched_priority);
> +	err = sched_setattr_nocheck(ec_spi->high_pri_worker->task, &sched_attr);
>  	if (err)
>  		dev_err(dev, "Can't set cros_ec high pri priority: %d\n", err);
>  	return err;

If I read the code correctly, if you fail here cros_ec_spi_probe() will fail
too and the whole thing will not be loaded. If you compile without uclamp then
sched_setattr_nocheck() will always fail with -EOPNOTSUPP.

Why can't you manage the priority and boost value of such tasks via your init
scripts instead?

I have to admit I need to think about whether it makes sense to have a generic
API that allows drivers to opt-out of the default boosting behavior for their
RT tasks.

Thanks

--
Qais Yousef

> -- 
> 2.27.0.290.gba653c62da-goog
> 
