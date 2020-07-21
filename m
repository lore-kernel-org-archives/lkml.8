Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8822C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7F66206F2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yLeByTOo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbgGUIrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgGUIrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:47:21 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BEDC0619D8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:47:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a15so5404757wrh.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:subject:in-reply-to:date:message-id
         :mime-version;
        bh=K1UC6jdZ3c17SoyP6xlxlFovUPpmZnz7mywCnflsBk0=;
        b=yLeByTOo/OuRZOhYSglmXMos6TiL26zvvxwrhk+bL5lWrsou8qeC4S3+TZtxGQDLuw
         L7Ys23fspQbkmwkAVtzfVqsVHVxQm1MjRdHmOO3bNSC+l/cNljHbODizKlMXG/Ocde/Y
         h2Lhh11tIUosxCFVQv/QryUzJE3cnCS4aFo9sdixtsKYFaPW/4wE8bvMfKnIbT8TxdCM
         uH8bgVD/OCPfVOnC/cxBgiqi0abxIhCSyZsfGrCBnankem40jBRFEil+pi2XJfyX9Co1
         SsZjxOWJc2qRHH7LGcs2/OO94lkNMy2KdoAJ8i1qhwyaii3DZGFQOEpFRI6EozGLzqJ+
         sErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:subject
         :in-reply-to:date:message-id:mime-version;
        bh=K1UC6jdZ3c17SoyP6xlxlFovUPpmZnz7mywCnflsBk0=;
        b=WCUEZBljORY2306PE97AWChBwx8bZK57VgSiRFSbYawl9JxHYdihyK4s43xdMgW264
         9Xn7aiwlMatY2C61jK3XpqFewoyqUkc5UPvDcbFBbZj6ezw947fB2/2kFqMUNEM4VZaf
         LRxgw4N0PvK4R1HQiKMKj2qL9dzNb+BSxD+V1uWcR9cglwj4rRyKm6HfvFS6JSb6aSyE
         fP3Y+Po9rAyhvC7OUCAshvO0VG6HVG0s0qoTfRfhfxvwxQNy8mCZCVk5ZLyG3Px0ZAw8
         K7xrZfjb2YkR33Vcjt8b6MIhtDL7gazsTkqpwAP99W0Au9fKd9F39OOdTq3ocH+yR63r
         xi9Q==
X-Gm-Message-State: AOAM53174R4+PB3spP3D6i6Eu/7PwWPqfYtVF/FKMaxfqQJikNrTw6It
        TGx8QonGlaKPj/Vlp6wuikDAgw==
X-Google-Smtp-Source: ABdhPJwYjwvOJGv70O4j08oC5Qj/6svFm8pb1ZFxyQlbQgrUYLJvNUdUrDKKHwsDnuZm3Aohn4pOtg==
X-Received: by 2002:adf:f784:: with SMTP id q4mr25561076wrp.397.1595321239433;
        Tue, 21 Jul 2020 01:47:19 -0700 (PDT)
Received: from localhost (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f15sm35050842wrx.91.2020.07.21.01.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 01:47:18 -0700 (PDT)
References: <20200718072532.8427-1-christianshewitt@gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: meson: add more SM1 soundcards
In-reply-to: <20200718072532.8427-1-christianshewitt@gmail.com>
Date:   Tue, 21 Jul 2020 10:47:18 +0200
Message-ID: <1jsgdl8dbd.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat 18 Jul 2020 at 09:25, Christian Hewitt <christianshewitt@gmail.com> wrote:

> This series adds basic support for LPCM audio over HDMI interfaces
> to the Khadas VIM3L (reusing the same config as the VIM3) and the
> HardKernel ODROID-C4 devices. I'm sure support can be extended to
> include other hardware but this gets the HDMI port working as a
> minimum capability. I have personally tested with both devices.
>
> Christian Hewitt (2):
>   arm64: dts: meson: add audio playback to odroid-c4
>   arm64: dts: meson: add audio playback to khadas-vim3l
>
>  .../dts/amlogic/meson-sm1-khadas-vim3l.dts    | 88 +++++++++++++++++++
>  .../boot/dts/amlogic/meson-sm1-odroid-c4.dts  | 88 +++++++++++++++++++
>  2 files changed, 176 insertions(+)

Acked-by: Jerome Brunet <jbrunet@baylibre.com>
