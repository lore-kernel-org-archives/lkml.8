Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7998C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FDE722269
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593455944;
	bh=qGJ5DDy7rlDuo2pRmRcnAX1JmoERfK/OVkePHNpPWHI=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=kkhpkRugR2C8b3s7vmSTYhxx/vbRU6izG81rdu14mA+u2wjBnUBKnsFpihgxEihLP
	 jSHaYvLHyjwfLd/r//kOmbTAySjq3Qd9Jw0gPmxDhzlf3jKerK5TN6iAkxCzfBFiuB
	 Y/NuJ0Kpb/x199fQ7dgvV63XjpovxZg7h/Y89Q6k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgF2SjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:39:02 -0400
Received: from condef-07.nifty.com ([202.248.20.72]:27946 "EHLO
        condef-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbgF2Si6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:38:58 -0400
Received: from conuserg-07.nifty.com ([10.126.8.70])by condef-07.nifty.com with ESMTP id 05T90bCW006206;
        Mon, 29 Jun 2020 18:00:37 +0900
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 05T8xLJe008001;
        Mon, 29 Jun 2020 17:59:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 05T8xLJe008001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1593421162;
        bh=NsoI4eUWa9rbUruhM1nTxkmNquCZM22p5ZB+WQfFzbo=;
        h=From:To:Cc:Subject:Date:From;
        b=jlSAjWegy8blUBTbRWrR5LNbNgr+6sUDD4Su7dkk7/TngS4kv/cGl5CqqGQPCyhQF
         yaIh4+2pg6hFIu5K8J+1ewz7WazZuH1klic6KdWxuUZM91ZiTuWr+F/Lx55k2x8ePl
         YUi546bppwJS8+0NfM6Iaqyq1rbRx3iEvZ52Ce4fFhJsQzVq2evnmJGBucgtDOnSNh
         fDUvrxvKIJtNpfDugb7tMgAzjetNTgFKL0b2qEJrcxj5+QxMgfEspn+eQVtrayLXXG
         /YjvcMt020z2AGxBKcK+PSX9SCjJ/LYcww+LGsXlAHmzNhCS9qAn2tyShs71A6kva4
         CWLaMR6NrddZw==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        clang-built-linux@googlegroups.com
Subject: [PATCH] kbuild: make Clang build userprogs for target architecture
Date:   Mon, 29 Jun 2020 17:59:11 +0900
Message-Id: <20200629085911.1676554-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Programs added 'userprogs' should be compiled for the target
architecture i.e. the same architecture as the kernel.

GCC does this correctly since the target architecture is implied
by the toolchain prefix.

Clang builds standalone programs always for the host architecture
because the target triple is currently missing.

Fix this.

Fixes: 7f3a59db274c ("kbuild: add infrastructure to build userspace programs")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 73948798ce3f..cac29cc2ec25 100644
--- a/Makefile
+++ b/Makefile
@@ -970,8 +970,8 @@ LDFLAGS_vmlinux	+= --pack-dyn-relocs=relr
 endif
 
 # Align the bit size of userspace programs with the kernel
-KBUILD_USERCFLAGS  += $(filter -m32 -m64, $(KBUILD_CFLAGS))
-KBUILD_USERLDFLAGS += $(filter -m32 -m64, $(KBUILD_CFLAGS))
+KBUILD_USERCFLAGS  += $(filter -m32 -m64 --target=%, $(KBUILD_CFLAGS))
+KBUILD_USERLDFLAGS += $(filter -m32 -m64 --target=%, $(KBUILD_CFLAGS))
 
 # make the checker run with the right architecture
 CHECKFLAGS += --arch=$(ARCH)
-- 
2.25.1

