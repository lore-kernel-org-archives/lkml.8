Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA064C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B701F2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KDwjANyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgEUAjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 20:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgEUAjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 20:39:21 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F48C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 17:39:21 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so2080025plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 17:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=AuRWVLRxtpPKYDJF4d6J01cX+Jpvtmn7S05Da/vU59I=;
        b=KDwjANyodnr/KdFhYC8iRTa2ogAw/Bmn9gfyG7mniJvh19F4yz/337R3gj6e+DqHrt
         rTP7CGc7RgAHP/snyqEed9iILEB3w5F0WvVuYJxW5gHbaUCv6e5g9bLJTRWp2AwKSlG9
         Dt1FiRtkBMad7nsIlSzTaymvQ/1pSWGanTjQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=AuRWVLRxtpPKYDJF4d6J01cX+Jpvtmn7S05Da/vU59I=;
        b=J9CWrYsSP8l6dmwBYxk97oKXuILDOuZkkfLu5S/wYa3FIR/g3MIthGYCp0kdsJoRYG
         fYSso7q/WiCtGsQuWxpRLg1JJYr9dtvZHBHsyWynybybL8RmWON8NGL9WcBPfiJTjKUA
         PidEvs18/cHk0LJKXftHMeTI7xYeQVrBQTYhjVPVQ/w032KuJkff+Nsb8pFFvkm2wB8J
         7JEhiDJdI6gJ5utD8gdDhDsD2mdlj33zey9POjdyS1ehsHiEHuyb+8sJETkAzEyE0u6H
         YMx0s17+G70Ztq5qm9CrpI73h9goc5VWpd5xIk4afkWMt/o8K0SxHVZynY16T9S5t9Rr
         hrBA==
X-Gm-Message-State: AOAM530c0L1k+gigu0OTvihbzNganLg+zfVLUUZHsBY0WzHrfPKoPEgt
        usDxDrDY+vAMK5DR0S/XXZkytQ==
X-Google-Smtp-Source: ABdhPJzRZdcv1ZemD8aJI6y1ci2NNs5bMnvQk6huU94fVngbjOvzaNN5p1vkWzbEoycbfgUl4V3zoQ==
X-Received: by 2002:a17:90a:dd44:: with SMTP id u4mr7639086pjv.132.1590021560562;
        Wed, 20 May 2020 17:39:20 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y5sm3005608pjp.27.2020.05.20.17.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 17:39:19 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1589804402-27130-1-git-send-email-mkshah@codeaurora.org>
References: <1589804402-27130-1-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc7180: Correct the pdc interrupt ranges
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rnayak@codeaurora.org, ilina@codeaurora.org, lsrao@codeaurora.org,
        mka@chromium.org, evgreen@chromium.org, dianders@chromium.org,
        Maulik Shah <mkshah@codeaurora.org>, devicetree@vger.kernel.org
To:     Maulik Shah <mkshah@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org
Date:   Wed, 20 May 2020 17:39:18 -0700
Message-ID: <159002155857.215346.7990318931003802964@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-05-18 05:20:02)
> Few PDC interrupts do not map to respective parent GIC interrupt.
> Fix this by correcting the pdc interrupt map.
>=20
> Fixes: 22f185ee81d2 ("arm64: dts: qcom: sc7180: Add pdc interrupt control=
ler")
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/q=
com/sc7180.dtsi
> index f1280e0..f6b4ee8 100644
> --- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
> @@ -2308,8 +2308,7 @@
>                 pdc: interrupt-controller@b220000 {
>                         compatible =3D "qcom,sc7180-pdc", "qcom,pdc";
>                         reg =3D <0 0x0b220000 0 0x30000>;
> -                       qcom,pdc-ranges =3D <0 480 15>, <17 497 98>,
> -                                         <119 634 4>, <124 639 1>;
> +                       qcom,pdc-ranges =3D <0 480 94>, <94 609 31>, <125=
 63 1>;

This is a sign that we shouldn't put this information in DT. It was
wrong once so who knows if it will be wrong again. We don't have an
automated way to check this like we can check other properties. And the
information isn't something that is changed by firmware or the OS
loader. It is static data about the internals of the PDC device and how
it maps PDC pins to GIC SPI lines. We are probably better off just
setting up these ranges in the driver vs. relying on DT authors to get
it right.
