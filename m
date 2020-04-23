Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62016C55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 421B02077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 12:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sC3+cymp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgDWMw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 08:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728471AbgDWMwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 08:52:25 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A94FC09B040
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 05:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=9MwTIMpdaC4VygWnq1XRJh2I8O/EbbREN7voJhdd838=; b=sC3+cymp+JYks4EP3XSSA2by8j
        p55rD72koFe249yUVDHppw5ltlculNfH/0RZTW1PDUuG1KOqUvJ80X8MGpbiWjlR2Ty+KoVUVmRNd
        FNF+m3Ykvkxr+Tjg64G+P2ZW4y/XyYGBgepvNd43GagQDsCvSBqYvTgwXdn66kH0oxOwK8IK97WWv
        59QGqwjaCo4gs4VWDFAsHf7vcdBBtclzD74Yd6scUXZMA2+qqpxpDvO6ZYsxKTTjbGSoPb+g9dMjm
        j5Jcv3rdBnVXS4UdwThwnB7xiKOGtIRf+miva61JemIyS2sLKWEr91k+df446FcmR8qkSIdKsBPBK
        lkuCFSYA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRbKi-0007S4-R2; Thu, 23 Apr 2020 12:52:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5435B306099;
        Thu, 23 Apr 2020 14:51:58 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3799B20BE637C; Thu, 23 Apr 2020 14:51:58 +0200 (CEST)
Message-Id: <20200423125042.636198092@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 23 Apr 2020 14:47:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org, mbenes@suse.cz,
        peterz@infradead.org
Subject: [PATCH 2/8] objtool: UNWIND_HINT_RET_OFFSET should not check registers
References: <20200423125013.452964352@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Chartre <alexandre.chartre@oracle.com>

UNWIND_HINT_RET_OFFSET will adjust a modified stack. However if a
callee-saved register was pushed on the stack then the stack frame
will still appear modified. So stop checking registers when
UNWIND_HINT_RET_OFFSET is used.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200407073142.20659-3-alexandre.chartre@oracle.com
---
 tools/objtool/check.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1513,6 +1513,14 @@ static bool has_modified_stack_frame(str
 	if (cfi->stack_size != initial_func_cfi.cfa.offset + ret_offset)
 		return true;
 
+	/*
+	 * If there is a ret offset hint then don't check registers
+	 * because a callee-saved register might have been pushed on
+	 * the stack.
+	 */
+	if (ret_offset)
+		return false;
+
 	for (i = 0; i < CFI_NUM_REGS; i++) {
 		if (cfi->regs[i].base != initial_func_cfi.regs[i].base ||
 		    cfi->regs[i].offset != initial_func_cfi.regs[i].offset)


