Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDCCC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EC120801
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQ1TkPAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgBROAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:00:50 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40484 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgBROAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:00:50 -0500
Received: by mail-pg1-f193.google.com with SMTP id z7so10989878pgk.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 06:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P4bes5n6/gbjuUv9oMzNslpRGSsSzzsqrIpzgdKjxVU=;
        b=dQ1TkPAMBlzicPt30U9ud0Kqlk7x17I4QGF11maRUlo55WmPAI4fp8sV0sgmfqlHEF
         Yu+NBaBYOa86gLfzHQcoPxXPFFhf+/2jdIDZSajQTjnRSgO/RH7FvgcpiiFq4BPzbrTa
         nAcYVbIU99Df3ZO8NIdJmdoDAYp0/gJkqwDTxBu2t0+eEN4JuQSFAS0lVkDW64x/d/hz
         VM7cc9a9cvvzOpJ44L+Dv3zSORIYkPVdbYnepYMMlyhnCtB+h5pKkNba/W66dFHfLUSE
         tUAvahRffMN+GeNvt4ydEDtPMXF7ZMj6vS2e1QtHHpiTneQPRXfagCXRjNiD2tB/M97u
         Z1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P4bes5n6/gbjuUv9oMzNslpRGSsSzzsqrIpzgdKjxVU=;
        b=HCjKa3xfXHsYSEMDPa1vAE+dGvqlw0029EuJ4/OpibYUyQdPhFxHcY7XlGOqIJXV25
         rdG9rCSQVaEmHjg/Rubj2fZ1VvoPs9I88oC+lycjovkTEV9O4gFF6Qlsq9u2yrOL58wZ
         j33CV4pOBJ3zA/qfsPyE9tLcXrKJTIPYVNGmQMtReEpyI2GP7W+L6rGIgLVNLG5hHSBW
         l5turs8D3aVyFZs4/YcdK/R+eKE85zvE0J7z2M6Q9yScmoFoVJVQcBi3WTosZlli0dOp
         j78Mby2Wn0tDJH9aiKXhD9/jrnj+Pz636mX/PHWI9Np2zmR69/ioQ2omUBDERKAqxjaT
         yRkA==
X-Gm-Message-State: APjAAAVyPhc2/hkfLQJ2PF8TD1pqJJ1qPCl3n/lT9LLbTPiMStCs7h8i
        x5H6auUygxP/M+oLxxGHYJA=
X-Google-Smtp-Source: APXvYqyCUVbRSU+kBGt8P7InnXqQ/jb1KZ0qtw+DqRtTl3Iexpq1KtmYdeGLKia+QGQMsLsMEuqjxQ==
X-Received: by 2002:a63:7311:: with SMTP id o17mr2203755pgc.377.1582034449383;
        Tue, 18 Feb 2020 06:00:49 -0800 (PST)
Received: from gnu-cfl-2.localdomain (c-73-93-86-59.hsd1.ca.comcast.net. [73.93.86.59])
        by smtp.gmail.com with ESMTPSA id 13sm4888541pgo.13.2020.02.18.06.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 06:00:48 -0800 (PST)
Received: from gnu-cfl-2.hsd1.ca.comcast.net (localhost [IPv6:::1])
        by gnu-cfl-2.localdomain (Postfix) with ESMTP id 99699C03CF;
        Tue, 18 Feb 2020 06:00:45 -0800 (PST)
From:   "H.J. Lu" <hjl.tools@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH] x86: Don't declare __force_order in kaslr_64.c
Date:   Tue, 18 Feb 2020 06:00:45 -0800
Message-Id: <20200218140045.155642-1-hjl.tools@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 10 changed the default to -fno-common, which leads to

  LD      arch/x86/boot/compressed/vmlinux
ld: arch/x86/boot/compressed/pgtable_64.o:(.bss+0x0): multiple definition of `__force_order'; arch/x86/boot/compressed/kaslr_64.o:(.bss+0x0): first defined here
make[2]: *** [arch/x86/boot/compressed/Makefile:119: arch/x86/boot/compressed/vmlinux] Error 1

Since __force_order is already provided in pgtable_64.c, there is no
need to declare __force_order in kaslr_64.c.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
---
 arch/x86/boot/compressed/kaslr_64.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/boot/compressed/kaslr_64.c b/arch/x86/boot/compressed/kaslr_64.c
index 748456c365f4..9557c5a15b91 100644
--- a/arch/x86/boot/compressed/kaslr_64.c
+++ b/arch/x86/boot/compressed/kaslr_64.c
@@ -29,9 +29,6 @@
 #define __PAGE_OFFSET __PAGE_OFFSET_BASE
 #include "../../mm/ident_map.c"
 
-/* Used by pgtable.h asm code to force instruction serialization. */
-unsigned long __force_order;
-
 /* Used to track our page table allocation area. */
 struct alloc_pgt_data {
 	unsigned char *pgt_buf;
-- 
2.24.1

