Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2ABC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9C3720838
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585265365;
	bh=ZRHdGGkfhDo9JmWaKIaBpioaKTS8YGwYZySmOSLLH3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GJeEDzWMJO3hVKZG2nGA2fmwPSULRovUfF8lrdj0t61D9yPw/wZoPT7QvDsa8635P
	 Lk72JY2d+7rp0HCBXxIq3JyYhhPJEmsE0FaY6HFlgBjLQMXF9vmZSs6b2mEc/q6q9F
	 H/M7klA0rgeBhASjK7OVm9v14P5gvqcZS/M0RHAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgCZX3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:29:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:43490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727763AbgCZXYL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:24:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2E712073E;
        Thu, 26 Mar 2020 23:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585265050;
        bh=ZRHdGGkfhDo9JmWaKIaBpioaKTS8YGwYZySmOSLLH3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lpWCw+o3Lzyeb3v2W7qUHZmwt0w866oJoEhrkq7wpkZuT3d7Bl+MsvSVw1PNF6Uv4
         YQd7OiJ9Upg8hep94K7HC+UKHmjmRkuoQMpZE9MKwHQxIJKv66tjWU69OAb4VfkfI9
         k6b88arYbbDfNFfkDZdnluhjvWx5p/ydTf5aC8qU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 11/28] initramfs: restore default compression behavior
Date:   Thu, 26 Mar 2020 19:23:40 -0400
Message-Id: <20200326232357.7516-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326232357.7516-1-sashal@kernel.org>
References: <20200326232357.7516-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

[ Upstream commit 785d74ec3bbf26ac7f6e92e6e96a259aec0f107a ]

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
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 usr/Kconfig | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/usr/Kconfig b/usr/Kconfig
index a6b68503d1774..a80cc79722745 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -131,17 +131,6 @@ choice
 
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
@@ -214,6 +203,17 @@ config INITRAMFS_COMPRESSION_LZ4
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
 
 config INITRAMFS_COMPRESSION
-- 
2.20.1

