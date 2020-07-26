Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926F0C433E4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 582B72070E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 00:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M0ADK4gR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgGZAS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 20:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbgGZASZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 20:18:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41CBC08C5C0;
        Sat, 25 Jul 2020 17:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=VitMP7uQjz9q5/byuL/XQS+Y0BC50vmbZT4y0BkkwD4=; b=M0ADK4gRX5A4r5OV5jZ2QW0GHV
        juSj+uUzbgNE8I7St5aQ9h9n2jIGNybUom8yKMjh4zEhpxOBndNTTFj//fRu3f/cd8+geXpF6nJmF
        qUqynhovxvl2a0YRfKJeHh6JgRhC2YiKurcqIfrKjKZgwOeSOV2ElXRp1mTxuPnZx97LDVGIyGxfo
        Z887Mr2x+7RS1LN73XP/BVxpfxhRIC0p+VMqLajQr31+1+cXgsf9t+ZpNwjVspU3FoKGfBpgcUw52
        jqUB4JFxgS/9LvlwwiZqcD4hUqBRFvFVndJuJDcPlspcx4ex1uwqanp7VwhE0bv/Nef7WtOi3txY/
        YTQOfhew==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzUMx-0002Oz-OZ; Sun, 26 Jul 2020 00:18:24 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: [PATCH] kvm: paging_tmpl.h: delete duplicated word
Date:   Sat, 25 Jul 2020 17:18:20 -0700
Message-Id: <20200726001820.19653-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the repeated word "to".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
---
 arch/x86/kvm/mmu/paging_tmpl.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200720.orig/arch/x86/kvm/mmu/paging_tmpl.h
+++ linux-next-20200720/arch/x86/kvm/mmu/paging_tmpl.h
@@ -478,7 +478,7 @@ error:
 
 #if PTTYPE == PTTYPE_EPT
 	/*
-	 * Use PFERR_RSVD_MASK in error_code to to tell if EPT
+	 * Use PFERR_RSVD_MASK in error_code to tell if EPT
 	 * misconfiguration requires to be injected. The detection is
 	 * done by is_rsvd_bits_set() above.
 	 *
