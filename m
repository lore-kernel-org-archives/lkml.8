Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B52C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58DAF20731
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 09:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgDMJyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 05:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727826AbgDMJyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 05:54:41 -0400
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Apr 2020 05:54:41 EDT
X-Greylist: delayed 301 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Apr 2020 02:47:48 PDT
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98942C008748
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 02:47:48 -0700 (PDT)
Received: from ramsan ([84.195.182.253])
        by laurent.telenet-ops.be with bizsmtp
        id S9ij2200E5USYZQ019ijFU; Mon, 13 Apr 2020 11:42:43 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jNvc3-0007LZ-5P
        for linux-kernel@vger.kernel.org; Mon, 13 Apr 2020 11:42:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jNvQi-0006NR-79
        for linux-kernel@vger.kernel.org; Mon, 13 Apr 2020 11:31:00 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.7-rc1
Date:   Mon, 13 Apr 2020 11:31:00 +0200
Message-Id: <20200413093100.24470-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.7-rc1[1] compared to v5.6[2].

Summarized:
  - build errors: +132/-3
  - build warnings: +257/-79

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8f3d9f354286745c751374f5f1fcafee6b3f3136/ (all 239 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7111951b8d4973bda27ff663f2cf18b663d15b48/ (all 239 configs)


*** ERRORS ***

132 error regressions:
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/hash.h: error: implicit declaration of function 'pte_raw' [-Werror=implicit-function-declaration]:  => 192:2
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/hash.h: error: implicit declaration of function 'pte_raw'; did you mean 'pte_read'? [-Werror=implicit-function-declaration]:  => 192:8
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/mmu-hash.h: error: 'SLICE_NUM_HIGH' undeclared here (not in a function):  => 698:2, 698:30
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/mmu-hash.h: error: 'struct mmu_psize_def' has no member named 'ap':  => 207:28
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/mmu-hash.h: error: 'struct mmu_psize_def' has no member named 'avpnm':  => 337:57
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/mmu-hash.h: error: 'struct mmu_psize_def' has no member named 'penc':  => 411:49
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/mmu-hash.h: error: 'struct mmu_psize_def' has no member named 'penc'; did you mean 'enc'?:  => 411:50
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/mmu-hash.h: error: 'struct mmu_psize_def' has no member named 'sllp':  => 218:32, 219:26
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/mmu-hash.h: error: redefinition of 'mmu_psize_to_shift':  => 195:28
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/mmu-hash.h: error: redefinition of 'shift_to_mmu_psize':  => 185:19
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable-4k.h: error: implicit declaration of function 'pgd_raw' [-Werror=implicit-function-declaration]:  => 35:3
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable-4k.h: error: implicit declaration of function 'pgd_raw'; did you mean 'pgd_val'? [-Werror=implicit-function-declaration]:  => 35:13
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable-4k.h: error: implicit declaration of function 'pud_raw' [-Werror=implicit-function-declaration]:  => 25:3
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable-4k.h: error: implicit declaration of function 'pud_raw'; did you mean 'pud_val'? [-Werror=implicit-function-declaration]:  => 25:13
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable-4k.h: error: redefinition of 'hugepd_ok':  => 44:19
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable-4k.h: error: redefinition of 'pgd_huge':  => 29:19
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable-4k.h: error: redefinition of 'pmd_huge':  => 9:19
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable-4k.h: error: redefinition of 'pud_huge':  => 19:19
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: expected ')' before '!=' token:  => 964:19, 921:19
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: expected ')' before '==' token:  => 979:19, 801:19
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: expected ')' before '^' token:  => 801:19
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: expected ')' before '__vmalloc_end':  => 291:21, 274:21
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: expected identifier or '(' before '!' token:  => 916:19, 904:19, 939:19, 959:19, 868:19, 873:19
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: expected identifier or '(' before 'struct':  => 291:21
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: implicit declaration of function '__pgd_raw' [-Werror=implicit-function-declaration]:  => 976:2
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: implicit declaration of function '__pgd_raw'; did you mean '__fdget_raw'? [-Werror=implicit-function-declaration]:  => 976:9
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: implicit declaration of function '__pmd_raw' [-Werror=implicit-function-declaration]:  => 1075:9, 1075:2
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: implicit declaration of function '__pte_raw' [-Werror=implicit-function-declaration]:  => 552:2, 552:9
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: implicit declaration of function '__pud_raw' [-Werror=implicit-function-declaration]:  => 935:9, 935:2
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: incompatible types when returning type 'int' but 'pgd_t' was expected:  => 976:2
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: incompatible types when returning type 'int' but 'pgd_t' {aka 'struct <anonymous>'} was expected:  => 976:9
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: incompatible types when returning type 'int' but 'pmd_t' was expected:  => 1075:2
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: incompatible types when returning type 'int' but 'pmd_t' {aka 'struct <anonymous>'} was expected:  => 1075:9
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: incompatible types when returning type 'int' but 'pte_t' was expected:  => 675:2, 552:2, 971:2, 670:2, 1070:2, 647:2, 652:2, 642:2, 695:2, 660:2, 632:2, 665:2, 690:2, 627:2, 714:2, 930:2, 685:2, 637:2
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: incompatible types when returning type 'int' but 'pte_t' {aka 'struct <anonymous>'} was expected:  => 1070:9, 695:9, 627:9, 685:9, 642:9, 930:9, 647:9, 690:9, 665:9, 660:9, 675:9, 670:9, 714:9, 552:9, 971:9, 637:9, 632:9, 652:9
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: incompatible types when returning type 'int' but 'pud_t' was expected:  => 935:2
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: incompatible types when returning type 'int' but 'pud_t' {aka 'struct <anonymous>'} was expected:  => 935:9
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of '__ptep_set_access_flags':  => 789:20
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of '__ptep_test_and_clear_young':  => 371:19
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of '__set_pte_at':  => 815:20
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'huge_ptep_set_wrprotect':  => 437:20
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pfn_pte':  => 609:21
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pgd_clear':  => 954:20
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pgd_is_leaf':  => 1373:21, 1375:20
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pgd_pte':  => 969:21
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pmd_clear':  => 863:20
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pmd_is_leaf':  => 1359:21, 1361:20
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pmd_pte':  => 1068:21
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_access_permitted':  => 587:20, 586:30
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_ci':  => 853:20
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_clear':  => 474:20
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_devmap':  => 704:19
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_dirty':  => 480:19
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_exec':  => 495:20
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_exprotect':  => 630:21
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_hw_valid':  => 567:20
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_mkclean':  => 635:21
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_mkdirty':  => 663:21
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_mkexec':  => 645:21
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_mkhuge':  => 678:21
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_mkold':  => 640:21
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_mkprivileged':  => 688:21
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_mkpte':  => 650:21
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_mkspecial':  => 673:21
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_mkuser':  => 693:21
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_mkwrite':  => 655:21
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_mkyoung':  => 668:21
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_modify':  => 711:21
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_none':  => 808:19
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_pfn':  => 617:29
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_pgd':  => 974:21
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_present':  => 556:19
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_pud':  => 933:21
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_read':  => 421:19
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_special':  => 490:19
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_unmap':  => 1022:20
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_update':  => 353:29
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_user':  => 581:20
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_write':  => 416:19
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_wrprotect':  => 623:21
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pte_young':  => 485:19
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'ptep_get_and_clear':  => 451:21
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'ptep_get_and_clear_full':  => 459:21
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'ptep_set_wrprotect':  => 427:20
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pud_clear':  => 911:20
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pud_is_leaf':  => 1366:21, 1368:20
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: redefinition of 'pud_pte':  => 928:21
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: static declaration of 'map_kernel_page' follows non-static declaration:  => 1037:19
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: static declaration of 'vmemmap_create_mapping' follows non-static declaration:  => 1049:29
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: error: static declaration of 'vmemmap_remove_mapping' follows non-static declaration:  => 1059:20
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/radix.h: error: implicit declaration of function 'pmd_raw' [-Werror=implicit-function-declaration]:  => 221:2
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/radix.h: error: implicit declaration of function 'pmd_raw'; did you mean 'pmd_val'? [-Werror=implicit-function-declaration]:  => 221:11
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/tlbflush-radix.h: error: 'struct mmu_psize_def' has no member named 'ap':  => 11:30
  + /kisskb/src/arch/powerpc/include/asm/kvm_book3s.h: error: 'struct kvm_vcpu_arch' has no member named 'book3s':  => 316:19
  + /kisskb/src/arch/powerpc/include/asm/kvm_book3s.h: error: 'struct kvm_vcpu_arch' has no member named 'fault_dar':  => 396:19
  + /kisskb/src/arch/powerpc/include/asm/kvm_book3s.h: error: 'struct kvm_vcpu_arch' has no member named 'fault_dar'; did you mean 'fault_dear'?:  => 396:20
  + /kisskb/src/arch/powerpc/include/asm/kvm_book3s.h: error: redefinition of 'kvmppc_get_cr':  => 343:19
  + /kisskb/src/arch/powerpc/include/asm/kvm_book3s.h: error: redefinition of 'kvmppc_get_ctr':  => 363:21
  + /kisskb/src/arch/powerpc/include/asm/kvm_book3s.h: error: redefinition of 'kvmppc_get_fault_dar':  => 394:21
  + /kisskb/src/arch/powerpc/include/asm/kvm_book3s.h: error: redefinition of 'kvmppc_get_gpr':  => 333:21
  + /kisskb/src/arch/powerpc/include/asm/kvm_book3s.h: error: redefinition of 'kvmppc_get_lr':  => 373:21
  + /kisskb/src/arch/powerpc/include/asm/kvm_book3s.h: error: redefinition of 'kvmppc_get_pc':  => 383:21
  + /kisskb/src/arch/powerpc/include/asm/kvm_book3s.h: error: redefinition of 'kvmppc_get_xer':  => 353:21
  + /kisskb/src/arch/powerpc/include/asm/kvm_book3s.h: error: redefinition of 'kvmppc_need_byteswap':  => 389:20
  + /kisskb/src/arch/powerpc/include/asm/kvm_book3s.h: error: redefinition of 'kvmppc_set_cr':  => 338:20
  + /kisskb/src/arch/powerpc/include/asm/kvm_book3s.h: error: redefinition of 'kvmppc_set_ctr':  => 358:20
  + /kisskb/src/arch/powerpc/include/asm/kvm_book3s.h: error: redefinition of 'kvmppc_set_gpr':  => 328:20
  + /kisskb/src/arch/powerpc/include/asm/kvm_book3s.h: error: redefinition of 'kvmppc_set_lr':  => 368:20
  + /kisskb/src/arch/powerpc/include/asm/kvm_book3s.h: error: redefinition of 'kvmppc_set_pc':  => 378:20
  + /kisskb/src/arch/powerpc/include/asm/kvm_book3s.h: error: redefinition of 'kvmppc_set_xer':  => 348:20
  + /kisskb/src/arch/powerpc/include/asm/kvm_book3s.h: error: redefinition of 'kvmppc_supports_magic_page':  => 405:20
  + /kisskb/src/arch/powerpc/include/asm/nohash/64/pgtable-4k.h: error: expected ')' before '!=' token:  => 58:40
  + /kisskb/src/arch/powerpc/include/asm/nohash/64/pgtable-4k.h: error: expected ')' before '==' token:  => 57:37
  + /kisskb/src/arch/powerpc/include/asm/nohash/64/pgtable-4k.h: error: expected identifier or '(' before '!' token:  => 56:25
  + /kisskb/src/arch/powerpc/include/asm/nohash/64/pgtable.h: error: expected ')' before '!=' token:  => 163:40
  + /kisskb/src/arch/powerpc/include/asm/nohash/64/pgtable.h: error: expected ')' before '==' token:  => 333:50
  + /kisskb/src/arch/powerpc/include/asm/nohash/64/pgtable.h: error: expected ')' before '^' token:  => 333:36
  + /kisskb/src/arch/powerpc/include/asm/nohash/64/pgtable.h: error: expected identifier or '(' before '!' token:  => 146:27, 144:24, 160:25, 161:24, 143:25
  + /kisskb/src/arch/powerpc/include/asm/nohash/64/pgtable.h: error: expected identifier or '(' before 'struct':  => 77:21
  + /kisskb/src/arch/powerpc/include/asm/nohash/pgtable.h: error: redefinition of 'pgd_huge':  => 291:19
  + /kisskb/src/arch/powerpc/include/asm/nohash/pte-book3e.h: error: redefinition of 'pte_mkprivileged':  => 108:26
  + /kisskb/src/arch/powerpc/include/asm/nohash/pte-book3e.h: error: redefinition of 'pte_mkuser':  => 115:20
  + /kisskb/src/arch/powerpc/kvm/book3s_64_vio_hv.c: error: 'struct kvm_arch' has no member named 'spapr_tce_tables':  => 68:46, 68:2
  + /kisskb/src/arch/sh/mm/init.c: error: control reaches end of non-void function [-Werror=return-type]:  => 424:1
  + /kisskb/src/arch/sh/mm/init.c: error: expected ')' before 'return':  => 416:3
  + /kisskb/src/arch/sh/mm/init.c: error: expected expression before '}' token:  => 424:1
  + /kisskb/src/arch/sh/mm/init.c: error: unused variable 'nr_pages' [-Werror=unused-variable]:  => 412:16
  + /kisskb/src/arch/sh/mm/init.c: error: unused variable 'ret' [-Werror=unused-variable]:  => 413:6
  + /kisskb/src/arch/sh/mm/init.c: error: unused variable 'start_pfn' [-Werror=unused-variable]:  => 411:16
  + /kisskb/src/drivers/vdpa/vdpa_sim/vdpa_sim.c: error: implicit declaration of function 'set_dma_ops' [-Werror=implicit-function-declaration]:  => 324:2
  + error: modpost: "__delay" [drivers/net/phy/mdio-cavium.ko] undefined!:  => N/A
  + error: modpost: "sysrq_mask" [drivers/tty/serial/serial_core.ko] undefined!:  => N/A

3 error improvements:
  - error: "__delay" [drivers/net/phy/mdio-cavium.ko] undefined!: N/A => 
  - error: "devm_ioremap_resource" [drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!: N/A => 
  - error: "devm_ioremap_resource" [drivers/ptp/ptp_ines.ko] undefined!: N/A => 


*** WARNINGS ***

257 warning regressions:
  + .config: warning: symbol value '2.01827e+11' invalid for LD_VERSION:  => 11
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/hash-4k.h: warning: "H_PAGE_4K_PFN" redefined [enabled by default]:  => 49:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/hash-4k.h: warning: "H_PAGE_4K_PFN" redefined:  => 49
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/hash-4k.h: warning: "REGION_SHIFT" redefined [enabled by default]:  => 16:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/hash-4k.h: warning: "REGION_SHIFT" redefined:  => 16
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/hash.h: warning: "USER_REGION_ID" redefined [enabled by default]:  => 91:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/hash.h: warning: "USER_REGION_ID" redefined:  => 91
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/hash.h: warning: "VMALLOC_REGION_ID" redefined [enabled by default]:  => 93:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/hash.h: warning: "VMALLOC_REGION_ID" redefined:  => 93
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "IOREMAP_END" redefined [enabled by default]:  => 320:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "IOREMAP_END" redefined:  => 320
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "IOREMAP_MAX_ORDER" redefined [enabled by default]:  => 282:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "IOREMAP_MAX_ORDER" redefined:  => 282
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "KERN_IO_START" redefined [enabled by default]:  => 288:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "KERN_IO_START" redefined:  => 288
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "KERN_VIRT_START" redefined [enabled by default]:  => 287:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "KERN_VIRT_START" redefined:  => 287
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "MAX_SWAPFILES_CHECK" redefined [enabled by default]:  => 719:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "MAX_SWAPFILES_CHECK" redefined:  => 719
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PAGE_COPY" redefined [enabled by default]:  => 150:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PAGE_COPY" redefined:  => 150
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PAGE_COPY_X" redefined [enabled by default]:  => 151:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PAGE_COPY_X" redefined:  => 151
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PAGE_KERNEL_NC" redefined [enabled by default]:  => 157:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PAGE_KERNEL_NC" redefined:  => 157
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PAGE_KERNEL_NCG" redefined [enabled by default]:  => 159:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PAGE_KERNEL_NCG" redefined:  => 159
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PAGE_NONE" redefined [enabled by default]:  => 147:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PAGE_NONE" redefined:  => 147
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PAGE_READONLY" redefined [enabled by default]:  => 152:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PAGE_READONLY" redefined:  => 152
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PAGE_READONLY_X" redefined [enabled by default]:  => 153:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PAGE_READONLY_X" redefined:  => 153
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PAGE_SHARED" redefined [enabled by default]:  => 148:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PAGE_SHARED" redefined:  => 148
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PAGE_SHARED_X" redefined [enabled by default]:  => 149:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PAGE_SHARED_X" redefined:  => 149
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PGD_INDEX_SIZE" redefined [enabled by default]:  => 193:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PGD_INDEX_SIZE" redefined:  => 193
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PGD_MASKED_BITS" redefined [enabled by default]:  => 254:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PGD_MASKED_BITS" redefined:  => 254
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PGD_TABLE_SIZE" redefined [enabled by default]:  => 208:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PGD_TABLE_SIZE" redefined:  => 208
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PMD_CACHE_INDEX" redefined [enabled by default]:  => 195:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PMD_CACHE_INDEX" redefined:  => 195
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PMD_INDEX_SIZE" redefined [enabled by default]:  => 191:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PMD_INDEX_SIZE" redefined:  => 191
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PMD_MASKED_BITS" redefined [enabled by default]:  => 250:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PMD_MASKED_BITS" redefined:  => 250
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PMD_TABLE_SIZE" redefined [enabled by default]:  => 206:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PMD_TABLE_SIZE" redefined:  => 206
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PTE_FRAG_NR" redefined [enabled by default]:  => 218:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PTE_FRAG_NR" redefined:  => 218
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PTE_FRAG_SIZE_SHIFT" redefined [enabled by default]:  => 220:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PTE_FRAG_SIZE_SHIFT" redefined:  => 220
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PTE_INDEX_SIZE" redefined [enabled by default]:  => 190:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PTE_INDEX_SIZE" redefined:  => 190
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PTE_RPN_MASK" redefined [enabled by default]:  => 105:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PTE_RPN_MASK" redefined:  => 105
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PTE_TABLE_SIZE" redefined [enabled by default]:  => 205:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PTE_TABLE_SIZE" redefined:  => 205
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PUD_CACHE_INDEX" redefined [enabled by default]:  => 196:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PUD_CACHE_INDEX" redefined:  => 196
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PUD_INDEX_SIZE" redefined [enabled by default]:  => 192:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PUD_INDEX_SIZE" redefined:  => 192
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PUD_MASKED_BITS" redefined [enabled by default]:  => 252:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PUD_MASKED_BITS" redefined:  => 252
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PUD_TABLE_SIZE" redefined [enabled by default]:  => 207:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "PUD_TABLE_SIZE" redefined:  => 207
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "VMALLOC_END" redefined [enabled by default]:  => 274:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "VMALLOC_END" redefined:  => 274
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "VMALLOC_START" redefined [enabled by default]:  => 273:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "VMALLOC_START" redefined:  => 273
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_ACCESSED" redefined [enabled by default]:  => 27:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_ACCESSED" redefined:  => 27
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_BASE" redefined [enabled by default]:  => 137:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_BASE" redefined:  => 137
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_BASE_NC" redefined [enabled by default]:  => 136:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_BASE_NC" redefined:  => 136
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_BIT_SWAP_TYPE" redefined [enabled by default]:  => 15:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_BIT_SWAP_TYPE" redefined:  => 15
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_CACHE_CTL" redefined [enabled by default]:  => 823:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_CACHE_CTL" redefined:  => 823
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_CHG_MASK" redefined [enabled by default]:  => 124:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_CHG_MASK" redefined:  => 124
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_DIRTY" redefined [enabled by default]:  => 26:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_DIRTY" redefined:  => 26
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_EXEC" redefined [enabled by default]:  => 17:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_EXEC" redefined:  => 17
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_KERNEL_RO" redefined [enabled by default]:  => 117:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_KERNEL_RO" redefined:  => 117
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_KERNEL_RW" redefined [enabled by default]:  => 116:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_KERNEL_RW" redefined:  => 116
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_KERNEL_RWX" redefined [enabled by default]:  => 118:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_KERNEL_RWX" redefined:  => 118
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_NO_CACHE" redefined [enabled by default]:  => 99:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_NO_CACHE" redefined:  => 99
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_PRESENT" redefined [enabled by default]:  => 42:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_PRESENT" redefined:  => 42
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_PRIVILEGED" redefined [enabled by default]:  => 22:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_PRIVILEGED" redefined:  => 22
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_RW" redefined [enabled by default]:  => 20:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_RW" redefined:  => 20
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_SAO" redefined [enabled by default]:  => 23:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_SAO" redefined:  => 23
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_SPECIAL" redefined [enabled by default]:  => 91:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "_PAGE_SPECIAL" redefined:  => 91
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "__pte_to_swp_entry" redefined [enabled by default]:  => 742:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "__pte_to_swp_entry" redefined:  => 742
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "__swp_entry" redefined [enabled by default]:  => 733:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "__swp_entry" redefined:  => 733
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "__swp_entry_to_pte" redefined [enabled by default]:  => 743:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "__swp_entry_to_pte" redefined:  => 743
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "__swp_offset" redefined [enabled by default]:  => 732:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "__swp_offset" redefined:  => 732
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pgd_access_permitted" redefined [enabled by default]:  => 986:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pgd_access_permitted" redefined:  => 986
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pgd_leaf" redefined [enabled by default]:  => 1374:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pgd_leaf" redefined:  => 1374
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pgd_page_vaddr" redefined [enabled by default]:  => 999:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pgd_page_vaddr" redefined:  => 999
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pgprot_cached" redefined [enabled by default]:  => 839:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pgprot_cached" redefined:  => 839
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pgprot_noncached" redefined [enabled by default]:  => 825:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pgprot_noncached" redefined:  => 825
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pgprot_noncached_wc" redefined [enabled by default]:  => 832:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pgprot_noncached_wc" redefined:  => 832
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pgprot_writecombine" redefined [enabled by default]:  => 845:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pgprot_writecombine" redefined:  => 845
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pmd_access_permitted" redefined [enabled by default]:  => 1117:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pmd_access_permitted" redefined:  => 1117
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pmd_clear_savedwrite" redefined [enabled by default]:  => 1092:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pmd_clear_savedwrite" redefined:  => 1092
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pmd_leaf" redefined [enabled by default]:  => 1360:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pmd_leaf" redefined:  => 1360
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pmd_mk_savedwrite" redefined [enabled by default]:  => 1091:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pmd_mk_savedwrite" redefined:  => 1091
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pmd_offset" redefined [enabled by default]:  => 1015:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pmd_offset" redefined:  => 1015
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pmd_page_vaddr" redefined [enabled by default]:  => 997:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pmd_page_vaddr" redefined:  => 997
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pmd_savedwrite" redefined [enabled by default]:  => 1115:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pmd_savedwrite" redefined:  => 1115
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pte_clear_savedwrite" redefined [enabled by default]:  => 548:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pte_clear_savedwrite" redefined:  => 548
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pte_offset_kernel" redefined [enabled by default]:  => 1017:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pte_offset_kernel" redefined:  => 1017
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pte_savedwrite" redefined [enabled by default]:  => 409:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pte_savedwrite" redefined:  => 409
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pud_access_permitted" redefined [enabled by default]:  => 946:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pud_access_permitted" redefined:  => 946
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pud_leaf" redefined [enabled by default]:  => 1367:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pud_leaf" redefined:  => 1367
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pud_offset" redefined [enabled by default]:  => 1013:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pud_offset" redefined:  => 1013
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pud_page_vaddr" redefined [enabled by default]:  => 998:0
  + /kisskb/src/arch/powerpc/include/asm/book3s/64/pgtable.h: warning: "pud_page_vaddr" redefined:  => 998
  + /kisskb/src/arch/powerpc/include/asm/kvm_book3s_asm.h: warning: "KVMPPC_NR_LPIDS" redefined [enabled by default]:  => 18:0
  + /kisskb/src/arch/powerpc/include/asm/kvm_book3s_asm.h: warning: "KVMPPC_NR_LPIDS" redefined:  => 18
  + /kisskb/src/block/genhd.c: warning: the frame size of 1688 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 1617:1
  + /kisskb/src/block/genhd.c: warning: the frame size of 1720 bytes is larger than 1280 bytes [-Wframe-larger-than=]:  => 1617:1
  + /kisskb/src/drivers/char/random.c: warning: 'rv' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 814:18
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c: warning: (near initialization for 'dcn2_0_nv12_soc.clock_limits') [-Wmissing-braces]:  => 451:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.c: warning: missing braces around initializer [-Wmissing-braces]:  => 451:8
  + /kisskb/src/drivers/gpu/drm/bridge/tc358768.c: warning: the frame size of 2224 bytes is larger than 2048 bytes [-Wframe-larger-than=]:  => 840:1
  + /kisskb/src/drivers/iio/dac/ad5770r.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 516:6
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en/health.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]:  => 264:6
  + /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c: warning: 'rule' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 1138:27
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_probe' uses dynamic stack allocation:  => 544:1
  + /kisskb/src/drivers/staging/octeon/ethernet-mem.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 123:18
  + /kisskb/src/drivers/tty/n_tty.c: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'unsigned int' [-Wformat=]:  => 2059:14, 2037:14
  + /kisskb/src/drivers/tty/n_tty.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]:  => 2037:14
  + /kisskb/src/drivers/tty/n_tty.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat=]:  => 2059:14, 2037:14
  + /kisskb/src/drivers/tty/n_tty.c: warning: format '%zu' expects argument of type 'size_t', but argument 6 has type 'unsigned int' [-Wformat=]:  => 2059:14, 2037:14
  + /kisskb/src/drivers/tty/n_tty.c: warning: format '%zu' expects argument of type 'size_t', but argument 7 has type 'unsigned int' [-Wformat=]:  => 2059:14
  + /kisskb/src/drivers/tty/n_tty.c: warning: format '%zu' expects argument of type 'size_t', but argument 8 has type 'unsigned int' [-Wformat=]:  => 2059:14
  + /kisskb/src/drivers/vdpa/ifcvf/ifcvf_main.c: warning: large integer implicitly truncated to unsigned type [-Woverflow]:  => 233:2
  + /kisskb/src/drivers/vdpa/vdpa_sim/vdpa_sim.c: warning: large integer implicitly truncated to unsigned type [-Woverflow]:  => 440:2
  + /kisskb/src/drivers/vhost/vdpa.c: warning: 'map_pfn' may be used uninitialized in this function [-Wuninitialized]:  => 579:52
  + /kisskb/src/fs/btrfs/backref.c: warning: (near initialization for 'target.rbnode') [-Wmissing-braces]:  => 394:9
  + /kisskb/src/fs/btrfs/backref.c: warning: missing braces around initializer [-Wmissing-braces]:  => 394:9
  + /kisskb/src/fs/namei.c: warning: 'inode' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 1805:10
  + /kisskb/src/fs/namei.c: warning: 'inode' may be used uninitialized in this function [-Wuninitialized]:  => 1805:10
  + /kisskb/src/fs/namei.c: warning: 'seq' may be used uninitialized in this function [-Wuninitialized]:  => 1805:10
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_cgroup_output' uses dynamic stack allocation:  => 7824:1
  + /kisskb/src/kernel/futex.c: warning: 'oldval' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 1686:17, 1676:17
  + /kisskb/src/kernel/futex.c: warning: 'oldval' may be used uninitialized in this function [-Wuninitialized]:  => 1676:3, 1686:3
  + /kisskb/src/kernel/sched/cputime.c: warning: 'val' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 1007:6
  + /kisskb/src/kernel/trace/ftrace.c: warning: 'filtered_pids' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 7244:8
  + /kisskb/src/kernel/trace/ftrace.c: warning: 'filtered_pids' may be used uninitialized in this function [-Wuninitialized]:  => 7244:6, 7244:23
  + /kisskb/src/kernel/trace/ftrace.c: warning: 'other_pids' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 7261:22
  + /kisskb/src/kernel/trace/ftrace.c: warning: 'other_pids' may be used uninitialized in this function [-Wuninitialized]:  => 7261:22, 7261:25
  + /kisskb/src/kernel/trace/ftrace.c: warning: 'seq_ops' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 7166:6
  + /kisskb/src/kernel/trace/ftrace.c: warning: 'seq_ops' may be used uninitialized in this function [-Wuninitialized]:  => 7166:6
  + /kisskb/src/mm/memory.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]:  => 1614:2
  + /kisskb/src/mm/page_alloc.c: warning: array subscript is above array bounds [-Warray-bounds]:  => 874:2, 872:43
  + /kisskb/src/net/mptcp/protocol.c: warning: 'dfrag_collapsed' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 611:6
  + /kisskb/src/net/mptcp/protocol.c: warning: 'dfrag_collapsed' may be used uninitialized in this function [-Wuninitialized]:  => 611:6
  + init/Kconfig: warning: 'LD_VERSION': number is invalid:  => 21
  + modpost: WARNING: modpost: "clear_page" [drivers/md/dm-integrity.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "clear_page" [drivers/md/raid456.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "clear_page" [drivers/scsi/sd_mod.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "clear_page" [fs/btrfs/btrfs.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "clear_page" [fs/fuse/fuse.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "clear_page" [fs/gfs2/gfs2.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "clear_page" [fs/ntfs/ntfs.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "clear_page" [fs/ocfs2/dlm/ocfs2_dlm.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "copy_page" [drivers/block/drbd/drbd.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "copy_page" [drivers/md/dm-integrity.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "copy_page" [fs/btrfs/btrfs.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "copy_page" [fs/cachefiles/cachefiles.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "copy_page" [fs/fuse/fuse.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "copy_page" [fs/nilfs2/nilfs2.ko] has no CRC!:  => N/A
  + modpost: WARNING: modpost: "saved_config" [vmlinux] is COMMON symbol:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "___rw_read_enter" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "___rw_read_exit" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "___rw_read_try" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "___rw_write_enter" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__ashldi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__ashrdi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__copy_1page" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__divdi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__lshrdi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__muldi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__ndelay" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "__udelay" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "bzero_1page" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "clear_page" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "copy_page" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: EXPORT symbol "empty_zero_page" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
  + modpost: WARNING: modpost: lib/test_bitmap.o(.text.unlikely+0x58): Section mismatch in reference from the function bitmap_equal() to the variable .init.rodata:clump_exp:  => N/A
  + modpost: WARNING: modpost: vmlinux.o (.PPC.EMB.apuinfo): unexpected non-allocatable section.:  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text+0x31668): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text+0x36888): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x1a0): Section mismatch in reference from the function early_init_mmu() to the function .init.text:radix__early_init_mmu():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x1ac): Section mismatch in reference from the function early_init_mmu() to the function .init.text:hash__early_init_mmu():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x2b0): Section mismatch in reference from the function early_init_mmu() to the function .init.text:radix__early_init_mmu():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x2ba4): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x2ba8): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x2bc): Section mismatch in reference from the function early_init_mmu() to the function .init.text:hash__early_init_mmu():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x2dac): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x2db0): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x2e00): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x3008): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x3d94): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x3da4): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x3da8): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x3db8): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x3dc0): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x3dd4): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x4074): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x4084): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x40a0): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x714): Section mismatch in reference from the function .smp_setup_pacas() to the function .init.text:.allocate_paca():  => N/A
  + modpost: WARNING: modpost: vmlinux.o(.text.unlikely+0x94c): Section mismatch in reference from the function .smp_setup_pacas() to the function .init.text:.allocate_paca():  => N/A
  + warning: unmet direct dependencies detected for SND_SOC_WM9712:  => N/A

79 warning improvements:
  - /kisskb/src/arch/m68k/include/asm/string.h: warning: '__builtin_memcpy' forming offset 8 is out of the bounds [0, 7] [-Warray-bounds]: 72:25 => 
  - /kisskb/src/arch/powerpc/include/asm/epapr_hcalls.h: warning: array subscript 1 is outside array bounds of 'const char[1]' [-Warray-bounds]: 298:20 => 
  - /kisskb/src/arch/powerpc/include/asm/epapr_hcalls.h: warning: array subscript 2 is outside array bounds of 'const char[1]' [-Warray-bounds]: 299:20 => 
  - /kisskb/src/arch/powerpc/include/asm/epapr_hcalls.h: warning: array subscript 3 is outside array bounds of 'const char[1]' [-Warray-bounds]: 300:20 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_dev_init' uses dynamic stack allocation: 491:1 => 
  - /kisskb/src/drivers/usb/host/fhci-hcd.c: warning: this statement may fall through [-Wimplicit-fallthrough=]: 398:8 => 
  - /kisskb/src/fs/ext4/readpage.c: warning: the frame size of 1180 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 416:1 => 
  - /kisskb/src/fs/mpage.c: warning: the frame size of 1108 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 338:1 => 
  - /kisskb/src/fs/mpage.c: warning: the frame size of 1148 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 690:1 => 
  - /kisskb/src/include/linux/spinlock.h: warning: 'flags' may be used uninitialized in this function [-Wuninitialized]: 393:2 => 
  - /kisskb/src/include/linux/unaligned/le_byteshift.h: warning: array subscript is above array bounds [-Warray-bounds]: 26:7 => 
  - /kisskb/src/kernel/padata.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 539:2 => 
  - /kisskb/src/mm/memcontrol.c: warning: 'mem_cgroup_id_get_many' defined but not used [-Wunused-function]: 4864:13 => 
  - warning: "clear_page" [drivers/md/dm-integrity.ko] has no CRC!: N/A => 
  - warning: "clear_page" [drivers/md/raid456.ko] has no CRC!: N/A => 
  - warning: "clear_page" [drivers/scsi/sd_mod.ko] has no CRC!: N/A => 
  - warning: "clear_page" [fs/btrfs/btrfs.ko] has no CRC!: N/A => 
  - warning: "clear_page" [fs/fuse/fuse.ko] has no CRC!: N/A => 
  - warning: "clear_page" [fs/gfs2/gfs2.ko] has no CRC!: N/A => 
  - warning: "clear_page" [fs/ntfs/ntfs.ko] has no CRC!: N/A => 
  - warning: "clear_page" [fs/ocfs2/dlm/ocfs2_dlm.ko] has no CRC!: N/A => 
  - warning: "copy_page" [drivers/block/drbd/drbd.ko] has no CRC!: N/A => 
  - warning: "copy_page" [drivers/md/dm-integrity.ko] has no CRC!: N/A => 
  - warning: "copy_page" [fs/btrfs/btrfs.ko] has no CRC!: N/A => 
  - warning: "copy_page" [fs/cachefiles/cachefiles.ko] has no CRC!: N/A => 
  - warning: "copy_page" [fs/fuse/fuse.ko] has no CRC!: N/A => 
  - warning: "copy_page" [fs/nilfs2/nilfs2.ko] has no CRC!: N/A => 
  - warning: "saved_config" [vmlinux] is COMMON symbol: N/A => 
  - warning: 140 bad relocations: N/A => 
  - warning: EXPORT symbol "___rw_read_enter" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "___rw_read_exit" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "___rw_read_try" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "___rw_write_enter" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "__ashldi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "__ashrdi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "__copy_1page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "__divdi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "__lshrdi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "__muldi3" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "__ndelay" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "__udelay" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "_mcount" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "bzero_1page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "clear_page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "copy_page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: EXPORT symbol "empty_zero_page" [vmlinux] version generation failed, symbol will not be versioned.: N/A => 
  - warning: lib/test_bitmap.o(.text.unlikely+0x58): Section mismatch in reference from the function bitmap_equal() to the variable .init.rodata:clump_exp: N/A => 
  - warning: unmet direct dependencies detected for SPI_PXA2XX: N/A => 
  - warning: vmlinux.o (.PPC.EMB.apuinfo): unexpected non-allocatable section.: N/A => 
  - warning: vmlinux.o(.text+0x2e1c): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x2fc8): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x314c8): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init(): N/A => 
  - warning: vmlinux.o(.text+0x31d4): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x31dc): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x31e4): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x33c8): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x36698): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x114): Section mismatch in reference from the function .setup_secure_guest() to the function .init.text:.prom_printf(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x160): Section mismatch in reference from the function .setup_secure_guest() to the function .init.text:.prom_printf(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x180): Section mismatch in reference from the function .setup_secure_guest() to the function .init.text:.call_prom(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x1b0): Section mismatch in reference from the function .setup_secure_guest() to the function .init.text:.prom_getprop(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x1c8): Section mismatch in reference from the function .setup_secure_guest() to the function .init.text:.prom_panic(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2b74): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2b78): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2d7c): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2d80): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2dd0): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2fd8): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3d64): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3d74): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3d78): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3d88): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3d90): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3da4): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x4044): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x4054): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x4070): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x874): Section mismatch in reference from the function .smp_setup_pacas() to the function .init.text:.allocate_paca(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0xaac): Section mismatch in reference from the function .smp_setup_pacas() to the function .init.text:.allocate_paca(): N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
