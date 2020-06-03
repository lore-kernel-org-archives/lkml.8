Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B9BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7BCD2053B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n4OmWpRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgFCRoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgFCRo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:44:29 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984DEC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 10:44:29 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e9so2213768pgo.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 10:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jq/XMCu8C1tBnhihgN8ovqZ4K39bLgFUtiV401gBtko=;
        b=n4OmWpRd0KqGc/av3cLu3mkKaDuyVkxfyBJv0Wou/E6+ulN06HRx90pStlf/XT8Fxm
         fLLo06uUWRUfGVUrvhykXlwLhVhqwSdEmnyYjAOyVBi0HcCG+gUJwRVsSEF10Ag01ocY
         K9HpjUho6PLw14i3tEynLMyHPLH1DE5/cRKRl7xTFIZoSUcWbknjFI9GPcFDUztUmlHK
         FQYJvgMFS+wV8csnxqHRm1j8HL3N39hm2Ep2XqT5bMw/QBRtrMBVos08vA3n0/pp8VBy
         o0hyo3J/r0Y4aftMlIInLxhJCtOq6ihq6WdXPODi6c/PAV3+soEvVNYIJlnoMUix3M9R
         rO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jq/XMCu8C1tBnhihgN8ovqZ4K39bLgFUtiV401gBtko=;
        b=Xfpsl71vgtwkhzN1NfGR6RYlOjci6L0Hd1lTWn3lQO7Cv440mNYvWfQdsaj/lSoxYZ
         PXYTctW5Mx7sRvq9SasJcQHIgwBQ6DtBeq5nrVGA2SktSl/ync3/luoVWS0D49SCXly6
         UXdObu3hfMZA+63EBxrixqO4XUsrcRFCUaTAMNNwA07lccUdfMNugDZ15EZ6MWh27Lrd
         lsLQ4P+mYEPGpxmP8rq5d4QdryUPyj9r9B4RC/yMzWo3PL/Umdk2QFRttEbNbrEo8KSE
         I2vtbcsRTvfM379uC+HnxaYfgLss1QEUKuGovs+CoD0hhmw/NQPegcoQv/RzAL80zTCO
         lwtw==
X-Gm-Message-State: AOAM531LktyznISNN0Kd8ctMB0Jn2QX8QEuVJoTz/Vl3rZ/FcOc3rTef
        phB28s7KgFjCUkAwZ0Zx7uEmIhzv2og=
X-Google-Smtp-Source: ABdhPJzdyI4/XC8yusU4a6nrAdgweku9ER1s7t/uGLDl/DV7BBjH+O2YCLYp+G3uOF/1M+P7fOJY/Q==
X-Received: by 2002:aa7:8dc7:: with SMTP id j7mr245043pfr.169.1591206268980;
        Wed, 03 Jun 2020 10:44:28 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m12sm3153473pjs.41.2020.06.03.10.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 10:44:28 -0700 (PDT)
Date:   Wed, 3 Jun 2020 11:44:26 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Mike Leach <mike.leach@linaro.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 2/2] coresight: tmc: Add shutdown callback for TMC ETR/ETF
Message-ID: <20200603174426.GA23165@xps15>
References: <cover.1590947174.git.saiprakash.ranjan@codeaurora.org>
 <28123d1e19f235f97555ee36a5ed8b52d20cbdea.1590947174.git.saiprakash.ranjan@codeaurora.org>
 <20200601212858.GB24287@xps15>
 <6d759cc28628ea72767c1304883630eb@codeaurora.org>
 <CAJ9a7VhMbdqVBHxEXGYxFkgPnnQqNnDAz=wkHP3s7Ntw0iLmKA@mail.gmail.com>
 <f0357072de96970b641bbd0da98c1d61@codeaurora.org>
 <CAJ9a7Vj9STJw4jBxWU_9wHftj4Q7+k8o1nTc8tr21KjYi0RkpQ@mail.gmail.com>
 <4a09cd2e054836d85f2e024ca4435e91@codeaurora.org>
 <CAJ9a7VgCFeHNbY_9Gwvu6uT9MFBeY=_GCaN4N1dwmm+iNpfJOw@mail.gmail.com>
 <1a5a6a6d-b86d-df45-cf91-7081e70d88a3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a5a6a6d-b86d-df45-cf91-7081e70d88a3@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 02:34:10PM +0100, Robin Murphy wrote:
> On 2020-06-03 14:22, Mike Leach wrote:
> > Hi Sai,
> > 
> > On Wed, 3 Jun 2020 at 13:14, Sai Prakash Ranjan
> > <saiprakash.ranjan@codeaurora.org> wrote:
> > > 
> > > Hi Mike,
> > > 
> > > On 2020-06-03 16:57, Mike Leach wrote:
> > > > Hi,
> > > > 
> > > > On Wed, 3 Jun 2020 at 11:24, Sai Prakash Ranjan
> > > > <saiprakash.ranjan@codeaurora.org> wrote:
> > > > > 
> > > > > Hi Mike,
> > > > > 
> > > > > Thanks again for looking at this.
> > > > > 
> > > > > On 2020-06-03 03:42, Mike Leach wrote:
> > > > > [...]
> > > > > 
> > > > > > > 
> > > > > > > SMMU/IOMMU won't be able to do much here as it is the client's
> > > > > > > responsiblity to
> > > > > > > properly shutdown and SMMU device link just makes sure that
> > > > > > > SMMU(supplier) shutdown is
> > > > > > > called only after its consumers shutdown callbacks are called.
> > > > > > 
> > > > > > I think this use case can be handled slightly differently than the
> > > > > > general requirements for modular CoreSight drivers.
> > > > > > 
> > > > > > What is needed here is a way of stopping the underlying ETR hardware
> > > > > > from issuing data to the SMMU, until the entire device has been shut
> > > > > > down, in a way that does not remove the driver, breaking existing
> > > > > > references and causing a system crash.
> > > > > > 
> > > > > > We could introduce a new mode to the ETR driver - e.g.
> > > > > > CS_MODE_SHUTDOWN.
> > > > > > 
> > > > > > At the end of the block tmc_shutdown(struct amba_device *adev), set
> > > > > > drvdata->mode to CS_MODE_SHUTDOWN & remove the coresight_unregister().
> > > > > > This new mode can be used to  prevent the underlying hardware from
> > > > > > being able to restart until the device is re-powered.
> > > > > > 
> > > > > > This mode can be detected in the code that enables / disables the ETR
> > > > > > and handled appropriately (updates to tmc_enable_etr_sink and
> > > > > > tmc_disable_etr_sink).
> > > > > > This mode will persist until the device is re-started - but because we
> > > > > > are on the device shutdown path this is not an issue.
> > > > > > 
> > > > > > This should leave the CoreSight infrastructure stable until the
> > > > > > drivers are shut down normally as part of the device power down
> > > > > > process.
> > > > > > 
> > > > > 
> > > > > Sounds good to me, but if the coresight_unregister() is the trouble
> > > > > point
> > > > > causing these crashes, then can't we just remove that from
> > > > > tmc_shutdown()
> > > > > callback? This would be like maintaining the same behaviour as now
> > > > > where
> > > > > on reboot/shutdown we basically don't do anything except for disabling
> > > > > ETR.
> > > > 
> > > > No - the new mode prevents race conditions where the thread shutting
> > > > down the SMMU does the ETR shutdown, but then another thread happens
> > > > to be trying to start trace and restarts the ETR.
> > > > It also prevents the condition Mathieu discussed where a thread might
> > > > be attempting to shutdown trace - this could try to disable the
> > > > hardware again re-releasing resources/ re-flushing and waiting for
> > > > stop.
> > > > 
> > > 
> > > I do not think there will a race between SMMU shutdown and ETR shutdown.
> > > Driver core takes care of calling SMMU shutdown after its consumer
> > > shutdown callbacks via device link, otherwise there would already be
> > > bugs in all other client drivers.
> > > 
> > 
> > I am not saying there could be a race between tmc_shutdowm and
> > Smmu_shutdown - there may be a case if the coresight_disable_path
> > sequence is running and gets to the point of disabling the ETR after
> > the SMMU callback has disabled it.
> 
> I'm confused now - there is no "SMMU callback", we're talking about the
> system-wide cleanup from kernel_shutdown_prepare() or
> kernel_restart_prepare(). As far as I'm aware userspace should be long gone
> by that point, so although trace may have been left running, the chance of
> racing against other driver operations seems pretty unlikely.

Robin has a point - user space is long gone at this time.  As such the first 
question to ask is what kind of CS session was running at the time the system
was shutting down.  Was it a perf session of a sysfs session?

I'm guessing it was a sysfs session because user space has been blown away a
while back and part of that process should have killed all perf sessions.

If I am correct then simply switching off the ETR HW in the shutdown() amba bus
callback should be fine - otherwise Mike's approach is mandatory.  There is 
also the exchange between Robin and Sai about removing the SMMU shutdown
callback, but that thread is still incomplete. 

Thanks,
Mathieu

> 
> Robin.
