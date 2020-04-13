Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9B3C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 959A1206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gDWh6j14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732566AbgDMROY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727981AbgDMROW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:14:22 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1746C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:14:21 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d24so3606410pll.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 10:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=va2uPd7gyyI5OiovlTyEhOf6lRyi6dJtoYK2M5SWvPM=;
        b=gDWh6j14JvPT3UwCLGJEB581EJj/w7HBfF70Jt8j93xZ7zbCUBl1BGGp+O1blegZ5j
         ZNtL+VfX5FYPjsybQNTlZfkUzatyh84vpAt7L31U828RIgD9fkhhNEy8ZiUBUy6WtOYC
         2mGYOQzaSlbNaDIO4+bWLh+WlRGu56Sop0xyxcjoWKQV1ONe2xeOFIHJaTztAImHE2nQ
         ojpv0kKIUqCb340rPaFztaiQOM3ZYo3DT4JxHw3cNQp3812k1rIQN0PY+heJ69V8Sf+P
         oBbh721jD1bOs2dAAFNlaKKMKwZEWJZWcOnTNX9QMwBFjnjdFv4Cm8p/eUi961RH0K5z
         P/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=va2uPd7gyyI5OiovlTyEhOf6lRyi6dJtoYK2M5SWvPM=;
        b=S1Flp9gSPg7B2V8DfZaLoWWNw1Ow/WcXcQvEk0bdE7JTMlBbfMK+mLU7loez0CP/hN
         BVmflna4RbNQ3upIeFukAtaHwXehS44xbj96RZal2+HXBQgbR8MP5BmgyMOWtBjyX1sL
         o2jItmMAzRMnNCcWmtUBFwimegOfDntPIfQwqNAsCy3fC5OLPcqzTb79TXLs7+7sYep7
         pIReBujk08vz9hHc7Qq6sEm6sCKoTwu91NM+euZEaaW0ZUTg4e84GqHiFgrrUgpH596H
         6YUtzzx6dkIxeWeBaa/uU7UqjHB66ZxXEJUC9gv3wZyemBz03evGp79Xh8xt49k/bkL3
         USKw==
X-Gm-Message-State: AGi0PuZsLC/yZtqtC61mwKdNs7m4+B2trAq806/8TInSUqZVKVhckcex
        PA/+hhmKha9IQGEecKQOIQKHXA==
X-Google-Smtp-Source: APiQypIZZkrX9RIT+bliapkNwsQYSFqXGatRjoO5IhedqJDm2E4IrnHVkdqum/bKSYnJ+rvyhlol8Q==
X-Received: by 2002:a17:90a:890a:: with SMTP id u10mr14709181pjn.154.1586798061368;
        Mon, 13 Apr 2020 10:14:21 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id v24sm8978016pfm.94.2020.04.13.10.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 10:14:20 -0700 (PDT)
Date:   Mon, 13 Apr 2020 11:14:18 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>, mike.leach@linaro.org,
        swboyd@chromium.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] coresight: tmc: Read TMC mode only when TMC hw is enabled
Message-ID: <20200413171418.GB28804@xps15>
References: <20200409113538.5008-1-saiprakash.ranjan@codeaurora.org>
 <9a792e3e-5a17-156d-4b59-4a3ec8f9993e@arm.com>
 <1751aeabd22bee18d2eef0f643883265@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1751aeabd22bee18d2eef0f643883265@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 01:55:30PM +0530, Sai Prakash Ranjan wrote:
> Hi Suzuki,
> 
> On 2020-04-13 04:47, Suzuki K Poulose wrote:
> > Hi Sai,
> > 
> > On 04/09/2020 12:35 PM, Sai Prakash Ranjan wrote:
> > > Reading TMC mode register in tmc_read_prepare_etb without
> > > enabling the TMC hardware leads to async exceptions like
> > > the one in the call trace below. This can happen if the
> > > user tries to read the TMC etf data via device node without
> > > setting up source and the sink first which enables the TMC
> > > hardware in the path. So make sure that the TMC is enabled
> > > before we try to read TMC data.
> > 
> > So, one can trigger the same SError by simply :
> > 
> > $ cat /sys/bus/coresight/device/tmc_etb0/mgmt/mode
> > 
> 
> I do not see any SError when I run the above command.
> 
> localhost ~ # cat /sys/bus/coresight/devices/tmc_etf0/mgmt/mode
> 0x0
> 
> And this is most likely due to
> 
> commit cd9e3474bb793dc ("coresight: add PM runtime calls to
> coresight_simple_func()")

Ok, so this is related to power management (you can ignore my question in the
previous email).

Regarding function tmc_read_prepare_etb(), the best way to deal with this is
probably make sure drvdata->mode != CS_MODE_DISABLED before reading TMC_MODE.
If there is a buffer to read it will have been copied when the ETB was disabled
and there won't be a need to access the HW.

Mathieu

> 
> > And also :
> > 
> > > 
> > >   Kernel panic - not syncing: Asynchronous SError Interrupt
> > >   CPU: 7 PID: 2605 Comm: hexdump Tainted: G S                5.4.30
> > > #122
> > >   Call trace:
> > >    dump_backtrace+0x0/0x188
> > >    show_stack+0x20/0x2c
> > >    dump_stack+0xdc/0x144
> > >    panic+0x168/0x36c
> > >    panic+0x0/0x36c
> > >    arm64_serror_panic+0x78/0x84
> > >    do_serror+0x130/0x138
> > >    el1_error+0x84/0xf8
> > >    tmc_read_prepare_etb+0x88/0xb8
> > >    tmc_open+0x40/0xd8
> > >    misc_open+0x120/0x158
> > >    chrdev_open+0xb8/0x1a4
> > >    do_dentry_open+0x268/0x3a0
> > >    vfs_open+0x34/0x40
> > >    path_openat+0x39c/0xdf4
> > >    do_filp_open+0x90/0x10c
> > >    do_sys_open+0x150/0x3e8
> > >    __arm64_compat_sys_openat+0x28/0x34
> > >    el0_svc_common+0xa8/0x160
> > >    el0_svc_compat_handler+0x2c/0x38
> > >    el0_svc_compat+0x8/0x10
> > > 
> > > Fixes: 4525412a5046 ("coresight: tmc: making prepare/unprepare
> > > functions generic")
> > > Reported-by: Stephen Boyd <swboyd@chromium.org>
> > > Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > > ---
> > >   drivers/hwtracing/coresight/coresight-tmc.c | 5 +++++
> > >   drivers/hwtracing/coresight/coresight-tmc.h | 1 +
> > >   2 files changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/hwtracing/coresight/coresight-tmc.c
> > > b/drivers/hwtracing/coresight/coresight-tmc.c
> > > index 1cf82fa58289..7bae69748ab7 100644
> > > --- a/drivers/hwtracing/coresight/coresight-tmc.c
> > > +++ b/drivers/hwtracing/coresight/coresight-tmc.c
> > > @@ -62,11 +62,13 @@ void tmc_flush_and_stop(struct tmc_drvdata
> > > *drvdata)
> > >     void tmc_enable_hw(struct tmc_drvdata *drvdata)
> > >   {
> > > +	drvdata->enable = true;
> > >   	writel_relaxed(TMC_CTL_CAPT_EN, drvdata->base + TMC_CTL);
> > >   }
> > >     void tmc_disable_hw(struct tmc_drvdata *drvdata)
> > >   {
> > > +	drvdata->enable = false;
> > >   	writel_relaxed(0x0, drvdata->base + TMC_CTL);
> > >   }
> > >   @@ -102,6 +104,9 @@ static int tmc_read_prepare(struct tmc_drvdata
> > > *drvdata)
> > >   {
> > >   	int ret = 0;
> > >   +	if (!drvdata->enable)
> > > +		return -EINVAL;
> > > +
> > 
> > Does this check always guarantee that the TMC is enabled when
> > we actually get to reading the MODE ? This needs to be done
> > under the spinlock.
> > 
> 
> Ok I will make this change.
> 
> Thanks,
> Sai
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
