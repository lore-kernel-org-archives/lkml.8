Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FE3C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C77D21775
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xB4h7JJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgHTIOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgHTIMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:12:25 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A464C061383
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 01:12:24 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w2so596436edv.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 01:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ao9uhoBJZm/xzm5bKKTXsoRUgxvi4hYl2frDiL3p6Ek=;
        b=xB4h7JJ1N0TNQ7ccwTGda/uwX30dzaQW5NnWf9el3AW1DeORgfo/iTGZKpfEwQEPvt
         c7s/4IUb5KoXBSEeXZvDxPOlRAWuUk8TM1jwTHF7o2GOnWL5GWu8fuPlOuzqT9Ex3skL
         5jEB/TK0abmd+6njhUP775D+frBCR05Jh4GVD+JKevh5caE3bd+nmi6J1wHVGlzLGMHs
         /UNOdQhM7Ar6nWoOkar4YsGJgi4X/xGiE6/tIwV7CFpBSIeqtC05CLJbECjcu8MHhfJp
         QA64/dur1Ik+ACO9OTnFizYfhlYFn5sgHOeQ+WO8ZI3JRkxbWB0kPaphZ807rAGVTN8Q
         BnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ao9uhoBJZm/xzm5bKKTXsoRUgxvi4hYl2frDiL3p6Ek=;
        b=lH+KtpEmTL0fzstOhR/sVXDAJu3KkpgxugN+eJbqP+M+sz7WcNB1OAsHjHyHEZ6Q0g
         esyml9NkW/LAm63eqvcTHBdvMVHzKLtm/q/Rr4UaVwk5nnF/QDukwnsklLsitrxglqEl
         Q0D6I+PjYwmAaCLgnYx6D6Kbt9Cbo3QyU+vIIb1pExxKQGyJMPt26qmvr3VVoUT/WCYk
         93Vmv2TaFxwFYawcX4UtoOJ1Xd+hTgBtN2wHDvF90c5za073KwVmmjX7jyUnmxLIjh6d
         TCXJquIa/8KMRTSF/6ppvsmWX+CVJC4re/Iz318rCEbRl52VpJhJJ0O4do2XoP9StU9j
         xIbg==
X-Gm-Message-State: AOAM531Dl3VwzUq1rmnxUSkQAsflPFrO1n2GS3AKHR/70nckp5STUwEQ
        /QnGn7yPXe/U8JjD2jtb6o43OLPC3nCisxrAhLCbgQ==
X-Google-Smtp-Source: ABdhPJxcdsGXyoTp69C+mH9LjdkzFmHGs/y3HoUdXM9GRe6Aie7IX6MMciYGWBoZES0c7c6DY7NSnyYyR3qa9d3C274=
X-Received: by 2002:a05:6402:17c2:: with SMTP id s2mr1739529edy.188.1597911142916;
 Thu, 20 Aug 2020 01:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200818111057.19755-1-tingwei@codeaurora.org>
In-Reply-To: <20200818111057.19755-1-tingwei@codeaurora.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Thu, 20 Aug 2020 09:12:12 +0100
Message-ID: <CAJ9a7VjCX1Gmw0b8rTK8extrc6_mmbRn2BRXNK-+sSN9_6BMtw@mail.gmail.com>
Subject: Re: [PATCH] coresight: cti: disclaim device only when it's claimed
To:     Tingwei Zhang <tingwei@codeaurora.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 at 12:11, Tingwei Zhang <tingwei@codeaurora.org> wrote:
>
> Coresight_claim_device() is called in cti_starting_cpu() only
> when CTI is enabled while coresight_disclaim_device() is called
> uncontionally in cti_dying_cpu(). This triggered below WARNING.
> Only call disclaim device when CTI device is enabled to fix it.
>
> [   75.989643] WARNING: CPU: 1 PID: 14 at
> kernel/drivers/hwtracing/coresight/coresight.c:209
> coresight_disclaim_device_unlocked+0x10/0x24
> [   75.989697] CPU: 1 PID: 14 Comm: migration/1 Not tainted
> 5.9.0-rc1-gff1304be0a05-dirty #21
> [   75.989709] Hardware name: Thundercomm Dragonboard 845c (DT)
> [   75.989737] pstate: 80c00085 (Nzcv daIf +PAN +UAO BTYPE=--)
> [   75.989758] pc : coresight_disclaim_device_unlocked+0x10/0x24
> [   75.989775] lr : coresight_disclaim_device+0x24/0x38
> [   75.989783] sp : ffff800011cd3c90
> .
> [   75.990018] Call trace:
> [   75.990041]  coresight_disclaim_device_unlocked+0x10/0x24
> [   75.990066]  cti_dying_cpu+0x34/0x4c
> [   75.990101]  cpuhp_invoke_callback+0x84/0x1e0
> [   75.990121]  take_cpu_down+0x90/0xe0
> [   75.990154]  multi_cpu_stop+0x134/0x160
> [   75.990171]  cpu_stopper_thread+0xb0/0x13c
> [   75.990196]  smpboot_thread_fn+0x1c4/0x270
> [   75.990222]  kthread+0x128/0x154
> [   75.990251]  ret_from_fork+0x10/0x18
>
> Fixes: e9b880581d55 ("coresight: cti: Add CPU Hotplug handling to CTI driver")
> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> ---
>  drivers/hwtracing/coresight/coresight-cti.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
> index 3ccc703dc940..d6fea6efec71 100644
> --- a/drivers/hwtracing/coresight/coresight-cti.c
> +++ b/drivers/hwtracing/coresight/coresight-cti.c
> @@ -742,7 +742,8 @@ static int cti_dying_cpu(unsigned int cpu)
>
>         spin_lock(&drvdata->spinlock);
>         drvdata->config.hw_powered = false;
> -       coresight_disclaim_device(drvdata->base);
> +       if (drvdata->config.hw_enabled)
> +               coresight_disclaim_device(drvdata->base);
>         spin_unlock(&drvdata->spinlock);
>         return 0;
>  }
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
>
Reviewed-by: Mike Leach <mike.leach@linaro.org>

-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
