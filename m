Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D850EC11D0B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE555207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsI+M80q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgBTPeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:34:03 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:38793 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgBTPeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:34:02 -0500
Received: by mail-lj1-f176.google.com with SMTP id w1so4685926ljh.5;
        Thu, 20 Feb 2020 07:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5019G7yq0avtfjWMAOLceayBMfSqRFTAMAXEQqHSZug=;
        b=PsI+M80qxN2gYjTcQsbtfNJtVJnILU6F6Pv0qT2SjfyhK7SbCDRjMkVsmi0o58N92h
         jo1mk5IJLbW1Sk6MFhu5ArFVWD8JLaSvfqyMXdkjA4LpSPjO3bML7zdrgMZSzLXpCZRp
         8iycMu+EvI+4tGPi/zOrMKWYEQV6JJ52eBc36UdfycUYYNtzG4qAYMCLxmgNHL+J2dzQ
         nIMCbMTBfJL4irXeigijEE8IoCits1/LDSTG3cC8hRebJB11KN/PN9LKSCySNQX9hxAq
         txCc9nafhCKlncTgwzei8TsKc1XsE1RrwlCyMERKM8EtDl/N/oaV9svC/1PI0UvfO0v7
         G49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5019G7yq0avtfjWMAOLceayBMfSqRFTAMAXEQqHSZug=;
        b=YyVD1nwwGwPNnJVbrBuscAcy9hvtIeOxiYo2zfD81/r/SojzVYC/WYwnOCMurr+g8v
         t/1LucPSWgKY9rgMAxkUa1LZGNI0Xqaduh8YghDPWOPKCInp/z5U9QmwaCt29JWRpKge
         gZdHuIQiGZhzPEcvmOsnzkppy3cDuQnlu5PKVok7Sb6dOxOuyw/rax7g5xR3DgJZZB6/
         gvhS+ksCpkmhPwfWE+3PN5reJVyoh7nHt8w6QcwUq1dYMUkJnjuA3j/c+gGCB3qWo/zg
         1WnaB5DqYY2emJklRBHqUt66IVd9OcSVhCvN1GhfhLZzIMwgNRGzcpDcq/ZePlqHx/Fm
         1mEw==
X-Gm-Message-State: APjAAAVgiy+bek9c3lm7C3frZBRkyCBgk7JVUNUxmVk4MdQcc3bHVlhS
        23VDunAIQz0E+P6vpj2VD1c=
X-Google-Smtp-Source: APXvYqxaGUst+wKhSuMt86KQ7TYw1ssovVjk09fGgxif+X+Hf39ciAP//EaX7mfFGKuhhUseY3kzUg==
X-Received: by 2002:a2e:8698:: with SMTP id l24mr19404158lji.94.1582212840413;
        Thu, 20 Feb 2020 07:34:00 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id u13sm2162285lfq.19.2020.02.20.07.33.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Feb 2020 07:33:59 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Art Nikpal <email2tema@gmail.com>
Subject: [PATCH] arm64: dts: meson: fix gxm-khadas-vim2 wifi
Date:   Thu, 20 Feb 2020 19:33:10 +0400
Message-Id: <1582212790-11402-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: adc52bf7ef16 ("arm64: dts: meson: fix mmc v2 chips max frequencies")

before

[6.418252] brcmfmac: F1 signature read @0x18000000=0x17224356
[6.435663] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4356-sdio for chip BCM4356/2
[6.551259] brcmfmac: brcmf_sdiod_ramrw: membytes transfer failed
[6.551275] brcmfmac: brcmf_sdio_verifymemory: error -84 on reading 2048 membytes at 0x00184000
[6.551352] brcmfmac: brcmf_sdio_download_firmware: dongle image file download failed

after

[6.657165] brcmfmac: F1 signature read @0x18000000=0x17224356
[6.660807] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4356-sdio for chip BCM4356/2
[6.918643] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4356-sdio for chip BCM4356/2
[6.918734] brcmfmac: brcmf_c_process_clm_blob: no clm_blob available (err=-2), device may have limited channels available
[6.922724] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4356/2 wl0: Jun 16 2015 14:25:06 version 7.35.184.r1 (TOB) (r559293) FWID 01-b22ae69c

Suggested-by: Art Nikpal <email2tema@gmail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index f82f25c..d5dc128 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -327,7 +327,7 @@
 	#size-cells = <0>;
 
 	bus-width = <4>;
-	max-frequency = <50000000>;
+	max-frequency = <60000000>;
 
 	non-removable;
 	disable-wp;
-- 
2.7.4

