Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3872FC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBDD20714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581351571;
	bh=2+S6v3zKv0TqAS3HqeHmc/og8Nf3i01lW5PIF7pQxAw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=FItTZlA7f7VmCEGCKerQvnuqE60mx5x54Ap+OYnViDBX1yWkCkvygN3jyfSWkeoDY
	 x1h8zCRGVld+hynVWerh5kbg4CT5b7HXpClVzB3IgRl2sdMvz1HEuRVwDfxiX9e2YN
	 qRRXKvsPVtovucYcyNJf2G2ZWfp0Om23M8ltudPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgBJQTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:19:30 -0500
Received: from conuserg-10.nifty.com ([210.131.2.77]:65330 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgBJQT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:19:29 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 01AGIte3016092;
        Tue, 11 Feb 2020 01:18:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 01AGIte3016092
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1581351536;
        bh=SL4MRwT3ATSa2hQI1yjh/EyEY5X2F0/2RXCoIx/OgHE=;
        h=From:To:Cc:Subject:Date:From;
        b=crTnNtuLPCmHQUWJ0zfu9b/MXO1lS+3g+PQ5wrSLn/1D8RG/BbirUjJA5rJf2ftOS
         oOUu2KOvpuBWWthQhjj0Iyo4D2+u43t0PRK8PsvRIcXvmk+72PcF0rJpkat32msS2o
         5Set9v0ljQvxMvO+mE/5uDmMzrM3niLe0GvDGI/EFgWnmoij8x9Fvu6O0JMZ0kYaIu
         pZCpAgCj4Yn/Q/be+tg473Gpc393S5YMft+jf8kg1vAlqGfT0sgPY61HnQx0ae7LN0
         89UZ4bo8KqV9ehjkSKKeSFR0wbYA6ITuAdDUDOYG1XofWN+1ke23wf+nfiNoeRzYhY
         hs7hn8QViem0w==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     youling257 <youling257@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] scripts/kallsyms: fix memory corruption caused by write over-run
Date:   Tue, 11 Feb 2020 01:18:52 +0900
Message-Id: <20200210161852.842-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/kallsyms crashes because memcpy() writes one more byte than
allocated.

Fixes: 8d60526999aa ("scripts/kallsyms: change table to store (strcut sym_entry *)")
Reported-by: youling257 <youling257@gmail.com>
Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kallsyms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index a566d8201b56..0133dfaaf352 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -210,7 +210,7 @@ static struct sym_entry *read_symbol(FILE *in)
 
 	len = strlen(name) + 1;
 
-	sym = malloc(sizeof(*sym) + len);
+	sym = malloc(sizeof(*sym) + len + 1);
 	if (!sym) {
 		fprintf(stderr, "kallsyms failure: "
 			"unable to allocate required amount of memory\n");
@@ -219,7 +219,7 @@ static struct sym_entry *read_symbol(FILE *in)
 	sym->addr = addr;
 	sym->len = len;
 	sym->sym[0] = type;
-	memcpy(sym_name(sym), name, len);
+	strcpy(sym_name(sym), name);
 	sym->percpu_absolute = 0;
 
 	return sym;
-- 
2.17.1

