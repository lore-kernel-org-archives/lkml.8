Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77BCC433E5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:38:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A02B420700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:38:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V0pggUR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbgGZAi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgGZAiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:38:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F335FC08C5C1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 17:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kRlm4puZpGJjazmeLM31S2T7/zfx00sZ7wU19LshKI8=; b=V0pggUR7hSLwhalDDaiNjibhDy
        AUbjPtV1k2xUe63N2ygpENGLsKdRHdh/i1q1dxaM1P1NkWHm8ws/7xZndgI2KJzYIgTzSF8H0EQGo
        x+24mBOMOBNHy6dnwEnLeUp6mgdMuvpe1XLqZo58CFeOie0bzizo0j7uMkk1vvauy7fDf/lJQ3Psd
        Xuhj7areJ+8SvpqtvE2qKu2AOYhY3YB8P/gEnL9v8feTPOmUx/HpPFmb0zHboqU2BNGS8FKFr4g/s
        RVFxPk7IXGZHFuJa7oK414Kdv/uyJe+QMG8szuxDhDpXg5Q97Q+cgQEYnNBm25WzgLH4M+mk7a6iI
        KY53cKMg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUgI-0003Cq-8B; Sun, 26 Jul 2020 00:38:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/9] powerpc: hw_breakpoint.h: delete duplicated word
Date:   Sat, 25 Jul 2020 17:38:05 -0700
Message-Id: <20200726003809.20454-6-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200726003809.20454-1-rdunlap@infradead.org>
References: <20200726003809.20454-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/hw_breakpoint.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/powerpc/include/asm/hw_breakpoint.h
+++ linux-next-20200720/arch/powerpc/include/asm/hw_breakpoint.h
@@ -17,7 +17,7 @@ struct arch_hw_breakpoint {
 	u16		hw_len; /* length programmed in hw */
 };
 
-/* Note: Don't change the the first 6 bits below as they are in the same order
+/* Note: Don't change the first 6 bits below as they are in the same order
  * as the dabr and dabrx.
  */
 #define HW_BRK_TYPE_READ		0x01
