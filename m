Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47CEC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BC32072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="SrHNzrCA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgCFEs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 23:48:59 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:42097 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgCFEs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 23:48:59 -0500
Received: by mail-qv1-f66.google.com with SMTP id e7so391168qvy.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 20:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u3A82Tm6v/IKdXzlz1x166tlvvtPigj+LiMK7gr2ad8=;
        b=SrHNzrCAmssYq4JPdHbvjy/uNh0otDPdaeUYLhK6N1FZtMOVeNPL2MCNVMLeAT/j3B
         luVLvPkjt4oeynQQYFLozpy3gg58sLqjVeuuPewwHP6+aRyAoFFK4bxm5ph8Ks3uYtjX
         p7MK1f0wFfrVwZGhiWr3Ab7BGcdMaoGRzozL2Kk+vRRLEQJvPs3gT4b4Hg7OnzjATPDB
         +4XsgJeDkSCnf+y55h7aBEztRDdbBs/w9o6H4dFl47YNIGbg9omRnk1O2QHNEALknYQ1
         draaEos8IIoGzuXT978acsZO4m8hdtAcRnxx5NMDqqIUV9j3IiEA/xnFwJU/GY3Tr9tn
         ULkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u3A82Tm6v/IKdXzlz1x166tlvvtPigj+LiMK7gr2ad8=;
        b=YX1BokmCxj2fRYq8+UYH5I8yKWk2avsKMINB9d3V6Rl9VOANkGglKiDB2tmPokZ60i
         G5QnlM9CHS/m97XY6xv/xJI5ucAHAe+V1HzW1QT+v9GiAykKE1m7EOIZKPcPWzZX9t3D
         WqMiq39TjzX/JZi0PQLvq5SDsGM2Ng9tY+cs7Qnt7I+JIN44Lz8wJHwok2x+3GZt7lDL
         frY/k0XnHQzjwLOK6KGxFDAHe4ApGtziglMmeH0yVpl4P1TsgKJsNpI23o9eekJT8x7g
         jHEQn0eeC4AHw1ANERkM0KuMBOm9ry3h1NiT+q/2ur0bTKiSGKK9A/A3TyNGCQplxAlr
         QS8g==
X-Gm-Message-State: ANhLgQ3C+X2Vn/y1WILxNrhyQORP6VmYNRp+WoeVoVmijrB4vZOwkja7
        SAteWPNljJ6Cexr0gD3pHUlvSg==
X-Google-Smtp-Source: ADFU+vvQgccczFThDKKrhdBq0sChFDblkmCyADzO4o8oCg8ZtNgK7xG/FRwurPZwlHpIbW/Z4/bbZg==
X-Received: by 2002:a05:6214:907:: with SMTP id dj7mr1361299qvb.245.1583470138296;
        Thu, 05 Mar 2020 20:48:58 -0800 (PST)
Received: from ovpn-121-18.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id f189sm11207988qke.90.2020.03.05.20.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 20:48:57 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au
Cc:     rashmicy@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v3] powerpc/64s/pgtable: fix an undefined behaviour
Date:   Thu,  5 Mar 2020 23:48:52 -0500
Message-Id: <20200306044852.3236-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Booting a power9 server with hash MMU could trigger an undefined
behaviour because pud_offset(p4d, 0) will do,

0 >> (PAGE_SHIFT:16 + PTE_INDEX_SIZE:8 + H_PMD_INDEX_SIZE:10)

Fix it by converting pud_index() and friends to static inline
functions.

UBSAN: shift-out-of-bounds in arch/powerpc/mm/ptdump/ptdump.c:282:15
shift exponent 34 is too large for 32-bit type 'int'
CPU: 6 PID: 1 Comm: swapper/0 Not tainted 5.6.0-rc4-next-20200303+ #13
Call Trace:
dump_stack+0xf4/0x164 (unreliable)
ubsan_epilogue+0x18/0x78
__ubsan_handle_shift_out_of_bounds+0x160/0x21c
walk_pagetables+0x2cc/0x700
walk_pud at arch/powerpc/mm/ptdump/ptdump.c:282
(inlined by) walk_pagetables at arch/powerpc/mm/ptdump/ptdump.c:311
ptdump_check_wx+0x8c/0xf0
mark_rodata_ro+0x48/0x80
kernel_init+0x74/0x194
ret_from_kernel_thread+0x5c/0x74

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v3: convert pud_index() etc to static inline functions.
v2: convert pud_offset() etc to static inline functions.

 arch/powerpc/include/asm/book3s/64/pgtable.h | 23 ++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 201a69e6a355..bd432c6706b9 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -998,10 +998,25 @@ extern struct page *pgd_page(pgd_t pgd);
 #define pud_page_vaddr(pud)	__va(pud_val(pud) & ~PUD_MASKED_BITS)
 #define pgd_page_vaddr(pgd)	__va(pgd_val(pgd) & ~PGD_MASKED_BITS)
 
-#define pgd_index(address) (((address) >> (PGDIR_SHIFT)) & (PTRS_PER_PGD - 1))
-#define pud_index(address) (((address) >> (PUD_SHIFT)) & (PTRS_PER_PUD - 1))
-#define pmd_index(address) (((address) >> (PMD_SHIFT)) & (PTRS_PER_PMD - 1))
-#define pte_index(address) (((address) >> (PAGE_SHIFT)) & (PTRS_PER_PTE - 1))
+static inline unsigned long pgd_index(unsigned long address)
+{
+	return (address >> PGDIR_SHIFT) & (PTRS_PER_PGD - 1);
+}
+
+static inline unsigned long pud_index(unsigned long address)
+{
+	return (address >> PUD_SHIFT) & (PTRS_PER_PUD - 1);
+}
+
+static inline unsigned long pmd_index(unsigned long address)
+{
+	return (address >> PMD_SHIFT) & (PTRS_PER_PMD - 1);
+}
+
+static inline unsigned long pte_index(unsigned long address)
+{
+	return (address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1);
+}
 
 /*
  * Find an entry in a page-table-directory.  We combine the address region
-- 
2.21.0 (Apple Git-122.2)

