Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8634CC433E8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5883B20700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wWbwfO8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgGZAi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbgGZAi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:38:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6234C08C5DB
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 17:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=n/SW5RPvwad3efH1XqcysXHw321JXV8xdkGGbkaJgAc=; b=wWbwfO8lO2PZy6ujbc+1HI8cq0
        jZTlf8wpdAdKfv0p6pKK+1wQQBIQk2+XAg/fNi/+vzRtOlne+0Z6Ua6bDJeD+iySjLZFVPA0abiW/
        Qz0ypdG0JMGNfoA0avsiTjlh2doE1VN/PQXKfCU0WbdQSo9I/gNPBkKs2aJYuHbtV0WqcQLjIHZ35
        YWVWX0WXp59b28ivE1w2UefV8BQYiBO8+HWkZPfKbVvXz+U6dyMIhOygqtdcVswVkxgYdz56JiUKL
        b94FbwA0xmg5u46nLVvH4W2rBZMgN7qtd29lBka2PV0mIGNr5xpo0RtAtuRW5O32oulD2a691RAzd
        FVMjW24Q==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUgK-0003Cq-4d; Sun, 26 Jul 2020 00:38:24 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 6/9] powerpc: ppc_asm.h: delete duplicated word
Date:   Sat, 25 Jul 2020 17:38:06 -0700
Message-Id: <20200726003809.20454-7-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726003809.20454-1-rdunlap@infradead.org>
References: <20200726003809.20454-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "in".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/ppc_asm.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/powerpc/include/asm/ppc_asm.h
+++ linux-next-20200720/arch/powerpc/include/asm/ppc_asm.h
@@ -774,7 +774,7 @@ END_FTR_SECTION_NESTED(CPU_FTR_CELL_TB_B
 #define FIXUP_ENDIAN
 #else
 /*
- * This version may be used in in HV or non-HV context.
+ * This version may be used in HV or non-HV context.
  * MSR[EE] must be disabled.
  */
 #define FIXUP_ENDIAN						   \
