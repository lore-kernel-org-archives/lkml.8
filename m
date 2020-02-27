Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC63C35DEE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276DF20578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812887;
	bh=M8nOWdSwyIN9dVnGbyJzR9EvWHZSSK8dqPkYJyjx+JA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UHAa7NUXyhS3T+Pj5TQnb72yNcxxhirqxPIKADzLFDji8VS2s96DcHnDBIzea5v2m
	 Zu/vEJhhp9ZQDc8cI0rnQiicL1/Z1oR3P6VPgES+3Etsv+MDjbDyWx3GFQbNLLJvwb
	 kQ1ZIofyoL+rrhTH6sSOBIEO0S4h0Vl9QYUqY+J0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389178AbgB0OOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:14:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389168AbgB0OOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:14:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4740720578;
        Thu, 27 Feb 2020 14:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812882;
        bh=M8nOWdSwyIN9dVnGbyJzR9EvWHZSSK8dqPkYJyjx+JA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+UFvF4eX6zXGnThP78Vl455CZjrbStOVM6cHwvQU67rgY/Wx+q4RTgUxwSsXwrh7
         CBP9CndtW6u6lXPlyM/1nUF4B/OAOmgcbRv9LdXWFL1ofa9dWCyoyYjds/Cogcyi51
         QFnehi4sQd2ar+2gemjzTkJBe3HgU4w5QTmje2as=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.5 051/150] powerpc/8xx: Fix clearing of bits 20-23 in ITLB miss
Date:   Thu, 27 Feb 2020 14:36:28 +0100
Message-Id: <20200227132240.597551138@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy <christophe.leroy@c-s.fr>

commit a4031afb9d10d97f4d0285844abbc0ab04245304 upstream.

In ITLB miss handled the line supposed to clear bits 20-23 on the L2
ITLB entry is buggy and does indeed nothing, leading to undefined
value which could allow execution when it shouldn't.

Properly do the clearing with the relevant instruction.

Fixes: 74fabcadfd43 ("powerpc/8xx: don't use r12/SPRN_SPRG_SCRATCH2 in TLB Miss handlers")
Cc: stable@vger.kernel.org # v5.0+
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Leonardo Bras <leonardo@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/4f70c2778163affce8508a210f65d140e84524b4.1581272050.git.christophe.leroy@c-s.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/head_8xx.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -289,7 +289,7 @@ InstructionTLBMiss:
 	 * set.  All other Linux PTE bits control the behavior
 	 * of the MMU.
 	 */
-	rlwimi	r10, r10, 0, 0x0f00	/* Clear bits 20-23 */
+	rlwinm	r10, r10, 0, ~0x0f00	/* Clear bits 20-23 */
 	rlwimi	r10, r10, 4, 0x0400	/* Copy _PAGE_EXEC into bit 21 */
 	ori	r10, r10, RPN_PATTERN | 0x200 /* Set 22 and 24-27 */
 	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */


