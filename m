Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F1FC3F2CE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 12:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C22BD246B0
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 12:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GnNZfvzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgB2M00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 07:26:26 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40799 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgB2M0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 07:26:25 -0500
Received: by mail-lj1-f196.google.com with SMTP id 143so6379119ljj.7;
        Sat, 29 Feb 2020 04:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PUiZOEdutWx8wS79TjIHPc76XzhI43CZLLGIcRxipWk=;
        b=GnNZfvzVXkoiE9c3hEVHWBQT9Ehj4Tp3VttSt+WwVK9wMm4+PT2IUIgUd0LElbSIWv
         E583Tnzqw3Y+4Bnt1o5CvqUKT4lyKxsYytWJtMOLLymZCrg4dtudO2kbnu1LxAcv96Tb
         hT7HdhaP/7+9OC5D8w1ETZtMOKqbRE5a0S56aifMRzl8nJTU05RWD4uyhRygwtZFDjrK
         CdwXmYWnTyasP+6DBmLiS20H8XXf5O4XXCF+rLBk95PTa23q+GEasNlJayf4B7asbgKH
         sp+J/osdEVYsOKlN550wUu4N0QQgZFjYej0Pk6NB29QMOYYgbAwP7L1wS9XRaB2enc0s
         6ltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PUiZOEdutWx8wS79TjIHPc76XzhI43CZLLGIcRxipWk=;
        b=uD3EW+QKyZva07XPOF9yRcfVCiM6EX1d651TPPtVQY2fmsceNQT4Qmp3G//q0QR6Ka
         PzHnmXAfHEz7tPwM9xWrOIVWvnlSVkhzzQWW0PIloB+Myq/JqXmPguNs7VNqQfYHmQVs
         HcfVH6jO0AnyfR2dGxwyzM9jMNLG3yI3s2qBovWLLLgiBTzLFc3kTNSV+/wXPRvK21D3
         6cE0m7IybzMX38e5CA9EXGVoU2SMEZxd2GB4KIBDjc45SeiqEpMY4/GRx4AVFS9BnBwi
         hOVKkLAjzZMWZFjhdp0oxou4pzcab+T7zzNkIbbvN8vCV3egNZo3IYzWqWPg6Gq77m+L
         OiXA==
X-Gm-Message-State: ANhLgQ3tCIaw7vuFvkXO7lci6Ob6xp0QlGmN0HKwHm8IEHKr7nkfCKmn
        f4+dowrdajlWblXWvdfMzO8=
X-Google-Smtp-Source: ADFU+vuR0OA5/WFl9EmZWoqAFFlsI+4zgATJyre6DXFjFK21Tf2qFXC61QFEmGrIOKLhkTT/qH1Tzg==
X-Received: by 2002:a2e:9256:: with SMTP id v22mr6134814ljg.45.1582979181557;
        Sat, 29 Feb 2020 04:26:21 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id r10sm8950775ljk.9.2020.02.29.04.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Feb 2020 04:26:21 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?q?Jer=C3=B4me=20Brunet?= <jbrunet@baylibre.com>
Subject: [PATCH v5 2/3] dt-bindings: arm: amlogic: add support for the SmartLabs SML-5442TW
Date:   Sat, 29 Feb 2020 16:25:23 +0400
Message-Id: <1582979124-82363-3-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582979124-82363-1-git-send-email-christianshewitt@gmail.com>
References: <1582979124-82363-1-git-send-email-christianshewitt@gmail.com>
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

