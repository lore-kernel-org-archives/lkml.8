Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9928DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E3F8206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VjpnOp9a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732159AbgIAP4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731364AbgIAP4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:56:10 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA18C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 08:56:09 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id h4so1781223ioe.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oHdmPIGc1UdLCwtabNwKXST8Nzwlla5YL4eeacWsu1I=;
        b=VjpnOp9aiJY52BxZcXb5yoPB+72grngZXFAn26nQt3o/kKNTnIsM6KrnhoR6TBZkTg
         vlJE0PnpGzxHNm+6P1X4lb/icYWyjWECoREVf2ZC/0K0TllbhsO+lezjS2KhTXzkTxBj
         857RTtmyDVDVMwivWe2zJNURHoHUQw0Vzdb/2Z+uIPMNVbHd934j3CKuY29v7NnGkvQU
         raRMjz5hUsSQxy6eW9JCyUlEP6yIlfHymMrYtOgJDEkfbGog3aEIRpL/xgwaQIbFklmA
         cSHmoBEQ8MkaTUShsR/X6D/9XkAqzAxPr8eTFjaK9tHn5iAIkrJtMpgmRSslV85MkONp
         OeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oHdmPIGc1UdLCwtabNwKXST8Nzwlla5YL4eeacWsu1I=;
        b=F94STGtRiihjYhz+XizaM4PUFjUxC1VCsMTKdDnlDeCgYsG03Hdj+XzY9XOOIn5IXs
         6wbwYzdc2PnWYCqelvw1ea8nXfcY8jYKQrlsx1bZ50PPaJ1mGntnFcS2ZmDskrbsJZwK
         /mN8u24sMBIrautDlssOlTqepsPzqy13iU6rca23AkNdBIhH7fz3wwcTw75JPtuMHSGX
         u0d2pBDnL89SLmnrsxWuf8pvSdLCb0Ys+vrEnJLsqNQtRq7kNDMV1sioMgNqYjlT0vNu
         aVc7LGEJ+mGScXci9wQA3FSX09VaUKROOFoSOwzYD0EIPOBvbGmCp6jt4FIVk58iTl3d
         rqIw==
X-Gm-Message-State: AOAM5307mB7jAtSWQYTvQwNu9E6t7EC+Pug9eNJDiBFJsfq7Ubng966/
        n5r70qrfPimrceA01JkznagLUlR6nO4N13Vne5OP0A==
X-Google-Smtp-Source: ABdhPJwOgUG5A07Ta8oCpswEaPxY7uCJEZSgebz2RNdW9MRNH9XiIPZYoLCjAPI5+e9ZqFNFFNsi+Y+yaNvyiEPwUrM=
X-Received: by 2002:a5d:80c9:: with SMTP id h9mr1999593ior.73.1598975769024;
 Tue, 01 Sep 2020 08:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <1597824397-29894-1-git-send-email-liuqi115@huawei.com>
 <20200831221308.GB207013@xps15> <fae22c97-489b-0312-4357-973a4969780c@huawei.com>
In-Reply-To: <fae22c97-489b-0312-4357-973a4969780c@huawei.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Tue, 1 Sep 2020 09:55:58 -0600
Message-ID: <CANLsYkwkUnTWzWk7RLrRc3WH3AmY3M9z9PE2Yu2tr4_U4J7=vA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] coresight: etm4x: Modify core-commit of cpu to
 avoid the overflow of HiSilicon ETM
To:     Qi Liu <liuqi115@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020 at 19:57, Qi Liu <liuqi115@huawei.com> wrote:
>
> Hi Mathieu,
>
> Thanks for your review.
>
> On 2020/9/1 6:13, Mathieu Poirier wrote:
> > Following Al's comment I have the following recommendations...
> >
> > On Wed, Aug 19, 2020 at 04:06:37PM +0800, Qi Liu wrote:
> >> When too much trace information is generated on-chip, the ETM will
> >> overflow, and cause data loss. This is a common phenomenon on ETM
> >> devices.
> >>
> >> But sometimes we do not want to lose performance trace data, so we
> >> suppress the speed of instructions sent from CPU core to ETM to
> >> avoid the overflow of ETM.
> >>
> >> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> >> ---
> >>
> >> Changes since v1:
> >> - ETM on HiSilicon Hip09 platform supports backpressure, so does
> >> not need to modify core commit.
> >>
> >>  drivers/hwtracing/coresight/coresight-etm4x.c | 43 +++++++++++++++++++++++++++
> >>  1 file changed, 43 insertions(+)
> >>
> >> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
> >> index 7797a57..7641f89 100644
> >> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> >> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> >> @@ -43,6 +43,10 @@ MODULE_PARM_DESC(boot_enable, "Enable tracing on boot");
> >>  #define PARAM_PM_SAVE_NEVER   1 /* never save any state */
> >>  #define PARAM_PM_SAVE_SELF_HOSTED 2 /* save self-hosted state only */
> >>
> >> +#define CORE_COMMIT_CLEAR   0x3000
> >> +#define CORE_COMMIT_SHIFT   12
> >> +#define HISI_ETM_AMBA_ID_V1 0x000b6d01
> > Do you have a name for the SoC that can be added so that other HiSilicon SoC can
> > be added?  I suggest something like:
> >
> > #define HISI_NAME_CORE_COMMIT_CLEAR
> > #define HISI_NAME_CORE_COMMIT_SHIFT
> > #define HISI_NAME_ETM_ID
> Will fix this next version.
> > Moreover I don't see an entry for 0x000b6d01 in the amba id table - is your
> > devices upstream?  Needless to day that is mandatory in order to move forward
> > with this work.
> A patch has been applied to add this ETM id and here is the link:
> https://lore.kernel.org/linux-arm-kernel/20200813210000.GO3393195@xps15/
>

Ah yes - my tree was on the wrong baseline when I reviewed your patch.
You can forget about this comment.

Thanks,
Mathieu

> >> +
> >>  static int pm_save_enable = PARAM_PM_SAVE_FIRMWARE;
> >>  module_param(pm_save_enable, int, 0444);
> >>  MODULE_PARM_DESC(pm_save_enable,
> >> @@ -104,11 +108,40 @@ struct etm4_enable_arg {
> >>      int rc;
> >>  };
> >>
> >> +static void etm4_cpu_actlr1_cfg(void *info)
> >> +{
> >> +    struct etm4_enable_arg *arg = (struct etm4_enable_arg *)info;
> >> +    u64 val;
> >> +
> >> +    asm volatile("mrs %0,s3_1_c15_c2_5" : "=r"(val));
> >> +    val &= ~CORE_COMMIT_CLEAR;
> >> +    val |= arg->rc << CORE_COMMIT_SHIFT;
> >> +    asm volatile("msr s3_1_c15_c2_5,%0" : : "r"(val));
> >> +}
> >> +
> >> +static void etm4_config_core_commit(int cpu, int val)
> >> +{
> >> +    struct etm4_enable_arg arg = {0};
> >> +
> >> +    arg.rc = val;
> >> +    smp_call_function_single(cpu, etm4_cpu_actlr1_cfg, &arg, 1);
> >> +}
> >> +
> >>  static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
> >>  {
> >>      int i, rc;
> >> +    struct amba_device *adev;
> >>      struct etmv4_config *config = &drvdata->config;
> >>      struct device *etm_dev = &drvdata->csdev->dev;
> >> +    struct device *dev = drvdata->csdev->dev.parent;
> >> +
> >> +    adev = container_of(dev, struct amba_device, dev);
> >> +    /*
> >> +     * If ETM device is HiSilicon ETM device, reduce the
> >> +     * core-commit to avoid ETM overflow.
> >> +     */
> >> +    if (adev->periphid == HISI_ETM_AMBA_ID_V1)
> >> +            etm4_config_core_commit(drvdata->cpu, 1);
> > I susggest to add a function like etm4_enable_arch_specific() and do the above
> > in there.  The same goes for the disable path.
> >
> > Thanks,
> > Mathieu
> Thanks, I'll fix this next version : )
>
> Qi
> >
> >>      CS_UNLOCK(drvdata->base);
> >>
> >> @@ -472,10 +505,20 @@ static void etm4_disable_hw(void *info)
> >>  {
> >>      u32 control;
> >>      struct etmv4_drvdata *drvdata = info;
> >> +    struct device *dev = drvdata->csdev->dev.parent;
> >>      struct etmv4_config *config = &drvdata->config;
> >>      struct device *etm_dev = &drvdata->csdev->dev;
> >> +    struct amba_device *adev;
> >>      int i;
> >>
> >> +    adev = container_of(dev, struct amba_device, dev);
> >> +    /*
> >> +     * If ETM device is HiSilicon ETM device, resume the
> >> +     * core-commit after ETM trace is complete.
> >> +     */
> >> +    if (adev->periphid == HISI_ETM_AMBA_ID_V1)
> >> +            etm4_config_core_commit(drvdata->cpu, 0);
> >> +
> >>      CS_UNLOCK(drvdata->base);
> >>
> >>      if (!drvdata->skip_power_up) {
> >> --
> >> 2.8.1
> >>
> > .
> >
>
>
