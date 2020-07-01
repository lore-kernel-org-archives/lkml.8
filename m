Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6B8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B61F62065D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 03:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593574224;
	bh=2MoVySu/ublseimSBPc25bFEnUgfYf0OXy9TbR5xyWU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Dbm5S5SvbpZBSTomN8edxbECJqYUgmOxNCr9ObV2VVXnOw9SWp7Cd7Nzu5VifL/4q
	 kBmfDYas6xwL1yhebVPZED2Z7DZURdeJDoCQG+GrXx9/2uIFBRQFc7nMgecL4hmy4G
	 Lx7k71eG7dgSTEi3u0UUPNlFxAsD0axQiP8vhGic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgGADaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 23:30:23 -0400
Received: from conuserg-07.nifty.com ([210.131.2.74]:46532 "EHLO
        conuserg-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgGADaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 23:30:23 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 0613Trw4014075;
        Wed, 1 Jul 2020 12:29:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 0613Trw4014075
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1593574194;
        bh=0Z1bbyiVQq41ZTVNj6Alel59TFbFFxJ8BkSvlKkpLvc=;
        h=From:To:Cc:Subject:Date:From;
        b=jrhAgf9S5/WyiK0vuVYeAX9ymxYQAryLXq0e2vbz9u4A6nweLovrJb7jAaUryqoxx
         LD3cvgngZBwHNDPJioP2CvStuPJ3VJnwedMWZT6q4DYmD5POlAYdFot70q03FloH3C
         YhJfXrFNxPoxADay/bEJZ+LyQRPUoLv2YmoF1fgw+NB9bEgCFudy5U6oRwQOcLL3G4
         CbqdVNeUpwXjk9K0KbcKXhZvw+ZgiaZSQFmuEJuVsDLmCNp9VoAD/YtS7ajOu6HPCA
         wkfp4SzTEGsHhQRliGR199huDeQ8bfi+CJk5tQK28UHb1pvMBXaaf9Alo+bDcYvhX5
         3/WFeJCZ1iBkw==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: always create directories of targets
Date:   Wed,  1 Jul 2020 12:29:51 +0900
Message-Id: <20200701032951.409675-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the directories of objects are automatically created
only for O= builds.

It should not hurt to cater to this for in-tree builds too.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.build | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index ca24c3077fef..98013fcde935 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -517,15 +517,13 @@ existing-targets := $(wildcard $(sort $(targets)))
 
 -include $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)).cmd)
 
-ifdef building_out_of_srctree
 # Create directories for object files if they do not exist
-obj-dirs := $(sort $(obj) $(patsubst %/,%, $(dir $(targets))))
+obj-dirs := $(sort $(patsubst %/,%, $(dir $(targets))))
 # If targets exist, their directories apparently exist. Skip mkdir.
 existing-dirs := $(sort $(patsubst %/,%, $(dir $(existing-targets))))
 obj-dirs := $(strip $(filter-out $(existing-dirs), $(obj-dirs)))
 ifneq ($(obj-dirs),)
 $(shell mkdir -p $(obj-dirs))
 endif
-endif
 
 .PHONY: $(PHONY)
-- 
2.25.1

