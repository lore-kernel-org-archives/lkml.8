Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DE7C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 11:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5626320578
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 11:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="2KSGbgq4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgFNLGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 07:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgFNLGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 07:06:02 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064F4C05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 04:05:50 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id r2so14835145ioo.4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 04:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FF55QwdecNw77dccKlbHsq19yjvhB6hhGth1ewY9UIA=;
        b=2KSGbgq4eKHSqlYMXP5RB1Nby6Ryz/TRQCaLJLz2vuvLOe1i0DmlHQn/od1KG2MFhI
         SX7NcDU4HrlQEjY4XDn5OL39/DWLkbS8Bd+UJyl14996OGAqV2Ni+sNm9C0kurqY5IXm
         65KwxoG++rVWMZ5u7cknYK2Vg91J19ToPkOBa30zkmP0siEPd88u//kpaLH6MnWb+NvV
         nzA6I37IFFQC3eutCsWYTHS+EgZnvqLW7TCyMjIVLzXv44U7FiNqE/gj2j08f9rTE3OD
         Sg9jlvkNUYG+qcOlI9dJRaWbwjAhNIFf56f6Cq6rYEPTFice3HK24hKev0KTMtNdZTzq
         13vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FF55QwdecNw77dccKlbHsq19yjvhB6hhGth1ewY9UIA=;
        b=rqNCSM39ETxqLE2rDlRVEKtG6q7Qd+cdyIdIG7QWU9Hi8KDy9Vlddk6J8kWPZ6lfn8
         SPpS/tT7KXbPDUVpDk800X1zgOvmz+6aS8Pd0lrbTrATS7zHpmSIM/3o11IVTBDM17nG
         kjzI+BmbSAToyrQkGSAz9XB9i7IAIbuamhY5UJnIzhFSzBocPSHMKZ1/W3SWwzlBrh/b
         L+pkN10d5ANZfw09F1PU2/ZDyOW+EV7tP84GCBcZiiOScFPlqerx9s474bVe9ekvxrCb
         xC9/i2P4+uaDKPmdW2hG+qEYu3CYgN5iPXgN4j0Eyw4t3MfboDyU5PmF9LAQJbONi/M1
         y8wg==
X-Gm-Message-State: AOAM531EC9WgC7GPyeNcgeCKa9dUGA9UAzgz/9Vq3075kKq04PiClAcn
        HL84O0pQaDME23AlLM1A98BXw/NMoFRR0VurJTAk4A==
X-Google-Smtp-Source: ABdhPJwSKjdmtTNXu6Kp+YCoXYgX/QyyFzhPdcGcVkuvRU2rm3Kff1WrGY4O8GAi0JdQQ+VshLEs7OtqITOOqeD58Qs=
X-Received: by 2002:a6b:dc12:: with SMTP id s18mr21969705ioc.56.1592132749372;
 Sun, 14 Jun 2020 04:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200614063858.85118-1-songmuchun@bytedance.com> <202006141842.lGHcqS4z%lkp@intel.com>
In-Reply-To: <202006141842.lGHcqS4z%lkp@intel.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Sun, 14 Jun 2020 19:05:13 +0800
Message-ID: <CAMZfGtXqwbU0JDpZKtm9+xXT-ca7t4AgYU95tJuVxmqNhhjPQQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm/slab: Add a __GFP_ACCOUNT GFP flag
 check for slab allocation
To:     kernel test robot <lkp@intel.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, Andrew Morton <akpm@linux-foundation.org>,
        kbuild-all@lists.01.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 6:19 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Muchun,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on mmotm/master]
>
> url:    https://github.com/0day-ci/linux/commits/Muchun-Song/mm-slab-Add-a-__GFP_ACCOUNT-GFP-flag-check-for-slab-allocation/20200614-144049
> base:   git://git.cmpxchg.org/linux-mmotm.git master
> config: xtensa-allyesconfig (attached as .config)
> compiler: xtensa-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=xtensa
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>
> In file included from include/linux/kernel.h:11,
> from include/linux/interrupt.h:6,
> from mm/kasan/common.c:18:
> include/linux/scatterlist.h: In function 'sg_set_buf':
> arch/xtensa/include/asm/page.h:182:9: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
> 182 |  ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
> |         ^~
> include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
> 78 | # define unlikely(x) __builtin_expect(!!(x), 0)
> |                                          ^
> include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
> 143 |  BUG_ON(!virt_addr_valid(buf));
> |  ^~~~~~
> arch/xtensa/include/asm/page.h:190:32: note: in expansion of macro 'pfn_valid'
> 190 | #define virt_addr_valid(kaddr) pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
> |                                ^~~~~~~~~
> include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
> 143 |  BUG_ON(!virt_addr_valid(buf));
> |          ^~~~~~~~~~~~~~~
> In file included from include/linux/mm_types_task.h:16,
> from include/linux/mm_types.h:5,
> from include/linux/mmzone.h:21,
> from include/linux/topology.h:33,
> from include/linux/irq.h:19,
> from include/asm-generic/hardirq.h:13,
> from ./arch/xtensa/include/generated/asm/hardirq.h:1,
> from include/linux/hardirq.h:9,
> from include/linux/interrupt.h:11,
> from mm/kasan/common.c:18:
> mm/kasan/../internal.h: In function 'mem_map_next':
> arch/xtensa/include/asm/page.h:182:9: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
> 182 |  ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
> |         ^~
> >> mm/kasan/../internal.h:393:8: note: in expansion of macro 'pfn_valid'
> 393 |   if (!pfn_valid(pfn))
> |        ^~~~~~~~~
> --
> In file included from arch/xtensa/include/asm/processor.h:15,
> from arch/xtensa/include/asm/bitops.h:20,
> from include/linux/bitops.h:19,
> from mm/kasan/report.c:17:
> include/linux/scatterlist.h: In function 'sg_set_buf':
> arch/xtensa/include/asm/page.h:182:9: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
> 182 |  ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
> |         ^~
> include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
> 78 | # define unlikely(x) __builtin_expect(!!(x), 0)
> |                                          ^
> include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
> 143 |  BUG_ON(!virt_addr_valid(buf));
> |  ^~~~~~
> arch/xtensa/include/asm/page.h:190:32: note: in expansion of macro 'pfn_valid'
> 190 | #define virt_addr_valid(kaddr) pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
> |                                ^~~~~~~~~
> include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
> 143 |  BUG_ON(!virt_addr_valid(buf));
> |          ^~~~~~~~~~~~~~~
> In file included from include/linux/mm_types_task.h:16,
> from include/linux/mm_types.h:5,
> from include/linux/mmzone.h:21,
> from include/linux/gfp.h:6,
> from include/linux/mm.h:10,
> from include/linux/kallsyms.h:12,
> from include/linux/ftrace.h:11,
> from mm/kasan/report.c:18:
> mm/kasan/../internal.h: In function 'mem_map_next':
> arch/xtensa/include/asm/page.h:182:9: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
> 182 |  ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
> |         ^~
> >> mm/kasan/../internal.h:393:8: note: in expansion of macro 'pfn_valid'
> 393 |   if (!pfn_valid(pfn))
> |        ^~~~~~~~~
> mm/kasan/report.c: At top level:
> mm/kasan/report.c:474:6: warning: no previous prototype for '__kasan_report' [-Wmissing-prototypes]
> 474 | void __kasan_report(unsigned long addr, size_t size, bool is_write, unsigned long ip)
> |      ^~~~~~~~~~~~~~
> --
> In file included from arch/xtensa/include/asm/processor.h:15,
> from arch/xtensa/include/asm/bitops.h:20,
> from include/linux/bitops.h:19,
> from mm/kasan/generic_report.c:17:
> include/linux/scatterlist.h: In function 'sg_set_buf':
> arch/xtensa/include/asm/page.h:182:9: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
> 182 |  ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
> |         ^~
> include/linux/compiler.h:78:42: note: in definition of macro 'unlikely'
> 78 | # define unlikely(x) __builtin_expect(!!(x), 0)
> |                                          ^
> include/linux/scatterlist.h:143:2: note: in expansion of macro 'BUG_ON'
> 143 |  BUG_ON(!virt_addr_valid(buf));
> |  ^~~~~~
> arch/xtensa/include/asm/page.h:190:32: note: in expansion of macro 'pfn_valid'
> 190 | #define virt_addr_valid(kaddr) pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
> |                                ^~~~~~~~~
> include/linux/scatterlist.h:143:10: note: in expansion of macro 'virt_addr_valid'
> 143 |  BUG_ON(!virt_addr_valid(buf));
> |          ^~~~~~~~~~~~~~~
> In file included from include/linux/mm_types_task.h:16,
> from include/linux/mm_types.h:5,
> from include/linux/mmzone.h:21,
> from include/linux/gfp.h:6,
> from include/linux/mm.h:10,
> from include/linux/kallsyms.h:12,
> from include/linux/ftrace.h:11,
> from mm/kasan/generic_report.c:18:
> mm/kasan/../internal.h: In function 'mem_map_next':
> arch/xtensa/include/asm/page.h:182:9: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
> 182 |  ((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
> |         ^~
> >> mm/kasan/../internal.h:393:8: note: in expansion of macro 'pfn_valid'
> 393 |   if (!pfn_valid(pfn))
> |        ^~~~~~~~~
> mm/kasan/generic_report.c: At top level:
> mm/kasan/generic_report.c:116:6: warning: no previous prototype for '__asan_report_load1_noabort' [-Wmissing-prototypes]
> 116 | void __asan_report_load##size##_noabort(unsigned long addr)          |      ^~~~~~~~~~~~~~~~~~
> mm/kasan/generic_report.c:129:1: note: in expansion of macro 'DEFINE_ASAN_REPORT_LOAD'
> 129 | DEFINE_ASAN_REPORT_LOAD(1);
> | ^~~~~~~~~~~~~~~~~~~~~~~
> mm/kasan/generic_report.c:116:6: warning: no previous prototype for '__asan_report_load2_noabort' [-Wmissing-prototypes]
> 116 | void __asan_report_load##size##_noabort(unsigned long addr)          |      ^~~~~~~~~~~~~~~~~~
> mm/kasan/generic_report.c:130:1: note: in expansion of macro 'DEFINE_ASAN_REPORT_LOAD'
> 130 | DEFINE_ASAN_REPORT_LOAD(2);
> | ^~~~~~~~~~~~~~~~~~~~~~~
> mm/kasan/generic_report.c:116:6: warning: no previous prototype for '__asan_report_load4_noabort' [-Wmissing-prototypes]
> 116 | void __asan_report_load##size##_noabort(unsigned long addr)          |      ^~~~~~~~~~~~~~~~~~
> mm/kasan/generic_report.c:131:1: note: in expansion of macro 'DEFINE_ASAN_REPORT_LOAD'
> 131 | DEFINE_ASAN_REPORT_LOAD(4);
> | ^~~~~~~~~~~~~~~~~~~~~~~
> mm/kasan/generic_report.c:116:6: warning: no previous prototype for '__asan_report_load8_noabort' [-Wmissing-prototypes]
> 116 | void __asan_report_load##size##_noabort(unsigned long addr)          |      ^~~~~~~~~~~~~~~~~~
> mm/kasan/generic_report.c:132:1: note: in expansion of macro 'DEFINE_ASAN_REPORT_LOAD'
> 132 | DEFINE_ASAN_REPORT_LOAD(8);
> | ^~~~~~~~~~~~~~~~~~~~~~~
> mm/kasan/generic_report.c:116:6: warning: no previous prototype for '__asan_report_load16_noabort' [-Wmissing-prototypes]
> 116 | void __asan_report_load##size##_noabort(unsigned long addr)          |      ^~~~~~~~~~~~~~~~~~
> mm/kasan/generic_report.c:133:1: note: in expansion of macro 'DEFINE_ASAN_REPORT_LOAD'
> 133 | DEFINE_ASAN_REPORT_LOAD(16);
> | ^~~~~~~~~~~~~~~~~~~~~~~
> mm/kasan/generic_report.c:123:6: warning: no previous prototype for '__asan_report_store1_noabort' [-Wmissing-prototypes]
> 123 | void __asan_report_store##size##_noabort(unsigned long addr)          |      ^~~~~~~~~~~~~~~~~~~
> mm/kasan/generic_report.c:134:1: note: in expansion of macro 'DEFINE_ASAN_REPORT_STORE'
> 134 | DEFINE_ASAN_REPORT_STORE(1);
> | ^~~~~~~~~~~~~~~~~~~~~~~~
> mm/kasan/generic_report.c:123:6: warning: no previous prototype for '__asan_report_store2_noabort' [-Wmissing-prototypes]
> 123 | void __asan_report_store##size##_noabort(unsigned long addr)          |      ^~~~~~~~~~~~~~~~~~~
> mm/kasan/generic_report.c:135:1: note: in expansion of macro 'DEFINE_ASAN_REPORT_STORE'
> 135 | DEFINE_ASAN_REPORT_STORE(2);
> | ^~~~~~~~~~~~~~~~~~~~~~~~
> mm/kasan/generic_report.c:123:6: warning: no previous prototype for '__asan_report_store4_noabort' [-Wmissing-prototypes]
> 123 | void __asan_report_store##size##_noabort(unsigned long addr)          |      ^~~~~~~~~~~~~~~~~~~
> mm/kasan/generic_report.c:136:1: note: in expansion of macro 'DEFINE_ASAN_REPORT_STORE'
> 136 | DEFINE_ASAN_REPORT_STORE(4);
> | ^~~~~~~~~~~~~~~~~~~~~~~~
> mm/kasan/generic_report.c:123:6: warning: no previous prototype for '__asan_report_store8_noabort' [-Wmissing-prototypes]
> 123 | void __asan_report_store##size##_noabort(unsigned long addr)          |      ^~~~~~~~~~~~~~~~~~~
> mm/kasan/generic_report.c:137:1: note: in expansion of macro 'DEFINE_ASAN_REPORT_STORE'
> 137 | DEFINE_ASAN_REPORT_STORE(8);
> | ^~~~~~~~~~~~~~~~~~~~~~~~
> mm/kasan/generic_report.c:123:6: warning: no previous prototype for '__asan_report_store16_noabort' [-Wmissing-prototypes]
> 123 | void __asan_report_store##size##_noabort(unsigned long addr)          |      ^~~~~~~~~~~~~~~~~~~
> mm/kasan/generic_report.c:138:1: note: in expansion of macro 'DEFINE_ASAN_REPORT_STORE'
> 138 | DEFINE_ASAN_REPORT_STORE(16);
> | ^~~~~~~~~~~~~~~~~~~~~~~~
> mm/kasan/generic_report.c:140:6: warning: no previous prototype for '__asan_report_load_n_noabort' [-Wmissing-prototypes]
> 140 | void __asan_report_load_n_noabort(unsigned long addr, size_t size)
> |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> mm/kasan/generic_report.c:146:6: warning: no previous prototype for '__asan_report_store_n_noabort' [-Wmissing-prototypes]
> 146 | void __asan_report_store_n_noabort(unsigned long addr, size_t size)
> |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> vim +/pfn_valid +393 mm/kasan/../internal.h
>
> 69d177c2fc702d Andy Whitcroft  2008-11-06  383
> 69d177c2fc702d Andy Whitcroft  2008-11-06  384  /*
> 25985edcedea63 Lucas De Marchi 2011-03-30  385   * Iterator over all subpages within the maximally aligned gigantic
> 69d177c2fc702d Andy Whitcroft  2008-11-06  386   * page 'base'.  Handle any discontiguity in the mem_map.
> 69d177c2fc702d Andy Whitcroft  2008-11-06  387   */
> 69d177c2fc702d Andy Whitcroft  2008-11-06  388  static inline struct page *mem_map_next(struct page *iter,
> 69d177c2fc702d Andy Whitcroft  2008-11-06  389                                                  struct page *base, int offset)
> 69d177c2fc702d Andy Whitcroft  2008-11-06  390  {
> 69d177c2fc702d Andy Whitcroft  2008-11-06  391          if (unlikely((offset & (MAX_ORDER_NR_PAGES - 1)) == 0)) {
> 69d177c2fc702d Andy Whitcroft  2008-11-06  392                  unsigned long pfn = page_to_pfn(base) + offset;
> 69d177c2fc702d Andy Whitcroft  2008-11-06 @393                  if (!pfn_valid(pfn))
> 69d177c2fc702d Andy Whitcroft  2008-11-06  394                          return NULL;
> 69d177c2fc702d Andy Whitcroft  2008-11-06  395                  return pfn_to_page(pfn);
> 69d177c2fc702d Andy Whitcroft  2008-11-06  396          }
> 69d177c2fc702d Andy Whitcroft  2008-11-06  397          return iter + 1;
> 69d177c2fc702d Andy Whitcroft  2008-11-06  398  }
> 69d177c2fc702d Andy Whitcroft  2008-11-06  399
>
> :::::: The code at line 393 was first introduced by commit
> :::::: 69d177c2fc702d402b17fdca2190d5a7e3ca55c5 hugetlbfs: handle pages higher order than MAX_ORDER
>
> :::::: TO: Andy Whitcroft <apw@shadowen.org>
> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Sorry, I can't figure out where the problem is. It doesn't seem to be a problem
caused by my patch.

-- 
Yours,
Muchun
