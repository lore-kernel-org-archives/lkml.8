Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FF3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 11:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14567207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 11:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PnDUJ1l1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgFLLRZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 07:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgFLLRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 07:17:24 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1755C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 04:17:23 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l17so7777750wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 04:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lFJvzabjoEZ+HtsOECcEtmqFE9pBFs7uCPFeRIh5sLc=;
        b=PnDUJ1l1npEElayWuGR6BbsRPZMBMfoz+SUfyLlD7JrXmEYvSkr27n9p5szcYOrl/9
         B0fJ+fBTrwV3DAEyK0YGqEydXAUQk7egq6QTT7afNlyy1vEseRA7M+rPi6T6BJ+NC3Or
         FVfZA/9Ieb3tOmQYm39PCrTAs0h5Um/vx1RiOait6i2WXtJMxl2QnUx14LFf1FxpeWFN
         BOtFzC6Hdze7c3jUJ11SauoLPwcSeZbwDutqusueHnIm4NhiuumiBsKw5vNMPg6wFcFS
         0ZJrUfgGXyBG+qPOsRZaB/3RHYZHQ59NqgXSZcau7sGGO2DNWpBI1QwEZ5zNrdibuNFu
         8puQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lFJvzabjoEZ+HtsOECcEtmqFE9pBFs7uCPFeRIh5sLc=;
        b=QukZ+BH9MJydw0rYp9IBrF+GGPUP+79u6LvNSMoykwJOF7ugrfu2J+1y0uidWj+zCh
         BtJTMpR0aTGuc2kD4sval2azq6a5bWZiSnm5hRo8CXRq3LjfE72gDXccWtehecKZ7gaO
         4RN0QG4TmheEpTgpfXZfkDZ032zAXBbe5miuh9Q9N+as0X/f1s1bFple2Y7niVG2ZlAB
         V1RPozodcFs/v19gSLR7nA8gecT1TGKJAWUGH48Cj2ej+u91/U2ICTLEvuR/nOVOF3CN
         wqhtsblgrkNtlei/0v1vG2eQXEiLeQ3+BKMIdpjsjBPkdVdbLgO+35JZvsekNXtkyGdg
         umGg==
X-Gm-Message-State: AOAM530yAGU2rNpnyzV2qBjs7amU++AyWSdJHFXmYLkiVCXGMd+wm+hm
        lJfuR67W2WlLTeNfpjsPbzGalXIkc5g=
X-Google-Smtp-Source: ABdhPJy/H/RDxG/sjS0gqbAVmPeBzeGEkD+BK9JeLjyyQfM2QDREy9dBILVxAKQRbzNWeKEttBazIw==
X-Received: by 2002:a05:600c:2945:: with SMTP id n5mr13825316wmd.189.1591960640116;
        Fri, 12 Jun 2020 04:17:20 -0700 (PDT)
Received: from dell ([2.27.167.101])
        by smtp.gmail.com with ESMTPSA id p9sm8205945wma.48.2020.06.12.04.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 04:17:19 -0700 (PDT)
Date:   Fri, 12 Jun 2020 12:17:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gene Chen <gene_chen@richtek.com>, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH] mfd: mt6360: Fix register driver NULL pointer by add
 driver name
Message-ID: <20200612111717.GA2311694@dell>
References: <1591609125-3761-1-git-send-email-gene.chen.richtek@gmail.com>
 <20200608192829.GG4106@dell>
 <CAE+NS36mxw-FpQhJ4qV=_+r2CXVi_PaGaZo2m3jXAGFuOO252Q@mail.gmail.com>
 <20200609125305.GL4106@dell>
 <CAE+NS36b8fV2JnSEJpky+0ES3KTYmQzC0MRTfRUf8yRsJh_bpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE+NS36b8fV2JnSEJpky+0ES3KTYmQzC0MRTfRUf8yRsJh_bpQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jun 2020, Gene Chen wrote:

> Lee Jones <lee.jones@linaro.org> 於 2020年6月9日 週二 下午8:53寫道：
> >
> > On Tue, 09 Jun 2020, Gene Chen wrote:
> >
> > > Lee Jones <lee.jones@linaro.org> 於 2020年6月9日 週二 上午3:28寫道：
> > > >
> > > > On Mon, 08 Jun 2020, Gene Chen wrote:
> > > >
> > > > > From: Gene Chen <gene_chen@richtek.com>
> > > > >
> > > > > accidentally remove driver name when
> > > > > replace probe by probe_new in add mt6360 mfd driver patch v4
> > > > >
> > > > > [  121.243012] EAX: c2a8bc64 EBX: 00000000 ECX: 00000000 EDX: 00000000
> > > > > [  121.243012] ESI: c2a8bc79 EDI: 00000000 EBP: e54bdea8 ESP: e54bdea0
> > > > > [  121.243012] DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010286
> > > > > [  121.243012] CR0: 80050033 CR2: 00000000 CR3: 02ec3000 CR4: 000006b0
> > > > > [  121.243012] Call Trace:
> > > > > [  121.243012]  kset_find_obj+0x3d/0xc0
> > > > > [  121.243012]  driver_find+0x16/0x40
> > > > > [  121.243012]  driver_register+0x49/0x100
> > > > > [  121.243012]  ? i2c_for_each_dev+0x39/0x50
> > > > > [  121.243012]  ? __process_new_adapter+0x20/0x20
> > > > > [  121.243012]  ? cht_wc_driver_init+0x11/0x11
> > > > > [  121.243012]  i2c_register_driver+0x30/0x80
> > > > > [  121.243012]  ? intel_lpss_pci_driver_init+0x16/0x16
> > > > > [  121.243012]  mt6360_pmu_driver_init+0xf/0x11
> > > > > [  121.243012]  do_one_initcall+0x33/0x1a0
> > > > > [  121.243012]  ? parse_args+0x1eb/0x3d0
> > > > > [  121.243012]  ? __might_sleep+0x31/0x90
> > > > > [  121.243012]  ? kernel_init_freeable+0x10a/0x17f
> > > > > [  121.243012]  kernel_init_freeable+0x12c/0x17f
> > > > > [  121.243012]  ? rest_init+0x110/0x110
> > > > > [  121.243012]  kernel_init+0xb/0x100
> > > > > [  121.243012]  ? schedule_tail_wrapper+0x9/0xc
> > > > > [  121.243012]  ret_from_fork+0x19/0x24
> > > > > [  121.243012] Modules linked in:
> > > > > [  121.243012] CR2: 0000000000000000
> > > > > [  121.243012] random: get_random_bytes called from init_oops_id+0x3a/0x40 with crng_init=0
> > > > > [  121.243012] ---[ end trace 38a803400f1a2bee ]---
> > > > > [  121.243012] EIP: strcmp+0x11/0x30
> > > >
> > > > How did this driver ever work for you?
> > >
> > > i ask my coworker help me verify.
> > > i will check the patch myself, sincerely apologies for this.
> >
> > What does this mean?
> >
> > Are you saying that for all 10 versions of this patch submission, it
> > has never been tested?  And despite being authored by you and
> > submitted by you, you have never actually boot tested the driver
> > yourself?  Relying instead on your co-worker to conduct the testing,
> > who failed to do so.  Is that really correct?
> >
> 
> On carefully reading to the document how to upstream, I find that I
> had full duty for verify patch i sent.
> The fault is entirely mine and I deeply regret that it should have occurred.
> I will always verify patch by meself before sending it.
> I have already verfied sub-device adc/led/regulator done in Mediatek
> phone and Hikey960 development board

I'm not looking for someone to blame.  Instead, I would like to
ascertain how this happened.  How was this driver ever
tested/verified?  If you're not going to run/use it, does it even need
to exist?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
