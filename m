Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B251C54FD2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 483AA2074F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="h6lj6d5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgDTSdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgDTSdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:33:15 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3579C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 11:33:14 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o10so2256912pgb.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 11:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qow/IItEMt263q63wwyy8bHc5gqEIJAfztwTxJ0weYY=;
        b=h6lj6d5hViBaGtO2cp2DYc22rd8VQPQRjR95nPi7KVAiN3cLxNEt4HtQ9/skopBvjY
         XdrPKVy3oQdCq9ZFACCs1LrNtPLvHNfDXUzkARY7oan0QPBkndJf8i82iOPhi/G5dUNM
         JAqmBLwfAOdAG4SDqKpgMt909W6KlzUc+6m7YwN0tvZ3nl+q+ot0IAWM1l62yEOTg9W3
         QYWI036FL5l+s2GT80dTsjtjbVnLY+TtVUNN/Tmx5NxfNna7m4q6XwTIxZBrD9aoTDjO
         LVqX88lLQoX6qVMTS8LuU0zzULI8zGyMnzmHNVk5lDmA7nsnVe+SOqqbt896Bc71wSmF
         NmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qow/IItEMt263q63wwyy8bHc5gqEIJAfztwTxJ0weYY=;
        b=oi6gLESuR9HhefarkeNL0MjjNNUVJvEp1GhVN3E2XAfRT+Cl1et9lnS6WOtIjJTfXh
         xcIVy1RlJgvAowZtblCMCj62N4g8pg5Buc92f0bDh97Lh0We7/Dq+jdX7M6g0ynYhCUI
         bT7KF4ytm/nVBYaQVu1vP2OW1BLGEVLMvwkSsPMQj0XZX5jk0ZLA/v9+jBz9RJbkg39D
         SORQx91s713JkLhKPdgo2vkdMehZjvL//7u733Vm1l2iaOFikq+/1+SZSXAgSliTTQIJ
         KsK95wNensrVvdz/HYA6afGg3oRqJz0ki0v2YZKm1U2DCP0LVAmEjgcyp8ctT8b14Ph1
         qoqA==
X-Gm-Message-State: AGi0PubiA/+UM4HTIeAgY7wONJTVmVjXO9+wWLbQevaZMwqnRfdJ/Ksa
        v+IUGDbiVA119dbajVVq0RGXgNyEm58yyw==
X-Google-Smtp-Source: APiQypIqsC5btZg/faB4x4hyuI5vLEWlJx8SDOyW6fAbpdddBb1lo/aPCSn2yLyG2vqIb6JEhNT/4A==
X-Received: by 2002:a63:4b65:: with SMTP id k37mr17416044pgl.118.1587407593911;
        Mon, 20 Apr 2020 11:33:13 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id l185sm172536pfl.104.2020.04.20.11.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 11:33:13 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrei Vagin <avagin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
        Andrei Vagin <avagin@openvz.org>
Subject: [PATCH 2/3] x86/vdso2c: Convert iterators to unsigned
Date:   Mon, 20 Apr 2020 19:32:55 +0100
Message-Id: <20200420183256.660371-4-dima@arista.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420183256.660371-1-dima@arista.com>
References: <20200420183256.660371-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`i` and `j` are used everywhere with unsigned types.

Convert `i` to unsigned long in order to avoid signed to unsigned
comparisons.  Convert `k` to unsigned int with the same purpose.
Also, drop `j` as `i` could be used in place of it.
Introduce syms_nr for readability.

Co-developed-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/entry/vdso/vdso2c.h | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index a20b134de2a8..6f46e11ce539 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -13,8 +13,7 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	unsigned long load_size = -1;  /* Work around bogus warning */
 	unsigned long mapping_size;
 	ELF(Ehdr) *hdr = (ELF(Ehdr) *)raw_addr;
-	int i;
-	unsigned long j;
+	unsigned long i, syms_nr;
 	ELF(Shdr) *symtab_hdr = NULL, *strtab_hdr, *secstrings_hdr,
 		*alt_sec = NULL;
 	ELF(Dyn) *dyn = 0, *dyn_end = 0;
@@ -86,11 +85,10 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	strtab_hdr = raw_addr + GET_LE(&hdr->e_shoff) +
 		GET_LE(&hdr->e_shentsize) * GET_LE(&symtab_hdr->sh_link);
 
+	syms_nr = GET_LE(&symtab_hdr->sh_size) / GET_LE(&symtab_hdr->sh_entsize);
 	/* Walk the symbol table */
-	for (i = 0;
-	     i < GET_LE(&symtab_hdr->sh_size) / GET_LE(&symtab_hdr->sh_entsize);
-	     i++) {
-		int k;
+	for (i = 0; i < syms_nr; i++) {
+		unsigned int k;
 		ELF(Sym) *sym = raw_addr + GET_LE(&symtab_hdr->sh_offset) +
 			GET_LE(&symtab_hdr->sh_entsize) * i;
 		const char *sym_name = raw_addr +
@@ -150,11 +148,11 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 	fprintf(outfile,
 		"static unsigned char raw_data[%lu] __ro_after_init __aligned(PAGE_SIZE) = {",
 		mapping_size);
-	for (j = 0; j < stripped_len; j++) {
-		if (j % 10 == 0)
+	for (i = 0; i < stripped_len; i++) {
+		if (i % 10 == 0)
 			fprintf(outfile, "\n\t");
 		fprintf(outfile, "0x%02X, ",
-			(int)((unsigned char *)stripped_addr)[j]);
+			(int)((unsigned char *)stripped_addr)[i]);
 	}
 	fprintf(outfile, "\n};\n\n");
 
-- 
2.26.0

