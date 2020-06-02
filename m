Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CACC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14CBD20757
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:30:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lLk06NP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgFBOaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgFBOaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:30:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81AEC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 07:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=yk5W+9ZX2IUuGwYKVbqZfIpOyPVZNNw9KkR0QSF1QEI=; b=lLk06NP06ZyLF29ZL+hLWEkTjP
        pMaIC9VX6HJrNMnas4z5/C50QSFqPk7RZgsmSAuHCMV0yjbJByoyoPlskX9QTQO6ldXPq6J1z2wlM
        A1wvxpsuIXKSd7/gJTQeqzs2fpqfs1Zb2H6aAgCnwkVpRKHMoQl3NtBg5XIPpTNi95dyam3anhhoF
        bXN99NzBMrHONMvhMIpvMCczYcnevYUXTju85nTQa/JOGGBp8mGvasXOf/6NESpRQPPt/+rTTFi6l
        PepRIRHPHDFN5s8BgGLVWXTOfvczEKm6d4/p5Mq+aD0P/VbxJjb8JtTjqi/YnE7DVK4lZt66CeutQ
        cKTeRJKw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jg7wB-00012C-4p; Tue, 02 Jun 2020 14:30:43 +0000
To:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] x86: F00F: fix parenthesis in idt.c
Message-ID: <3df7fc9b-5cba-666a-be94-9c104ad117ef@infradead.org>
Date:   Tue, 2 Jun 2020 07:30:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix unmatched parenthesis and build error for F00F bug:

../arch/x86/kernel/idt.c: In function 'idt_is_f00f_address':
../arch/x86/kernel/idt.c:177:43: error: expected ';' before ')' token
  return (address - idt_descr.address) >> 3) == 6;
                                           ^
../arch/x86/kernel/idt.c:177:43: error: expected statement before ')' token
../arch/x86/kernel/idt.c:177:45: error: expected expression before '==' token
  return (address - idt_descr.address) >> 3) == 6;
                                             ^~

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 arch/x86/kernel/idt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200602.orig/arch/x86/kernel/idt.c
+++ linux-next-20200602/arch/x86/kernel/idt.c
@@ -174,7 +174,7 @@ void load_current_idt(void)
 #ifdef CONFIG_X86_F00F_BUG
 bool idt_is_f00f_address(unsigned long address)
 {
-	return (address - idt_descr.address) >> 3) == 6;
+	return ((address - idt_descr.address) >> 3) == 6;
 }
 #endif
 

