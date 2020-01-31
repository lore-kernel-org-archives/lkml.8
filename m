Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A5DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEB82206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cCCXrbR6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgAaQI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 11:08:27 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:35303 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729277AbgAaQI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 11:08:26 -0500
Received: by mail-vk1-f193.google.com with SMTP id o187so2215629vka.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 08:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4xPLoiaUgyd94a+bWIqEdjSO+/pm7JzzixTlR76nC4k=;
        b=cCCXrbR60CBlDAGSpmvFYrjjyE1DVVDlZhNhjXqkIlKpR2BcoPRCHGrUSSTCDfRqDk
         72D2LUsRS4KoF3mrsLr5JyigXGZ9EsF0j5WPA+OZLvWstHHFS/ADUWF2H+JRsfTpY1YT
         ZYDGjjQ7IrKGRYG64lWiFl0zCmZnBnqC4m0/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4xPLoiaUgyd94a+bWIqEdjSO+/pm7JzzixTlR76nC4k=;
        b=ZuJ3POmw6nJ6rGwWDv5UgiP5iSkmhL8MVW+PW8/9DKef+YSgAa0Mnk3TZN+7X8PzTO
         spCf2MoLsC1ry3b5PaX5AvQmlKI85PXfYUMpfOgA+pGqopFK/4YZPE7tssVbmgCRVFFh
         9mASStz8uUTH9pVD0ZoP2XM01oSduQwmRmWIELhM87w1S12tGslqKa4xHdY7OT3tP6KY
         lEG0xRFq4nvJVOEakvO0r4kZ+I9UedEA6q4CUXb1Q66IpTlcHd1z/zlR+xWRrXKmLssf
         WtHlQHyCxrqRRGU+e/dmiFXxQ8aIXAfZa9A69krpuWBkk+5tUWISbX5yd1P0OSP/pgSv
         BzpA==
X-Gm-Message-State: APjAAAW6PRoIo1DFzYW3XDt0pUNrDUX5YZEN9A4LU+zFAALkz5TtBHAe
        A1GITZALYzR6/gJGmLz8zoY8WHgYssM=
X-Google-Smtp-Source: APXvYqxmmL13CRb2QRRXJy2tsVLJ1PXnLyNTfiAgYk1zyDf+hfLzXmsf2qrsIQS8uRDg9Pnz4vMk8g==
X-Received: by 2002:ac5:ce8f:: with SMTP id 15mr6743803vke.81.1580486905510;
        Fri, 31 Jan 2020 08:08:25 -0800 (PST)
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com. [209.85.221.181])
        by smtp.gmail.com with ESMTPSA id x22sm2346723vsq.6.2020.01.31.08.08.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jan 2020 08:08:24 -0800 (PST)
Received: by mail-vk1-f181.google.com with SMTP id g7so2201208vkl.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 08:08:24 -0800 (PST)
X-Received: by 2002:a1f:a9d0:: with SMTP id s199mr6709266vke.40.1580486903706;
 Fri, 31 Jan 2020 08:08:23 -0800 (PST)
MIME-Version: 1.0
References: <1580117390-6057-1-git-send-email-smasetty@codeaurora.org>
 <CAD=FV=VFVC6XJ=OXJCSd2_oij5vggKnTedGP0Gj4KHC50QH0SQ@mail.gmail.com> <4bd79f53cab95db9286067836722dd4b@codeaurora.org>
In-Reply-To: <4bd79f53cab95db9286067836722dd4b@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 31 Jan 2020 08:08:09 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X7pUvab1FXkPbxio_0hW0mvAguFbPAcfQ1=K9HD9bMug@mail.gmail.com>
Message-ID: <CAD=FV=X7pUvab1FXkPbxio_0hW0mvAguFbPAcfQ1=K9HD9bMug@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: qcom: sc7180: Add A618 gpu dt blob
To:     Sharat Masetty <smasetty@codeaurora.org>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dri-devel@freedesktop.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Clark <robdclark@chromium.org>,
        linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 31, 2020 at 4:16 AM <smasetty@codeaurora.org> wrote:
>
> >> +                       reg = <0 0x0506a000 0 0x31000>, <0 0x0b290000
> >> 0 0x10000>,
> >> +                               <0 0x0b490000 0 0x10000>;
> >> +                       reg-names = "gmu", "gmu_pdc", "gmu_pdc_seq";
> >> +                       interrupts = <GIC_SPI 304
> >> IRQ_TYPE_LEVEL_HIGH>,
> >> +                                  <GIC_SPI 305 IRQ_TYPE_LEVEL_HIGH>;
> >> +                       interrupt-names = "hfi", "gmu";
> >> +                       clocks = <&gpucc GPU_CC_CX_GMU_CLK>,
> >> +                              <&gpucc GPU_CC_CXO_CLK>,
> >> +                              <&gcc GCC_DDRSS_GPU_AXI_CLK>,
> >> +                              <&gcc GCC_GPU_MEMNOC_GFX_CLK>;
> >> +                       clock-names = "gmu", "cxo", "axi", "memnoc";
> >> +                       power-domains = <&gpucc CX_GDSC>;
> >
> > Bindings claim that you need both CX and GC.  Is sc7180 somehow
> > different?  Bindings also claim that you should be providing
> > power-domain-names.
> No this is still needed, We need the GX power domain for GPU recovery
> use cases where the shutdown was not successful.

This almost sounds as if the bindings should mark the GX power domain
as optional?  The driver can function without it but doesn't get all
the features?  As the binding is written right now I think it is
"invalid" to not specify a a GX power domain and once the yaml
conversion is done then it will even be flagged as an error.  That's
going to make it harder to land the your patch...

> I am working the Taniya
> to get the dependencies sorted out to bring this change in. This should
> be
> okay for the time being.

What breaks today if you add in the GX power domain here?

Oh, I see.  It's not even provided by the 'gpucc-sc7180.c' file.  What
happens if you do this for now:

  power-domains = <&gpucc CX_GDSC>, <0>;
  power-domain-names = "cx", "gx";

That seems to be the trendy thing to do if a phandle to something is
"required" but the code isn't ready for it.

-Doug
