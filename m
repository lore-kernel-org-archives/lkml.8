Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9925DC433E7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B48420791
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y+sp4V9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgGPB3u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 21:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727938AbgGPB3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 21:29:49 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC05C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 18:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=80Cv1IsX1j20KEy3+YHkX9DECmJRcyYIEwZ015Az/3U=; b=Y+sp4V9c7wbuAwVyiLupY8zWp3
        fXDmQ+KOoO06NsCloUaHC2/fPXS+T6xzErqr8fXAqnlZLiRy/f9+dOC7dLb/ncicbbJYkfSg4/bs1
        hjr+yWV/yBbD+uNKqS/RIL4mvUqU5ZC2KcbtVN7/U1qUY3/sfcNJdZWdWpU0h4H6EvWbrKGlG+2Cr
        xwcpyu19NLd2XCciMOIRHeNSbYQsb9DzxdnC7OZMINHA5Xnx8BApkG851lt/ES9IdOJCCFXD1PL7J
        8SxQCbInyO49XWZWT+WFn2e6/J6HRAtv0ZsDbIGmTe8nSrr/vBwtuwPsBBYAKO8UrQw0YWIlVbGXu
        P4uDgXKg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvsiY-0000SN-4l; Thu, 16 Jul 2020 01:29:46 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] mm: drop duplicated words in <linux/mm.h>
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>
Message-ID: <d9fae8d6-0d60-4d52-9385-3199ee98de49@infradead.org>
Date:   Wed, 15 Jul 2020 18:29:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop the doubled words "to" and "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 include/linux/mm.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200714.orig/include/linux/mm.h
+++ linux-next-20200714/include/linux/mm.h
@@ -491,7 +491,7 @@ static inline bool fault_flag_allow_retr
 	{ FAULT_FLAG_INTERRUPTIBLE,	"INTERRUPTIBLE" }
 
 /*
- * vm_fault is filled by the the pagefault handler and passed to the vma's
+ * vm_fault is filled by the pagefault handler and passed to the vma's
  * ->fault function. The vma's ->fault is responsible for returning a bitmask
  * of VM_FAULT_xxx flags that give details about how the fault was handled.
  *
@@ -2613,7 +2613,7 @@ extern unsigned long stack_guard_gap;
 /* Generic expand stack which grows the stack according to GROWS{UP,DOWN} */
 extern int expand_stack(struct vm_area_struct *vma, unsigned long address);
 
-/* CONFIG_STACK_GROWSUP still needs to to grow downwards at some places */
+/* CONFIG_STACK_GROWSUP still needs to grow downwards at some places */
 extern int expand_downwards(struct vm_area_struct *vma,
 		unsigned long address);
 #if VM_GROWSUP

