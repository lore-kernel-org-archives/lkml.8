Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95A0C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 05:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B518820737
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 05:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tgp7wuTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgHYFag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 01:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbgHYFaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 01:30:35 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA946C061755
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 22:30:34 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id k4so9368369ilr.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 22:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=neyZL3XwDDi0ek1Ye3rJ4gqwsEJHH61znyG0zceh0QI=;
        b=Tgp7wuTv1IHgsnqufqj9kjl/EVG0o2Nw3FYx6C+gcxh1x2TkxJ8YIs9hPgIs9vpkMJ
         O8R/7xm1A5mAEiLUgFSpsxhojvedDXqhIj3R3FMfpQb1c1M2XdQI68wVDLH5CGgTKY+F
         qKwXfDhK4d7y03HzJ332+JWXqi6jHdnq0TmwNjXxljodZzmAgYin9M1xSm5i30gMP8p2
         961FsHzDOX9anHSzig1GZZv2V4F0L+L2mBOxVpbRQjQ1FEsXG/lwIa6YPzjat2iKui7M
         yY6CMuG17kF6TaLMhrsE3PkSM3if2O6rmzxhKD44cA3tUcn47THJDHSyHwa3Ee5rvZsy
         6RuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=neyZL3XwDDi0ek1Ye3rJ4gqwsEJHH61znyG0zceh0QI=;
        b=Az3g3oybmbxEkM3I2WfIxm8uux/564WWuzAJcmALrz0V4Q78yuC+jFMOCAzzzzx3Oq
         1CWFbaNcC5awZC6ATSM51yZ2bLnLPCfXI/ewg1VGFalKMvneQANgsH7Tos9sVDknoevt
         TAo50EtmpJDYGAkUjmqp23hcgzAzkvOZN9oW1kOKbZcc72caONZ3rx6aUZWc/ZCdk+t+
         89TxXfu5vni7ZkQqnYE4uXfNgYpRfvO90fsRa1G6eLbNmcHUwW1IkjaJdZMrUDNw3OIq
         D1A8gMG8Cm0r1qvcwz38GnOBHx4TfVOF2lDVA0a/QPVGULJ9Di4M/L7aI0atfIHnUL8T
         IKMg==
X-Gm-Message-State: AOAM532PjqFQLJ3M9huqL/UKQB6u7oo8eLTdjC2Ym+x+mTmKIDDdkuOh
        +4uFGih9gYkMyu5Uq4aGHUtG+Kzxq2A9cH4+SC+YKQ==
X-Google-Smtp-Source: ABdhPJy+FagyNB5/9MOEumL7LTOxvNb64K7Nk3DXYrDlwAYByZ74V/wFNbSr+6jt6N7XAq4eL1Uk36CxIQafL+2NmeY=
X-Received: by 2002:a92:9fdb:: with SMTP id z88mr7872110ilk.57.1598333433252;
 Mon, 24 Aug 2020 22:30:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200825152551.1.I6d12081e37d27ba7580a1af877727d882935787a@changeid>
In-Reply-To: <20200825152551.1.I6d12081e37d27ba7580a1af877727d882935787a@changeid>
From:   "Anand K. Mistry" <amistry@google.com>
Date:   Tue, 25 Aug 2020 15:30:22 +1000
Message-ID: <CAATStaPRS0Tduo7czesD9rzBDfVLgiWrHUQi+kAadGZAvUv+GA@mail.gmail.com>
Subject: Re: [PATCH] CHROMIUM: arm64: dts: mt8183-elm: Set GPU power regulator
 to always on
To:     "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Cc:     djkurtz@chromium.org, Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

:facepalm: sorry about the subject line. I'll fix it up in the next revision.

On Tue, 25 Aug 2020 at 15:26, Anand K Mistry <amistry@google.com> wrote:
>
> Keep the da9212 BUCKB always-on. This works around an issue on Elm/Hana
> devices where sometimes, the regulator is disabled before scpsys is
> suspended, causing the suspension of scpsys to fail.
>
> Usually, the GPU and scpsys are suspended by the runtime PM before the
> system is suspended, due to the GPU being idle. In this case, scpsys is
> suspended inline with the GPU suspend, which then disables the
> regulator. However, if the GPU is still active when system is suspended,
> GPU suspend occurs but defers suspending scpsys to the PM's noirq phase.
> Since GPU suspend disables the regulator, scpsys isn't powered and
> suspending it fails with the following error:
> [  523.773227] mtk-scpsys 10006000.scpsys: Failed to power off domain mfg_2d
>
> On resume, scpsys is resumed in the noirq phase. Since scpsys requires
> power from the regulator, which is still disabled at this point,
> attempting to turn it on will hang the CPU. A HW watchdog eventually
> reboots the system.
>
> The obvious solution would be to add a link to the regulator from scpsys
> in the devicetree. This would prevent the regulator from being disabled
> until scpsys is suspended. However, in the case where suspending scpsys
> is deferred to the noirq phase, disabling the regulator will fail since
> it is connected over I2C which requires IRQs to be enabled. Even in the
> usual case where scpsys is suspended inline with the GPU, PM will always
> attempt to resume scpsys in noirq. This will attempt to enable the
> regulator, which will also fail due to being unable to communicate over
> I2C.
>
> Since I2C can't be using with IRQs disabled, a workaround is to never
> turn off the regulator.
>
> Measuring power on the GPU rail on a Elm DVT shows that the change in
> power usage is negligible. The two relavent cases are S0 with an idle
> GPU, and S3.
>
> In S0 with an idle GPU, current behaviour with the regulator off:
> @@           NAME  COUNT  AVERAGE  STDDEV      MAX    MIN
> @@         gpu_mw    600     1.74    1.31     6.75   0.00
> ... and with the regulator on, but no load:
> @@           NAME  COUNT  AVERAGE  STDDEV     MAX    MIN
> @@         gpu_mw    600     1.68    1.25    7.13   0.00
> The difference being well within the margin of error.
>
> In S3, current behaviour with the regulator off:
> @@           NAME  COUNT  AVERAGE  STDDEV     MAX    MIN
> @@         gpu_mw    600     0.94    0.74    3.25   0.00
> ... and with the regulator on:
> @@           NAME  COUNT  AVERAGE  STDDEV     MAX     MIN
> @@         gpu_mw    600     0.83    0.66    3.25    0.00
>
> Signed-off-by: Anand K Mistry <amistry@google.com>
>
> ---
>
>  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> index a5a12b2599a4..1294f27b21c1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -304,6 +304,7 @@ da9211_vgpu_reg: BUCKB {
>                                 regulator-min-microamp  = <2000000>;
>                                 regulator-max-microamp  = <3000000>;
>                                 regulator-ramp-delay = <10000>;
> +                               regulator-always-on;
>                         };
>                 };
>         };
> --
> 2.28.0.297.g1956fa8f8d-goog
>


-- 
Anand K. Mistry
Software Engineer
Google Australia
