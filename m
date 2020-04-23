Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333ACC54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DEB721707
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587627665;
	bh=im15wNX38X3WBMZn7zLM7iy+W2/88axSa1j9i6Y8Al4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ahcPSrVUolFK+cUaMrLOjxW914FGi0/nlsmWmbNXkBGg72ZBqtMKVNQLTuDx6BMof
	 pXR2FHU7kot6vvNoJLtJXMB6kFXgk8nMVpLvOmOzs0UkgADHzsUy6QRGrO7aHqgy4X
	 l3TMQ6EYc/NgflZjrf7RPjc5Df2ZvVJuWYdNf228=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgDWHlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:41:03 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:31893 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgDWHkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:40:37 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 03N7dV9U000368;
        Thu, 23 Apr 2020 16:39:42 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 03N7dV9U000368
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587627582;
        bh=kpWIErtGjk+nNiQCQS8fEiXHwNw1IZLOOB6A61EUzm8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VxTjkNLJBDbRlV2i7A0jgoROkuz9K4mzv2x5QFyQWrtJqgp6W4U4oyswxIO+nQAvU
         iMost6bPmumftTJ2qXqI/QQbWE5nZQjwe1fabqi/cvQYUp3LGs+sIluHW6KAOhvkH3
         Hk7hUm5DAjWoX2BpVW2q3iSr20o/+toAXczljOrN7Rqs6R+p+rYKs5/gtIBDAA5EI9
         UoW49eQe5Gc/jcf1TBUBoRnTBsFkWNLBFVNNOCOMmNG9soqUZdwy6Pvumr6EyrUYfI
         cbLdZFfdqk/w45zUF8fS3OKRbFq2r+/Ro/dhWTEVtdh+4efDvd0RaA7KZ6PvLFjKuN
         ikwwRzJvGnKFQ==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     bpf@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/16] samples: hidraw: build sample program for target architecture
Date:   Thu, 23 Apr 2020 16:39:22 +0900
Message-Id: <20200423073929.127521-10-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200423073929.127521-1-masahiroy@kernel.org>
References: <20200423073929.127521-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This userspace program includes UAPI headers exported to usr/include/.
'make headers' always works for the target architecture (i.e. the same
architecture as the kernel), so the sample program must be built for
the target as well. Kbuild now supports the 'userprogs' syntax to
describe it cleanly.

I also guarded the CONFIG option by 'depends on CC_CAN_LINK' because
$(CC) may not necessarily provide libc.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 samples/Kconfig         | 2 +-
 samples/hidraw/Makefile | 9 +++------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index ff9126ef1c79..2e0ef2cc1aa8 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -118,7 +118,7 @@ config SAMPLE_CONNECTOR
 
 config SAMPLE_HIDRAW
 	bool "hidraw sample"
-	depends on HEADERS_INSTALL
+	depends on CC_CAN_LINK && HEADERS_INSTALL
 
 config SAMPLE_PIDFD
 	bool "pidfd sample"
diff --git a/samples/hidraw/Makefile b/samples/hidraw/Makefile
index 8bd25f77671f..752ed03cdb64 100644
--- a/samples/hidraw/Makefile
+++ b/samples/hidraw/Makefile
@@ -1,8 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-# List of programs to build
-hostprogs := hid-example
-always-y := $(hostprogs)
+userprogs := hid-example
+always-y := $(userprogs)
 
-HOSTCFLAGS_hid-example.o += -I$(objtree)/usr/include
-
-all: hid-example
+user-ccflags += -I usr/include
-- 
2.25.1

