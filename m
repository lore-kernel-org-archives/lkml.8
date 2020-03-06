Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E570C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7CA206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="sVQp0SNz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgCFUoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 15:44:46 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37163 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgCFUoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:44:46 -0500
Received: by mail-qt1-f193.google.com with SMTP id l20so1096522qtp.4
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 12:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VIytyDCq7f0kiHtZyAPYuhAfxkdQ6oPpVlPc91ezlzw=;
        b=sVQp0SNzavyEmQgQgPO7gOzbjdxNHOBGOKLb2+i6xH5nTB6ZP6ociRcsHZFKZahWzv
         lVQMhT0TucKZE0jr1svRTaAecWqS9Lak/5QCDTaDSkOc6vq9y74In5QZ3C0vju5Y/YSJ
         seKiYzybOes0y2OWOOVvb45ZEYoBXTTL7/NQZvUeV5Umj/iFPmYuELjQmpwwRG/RbM00
         WMRsRryr0bUnfhZtTUXyLUc60zizY1/bRX7olknPmplQ8VZG+HU7CqTLWPWwICtR5QAk
         sPbgocfLtbClg6uijm1uY7WawL446OXTMUcERTf+StMaVG507VDTlm1AAJaTPJabMPKz
         9fdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VIytyDCq7f0kiHtZyAPYuhAfxkdQ6oPpVlPc91ezlzw=;
        b=BpYpk2HjL1T0CClR6YBPhS2FrsWmUJCILxN7v+kq4I8sJHCSRQNNH1VoSZxM/rGqYw
         Wd4o65v+4HlblJPFwSe2w3ROuQkYUssyOm1KfO0iFVycz5V6MoNLox8kI48qrOhD0xwV
         4lCyiSq6PRIULE2Qhbq3TaqafqQqTgE4Tw4iepoPcDcy3mMeOKCRr0S2KjNVFZtVrt6T
         8vqbLzgj2TDtXo5gozQdkMDo2q3RZ1xtASKBLU8DqB7R42EB15e65dl3SbOBbWpVRa3Q
         AhQVVXdV4YJlH+oNzgXhEK0Bv2G7XTN9rKCiboAU8LqTTWsk75SEpyzMZ/1Uec2+wzw/
         tIPQ==
X-Gm-Message-State: ANhLgQ1mj21HQYyvj1GcWRq7MBeAV62f+2oMheXkx1PB3CreCbCFNyA1
        HmC9Kf8GLusdTKm7gYjoHUGFvA==
X-Google-Smtp-Source: ADFU+vtc3atgWoG361itKB4xApBMGrMUExpxNIdab4Ow4UUWS5fC6T+QADXDozQS4OkwoR392p5sKA==
X-Received: by 2002:ac8:43c1:: with SMTP id w1mr4780630qtn.381.1583527484932;
        Fri, 06 Mar 2020 12:44:44 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id g15sm14611541qtq.71.2020.03.06.12.44.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2020 12:44:44 -0800 (PST)
Message-ID: <1583527481.7365.165.camel@lca.pw>
Subject: Re: [PATCH V15] mm/debug: Add tests validating architecture page
 table helpers
From:   Qian Cai <cai@lca.pw>
To:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@c-s.fr>
Date:   Fri, 06 Mar 2020 15:44:41 -0500
In-Reply-To: <1583452659-11801-1-git-send-email-anshuman.khandual@arm.com>
References: <1583452659-11801-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-06 at 05:27 +0530, Anshuman Khandual wrote:
> This adds tests which will validate architecture page table helpers and
> other accessors in their compliance with expected generic MM semantics.
> This will help various architectures in validating changes to existing
> page table helpers or addition of new ones.
> 
> This test covers basic page table entry transformations including but not
> limited to old, young, dirty, clean, write, write protect etc at various
> level along with populating intermediate entries with next page table page
> and validating them.
> 
> Test page table pages are allocated from system memory with required size
> and alignments. The mapped pfns at page table levels are derived from a
> real pfn representing a valid kernel text symbol. This test gets called
> inside kernel_init() right after async_synchronize_full().
> 
> This test gets built and run when CONFIG_DEBUG_VM_PGTABLE is selected. Any
> architecture, which is willing to subscribe this test will need to select
> ARCH_HAS_DEBUG_VM_PGTABLE. For now this is limited to arc, arm64, x86, s390
> and ppc32 platforms where the test is known to build and run successfully.
> Going forward, other architectures too can subscribe the test after fixing
> any build or runtime problems with their page table helpers. Meanwhile for
> better platform coverage, the test can also be enabled with CONFIG_EXPERT
> even without ARCH_HAS_DEBUG_VM_PGTABLE.
> 
> Folks interested in making sure that a given platform's page table helpers
> conform to expected generic MM semantics should enable the above config
> which will just trigger this test during boot. Any non conformity here will
> be reported as an warning which would need to be fixed. This test will help
> catch any changes to the agreed upon semantics expected from generic MM and
> enable platforms to accommodate it thereafter.

OK, I get this working on powerpc hash MMU as well, so this?

diff --git a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
index 64d0f9b15c49..c527d05c0459 100644
--- a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
+++ b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
@@ -22,8 +22,7 @@
     |       nios2: | TODO |
     |    openrisc: | TODO |
     |      parisc: | TODO |
-    |  powerpc/32: |  ok  |
-    |  powerpc/64: | TODO |
+    |     powerpc: |  ok  |
     |       riscv: | TODO |
     |        s390: |  ok  |
     |          sh: | TODO |
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 2e7eee523ba1..176930f40e07 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -116,7 +116,7 @@ config PPC
 	#
 	select ARCH_32BIT_OFF_T if PPC32
 	select ARCH_HAS_DEBUG_VIRTUAL
-	select ARCH_HAS_DEBUG_VM_PGTABLE if PPC32
+	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 96a91bda3a85..98990a515268 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -256,7 +256,8 @@ static void __init pte_clear_tests(struct mm_struct *mm,
pte_t *ptep,
 	pte_t pte = READ_ONCE(*ptep);
 
 	pte = __pte(pte_val(pte) | RANDOM_ORVALUE);
-	WRITE_ONCE(*ptep, pte);
+	set_pte_at(mm, vaddr, ptep, pte);
+	barrier();
 	pte_clear(mm, vaddr, ptep);
 	pte = READ_ONCE(*ptep);
 	WARN_ON(!pte_none(pte));
