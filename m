Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FB0C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1076208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgD2S6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:58:31 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:37191 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgD2S6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:58:30 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mo73N-1ioFcd47Vz-00pZnh; Wed, 29 Apr 2020 20:57:33 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Marc Zyngier <maz@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guan Xuetao <gxt@pku.edu.cn>,
        James Morse <james.morse@arm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: kvm: fix gcc-10 shift warning
Date:   Wed, 29 Apr 2020 20:56:20 +0200
Message-Id: <20200429185657.4085975-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8OXL6NQmTkcBiOCkHQGhzeqEoFYUxBw7WVzJaTTnU7kjO2pO0JM
 vohxDpabUNcn7UsoxF5ym+YjgJOchU1884rbX3nuxFYMv4FB/rT8ozIi8VhoHWbj/EF7FPM
 U+oI0IRs8bC/K66ZNFOZU6JTuSag6RdDgHRdqF4yz8H69o2BDgngLCbAmGfAz69x0LP3CWv
 b1VyXnO0UAWk5jmoJob5g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pysSrQd7X8s=:tvN+Zry+xKDmdH/BL5InUX
 k1tAFE1WchomAM9UocK6bXNp4JNYt1/e59RDJNa79qv/7xfQwkCWYLJva6UmP/CQJc3SrX5eN
 1sKBkSQTG70ZBxT4d8/8Lgr1CSw3AugFsu3m/MaeumdXG0l6a8hJbrvmVNjLaGRqALRzw+AV3
 cOg5xDJUksWvc7nAn8UlShJD1V/LG5K8E9JvYYxuJbcIoIJ2/LuPlSiaMv1/q9/nc2dW+NziG
 5wf3KrVWmlsGw+cc1r++paHuiOApe512vZzjCAzXBpvmpmEEtp8UopOJhritiVk4ZOT6nTLEJ
 sAKdlaPrr9DQkQ/9dd1NFygEVWwYl4ebCaGMLA/3IDEoXmx6YXjU14ysaixwv+DRwDz/T8hrc
 wsyy49yGM0ASNpgvAzrwzGpOI5O+5+BO4C8IPAMK+ge/1w5BIG67Vb4qUyFLAPiRmRXbpV1po
 e75B5che6cb7E7CpKuuQwx5E/WNwLvNQGUJVxefMBvMkqw3CceT9/O9WM3dAPEgjpePkqgWaw
 f61iiu1vckjcT6R83rSm7xATAcRqXXfPj00qadM830cBOkalW8NRr1RxtYaNyKmGwaauEzcG3
 kdPKX135SM/Wygk8rSEKnwezKDRlGU5sKeTLQDl7cTt0RyUATWYkFmvCrsPpePojs0MRq/p90
 n021UC/9bO+o9vsHrol1N5IcG9sKArHnVX5TKUGDD+q1BTn3ew+69VSj/Q2nFEJv/VL9XiIXf
 X6eCzkNl2qWW3Empf+D/+2fsuXMH7eOqX7LTg9Iw/zoGnvsyTZqmB0nV+VfUOlmOJajSxKpQ/
 5s7JDIXg+yLnWjUaDR/Q/AxlkUK9if7NstvdDBwY25FedD8Vvk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-10 warns that the 32-bit zero cannot be shifted more than
32 bits to the right:

arch/arm64/kvm/../../../virt/kvm/arm/mmu.c: In function 'clear_hyp_p4d_entry':
arch/arm64/include/asm/pgtable.h:630:35: error: right shift count >= width of type [-Werror=shift-count-overflow]
  630 | #define pud_index(addr)  (((addr) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
      |                                   ^~
arch/arm64/include/asm/memory.h:271:45: note: in definition of macro '__phys_to_virt'
  271 | #define __phys_to_virt(x) ((unsigned long)((x) - physvirt_offset))
      |                                             ^
arch/arm64/include/asm/pgtable.h:633:42: note: in expansion of macro '__va'
  633 | #define pud_offset(dir, addr)  ((pud_t *)__va(pud_offset_phys((dir), (addr))))
      |                                          ^~~~
arch/arm64/include/asm/pgtable.h:632:73: note: in expansion of macro 'pud_index'
  632 | #define pud_offset_phys(dir, addr) (p4d_page_paddr(READ_ONCE(*(dir))) + pud_index(addr) * sizeof(pud_t))
      |                                                                         ^~~~~~~~~
arch/arm64/include/asm/pgtable.h:633:47: note: in expansion of macro 'pud_offset_phys'
  633 | #define pud_offset(dir, addr)  ((pud_t *)__va(pud_offset_phys((dir), (addr))))
      |                                               ^~~~~~~~~~~~~~~
arch/arm64/kvm/../../../virt/kvm/arm/mmu.c:510:36: note: in expansion of macro 'pud_offset'
  510 |  pud_t *pud_table __maybe_unused = pud_offset(p4d, 0);
      |                                    ^~~~~~~~~~

This is harmless, and the warning is a little bit silly for
a zero constant, but it's trivial to fix by making it an
unsigned long, so do that.

Fixes: 22998131ab33 ("arm64: add support for folded p4d page tables")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 virt/kvm/arm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
index 48d4288c5f1b..534d9798c3cb 100644
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -507,7 +507,7 @@ static void clear_hyp_pgd_entry(pgd_t *pgd)
 
 static void clear_hyp_p4d_entry(p4d_t *p4d)
 {
-	pud_t *pud_table __maybe_unused = pud_offset(p4d, 0);
+	pud_t *pud_table __maybe_unused = pud_offset(p4d, 0UL);
 	VM_BUG_ON(p4d_huge(*p4d));
 	p4d_clear(p4d);
 	pud_free(NULL, pud_table);
-- 
2.26.0

