Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854E1C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D6D6206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DQRW84hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgGZASN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbgGZASM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:18:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B9FC08C5C0;
        Sat, 25 Jul 2020 17:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=WiGs1qgslmQVm39ErD8FtEC6YDu9ozQcsFkJHMOI2oc=; b=DQRW84hrFK4kXvxMNHnKyNutab
        EAeTNO5IF3HDyRU/gtwUTgEnXmyYBs0F7ulun+eqn+rvpgVFe3Zye309sQiZaizSvtMjayUrF4wPi
        E32Ppo8mVSMFKfQJ9k0IxSLCJOGckkuQVQepBP+I951ek6K1oCb8DhhrAieXxDdaZt/qCzLDpeRCc
        LwJP0K34aD3h98ZAX6Jpdo/oq2UDgxpSRAEq7DkSvzIEg3qwcE/sqMCVgE6yfPPAzkw+cugpla97h
        qixj+GSy3RCRNunoC5Y7+tM/bCI75nj/L/A0j7V6S4SlyozmTxu6c58wZoLW6ySeOdWWy8+53gu4X
        TJT+ANIA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUMk-0002ON-1A; Sun, 26 Jul 2020 00:18:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH] kvm: mmu.h: delete duplicated word
Date:   Sat, 25 Jul 2020 17:18:06 -0700
Message-Id: <20200726001806.19600-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the repeated word "is".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
---
 arch/x86/kvm/mmu.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/x86/kvm/mmu.h
+++ linux-next-20200720/arch/x86/kvm/mmu.h
@@ -191,7 +191,7 @@ static inline u8 permission_fault(struct
 		* PKRU defines 32 bits, there are 16 domains and 2
 		* attribute bits per domain in pkru.  pte_pkey is the
 		* index of the protection domain, so pte_pkey * 2 is
-		* is the index of the first bit for the domain.
+		* the index of the first bit for the domain.
 		*/
 		pkru_bits = (vcpu->arch.pkru >> (pte_pkey * 2)) & 3;
 
