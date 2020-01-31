Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FACC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 06:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B581B20678
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 06:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgAaGbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 01:31:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:41842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgAaGbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 01:31:53 -0500
Received: from [10.44.0.22] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBB9B20674;
        Fri, 31 Jan 2020 06:31:51 +0000 (UTC)
Subject: Re: [PATCH 0/5] Rewrite Motorola MMU page-table layout
To:     Peter Zijlstra <peterz@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>
References: <20200129103941.304769381@infradead.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <8a81e075-d3bd-80c1-d869-9935fdd73162@linux-m68k.org>
Date:   Fri, 31 Jan 2020 16:31:48 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129103941.304769381@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 29/1/20 8:39 pm, Peter Zijlstra wrote:
> Hi!
> 
> In order to faciliate Will's READ_ONCE() patches:
> 
>    https://lkml.kernel.org/r/20200123153341.19947-1-will@kernel.org
> 
> we need to fix m68k/motorola to not have a giant pmd_t. These patches do so and
> are tested using ARAnyM/68040.
> 
> It would be very good if someone can either test or tell us what emulator to
> use for 020/030.

This series breaks compilation for the ColdFire (with MMU) variant of
the m68k family:

   CC      arch/m68k/kernel/sys_m68k.o
In file included from ./arch/m68k/include/asm/pgalloc.h:12,
                  from ./include/asm-generic/tlb.h:16,
                  from ./arch/m68k/include/asm/tlb.h:5,
                  from arch/m68k/kernel/sys_m68k.c:35:
./arch/m68k/include/asm/mcf_pgalloc.h: In function ‘__pte_free_tlb’:
./arch/m68k/include/asm/mcf_pgalloc.h:41:24: error: passing argument 1 of ‘pgtable_pte_page_dtor’ from incompatible pointer type [-Werror=incompatible-pointer-types]
   pgtable_pte_page_dtor(page);
                         ^~~~
In file included from arch/m68k/kernel/sys_m68k.c:13:
./include/linux/mm.h:1949:55: note: expected ‘struct page *’ but argument is of type ‘pgtable_t’ {aka ‘struct <anonymous> *’}
  static inline void pgtable_pte_page_dtor(struct page *page)
                                           ~~~~~~~~~~~~~^~~~
In file included from ./include/linux/mm.h:10,
                  from arch/m68k/kernel/sys_m68k.c:13:
./include/linux/gfp.h:577:40: error: passing argument 1 of ‘__free_pages’ from incompatible pointer type [-Werror=incompatible-pointer-types]
  #define __free_page(page) __free_pages((page), 0)
                                         ^~~~~~
./arch/m68k/include/asm/mcf_pgalloc.h:42:2: note: in expansion of macro ‘__free_page’
   __free_page(page);
   ^~~~~~~~~~~
./include/linux/gfp.h:566:39: note: expected ‘struct page *’ but argument is of type ‘pgtable_t’ {aka ‘struct <anonymous> *’}
  extern void __free_pages(struct page *page, unsigned int order);
                           ~~~~~~~~~~~~~^~~~
cc1: some warnings being treated as errors
scripts/Makefile.build:265: recipe for target 'arch/m68k/kernel/sys_m68k.o' failed


Easy to reproduce. Build for the m5475evb_defconfig.

Regards
Greg

