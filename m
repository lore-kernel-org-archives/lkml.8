Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0969BC433E5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C74D32076A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="e5ATe/YT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgGZAlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgGZAlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:41:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAC5C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 17:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=NskkC63wGl/kN9wReZdhYmbVfJGf4FDZPsLLAcFhAss=; b=e5ATe/YT5tTXOYhqe8GF0Mqidz
        pGeU1L3WTllwY3petKHI1TZHCdYxkrQvEPOyuNMQycb6sxjsrZsBDp8drMasS3ZdHOFGnDDm7aBWE
        9QcWvm9SoSqUAfRZJWq16+eUaYpKeSp0uO2Xf0JFvKw6TWR585j8D9tpyoJECYqB7uG0DApp/hCbC
        ma5OoeiPZig4QfhR/+Y8w8ZuKd+sVkk6YBIb13h4gXQGqBnGmfnPjmEVINKsG5FHO8JG+MjjmvvN4
        PQ5jmY/u24nAjc1vTaI3OBBOnGZdm4u/FAZAm54n0y2GLhybMD4Lgd6Amt5pX93UtNSXnABrbhc6J
        NdGGBaTA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUjN-0003QZ-SR; Sun, 26 Jul 2020 00:41:34 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: [PATCH 3/3] x86: uv: uv_hub.h: delete duplicated word
Date:   Sat, 25 Jul 2020 17:41:24 -0700
Message-Id: <20200726004124.20618-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726004124.20618-1-rdunlap@infradead.org>
References: <20200726004124.20618-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the repeated word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
---
 arch/x86/include/asm/uv/uv_hub.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/x86/include/asm/uv/uv_hub.h
+++ linux-next-20200720/arch/x86/include/asm/uv/uv_hub.h
@@ -682,7 +682,7 @@ static inline int uv_node_to_blade_id(in
 	return nid;
 }
 
-/* Convert a cpu number to the the UV blade number */
+/* Convert a cpu number to the UV blade number */
 static inline int uv_cpu_to_blade_id(int cpu)
 {
 	return uv_node_to_blade_id(cpu_to_node(cpu));
