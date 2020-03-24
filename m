Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFDAC2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F60214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GzJjD8CC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgCXQMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:12:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36980 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgCXQLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=/GjJ+xWr4L/UabC/x6T+Ol9cz+am4DeAa42o7EB3U2Q=; b=GzJjD8CCnGDSbMHlOu1Q/fM0sM
        VyWh1BeZqdZb7/fZIhHdb9hK2voqWGMBrXLDME+wEFophKhxVgjB87dFnEeYPiGy7ffoIjO6Wb+RS
        U3nsj1jbsGS8g77Oi6IpavsF14HJYFg5X8U405SUKoZuAzdjcxoNagMvB6LJkLQB7/o8cNjLZWhF5
        B7spHViu1J6HUa7KLnwNYVIZB1n0CD2t0uM+GHZIFSXaoT5catXtTnsw2QautVPLWyfE6him3OVz+
        Kc9G2uoe6ZaQVTE071+NjrrfF0Q6XD6ermT1MJ7j8bcGEV1IGgjVfBqZTzrI+bmZZ7OJ9K3hq/uEq
        +PICBC8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGm9N-0006c7-3l; Tue, 24 Mar 2020 16:11:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8FD5E30793E;
        Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 82A8929A490F1; Tue, 24 Mar 2020 17:11:28 +0100 (CET)
Message-Id: <20200324160925.470421121@infradead.org>
User-Agent: quilt/0.65
Date:   Tue, 24 Mar 2020 16:31:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz, brgerst@gmail.com
Subject: [PATCH v3 26/26] objtool: Add STT_NOTYPE noinstr validation
References: <20200324153113.098167666@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to also check STT_NOTYPE symbols for noinstr violations.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |   19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2563,7 +2563,7 @@ static int validate_symbol(struct objtoo
 		return 1;
 	}
 
-	if (sym->pfunc != sym || sym->alias != sym)
+	if ((sym->type == STT_FUNC && sym->pfunc != sym) || sym->alias != sym)
 		return 0;
 
 	insn = find_insn(file, sec, sym->offset);
@@ -2610,6 +2610,23 @@ static int validate_section(struct objto
 		warnings += validate_symbol(file, sec, func, &state);
 	}
 
+	if (state.noinstr) {
+		/*
+		 * In vmlinux mode we will not run validate_unwind_hints() by
+		 * default which means we'll not otherwise visit STT_NOTYPE
+		 * symbols.
+		 *
+		 * In case of --duplicate mode, insn->visited will avoid actual
+		 * duplicate work being done.
+		 */
+		list_for_each_entry(func, &sec->symbol_list, list) {
+			if (func->type != STT_NOTYPE)
+				continue;
+
+			warnings += validate_symbol(file, sec, func, &state);
+		}
+	}
+
 	return warnings;
 }
 


