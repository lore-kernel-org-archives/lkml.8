Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8EEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F3F206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sRudMVlH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgFIMxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 08:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgFIMxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 08:53:14 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5F7C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 05:53:12 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id p5so21154686wrw.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 05:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vrPhBQinJOm2GiOyvxlhSLQ8G2hbgcP888EbPjYnpWE=;
        b=sRudMVlHtnJjHmIBx59yGnZa7TgnSFmEgOv0HeaNM3Yw6g193AyJONzpDj2K1k4nbZ
         3xTl+eARUVcQU6Tt4E8p8c0kSvnhRU6CK94wKp+O1zKCK+BeFLfrkSnDGF3JEPThV4Kd
         sc07ajaQZQWU4bdYabuqev/2HW/xax9AGAylbGoOfdNWNMt9JNAxjWGIYUtRdbqIhMip
         Gds5DE0qh1mqcJn4jEGBTyTRPUXERdeb5nY1+Ia72Gg4h/xKlmGIbxdvsgvQNiE0lLDm
         86jNWlJqpc7q8mwufN9tb6/TTTnBM3wyRs/wn4wAaI7ZPy32ylNLyC2fvzh8u254T5eN
         IetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vrPhBQinJOm2GiOyvxlhSLQ8G2hbgcP888EbPjYnpWE=;
        b=sxBi9lE9npydDVVMjsb7gvcajh15M095iSNk2IK4fvLhfiX1CpL+zUuDLg2Xnz426U
         O0BzB1pGZqHq+b7L7WryXLnCAvzqoxZGDN1TcDANwBSoEVXCgjaYSZ9u+5uUqQ0XU3lM
         EsrbbLwe9oouJDHELe2n7NnIy+rsdS86kBeQGN2hUUqg1zVxwkLph0ijn59KBV5kRPtU
         tHCUQ3N2nvmAe6A5uqJxdzVNbgMAJyc7jR3iAW47XxlI9JWhInNmJ8NJ6OkLvJWAYWX8
         lfA8REQlI/y9iE2TVXaUUxWuXKGYCYVw+r+BwTY8rGyttDS58OPUxnLGRxA0rAUZ/oso
         yVDQ==
X-Gm-Message-State: AOAM532G2J5asiYZDfssxyrm+vueDBlAQPG/ss9bxcyHxUo+SH3JldoW
        KELMG5wgzSucArMjJRPvEA57tw==
X-Google-Smtp-Source: ABdhPJyUpfpT9l7B1MvSK8xJp6dacca2BXQKTrAQ4Wc72VOm5cQExzdGg3Ltp/re4zTYpjuCHoMJaA==
X-Received: by 2002:adf:feca:: with SMTP id q10mr3990520wrs.380.1591707191199;
        Tue, 09 Jun 2020 05:53:11 -0700 (PDT)
Received: from dell ([2.27.167.101])
        by smtp.gmail.com with ESMTPSA id x205sm2925431wmx.21.2020.06.09.05.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 05:53:10 -0700 (PDT)
Date:   Tue, 9 Jun 2020 13:53:05 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH] mfd: mt6360: Fix register driver NULL pointer by add
 driver name
Message-ID: <20200609125305.GL4106@dell>
References: <1591609125-3761-1-git-send-email-gene.chen.richtek@gmail.com>
 <20200608192829.GG4106@dell>
 <CAE+NS36mxw-FpQhJ4qV=_+r2CXVi_PaGaZo2m3jXAGFuOO252Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+NS36mxw-FpQhJ4qV=_+r2CXVi_PaGaZo2m3jXAGFuOO252Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Jun 2020, Gene Chen wrote:

> Lee Jones <lee.jones@linaro.org> 於 2020年6月9日 週二 上午3:28寫道：
> >
> > On Mon, 08 Jun 2020, Gene Chen wrote:
> >
> > > From: Gene Chen <gene_chen@richtek.com>
> > >
> > > accidentally remove driver name when
> > > replace probe by probe_new in add mt6360 mfd driver patch v4
> > >
> > > [  121.243012] EAX: c2a8bc64 EBX: 00000000 ECX: 00000000 EDX: 00000000
> > > [  121.243012] ESI: c2a8bc79 EDI: 00000000 EBP: e54bdea8 ESP: e54bdea0
> > > [  121.243012] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010286
> > > [  121.243012] CR0: 80050033 CR2: 00000000 CR3: 02ec3000 CR4: 000006b0
> > > [  121.243012] Call Trace:
> > > [  121.243012]  kset_find_obj+0x3d/0xc0
> > > [  121.243012]  driver_find+0x16/0x40
> > > [  121.243012]  driver_register+0x49/0x100
> > > [  121.243012]  ? i2c_for_each_dev+0x39/0x50
> > > [  121.243012]  ? __process_new_adapter+0x20/0x20
> > > [  121.243012]  ? cht_wc_driver_init+0x11/0x11
> > > [  121.243012]  i2c_register_driver+0x30/0x80
> > > [  121.243012]  ? intel_lpss_pci_driver_init+0x16/0x16
> > > [  121.243012]  mt6360_pmu_driver_init+0xf/0x11
> > > [  121.243012]  do_one_initcall+0x33/0x1a0
> > > [  121.243012]  ? parse_args+0x1eb/0x3d0
> > > [  121.243012]  ? __might_sleep+0x31/0x90
> > > [  121.243012]  ? kernel_init_freeable+0x10a/0x17f
> > > [  121.243012]  kernel_init_freeable+0x12c/0x17f
> > > [  121.243012]  ? rest_init+0x110/0x110
> > > [  121.243012]  kernel_init+0xb/0x100
> > > [  121.243012]  ? schedule_tail_wrapper+0x9/0xc
> > > [  121.243012]  ret_from_fork+0x19/0x24
> > > [  121.243012] Modules linked in:
> > > [  121.243012] CR2: 0000000000000000
> > > [  121.243012] random: get_random_bytes called from init_oops_id+0x3a/0x40 with crng_init=0
> > > [  121.243012] ---[ end trace 38a803400f1a2bee ]---
> > > [  121.243012] EIP: strcmp+0x11/0x30
> >
> > How did this driver ever work for you?
> 
> i ask my coworker help me verify.
> i will check the patch myself, sincerely apologies for this.

What does this mean?

Are you saying that for all 10 versions of this patch submission, it
has never been tested?  And despite being authored by you and
submitted by you, you have never actually boot tested the driver
yourself?  Relying instead on your co-worker to conduct the testing,
who failed to do so.  Is that really correct?

> > > Signed-off-by: Gene Chen <gene_chen@richtek.com>
> > > ---
> > >  drivers/mfd/mt6360-core.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> > > index db8cdf5..e9cacc2 100644
> > > --- a/drivers/mfd/mt6360-core.c
> > > +++ b/drivers/mfd/mt6360-core.c
> > > @@ -412,6 +412,7 @@ MODULE_DEVICE_TABLE(of, mt6360_pmu_of_id);
> > >
> > >  static struct i2c_driver mt6360_pmu_driver = {
> > >       .driver = {
> > > +             .name = "mt6360_pmu",
> > >               .pm = &mt6360_pmu_pm_ops,
> > >               .of_match_table = of_match_ptr(mt6360_pmu_of_id),
> > >       },
> >

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
