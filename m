Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AD2C5ACBF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 04:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C7420739
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 04:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRo3nEHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731665AbgCLEjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 00:39:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36263 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgCLEjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 00:39:05 -0400
Received: by mail-lj1-f194.google.com with SMTP id g12so4852858ljj.3;
        Wed, 11 Mar 2020 21:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=09qgIR6K1m5xPP1D1m5YyMuzVQzcRYUfNGJ9cyL/AI0=;
        b=WRo3nEHEG77l3hYpIWxPEfMGMwI9N1w0FhLaz87sLOR8tUhT/QvdNCy6kdKfS71Tgx
         DXv5k20N9MtocO6d1uleZYGrrt1+ucK30YXOJ37/Vf9trANUd5vgtRgLg3m3npZvNVuZ
         IYLEvc4t32Jm10P9ASCn7crxTYzgye862PgxD3BaxtpKz3jZNUWqhz9Kp7DmRUF+RNx8
         CWDUoeVJpoDAmKrFhIa+PZpFvf3ylinML+No+cAUygylzHhiRyCQFIeLU1m7RjXt05VC
         dBeatRz4Bos4MCVKL7I3MXoc2P6ztlv024/oIz4c2ecXnmkBlB9wubX+ZBii9Lj1h5OI
         Uv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=09qgIR6K1m5xPP1D1m5YyMuzVQzcRYUfNGJ9cyL/AI0=;
        b=fM9jIRowjA0PaRqRvx1IYiT1XK4qiSRoq7RJI+/70BOdJ37bStvMgPDxEDqzTjxH/a
         UTE4A+nA5bsM/CmDXRvZq8YVWqGuAr607HygsVM3a9HZmdOZRi/eacGH/fC3d6kmncGX
         i6DyvS8HkWoxco4TidU79sHlGSeLo/7NrqI5CQkhFOx5CVo3jTkFIWNglTLQorlAetkp
         XnPTcHEjxxLD3D5N6sBZI32/M4ZsIlhhJK/KrF8uxVN0lohCf/ZFTnAyzPxjTn6fXJ1f
         I/uA4U9ehRTH3j69O5kpzCKVEP/ySyRgDub0R4Z3ReSf5R4czeu/9cQ88+iL0kx/D8r9
         mDEQ==
X-Gm-Message-State: ANhLgQ1/UqnL6E1XTJgrVCUqgP6jI08NrUvoY5VoKFL725gQMYlTCbhn
        OqlYHyIqCwrWVn9Ynxvs5hzohMQ7KywXIQ==
X-Google-Smtp-Source: ADFU+vtWPwMvPxuuiPxqKAGjDzCxG3AYSqn41J8E1bbRtfPfeYr9/eq9Mt6OagpHP0ULDiLczBlENA==
X-Received: by 2002:a2e:8945:: with SMTP id b5mr3887908ljk.140.1583987943214;
        Wed, 11 Mar 2020 21:39:03 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id u2sm8872866lfu.3.2020.03.11.21.39.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Mar 2020 21:39:02 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?q?Jer=C3=B4me=20Brunet?= <jbrunet@baylibre.com>
Subject: [PATCH v7 2/3] dt-bindings: arm: amlogic: add support for the SmartLabs SML-5442TW
Date:   Thu, 12 Mar 2020 08:38:05 +0400
Message-Id: <1583987886-6288-3-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583987886-6288-1-git-send-email-christianshewitt@gmail.com>
References: <1583987886-6288-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SML-5442TW is an STB for O2 Czech IPTV/VOD and DVB-T/T2 based on the
Amlogic P231 reference design using the S905D chipset. Specs:

2GB DDR3 RAM
8GB eMMC storage
10/100 Base-T Ethernet
802.11 a/b/g/n/ac + BT 4.1 HS sdio wireless module (QCA9377)
2x single colour and 1x dual colour LEDs on the front panel
1x reset button on the front panel
HDMI 2.0 (4k@60p) video
Composite video + 2-channel audio output on 3.5mm jack
S/PDIF audio output
Single DVB-T/T2 tuner (AVL6762/MxL608)
2x USB 2.0 ports
1x micro SD card slot
UART pins (internal)

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index f74aba4..c0c0f66 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -107,6 +107,7 @@ properties:
               - amlogic,p231
               - libretech,aml-s905d-pc
               - phicomm,n1
+              - smartlabs,sml5442tw
           - const: amlogic,s905d
           - const: amlogic,meson-gxl
 
-- 
2.7.4

