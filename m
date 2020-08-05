Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABC4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A22F621744
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgHEHw3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:52:29 -0400
Received: from mx1.emlix.com ([188.40.240.192]:45480 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725981AbgHEHw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:52:28 -0400
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 818925FCA2;
        Wed,  5 Aug 2020 09:52:25 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH] binfmt_elf: fix documented return value for load_elf_phdrs()
Date:   Wed, 05 Aug 2020 09:52:23 +0200
Message-ID: <6469675.ETGqQKjL3G@devpool35>
Organization: emlix GmbH
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function has never returned anything but a plain NULL.

Fixes: 6a8d38945cf4e6e819d6b550250615db763065a0
Signed-off-by: Rolf Eike Beer <eb@emlix.com>
---
 fs/binfmt_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 9fe3b51c116a..251298d25c8c 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -428,7 +428,7 @@ static int elf_read(struct file *file, void *buf, size_t len, loff_t pos)
  *
  * Loads ELF program headers from the binary file elf_file, which has the ELF
  * header pointed to by elf_ex, into a newly allocated array. The caller is
- * responsible for freeing the allocated data. Returns an ERR_PTR upon failure.
+ * responsible for freeing the allocated data. Returns NULL upon failure.
  */
 static struct elf_phdr *load_elf_phdrs(const struct elfhdr *elf_ex,
 				       struct file *elf_file)
-- 
2.28.0


-- 
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
Fon +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 Göttingen, Germany
Sitz der Gesellschaft: Göttingen, Amtsgericht Göttingen HR B 3160
Geschäftsführung: Heike Jordan, Dr. Uwe Kracke – Ust-IdNr.: DE 205 198 055

emlix - smart embedded open source



