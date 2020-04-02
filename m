Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34CFC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8AA2074D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbgDBNyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:54:36 -0400
Received: from foss.arm.com ([217.140.110.172]:43028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731780AbgDBNyg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:54:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB18B30E;
        Thu,  2 Apr 2020 06:54:35 -0700 (PDT)
Received: from [10.57.59.199] (unknown [10.57.59.199])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC60E3F52E;
        Thu,  2 Apr 2020 06:54:33 -0700 (PDT)
Subject: Re: [PATCH] driver core: Use dev_warn() instead of dev_WARN() for
 deferred_probe_timeout warnings
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Basil Eljuse <Basil.Eljuse@arm.com>,
        Ferry Toth <fntoth@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>
References: <20200330202715.86609-1-john.stultz@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <63eb5197-a683-2103-9b7b-246949601ffd@arm.com>
Date:   Thu, 2 Apr 2020 14:54:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200330202715.86609-1-john.stultz@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-30 9:27 pm, John Stultz wrote:
> In commit c8c43cee29f6 ("driver core: Fix
> driver_deferred_probe_check_state() logic") and following
> changes the logic was changes slightly so that if there is no
> driver to match whats found in the dtb, we wait 30 seconds
> for modules to be loaded by userland, and then timeout, where
> as previously we'd print "ignoring dependency for device,
> assuming no driver" and immediately return -ENODEV after
> initcall_done.
> 
> However, in the timeout case (which previously existed but was
> practicaly un-used without a boot argument), the timeout message
> uses dev_WARN(). This means folks are now seeing a big backtrace
> in their boot logs if there a entry in their dts that doesn't
> have a driver.

I had always figured that timeout case somehow represented more of a 
definite failure than others, but if not then great! :)

> To fix this, lets use dev_warn(), instead of dev_WARN() to match
> the previous error path.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>

However, I do now wonder if we really need these two separate cases with 
subtly different messages - after all, giving up at init vs. giving up 
30 seconds later still represents some kind of timeout out either way. 
Given that there are at least 5 underlying situations with varying 
levels of certainty and severity:

- No driver loaded for dependency (yet, if CONFIG_MODULES)
- Driver present and dependency will be probed at some point in future
- Driver present but dependency will not be probed (e.g. disabled in DT)
- Dependency itself is deferred but will be re-probed at some point
- Dependency probed, explicitly failed and will not be retried

then I'm not sure there's much value in having two slightly different 
ways of saying "any of those may have happened".

Robin.

> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Basil Eljuse <Basil.Eljuse@arm.com>
> Cc: Ferry Toth <fntoth@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Anders Roxell <anders.roxell@linaro.org>
> Fixes: c8c43cee29f6 ("driver core: Fix driver_deferred_probe_check_state() logic")
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>   drivers/base/dd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 06ec0e851fa1..ca1652221c1a 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -267,7 +267,7 @@ int driver_deferred_probe_check_state(struct device *dev)
>   	}
>   
>   	if (!driver_deferred_probe_timeout) {
> -		dev_WARN(dev, "deferred probe timeout, ignoring dependency");
> +		dev_warn(dev, "deferred probe timeout, ignoring dependency");
>   		return -ETIMEDOUT;
>   	}
>   
> 
