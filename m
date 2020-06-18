Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72561C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EA8D20739
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UpdQ+zKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbgFROvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731135AbgFROvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:51:02 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F7EC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=m92giOroErRTL6M/g6Xbh5tE9NlrIhvpcX29kkROKPE=; b=UpdQ+zKQhKitbly1wn8jGlOO1b
        b7qQTqCHT2NtRe4jEhq7QuwnfzLL/WCHjnFcYG6YulJ7Zr9+6jw0m3anmLxagx0fpYXB7Cz+OdOTN
        RJNDETclaAD2VhYX6rtLhkxrn53GBkDNPtfV86YO19b6Bunu06K3H2fNoLv1J+1ukViRz3Rc37q3t
        ZxNOHKnok4qLLiv1jx2M/AhtuAY5jx66Rj/NpMEb9cSgzQtV6vDoxFbYN2bGXmGub8x4WXwFbpTu0
        sKjOAvaHihbN4raxgRiMukIJVbwz6ktIfM1GLmIhPQzCtoNxpzJGW0TBLVA/IO5SxRIq0X559BJBh
        0vnB19XQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlvsA-0006Hl-AJ; Thu, 18 Jun 2020 14:50:34 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 571623075C0;
        Thu, 18 Jun 2020 16:50:32 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 23F032146C400; Thu, 18 Jun 2020 16:50:32 +0200 (CEST)
Message-ID: <20200618144801.701257527@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 18 Jun 2020 16:44:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, dvyukov@google.com,
        elver@google.com, andreyknvl@google.com, mark.rutland@arm.com,
        mhelsley@vmware.com, rostedt@goodmis.org, jthierry@redhat.com,
        mbenes@suse.cz, peterz@infradead.org
Subject: [PATCH 2/7] objtool: Dont consider vmlinux a C-file
References: <20200618144407.520952071@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids issuing C-file warnings for vmlinux.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/check.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2772,7 +2772,7 @@ int check(const char *_objname, bool orc
 
 	INIT_LIST_HEAD(&file.insn_list);
 	hash_init(file.insn_hash);
-	file.c_file = find_section_by_name(file.elf, ".comment");
+	file.c_file = !vmlinux && find_section_by_name(file.elf, ".comment");
 	file.ignore_unreachables = no_unreachable;
 	file.hints = false;
 


