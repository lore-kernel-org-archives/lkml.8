Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009D9C433ED
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8AF422AAB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753605;
	bh=jnIhzxpXO0JKlxaSrH9JI4FN6RQDYgOo1kucbxLZ2DA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DxfrxHkM+FFmSh2QywfL1IwoWaYUExfYrpyKiLUt5TfW9SWBsyi6wnx2y7YT/6To6
	 8Wt2WxH7MtmqCC6BJuWJu0hhNas5w0R8Xq+e5MqlSaGXzVnwNtyQXHJkvKRI2kMco0
	 nP+sL8sLeTxhux2rIxt3AX11nI9AiAvmsB2jOmEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731369AbgGNTGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:06:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:50114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730588AbgGNSxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:53:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D73D22C7B;
        Tue, 14 Jul 2020 18:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752788;
        bh=jnIhzxpXO0JKlxaSrH9JI4FN6RQDYgOo1kucbxLZ2DA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RCIDXry/Cdu8FhhiEITw/AJKbF/aVJPKi60228YpT/W5G2582IAs0XT+BYqR2mKjR
         8o/O5hnIdKVHvP0byop0jd44dfmDKebRmey7tRLiY7NxnW4DcJxEMLb8x5NIRxIcQl
         Xk9avGXyxnMJuae1P2VMtfm0p3Rgyx9tuN2Y5/jA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 5.4 080/109] KVM: arm64: Fix definition of PAGE_HYP_DEVICE
Date:   Tue, 14 Jul 2020 20:44:23 +0200
Message-Id: <20200714184109.380816501@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184105.507384017@linuxfoundation.org>
References: <20200714184105.507384017@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

commit 68cf617309b5f6f3a651165f49f20af1494753ae upstream.

PAGE_HYP_DEVICE is intended to encode attribute bits for an EL2 stage-1
pte mapping a device. Unfortunately, it includes PROT_DEVICE_nGnRE which
encodes attributes for EL1 stage-1 mappings such as UXN and nG, which are
RES0 for EL2, and DBM which is meaningless as TCR_EL2.HD is not set.

Fix the definition of PAGE_HYP_DEVICE so that it doesn't set RES0 bits
at EL2.

Acked-by: Marc Zyngier <maz@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200708162546.26176-1-will@kernel.org
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/pgtable-prot.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -54,7 +54,7 @@
 #define PAGE_HYP		__pgprot(_HYP_PAGE_DEFAULT | PTE_HYP | PTE_HYP_XN)
 #define PAGE_HYP_EXEC		__pgprot(_HYP_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY)
 #define PAGE_HYP_RO		__pgprot(_HYP_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY | PTE_HYP_XN)
-#define PAGE_HYP_DEVICE		__pgprot(PROT_DEVICE_nGnRE | PTE_HYP)
+#define PAGE_HYP_DEVICE		__pgprot(_PROT_DEFAULT | PTE_ATTRINDX(MT_DEVICE_nGnRE) | PTE_HYP | PTE_HYP_XN)
 
 #define PAGE_S2_MEMATTR(attr)						\
 	({								\


