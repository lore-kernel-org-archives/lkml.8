Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97FCC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 11:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B3820719
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 11:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="c8RzpxQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbgCPLZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 07:25:24 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:54000 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730738AbgCPLZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 07:25:24 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 43CA243B4A;
        Mon, 16 Mar 2020 11:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1584357923; bh=9kqwUFTVykdq41YKf9JuOJHOlrQqWcymz/r9vr3SsOo=;
        h=From:To:Cc:Subject:Date:From;
        b=c8RzpxQixAtzfR/7fALxwWaktuPQ7m0knkNAAQQh1OtCKS9iOHPGPysBP4Zynpx73
         jzC6JZc4ppeEec2l4TC2SFkaCpWrYWi/6egCPWBRIBVzfM2E0Aaz4ZTGGl0ViDodSp
         FMoI7I35h/qkPMPN7RG7lap5vRMtqU9M5RYQ6Hu4o+6H8D5xm0QOY/JYWC+kceHLOx
         fQ5IFNJwhKUrg1heKQouizyhSI9Y2eal6r+39CY1ax/4yFuLXhDbjtTNBdDRRnJgFG
         GrAeSpcO4ZRJMu1ZG4Zci5TrnfaXAWsmvqNCrZgd+UQDS/XIP5yZ64ZFl4AjgLJwUx
         c4ttMXi7iLq0w==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.79])
        by mailhost.synopsys.com (Postfix) with ESMTP id 3C42FA005B;
        Mon, 16 Mar 2020 11:25:21 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v2] initramfs: restore default compression behavior
Date:   Mon, 16 Mar 2020 14:25:19 +0300
Message-Id: <20200316112519.4375-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even though INITRAMFS_SOURCE kconfig option isn't set in most of
defconfigs it is used (set) extensively by various build systems.
Commit f26661e12765 ("initramfs: make initramfs compression choice
non-optional") has changed default compression mode. Previously we
compress initramfs using available compression algorithm. Now
we don't use any compression at all by default.
It significantly increases the image size in case of build system
chooses embedded initramfs. Initially I faced with this issue while
using buildroot.

As of today it's not possible to set preferred compression mode
in target defconfig as this option depends on INITRAMFS_SOURCE
being set. Modification of all build systems either doesn't look
like good option.

Let's instead rewrite initramfs compression mode choices list
the way that "INITRAMFS_COMPRESSION_NONE" will be the last option
in the list. In that case it will be chosen only if all other
options (which implements any compression) are not available.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 usr/Kconfig | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/usr/Kconfig b/usr/Kconfig
index bdf5bbd40727..96afb03b65f9 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -124,17 +124,6 @@ choice
 
 	  If in doubt, select 'None'
 
-config INITRAMFS_COMPRESSION_NONE
-	bool "None"
-	help
-	  Do not compress the built-in initramfs at all. This may sound wasteful
-	  in space, but, you should be aware that the built-in initramfs will be
-	  compressed at a later stage anyways along with the rest of the kernel,
-	  on those architectures that support this. However, not compressing the
-	  initramfs may lead to slightly higher memory consumption during a
-	  short time at boot, while both the cpio image and the unpacked
-	  filesystem image will be present in memory simultaneously
-
 config INITRAMFS_COMPRESSION_GZIP
 	bool "Gzip"
 	depends on RD_GZIP
@@ -207,4 +196,15 @@ config INITRAMFS_COMPRESSION_LZ4
 	  If you choose this, keep in mind that most distros don't provide lz4
 	  by default which could cause a build failure.
 
+config INITRAMFS_COMPRESSION_NONE
+	bool "None"
+	help
+	  Do not compress the built-in initramfs at all. This may sound wasteful
+	  in space, but, you should be aware that the built-in initramfs will be
+	  compressed at a later stage anyways along with the rest of the kernel,
+	  on those architectures that support this. However, not compressing the
+	  initramfs may lead to slightly higher memory consumption during a
+	  short time at boot, while both the cpio image and the unpacked
+	  filesystem image will be present in memory simultaneously
+
 endchoice
-- 
2.21.1

