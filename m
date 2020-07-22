Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EA2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30A8E22B3F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 22:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CpdgH2q/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7nAtu0OG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733200AbgGVWtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 18:49:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52898 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732755AbgGVWso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 18:48:44 -0400
Date:   Wed, 22 Jul 2020 22:48:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595458122;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KpuPKpoMQ1vXCI/YK6JtR2eQJ1NuqlHho8RvYGCQ3Rs=;
        b=CpdgH2q/g9V2zXTI7r9ATp/BkYvMhAz5AnCbVikN14g0+f2RNZtghfrwsCx5/EVMswSV7n
        9aoj0sy/3lrFeOASOaIo0abrVxTmmAOFNma7PLW14SmkzmYBQ7LzHK7HsB6u7jhN3AQz67
        9qF2coAOKf/eHa3XyWRKMnW2sT5oqZm1wa8D2odSqExiteJdwRW3zcS/dWsVJlLOkoWXWc
        gOVEhQ+6vY3VgMY8vNub9jedRyTh3C/YziOi3loJAfsvMMv2b0vCOuQUwt8gmuK9xbD+YY
        BIMV0oQa33J7kNhruNp3Yq52hH3M+RsKycchpjiTsW6dZET6VA9stV1QA38WIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595458122;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KpuPKpoMQ1vXCI/YK6JtR2eQJ1NuqlHho8RvYGCQ3Rs=;
        b=7nAtu0OGf+WFex1IEHLDF/Zjy0QbRc4Xea+bEofv9I3qPG1E1BX/Ycwh0mIYEl7kHCDlKV
        c0mwEpyspZVRGKCA==
From:   "tip-bot2 for Atish Patra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi/libstub: Fix gcc error around __umoddi3 for 32
 bit builds
Cc:     Atish Patra <atish.patra@wdc.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200625234516.31406-2-atish.patra@wdc.com>
References: <20200625234516.31406-2-atish.patra@wdc.com>
MIME-Version: 1.0
Message-ID: <159545812117.4006.8365184793527804218.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     950accbabd4cfa83519fa920f99428bcc131c3c9
Gitweb:        https://git.kernel.org/tip/950accbabd4cfa83519fa920f99428bcc131c3c9
Author:        Atish Patra <atish.patra@wdc.com>
AuthorDate:    Thu, 25 Jun 2020 16:45:06 -07:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Thu, 09 Jul 2020 09:45:09 +03:00

efi/libstub: Fix gcc error around __umoddi3 for 32 bit builds

32bit gcc doesn't support modulo operation on 64 bit data. It results in
a __umoddi3 error while building EFI for 32 bit.

Use bitwise operations instead of modulo operations to fix the issue.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Link: https://lore.kernel.org/r/20200625234516.31406-2-atish.patra@wdc.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/alignedmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/alignedmem.c b/drivers/firmware/efi/libstub/alignedmem.c
index cc89c4d..1de9878 100644
--- a/drivers/firmware/efi/libstub/alignedmem.c
+++ b/drivers/firmware/efi/libstub/alignedmem.c
@@ -44,7 +44,7 @@ efi_status_t efi_allocate_pages_aligned(unsigned long size, unsigned long *addr,
 	*addr = ALIGN((unsigned long)alloc_addr, align);
 
 	if (slack > 0) {
-		int l = (alloc_addr % align) / EFI_PAGE_SIZE;
+		int l = (alloc_addr & (align - 1)) / EFI_PAGE_SIZE;
 
 		if (l) {
 			efi_bs_call(free_pages, alloc_addr, slack - l + 1);
