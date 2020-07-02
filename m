Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE19C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8197E2088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RVKW46yT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgGBNDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbgGBNDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:03:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3446C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 06:03:02 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a6so28229428wrm.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 06:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=x2lA0vz00OTlAj+9Kz23JP9p077e3dHraXNS67DafIc=;
        b=RVKW46yTAzAtHojQVUDNiUxwnwUcZ4Yd3oySCwHODKzFX/kBHSA+oWKIolTGJ5Rdcx
         S8VpDZgJBbPDAVIUw5yq5Jz3SO/9ehY4wWvunFdmaG2rvxo1t7mcvyo4HUTW/CFK97Zg
         SZ7CvgicqOrQBGx5Sx/uycZZD+w/Go3lHprfvDN3bBZXPJLZ+I1mCCV2zgkIfxUdcCoO
         vtaMnR0JCnRJ+2GF/fXCcFQKb9qCJlVibfIBhQLFFSe3lDuJJOSurDnJhSW3UaJqjOTn
         Vzzo5aBKkKC63uFmDknjlOMlDHX7a/d07akeZ+Zj3JVj51REcX4fQiJQEf8M3NAwwj43
         79VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x2lA0vz00OTlAj+9Kz23JP9p077e3dHraXNS67DafIc=;
        b=kU7cvtcmWMVCKFRYKm747M4XoywGXH2WxlGDJReRGd5V6DyUIJssw0zJq1aMMyAvED
         PHNZ0fT6Oybtfiarlf1oaL+H45jVOltCSx2AXUd4OBaw/byEdN8R1kthhudIJGmbGE3g
         zJdG8R5xObQuxEIBDJ2Fq+ma2+FQ17dm1ofMtglg3do81Nw3TGuxVyb2LiJnnahZtaM4
         0KHWNFRFF2eIVX4pFMZ4Zp02oMmUpWqSVKbmuP+x/64kcMBBehertfRChL8tdIBo/LPL
         CEgVIV1iJ8h3gOAPBN7Z9E6y3Xg4nceUzbVMBQueztSgeOjfcujNFaQ5dsanLA0UE0MB
         vpPQ==
X-Gm-Message-State: AOAM530+xV8SFViaOLTuyhP2wLsEpi3EDIFDOwoyrZ4tBzMg/pm3kVII
        CVWEeZ3ZBBDeRl8FuGrxVatxFQ==
X-Google-Smtp-Source: ABdhPJymk3QivoerF/S8PXzgdK1lEnCpMnYEhDUM5z2AAHBc06l8cYm3IQKaua7ZIcfwVS0yy+z5TQ==
X-Received: by 2002:a5d:518a:: with SMTP id k10mr30828663wrv.316.1593694981446;
        Thu, 02 Jul 2020 06:03:01 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id j4sm6255287wrp.51.2020.07.02.06.03.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 06:03:00 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] sparc: sparc64_defconfig: add necessary configs for qemu
Date:   Thu,  2 Jul 2020 13:02:53 +0000
Message-Id: <1593694973-34113-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sparc64 qemu machines uses pcnet32 network hardware by default, so for
simple boot testing using qemu, having PCNET32 is useful.
Same for its storage which is a PATA_CMD64.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/sparc/configs/sparc64_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sparc/configs/sparc64_defconfig b/arch/sparc/configs/sparc64_defconfig
index bde4d21a8ac8..61073f48a7a1 100644
--- a/arch/sparc/configs/sparc64_defconfig
+++ b/arch/sparc/configs/sparc64_defconfig
@@ -236,3 +236,6 @@ CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRC16=m
 CONFIG_LIBCRC32C=m
 CONFIG_VCC=m
+CONFIG_ATA=y
+CONFIG_PATA_CMD64X=y
+CONFIG_PCNET32=y
-- 
2.26.2

