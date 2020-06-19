Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6794C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66342166E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405676AbgFSQqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395254AbgFSQqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:46:08 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BE5C061797;
        Fri, 19 Jun 2020 09:46:03 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jmK9Q-00044S-QK; Fri, 19 Jun 2020 18:46:00 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 621211C0085;
        Fri, 19 Jun 2020 18:46:00 +0200 (CEST)
Date:   Fri, 19 Jun 2020 16:46:00 -0000
From:   "tip-bot2 for Gustavo A. R. Silva" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/urgent] efi: Replace zero-length array and use struct_size() helper
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200527171425.GA4053@embeddedor>
References: <20200527171425.GA4053@embeddedor>
MIME-Version: 1.0
Message-ID: <159258516013.16989.1720287565955551679.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the efi/urgent branch of tip:

Commit-ID:     2963795122f50b36ed16e3ba880c3ed2de1bda6e
Gitweb:        https://git.kernel.org/tip/2963795122f50b36ed16e3ba880c3ed2de1bda6e
Author:        Gustavo A. R. Silva <gustavoars@kernel.org>
AuthorDate:    Wed, 27 May 2020 12:14:25 -05:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Mon, 15 Jun 2020 14:38:56 +02:00

efi: Replace zero-length array and use struct_size() helper

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

Lastly, make use of the sizeof_field() helper instead of an open-coded
version.

This issue was found with the help of Coccinelle and audited _manually_.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20200527171425.GA4053@embeddedor
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi.c | 3 ++-
 include/linux/efi.h        | 7 ++-----
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 7f1657b..edc5d36 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -622,7 +622,8 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
 			rsv = (void *)(p + prsv % PAGE_SIZE);
 
 			/* reserve the entry itself */
-			memblock_reserve(prsv, EFI_MEMRESERVE_SIZE(rsv->size));
+			memblock_reserve(prsv,
+					 struct_size(rsv, entry, rsv->size));
 
 			for (i = 0; i < atomic_read(&rsv->count); i++) {
 				memblock_reserve(rsv->entry[i].base,
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 2c6495f..c3449c9 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1236,14 +1236,11 @@ struct linux_efi_memreserve {
 	struct {
 		phys_addr_t	base;
 		phys_addr_t	size;
-	} entry[0];
+	} entry[];
 };
 
-#define EFI_MEMRESERVE_SIZE(count) (sizeof(struct linux_efi_memreserve) + \
-	(count) * sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
-
 #define EFI_MEMRESERVE_COUNT(size) (((size) - sizeof(struct linux_efi_memreserve)) \
-	/ sizeof(((struct linux_efi_memreserve *)0)->entry[0]))
+	/ sizeof_field(struct linux_efi_memreserve, entry[0]))
 
 void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size);
 
