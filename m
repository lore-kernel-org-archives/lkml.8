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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6731C3F2CE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 12:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE512246AE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 12:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqSkBkPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgB2MRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 07:17:05 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44338 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726933AbgB2MRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 07:17:04 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so6343801ljj.11;
        Sat, 29 Feb 2020 04:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PUiZOEdutWx8wS79TjIHPc76XzhI43CZLLGIcRxipWk=;
        b=MqSkBkPBjk04hDgppfgMJuLujoJVKcBQ5q/pGfqNOON1r+G8cFy9Fwl71ZDKrOBB7G
         38bN0QnqC/p/UmggV6vnGEHyM88wktMmAmsm4p/cIRMKlnyuImkUwUmjozUas1zUvhYN
         NMvvE0uRO4QkHVcn5tTFNJYjQ8kjXGkd1WX44GJeFbmCLflh3yn4ZAWYZ4BbI18xreuG
         ycix+XYCpq/TOF7t7W7115rZKH4qxmSgLX3pWCxpz3QKoLsDgC9r/wYIQa+MUxxBOmGP
         t80vPcDRTeiAOWpGc6E+D43k9Xlvu7hODHjqnF8mEV5n3trfUK9w1ppUo8Iiqo2SoeQU
         u0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PUiZOEdutWx8wS79TjIHPc76XzhI43CZLLGIcRxipWk=;
        b=rGNeACfy41+HyiKg9KFvTl8PJh1ItzTda2g4bxnIUYLyJvtzoWqD1lre/gwzv4U06D
         uMtxnGcNIwlqa9X9y1tgH5m4AMTtnt1OuN0moqDgRzRd9uOUfEJui7nNne8f8ikPW7fD
         7HUJLNp7iyqTHeb9M2oi3bNvud10xEPhUTVb4Ge20nKVASEC0fuFnfKPRf7Hg8opWS82
         SAKVD+RRnodxjxc+lfzQ7SEHNd6wBqQqey0zhMpZm0bslh+1NbWV9RV702b+v2Tk5qJq
         PyN8yicao+GwGyHaPsWvNAKNsklRn41UhxxiOq2UlB9xhcAlxIjUvc9I7urI2ZHZG3Kw
         RNwA==
X-Gm-Message-State: ANhLgQ3KRhOY/7iNEaqkkf2TDuRNWfwswkTB/LimKMRg+Xw9uJZHghwZ
        ja3mybgMluZEBw6uuBa0RKI=
X-Google-Smtp-Source: ADFU+vtfyu/zEdv25VmM2ipzV3WThAztgg3/ulDhJPTfCVRbLqJ1yuJVjWhhAABZXUtB1ZxQ3NGdfQ==
X-Received: by 2002:a2e:9592:: with SMTP id w18mr5817470ljh.98.1582978621446;
        Sat, 29 Feb 2020 04:17:01 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id x1sm6270232lfq.46.2020.02.29.04.16.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Feb 2020 04:17:01 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?q?Jer=C3=B4me=20Brunet?= <jbrunet@baylibre.com>
Subject: [PATCH v4 2/3] dt-bindings: arm: amlogic: add support for the SmartLabs SML-5442TW
Date:   Sat, 29 Feb 2020 16:16:03 +0400
Message-Id: <1582978564-81491-3-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582978564-81491-1-git-send-email-christianshewitt@gmail.com>
References: <1582978564-81491-1-git-send-email-christianshewitt@gmail.com>
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

