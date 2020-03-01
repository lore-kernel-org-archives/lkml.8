Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B3CC3F2D5
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 04:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FD820848
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 04:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBrJkxRg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgCAESX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 23:18:23 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45538 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgCAESV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 23:18:21 -0500
Received: by mail-lj1-f194.google.com with SMTP id e18so7964929ljn.12;
        Sat, 29 Feb 2020 20:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PUiZOEdutWx8wS79TjIHPc76XzhI43CZLLGIcRxipWk=;
        b=VBrJkxRgWdQ6TPtLh3dP9aZZ1/tWFEwSx9ymvQf53dWckdJwHagpTOT/eGCm7Cx7Oy
         5FnI/6yvC8i7r8WUZy0mFlDHCxf048BqW1x1V81AeliIurAdHfovsdmTWkyRDUDe70z2
         HKfpnhoLx4zpPGU1LyRRzSo9/SjYa5NoqNEef+qCqmOy2I0l9/5uIakc7U67yD2nviKi
         5DQuTFjMt1CGv7T9tBhUw6L3mvPOldOnVhxHiJqQT0vBiMDe1hHpHRBVNgjHlmQzt/7S
         88omaRoVbqK4rtuieK0+Jzu5rGDE5Ve7HSzhE5FxSo/+hQ/MXfrPlRNvEdJWCGfaGodS
         dtrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PUiZOEdutWx8wS79TjIHPc76XzhI43CZLLGIcRxipWk=;
        b=Uw3b3Rwipd3wmcL9m6tuRVYQggW7T639pUcT1EWhUvcCFvIkR1yxAMCrnQvw3rFleZ
         kV346eJ/AWtgpB/kncU4Ff4psQ0cElJwd/ABC+9HauRg5wYO4iPlfkhVXw11zMRruI1y
         t8W4r+SRKlCX80onTK5FHyTg03Z0+tX0DGqApsPMKQf0g4y2E2yI0SQLjCfO2Z8Wioir
         ClkY/Yw8vpZBrHiO2RB/snTk4Vt2CPF5Vim/Qyq9cq98EbL1KQaIG5NbTe0pjH+YnZ5Y
         kZYs91M8iWC0FPBLe6QK1Ltc+NMwnmaHtqhkK3mjm/vQ9bwGocLR9EP1+ZAEVepZ4fIj
         BgdA==
X-Gm-Message-State: ANhLgQ0GByJbc26Q47OjW0qyNOuZwbvjVOwO71o6YXE6VQk+stkM6MV6
        y+SzZyLJnsEgkdcOjqloze8=
X-Google-Smtp-Source: ADFU+vvQ2y5mcQKwd9oUqJ2hNPWZ2PG37XsR4QwGtnp2+a9mYT0+jZ3kp9bekRArgOMbhtCTkgV01g==
X-Received: by 2002:a05:651c:2006:: with SMTP id s6mr7637828ljo.251.1583036299026;
        Sat, 29 Feb 2020 20:18:19 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id y24sm9568864lfg.63.2020.02.29.20.18.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Feb 2020 20:18:18 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?q?Jer=C3=B4me=20Brunet?= <jbrunet@baylibre.com>
Subject: [PATCH v6 2/3] dt-bindings: arm: amlogic: add support for the SmartLabs SML-5442TW
Date:   Sun,  1 Mar 2020 08:17:20 +0400
Message-Id: <1583036241-88937-3-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583036241-88937-1-git-send-email-christianshewitt@gmail.com>
References: <1583036241-88937-1-git-send-email-christianshewitt@gmail.com>
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

