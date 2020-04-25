Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74958C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 13:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A8EA206D4
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 13:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587820721;
	bh=LjoquMDwEG/L1MjD6QvwNri81iJYMemhxJ/D4EVYwPM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=aQ0CO6q4QRrR2FS4qdRQTV1iIh0bkiyGHKZSHfBfndiBLf5lRQlLGu96QaLc886pb
	 +ng1wCd3pn74a2xbcY+SO4xKu3SXy98gYXErb0yw9ZL7l9rD079biybX0V2X7TstiV
	 bpqR8W6WacdqhTAJkb9m5/Ml/utPkIBEIbZm4XGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgDYNSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 09:18:40 -0400
Received: from conuserg-11.nifty.com ([210.131.2.78]:65507 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbgDYNSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 09:18:40 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 03PDIDvH012736;
        Sat, 25 Apr 2020 22:18:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 03PDIDvH012736
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587820694;
        bh=4wJMY/yVTi4OrEzrVB0KyV0x5odpNOOIs5tMD7YU73I=;
        h=From:To:Cc:Subject:Date:From;
        b=cju21PMn5X7EMslYU0iOp1Mg4VGuvlYQ2z0pBe8h0aykXIX/S88l/xFg9KckL3wU5
         tB70tBfguHZ6tey42fYn1k7ci3KB1VWhekA1TEXrM6wbKxYTevZl28C73KxYLdOsGp
         IhqhMc9CjBc0oTDdf83NQryOD9+tQLaiJR7Bo9gh8YTF5KdgvtanEQJ9CsjD7oWwQ1
         5ezT2Uq3HdoKymgfiBeULd0EibvN2QklxwgV8VdxZ9s+w1e7jA2IvW1MIm6s3fbfiQ
         KhTj78UBewyaAsxMS+w+yGiZ91PTYmgtA4MSlw4L/holz3UwrDdnkGbwInE52NRj6W
         UC7nepl5GfjEQ==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove '/' target
Date:   Sat, 25 Apr 2020 22:18:10 +0900
Message-Id: <20200425131810.991717-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This notice has been here for a while. Remove it entirely now.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Makefile b/Makefile
index 49b2709ff44e..95c2d8c2dfe8 100644
--- a/Makefile
+++ b/Makefile
@@ -1650,10 +1650,6 @@ _emodinst_post: _emodinst_
 clean-dirs := $(KBUILD_EXTMOD)
 clean: rm-files := $(KBUILD_EXTMOD)/Module.symvers $(KBUILD_EXTMOD)/modules.nsdeps
 
-PHONY += /
-/:
-	@echo >&2 '"$(MAKE) /" is no longer supported. Please use "$(MAKE) ./" instead.'
-
 PHONY += help
 help:
 	@echo  '  Building external modules.'
-- 
2.25.1

