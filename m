Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98057C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 00:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DFE420747
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 00:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhvRKudN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgFOAA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 20:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbgFOAA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 20:00:26 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373E6C05BD43;
        Sun, 14 Jun 2020 17:00:26 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id y13so15527234eju.2;
        Sun, 14 Jun 2020 17:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cSWUfCMQddejc1c7RRGpjS3rAmuSxlqtUFvza+MSr1g=;
        b=mhvRKudNMLFCDQx9Bzw0xTPRcKsOGzRgJxmQVtOE/VziN0o5i3SHQdXiMYYbVG1yGE
         Z9EaouRzlS65nGTsI/K7iq743o+UEfdbkDP1I9et3wYAbJ0B9lRoS8wwmlKO7PaClBIJ
         8QcWkRspcU65WSyrNsYzD09CfqKI8RgPsM7W9EENrnedL29B4SBAB6n8JDS17Tu/HxNU
         82BSuwpqcg0wQdh3oIEU2PepD7UD0YvwXDJxpE3T9QtrRmP2FXH6catU6qmEvC0Sn3km
         LWBmx7S16vSpXhKd19CO7hHSSpGToEMaYNr1feYf6oerc0YopJuLgXWrC6PQg0pFDnz8
         leeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cSWUfCMQddejc1c7RRGpjS3rAmuSxlqtUFvza+MSr1g=;
        b=A1aGiBwS/yVoz/KE06V6i6s5HhaghrPIaW9k7N4K2gHyKSdbctiBOG3W3EafOejRff
         DRAAU/Vq32fPwPNGSL5YDBK2n8+LBWAxxDnp+KZQxiK5n8OlTnWKMyUaCpfnNZp/NJXA
         OY0/adRNuzkEn7WIqPhl4HEkAwZuvBtukbI7FsSgbv8ByP1GA9z6vJUSZASfU82jM2+a
         fHnWLPp4qsVxsHSXzQmpsnr/SieI7EvX4HVee/qelZm4Pv8F8Ps1Tk122q74r79UvggS
         rYeblUrz+CInNW1UK6ldE7Urpt24EO+w3+RboCf1E9mVHwzqECj5K4GzwCv7WAu0VuRh
         baRw==
X-Gm-Message-State: AOAM533wWmVlvGWbQ1tyyJBjdybQbt3BR+SPN3UbpdACRM2tLDNihBkf
        uTO5HlJ2qc4AIYVqo91Jv7Y=
X-Google-Smtp-Source: ABdhPJywGZTxzuIxI8ihSelPF+55JKwRh2GgpBxACZapKckPFlRs7+S7PDx+CcSttHbbWPBujf5ZWQ==
X-Received: by 2002:a17:906:9381:: with SMTP id l1mr23895119ejx.380.1592179224942;
        Sun, 14 Jun 2020 17:00:24 -0700 (PDT)
Received: from localhost.localdomain ([188.24.129.96])
        by smtp.gmail.com with ESMTPSA id g22sm7825504ejp.0.2020.06.14.17.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 17:00:23 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Add initial support for RoseapplePi SBC
Date:   Mon, 15 Jun 2020 03:00:17 +0300
Message-Id: <cover.1592123160.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enables basic support for RoseapplePi, relying exclusively
on the existing infrastructure for the Actions Semi Sxx SoCs (thank you
Andreas and Manni for making this possible).

The SBC is powered by the Actions Semi S500 SoC and comes with 2GB RAM,
uSD slot and optional eMMC storage. For more details, please check:
http://roseapplepi.org/index.php/spec/

The upcoming patches will improve this initial support by adding the
missing bits and pieces to the S500 clock management unit, which is a
prerequisite for providing an S500 pinctrl and gpio driver, in order to
eventually enable access to additional functionality like I2C and MMC.

Thanks and regards,
Cristian Ciocaltea

Cristian Ciocaltea (4):
  arm: dts: owl-s500: Fix incorrect PPI interrupt specifiers
  dt-bindings: Add vendor prefix for RoseapplePi.org
  dt-bindings: arm: actions: Document RoseapplePi
  arm: dts: owl-s500: Add RoseapplePi

 .../devicetree/bindings/arm/actions.yaml      |  1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/owl-s500-roseapplepi.dts    | 47 +++++++++++++++++++
 arch/arm/boot/dts/owl-s500.dtsi               |  6 +--
 5 files changed, 54 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/owl-s500-roseapplepi.dts

-- 
2.27.0

