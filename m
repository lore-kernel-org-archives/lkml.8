Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472B4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BB9A24655
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S1BxwFk1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgAWL1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:27:16 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40301 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAWL1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:27:15 -0500
Received: by mail-pf1-f196.google.com with SMTP id q8so1402110pfh.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 03:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=23Kori0Gfe9jOVOSUcpuHeH/VuCobIg4HsEBeoKpTcQ=;
        b=S1BxwFk16LfetRAqa0xbnN8dmEDW8TfeJvGPGJ3HzwW6EGkA1O4xcEukXhL+Lm+nha
         a8Cat4SC+RLR4kTDPllxAO3BDP2yEW05ADEDeDFKpUbNkNYLySWUZCSVEN2sDl1RLRZ0
         XdgFD9S1Sko7YJWDDgF7HtdSWLu/wXLWkS8WJdOxRaP1VoMiqbfKXn4w4VV8w1jZTZSE
         iDIf22PKz2Q+JvckiEoUBwW8g6cfdUSvcKnjVA9AJS8fBX54fmF7TGvc81TLsqqXjOWL
         B5D/eePQZ0NHYQcZYMJSb4Xx7i5Tbl1LUlwt4FVOHcQr9UtOEvjS935/AHuO0reivjIb
         jpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=23Kori0Gfe9jOVOSUcpuHeH/VuCobIg4HsEBeoKpTcQ=;
        b=SSt2fu93FJw4fagwKDPXC4NEI2FhDYersom4P1u5MtnOf4aklF6aJq2UQlCQQMpTqH
         lv1X62t1eV4Pjrwwk7R1a5Z5GlBFP2z8SXF4JOzh5nTJJxXZZO7Hr8H1Sp8wTY1Pcw48
         r6LM1gIhw5tJgctLLxLpxozrbheivW+4XYzZ/iKJ9As/ZwycxgtynMHSZQjPHC6kQJdR
         gPM6XHfHh50kDCQKNTWq8wNxNLYsXTjJ/YHRGRQrnh1ISlBAzQVQ1+d+NFk/j1hVfnhM
         5zD43BYfDmABuga1zrxGaWS7ORrdGaW+nwSdC0OiXjLIEXOLDwfvozSNmze2HNsKaEvK
         4TcA==
X-Gm-Message-State: APjAAAVrITS3Trx5ZA+pRFp/rsBJcg4cnmLKXknrOYHBQNw8KyTQ6CLW
        TGqWNDT2PEYoOWGPC/fVH8ueOw==
X-Google-Smtp-Source: APXvYqwFcaJ7cDsKUK568k6SWVVjcFL3dxY1Jxtf4pRha6JvGIBbMX6IW0bxP7CvbORMkaJwFafBTg==
X-Received: by 2002:a63:5f84:: with SMTP id t126mr3357593pgb.71.1579778834828;
        Thu, 23 Jan 2020 03:27:14 -0800 (PST)
Received: from localhost ([122.167.18.14])
        by smtp.gmail.com with ESMTPSA id b42sm2531675pjc.27.2020.01.23.03.27.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jan 2020 03:27:14 -0800 (PST)
Date:   Thu, 23 Jan 2020 16:57:11 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     arnd@arndb.de, jassisinghbrar@gmail.com, cristian.marussi@arm.com,
        peng.fan@nxp.com, peter.hilber@opensynergy.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V4] firmware: arm_scmi: Make scmi core independent of the
 transport type
Message-ID: <20200123112711.mggm7ayxcqnr54yf@vireshk-i7>
References: <20200121183818.GA11522@bogus>
 <a9ec58818b5e0c982810e74efe3f5f22b930ae40.1579660436.git.viresh.kumar@linaro.org>
 <20200122121538.GA31240@bogus>
 <20200123103033.GA7511@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123103033.GA7511@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-20, 10:30, Sudeep Holla wrote:
> On Wed, Jan 22, 2020 at 12:15:38PM +0000, Sudeep Holla wrote:
> > On Wed, Jan 22, 2020 at 08:06:23AM +0530, Viresh Kumar wrote:
> >
> 
> [...]
> 
> > > Can you please help me getting this tested, now that I have rebased it
> > > as well :) ?
> > >
> >
> > Sure, I will give it a go on my Juno. Thanks for the rebase, makes it
> > simpler.
> >
> 
> Sorry for the delay. I gave this a spin on my Juno. I am seeing below
> warning once on boot but it continues and everything seem to work fine.
> Also the warning is not related to this change I believe and this patch
> is just helping to hit some corner case with deferred probe and devres.
> I need to spend some time to debug it.
> 
> Regards,
> Sudeep
> 
> --->8
> 
> WARNING: CPU: 1 PID: 187 at drivers/base/dd.c:519 really_probe+0x11c/0x418
> Modules linked in:
> CPU: 1 PID: 187 Comm: kworker/1:2 Not tainted 5.5.0-rc7-00026-gf7231cd3108d-dirty #20
> Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Jan 16 2020
> Workqueue: events deferred_probe_work_func
> pstate: 80000005 (Nzcv daif -PAN -UAO)
> pc : really_probe+0x11c/0x418
> lr : really_probe+0x10c/0x418
> Call trace:
>  really_probe+0x11c/0x418
>  driver_probe_device+0xe4/0x138
>  __device_attach_driver+0x90/0x110
>  bus_for_each_drv+0x80/0xd0
>  __device_attach+0xdc/0x160
>  device_initial_probe+0x18/0x20
>  bus_probe_device+0x98/0xa0
>  deferred_probe_work_func+0x90/0xe0
>  process_one_work+0x1ec/0x4a8
>  worker_thread+0x210/0x490
>  kthread+0x110/0x118
>  ret_from_fork+0x10/0x18
> ---[ end trace 06f96d55ce6093a8 ]---

Still it looks strange that the warning comes only after my patch :)

Should I send V5 (fixed few comments after reviews) now ?

-- 
viresh
