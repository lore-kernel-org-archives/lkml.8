Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D79C2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31D0B207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OsIZ7t/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgCYRrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:47:51 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58360 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbgCYRrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=bgFMFAg40dNYVQqI8LTEoS+YHN0f3ekwso2Cq3yrjFw=; b=OsIZ7t/GC/rnm8K12iFjfNfMjN
        LX5bkqD5cmr5W3wZlFnfTIWHkbOvOXvnKGLRKyNpxfMEeMYHSFG8iI4ftb052Y/AGFesbjNX7qF7P
        yiVYSudK8MDxjwrDvcPNT2q4fky7lTZ8y4OvwxZeo6msnE/WN8pWnyL/dFUXD5h0Irkol6G83uNfD
        6+N7d7IdJxymFIPGVk97dH1mtm2p1uhXQ/LRNOJYxKmf1elPRRRTfieVXaTtxR78L0XFtPO7nLyI/
        WIwlG+C1yRKIIbFYX5jvkCsthaCMxmS40otfdCmi1RivUwPDB2mBJQQP1s0K7b3He0yQXjWwWcK5z
        zsr95hPg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHA81-0003oh-PW; Wed, 25 Mar 2020 17:47:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D90D9306D86;
        Wed, 25 Mar 2020 18:47:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C94F829BD8A29; Wed, 25 Mar 2020 18:47:42 +0100 (CET)
Message-Id: <20200325174606.125161388@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 25 Mar 2020 18:45:35 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        mhiramat@kernel.org, mbenes@suse.cz
Subject: [PATCH v4 10/13] objtool: Avoid iterating !text section symbols
References: <20200325174525.772641599@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

validate_functions() iterates all sections their symbols; this is
pointless to do for !text sections as they won't have instructions
anyway.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2621,8 +2621,12 @@ static int validate_functions(struct obj
 	struct section *sec;
 	int warnings = 0;
 
-	for_each_sec(file, sec)
+	for_each_sec(file, sec) {
+		if (!(sec->sh.sh_flags & SHF_EXECINSTR))
+			continue;
+
 		warnings += validate_section(file, sec);
+	}
 
 	return warnings;
 }


