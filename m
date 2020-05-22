Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC701C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 02:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6A7B2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 02:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590112828;
	bh=SQmtTFuVd79cdfCcZYMqbZHmgdY3QmLi9wAgXaEyczc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IGagWg1OUd5caKxv0pzI4EwfmEpr8vsDR79ZQNhABoYBRKUS3ShHbWYlichKXQkA+
	 RLUK6VZUACpCYwL19m7TfrVk5nZgba2iqp8eY2/SS+h1w6IjeK4y/9Qht6OP/0urKI
	 rWt5Dt+/cIaVZ5liz2b3Kj19AcLgC0q8QCuGnHfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgEVCA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 22:00:28 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:37242 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgEVCA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 22:00:27 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 04M205UY009585;
        Fri, 22 May 2020 11:00:09 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 04M205UY009585
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1590112810;
        bh=dbhmn93DYcq1CwpbzW5tE0+OrtgaGmet5z0CDnvyloI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qgIScu1vmTas3XiGny1RBldzs77Tb9sXQ/0vDuHvptOROSDNeaxrDnaTFS7tGTAEq
         kUqOdbsqhT7mAcFm/CtJFOM7FNmFdXA4eykmnopV99SzWUqOVxXss+WF8duQWEYO6d
         FP3cXtRCsY6qCV/jpPfB6324TCH/G/t5HwqgzYZ4BENk3eUPZEBBBRMPohVH/k/brQ
         Or4PDgZwvp39G67E9APWYtmbq7O3HRMvVIxhZfLFuGjFEBQ/+r/dMyKp7roiz0OHGi
         aghZfFiAcIhKrXppUo6p26xfm1h8n3QBlApT3a/baaQ2mu00meHEWko6uPL5K00kxU
         c1wXJB2o1ttKQ==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] kbuild: clear KBUILD_MODULES in top Makefile if CONFIG_MODULES=n
Date:   Fri, 22 May 2020 10:59:59 +0900
Message-Id: <20200522020002.504506-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522020002.504506-1-masahiroy@kernel.org>
References: <20200522020002.504506-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not try to build any module-related artifacts when CONFIG_MODULES
is disabled.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile               | 4 ++++
 scripts/Makefile.build | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1f5bbfb31103..72eb55a36545 100644
--- a/Makefile
+++ b/Makefile
@@ -1724,6 +1724,10 @@ build-dirs := $(foreach d, $(build-dirs), \
 
 endif
 
+ifndef CONFIG_MODULES
+KBUILD_MODULES :=
+endif
+
 # Handle descending into subdirectories listed in $(build-dirs)
 # Preset locale variables to speed up the build process. Limit locale
 # tweaks to this spot to avoid wrong language settings when running
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 9af88f4cacb8..f46d25441804 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -77,7 +77,7 @@ ifdef need-builtin
 builtin-target := $(obj)/built-in.a
 endif
 
-ifeq ($(CONFIG_MODULES)$(need-modorder),y1)
+ifdef need-modorder
 modorder-target := $(obj)/modules.order
 endif
 
-- 
2.25.1

