Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EDFC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86024206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jspE19xo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgGZAiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgGZAiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:38:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0E5C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 17:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4JEy9A35/ccMqJD11HDwUeyBZOGSUkra2+elyfXHxz8=; b=jspE19xojGZ+32mCGJqP+LbTid
        Jpt9Akh2rr/joNC16sz9L5rhhzT0ao7sKRRX0n+d6BqZtUAjbO4MgfE1u2LbtzIvkRCS8qSNMVRIH
        FAl240UoMw7k+4XUUEZiSIy+jlmF1ZhiM0cqfIkZzAM5uNLk5UfFqq5zuLa4uTzIIC8rjlXDYdhy6
        FqORPFxj4mFQb5N5Xme/U6xd/bjbu6VCds0olzVqWqeUlzcZ19fqsnhiATbFaNzdlDWXXvr/q3rnR
        O9aEuuKlSGhtNiMaY618eZ8WcWEwAOkVd1xOJVms85TMRJbgaND6JYmb0MRs6dkpxlaCM31kxMXWL
        XUuwCcJg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUgE-0003Cq-8j; Sun, 26 Jul 2020 00:38:18 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/9] powerpc: cputime.h: delete duplicated word
Date:   Sat, 25 Jul 2020 17:38:03 -0700
Message-Id: <20200726003809.20454-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726003809.20454-1-rdunlap@infradead.org>
References: <20200726003809.20454-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "use".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/cputime.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/powerpc/include/asm/cputime.h
+++ linux-next-20200720/arch/powerpc/include/asm/cputime.h
@@ -67,7 +67,7 @@ static inline void arch_vtime_task_switc
 
 /*
  * account_cpu_user_entry/exit runs "unreconciled", so can't trace,
- * can't use use get_paca()
+ * can't use get_paca()
  */
 static notrace inline void account_cpu_user_entry(void)
 {
