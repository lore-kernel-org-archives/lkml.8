Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAE7C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E47208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UBnXq874"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgCKKWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 06:22:30 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:40646 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725976AbgCKKWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 06:22:30 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 31C1BC0F5E;
        Wed, 11 Mar 2020 10:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583922149; bh=B0LXRtnUY0xELU3mx53c6L8Wx4Nfptiv5Yp8NrUU6DY=;
        h=From:To:Cc:Subject:Date:From;
        b=UBnXq874oIsln5Amvel0BR0LjABeaesLXcas6MKMh44VGKD9YBtRyNW7u/C/dP72p
         ulwxGZyEn4chRN4S/A7Tiea10r2EK5h5GBJUy/I0GruTqXgPY+EMJki7vCdBQnywHz
         9WNpkGDwTytopwbselofdngzn7OPGcuE0+Xj+7VQmwMG2sL0h53jVX6RsRFwR8c7Dk
         J4KWcvHomJ4qovvKeiB6wmxx6rnkEzoLtWMvbp0xdXXO3TtVWqAi2Z2DlCiMYXe7V9
         USBm7oThR1eEeKmn7/qftRJ2vLw2ndCGlqhBOGB/SJR4kxt+6miQj/2f1rF2vAqBgI
         56RaKM5RyqPxQ==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.8.79])
        by mailhost.synopsys.com (Postfix) with ESMTP id 12B66A005B;
        Wed, 11 Mar 2020 10:22:26 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-snps-arc@lists.infradead.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH] initramfs: restore default compression behaviour
Date:   Wed, 11 Mar 2020 13:22:17 +0300
Message-Id: <20200311102217.25170-1-Eugeniy.Paltsev@synopsys.com>
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
being set.
Modification of build systems doesn't look like good option in this
case as it requires to check against kernel version when setting
compression mode. The reason for this is that kconfig options
describing compression mode was renamed (in same patch series) so
we are not able to simply enable one option for old and new kernels.

Given that I propose to use GZIP as default here instead of NO
compression. It should be used only when available but given that
gzip is enabled by default it looks like good enough choice.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
 usr/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/usr/Kconfig b/usr/Kconfig
index bdf5bbd40727..690ef9020819 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -102,6 +102,7 @@ config RD_LZ4
 
 choice
 	prompt "Built-in initramfs compression mode"
+	default INITRAMFS_COMPRESSION_GZIP if RD_GZIP
 	depends on INITRAMFS_SOURCE != ""
 	help
 	  This option allows you to decide by which algorithm the builtin
-- 
2.21.1

