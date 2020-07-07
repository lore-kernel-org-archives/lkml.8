Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770B2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F72206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 16:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594139760;
	bh=/oGk6s3G9VWmHSKu8MF25HCGJzwlM7IGAstZoDj63Tw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=blLKPfWqxzy8G/lF+WJVesu+HXViaJuV/fSu6UwLXtr63XcNEYP4xvpMhOmJ3xYUy
	 ArVKwxNdGV2J5IpsEqt4JrkEeckeLvKv4Od3uL6E/l9fFEBYYzQNEck73I2G19vB+L
	 0zjArHmLHuOwng1ijoA+p4dyEP0O9WpyIri0sNKQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgGGQf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 12:35:59 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:41914 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGQf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 12:35:58 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 067GZBhP024676;
        Wed, 8 Jul 2020 01:35:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 067GZBhP024676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1594139711;
        bh=Z7GDlYHkzBXkrrr5njoj7vSAxyMLh9VxFTcJmiipgQc=;
        h=From:To:Cc:Subject:Date:From;
        b=yrjdBlh2uYYEYpsif49lXGJrty+acA7R8ghKFFso/LrhlVuarwE+Q4M+6K/J6b/pX
         QicqdzQ7Zr62FaCY6Stj1JBUJduWeThE0jBGdOzyOoV9Tl/ZZ+Ut9k9Ivv/TsZtMkr
         KtL/K26dDzLTmAoo3hfBly/N89JBy5uQwiebV1J87QshFMwXA7ifzzo+sT3hOjv3we
         AGUfZzqL5o2pyAeAk8bVgdM5OxkCcgAh8Km8cRweCymIaA4i5D7/bFOTr6RsHfqk6J
         VqN7hOl/LjM/iHMFApoiTBVorsUJlCQIBB+K3+bE/ydMwyyoe16ak3pS/XDSuuoSLI
         ISQPLMDdGv2eA==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     =?UTF-8?q?Bj=8F=A9=CCrn=20Mork?= <bjorn@mork.no>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: fix single target builds for external modules
Date:   Wed,  8 Jul 2020 01:35:08 +0900
Message-Id: <20200707163508.1191105-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f566e1fbadb6 ("kbuild: make multiple directory targets work")
broke single target builds for external modules. Fix this.

Fixes: f566e1fbadb6 ("kbuild: make multiple directory targets work")
Reported-by: Bjørn Mork <bjorn@mork.no>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index fe0164a654c7..676f1cfb1d56 100644
--- a/Makefile
+++ b/Makefile
@@ -1754,7 +1754,7 @@ PHONY += descend $(build-dirs)
 descend: $(build-dirs)
 $(build-dirs): prepare
 	$(Q)$(MAKE) $(build)=$@ \
-	single-build=$(if $(filter-out $@/, $(filter $@/%, $(single-no-ko))),1) \
+	single-build=$(if $(filter-out $@/, $(filter $@/%, $(KBUILD_SINGLE_TARGETS))),1) \
 	need-builtin=1 need-modorder=1
 
 clean-dirs := $(addprefix _clean_, $(clean-dirs))
-- 
2.25.1

