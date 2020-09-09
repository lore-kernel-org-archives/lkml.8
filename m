Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E19C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 790DD2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zsDBJ8Ay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbgIIQgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730949AbgIIQ0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:26:11 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD0DC061799
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 09:26:08 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id v15so2438578pgh.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 09:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ur0jsYUj72BqgbcrHRQljmDeSLUciAGdL7rcnu/ICrQ=;
        b=zsDBJ8Ay5xaEkF/FfyJBAdmUhPz2eDWzkABSH82qTlpMEWaYpTT2gtQBJgT/fzb0EF
         lxWJEmQ3HpS5fT3HE19viHDtDsvzQEyKA8Vl3fE4xMpVC5iuvThEwRi8HGRozlN/ZgSp
         bhg3Vq5PdpT89gNH3fUstvcPJkBb5+8t/mgqnmKpoMMZjE3PpinxaceQG0xXRhGwuSDv
         Z0H2LjYjZFI+dzZiw2jgbJjX8sP7MMpNsYxIzqF7XD4Rfc5t8xrsyRFWT93zci7UhhhM
         hW/ElpGkiOj0Ht/KQMxW+MpHyykp08QUMz/gRSqgukZ+B3xMuC6APDIp/gdjwps3oNF9
         gtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ur0jsYUj72BqgbcrHRQljmDeSLUciAGdL7rcnu/ICrQ=;
        b=ttdfGz4ttvDEmA1LG7O5BRMEoiiZS5chnnGqCp4yO53WEdYCHTDznqPNuyzhwA2I2S
         KVy5i4bZwYjI/dQm6Mmkm3kkPEBHY1rTeMBl61iogHV2nxil3yQcVwP8Vg3Z0o2m2iqM
         LLrf6gFDi6HB5NyS65hnr80Gw1yoHg3HXMEzxTv+ZljvYdQ8iD5fNYXJdwCyG7d0y7Qt
         iAhWQVZ4n60tGod7ZUeiCzKvEskMvTG9NRV/mcFnNq+vw+xw6QrR+IcuJIAGTtXvsflI
         aV2rxK4AIRT/0c7dw5lRdIEdWqLEyIyEnbOc+zt1/+KZ26s7TqbMCOqOefp8bthTmbRU
         Yr7A==
X-Gm-Message-State: AOAM530n9hoq4cypYrDR8O5QMCMhnkvOWQpmcwdOof/GuMNavG9d5vhU
        LtNmnT4q7CYUoQmEB9GaPM9k2A==
X-Google-Smtp-Source: ABdhPJzKaRKjnDLDamt3CY34N5as3uDt3auHxWJf5YGeEbwYcQTt4fGMDRZ0NeG4OXqcnHq1AXXHvQ==
X-Received: by 2002:a17:902:b108:b029:d0:cbe1:e740 with SMTP id q8-20020a170902b108b02900d0cbe1e740mr1641016plr.27.1599668767760;
        Wed, 09 Sep 2020 09:26:07 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id gm17sm2388308pjb.46.2020.09.09.09.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 09:26:07 -0700 (PDT)
Date:   Wed, 9 Sep 2020 10:26:05 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>, liuqi115@huawei.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxarm@huawei.com, Coresight ML <coresight@lists.linaro.org>
Subject: Re: [RFC PATCH v2] coresight: etm4x: Modify core-commit of cpu to
 avoid the overflow of HiSilicon ETM
Message-ID: <20200909162605.GB553266@xps15>
References: <1597824397-29894-1-git-send-email-liuqi115@huawei.com>
 <20200827204426.GD22307@xps15>
 <548c973d-6964-ca5c-4c8d-fbc2386f3349@arm.com>
 <CAJ9a7Vh8r4q8sCJnOdrrONZpM42QNbMpZGiebXs-mGW=MgmM3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7Vh8r4q8sCJnOdrrONZpM42QNbMpZGiebXs-mGW=MgmM3Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 12:30:02PM +0100, Mike Leach wrote:
> Hi,
> 
> On Wed, 2 Sep 2020 at 11:36, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >
> > On 08/27/2020 09:44 PM, Mathieu Poirier wrote:
> > > Hi Liu,
> > >
> > > On Wed, Aug 19, 2020 at 04:06:37PM +0800, Qi Liu wrote:
> > >> When too much trace information is generated on-chip, the ETM will
> > >> overflow, and cause data loss. This is a common phenomenon on ETM
> > >> devices.
> > >>
> > >> But sometimes we do not want to lose performance trace data, so we
> > >> suppress the speed of instructions sent from CPU core to ETM to
> > >> avoid the overflow of ETM.
> > >>
> > >> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> > >> ---
> > >>
> > >> Changes since v1:
> > >> - ETM on HiSilicon Hip09 platform supports backpressure, so does
> > >> not need to modify core commit.
> > >>
> > >>   drivers/hwtracing/coresight/coresight-etm4x.c | 43 +++++++++++++++++++++++++++
> > >>   1 file changed, 43 insertions(+)
> > >>
> > >> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> > >> index 7797a57..7641f89 100644
> > >> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> > >> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> > >> @@ -43,6 +43,10 @@ MODULE_PARM_DESC(boot_enable, "Enable tracing on boot");
> > >>   #define PARAM_PM_SAVE_NEVER          1 /* never save any state */
> > >>   #define PARAM_PM_SAVE_SELF_HOSTED 2 /* save self-hosted state only */
> > >>
> > >> +#define CORE_COMMIT_CLEAR   0x3000
> > >> +#define CORE_COMMIT_SHIFT   12
> > >> +#define HISI_ETM_AMBA_ID_V1 0x000b6d01
> > >> +
> > >>   static int pm_save_enable = PARAM_PM_SAVE_FIRMWARE;
> > >>   module_param(pm_save_enable, int, 0444);
> > >>   MODULE_PARM_DESC(pm_save_enable,
> > >> @@ -104,11 +108,40 @@ struct etm4_enable_arg {
> > >>      int rc;
> > >>   };
> > >>
> > >> +static void etm4_cpu_actlr1_cfg(void *info)
> > >> +{
> > >> +    struct etm4_enable_arg *arg = (struct etm4_enable_arg *)info;
> > >> +    u64 val;
> > >> +
> > >> +    asm volatile("mrs %0,s3_1_c15_c2_5" : "=r"(val));
> >
> >
> > The ID register (S3_1_C15_c2_5) falls into implementation defined space.
> > See Arm ARM DDI 0487F.a, section "D12.3.2  Reserved encodings for
> > IMPLEMENTATION DEFINED registers".
> >
> > So, please stop calling this "etm4_cpu_actlr1_cfg". Since,
> > 1) actlr1 is not an architected name for the said encoding
> > 2) The id register could mean something else on another CPU.
> >
> > Rather this should indicate platform/CPU specific. e.g,
> >
> > etm4_cpu_hisilicon_config_core_commit()
> >
> >
> > >> +    val &= ~CORE_COMMIT_CLEAR;
> > >> +    val |= arg->rc << CORE_COMMIT_SHIFT;
> > >> +    asm volatile("msr s3_1_c15_c2_5,%0" : : "r"(val));
> > >> +}
> > >> +
> > >> +static void etm4_config_core_commit(int cpu, int val)
> > >> +{
> > >> +    struct etm4_enable_arg arg = {0};
> > >> +
> > >> +    arg.rc = val;
> > >> +    smp_call_function_single(cpu, etm4_cpu_actlr1_cfg, &arg, 1);
> > >
> > > Function etm4_enable/disable_hw() are already running on the CPU they are
> > > supposed to so no need to call smp_call_function_single().
> > >
> > >> +}
> > >> +
> > >>   static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
> > >>   {
> > >>      int i, rc;
> > >> +    struct amba_device *adev;
> > >>      struct etmv4_config *config = &drvdata->config;
> > >>      struct device *etm_dev = &drvdata->csdev->dev;
> > >> +    struct device *dev = drvdata->csdev->dev.parent;
> > >> +
> > >> +    adev = container_of(dev, struct amba_device, dev);
> > >> +    /*
> > >> +     * If ETM device is HiSilicon ETM device, reduce the
> > >> +     * core-commit to avoid ETM overflow.
> > >> +     */
> > >> +    if (adev->periphid == HISI_ETM_AMBA_ID_V1)
> >
> > Please could you move this check to the function above ?
> > Ideally, it would be good to have something like :
> >
> >         etm4_config_impdef_features();
> >
> > And :
> >
> >         etm4_config_impdef_features(struct etm4_drvdata *drvdata)
> >         {
> >                 etm4_cpu_hisilicon_config_core_commit(drvdata);
> >         }
> >
> 
> In addition to the above, Is it worth having this implementation
> defined code gated in the kernel configuration - like we do for core
> features sometimes?
> i,.e.
> CONFIG_ETM4X_IMPDEF_FEATURE (controls overall impdef support in the driver)
> and
> CONFIG_ETM4X_IMPDEF_HISILICON (depends on CONFIG_ETM4X_IMPDEF_FEATURE )
> 
> This way we keep non ETM architectural code off platforms that cannot
> use it / test it.
>

That's a good idea - they do the same for CPU erratas.
 
> 
> > >
> > > Do you have any documentation on this back pressure feature?  I doubt this is
> > > specific to Hip09 platform and as such would prefer to have a more generic
> > > approach that works on any platform that supports it.
> > >
> > > Anyone on the CS mailing list that knows what this is about?
> >
> > I believe this is hisilicon specific. May be same across their CPUs, may
> > be a specific one. There is no architectural guarantee.
> >
> 
> This could be an implementation of the feature provided by the
> TRCSTALLCTRL register - which allows PE to be stalled in response to
> the ETM fifos approaching overflow.
> At present we do nothing with this feature as we have yet to see a
> target with it implemented, but if this is the case then it is an
> ETMv4 architectural feature that could be added into the main driver
> code,  with use/access gated by the relevent TRCIDR bit.
> 
> Regards
> 
> Mike
> 
> 
> >
> > Cheers
> > Suzuki
> 
> 
> 
> -- 
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK
