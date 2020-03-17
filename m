Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F661C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 03:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FCB220736
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 03:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCQDZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 23:25:03 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:41698 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725837AbgCQDZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 23:25:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Tsq-E9i_1584415494;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tsq-E9i_1584415494)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 17 Mar 2020 11:24:56 +0800
Subject: Re: [v2 PATCH 1/2] mm: swap: make page_evictable() inline
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, shakeelb@google.com, vbabka@suse.cz,
        willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1584397455-28701-1-git-send-email-yang.shi@linux.alibaba.com>
 <202003171004.Kg80NfWn%lkp@intel.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <1c710863-ed2e-88ec-2ea9-401c56ecc630@linux.alibaba.com>
Date:   Mon, 16 Mar 2020 20:24:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <202003171004.Kg80NfWn%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/20 8:00 PM, kbuild test robot wrote:
> Hi Yang,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on mmotm/master]
> [also build test ERROR on linus/master v5.6-rc6 next-20200316]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Yang-Shi/mm-swap-make-page_evictable-inline/20200317-094836
> base:   git://git.cmpxchg.org/linux-mmotm.git master
> config: i386-tinyconfig (attached as .config)
> compiler: gcc-7 (Debian 7.5.0-5) 7.5.0
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=i386
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     In file included from include/linux/suspend.h:5:0,
>                      from arch/x86/kernel/asm-offsets.c:13:
>     include/linux/swap.h: In function 'page_evictable':
>>> include/linux/swap.h:395:9: error: implicit declaration of function 'mapping_unevictable'; did you mean 'mapping_deny_writable'? [-Werror=implicit-function-declaration]

It looks pagemap.h need to be included. The below patch should be able 
to fix the build error:

diff --git a/include/linux/swap.h b/include/linux/swap.h
index d296c70..e8b8bbe 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -12,6 +12,7 @@
  #include <linux/fs.h>
  #include <linux/atomic.h>
  #include <linux/page-flags.h>
+#include <linux/pagemap.h>
  #include <asm/page.h>

  struct notifier_block;


>       ret = !mapping_unevictable(page_mapping(page)) && !PageMlocked(page);
>              ^~~~~~~~~~~~~~~~~~~
>              mapping_deny_writable
>     cc1: some warnings being treated as errors
>     make[2]: *** [scripts/Makefile.build:99: arch/x86/kernel/asm-offsets.s] Error 1
>     make[2]: Target '__build' not remade because of errors.
>     make[1]: *** [Makefile:1139: prepare0] Error 2
>     make[1]: Target 'prepare' not remade because of errors.
>     make: *** [Makefile:179: sub-make] Error 2
>     11 real  4 user  5 sys  89.51% cpu 	make prepare
>
> vim +395 include/linux/swap.h
>
>     376	
>     377	/**
>     378	 * page_evictable - test whether a page is evictable
>     379	 * @page: the page to test
>     380	 *
>     381	 * Test whether page is evictable--i.e., should be placed on active/inactive
>     382	 * lists vs unevictable list.
>     383	 *
>     384	 * Reasons page might not be evictable:
>     385	 * (1) page's mapping marked unevictable
>     386	 * (2) page is part of an mlocked VMA
>     387	 *
>     388	 */
>     389	static inline bool page_evictable(struct page *page)
>     390	{
>     391		bool ret;
>     392	
>     393		/* Prevent address_space of inode and swap cache from being freed */
>     394		rcu_read_lock();
>   > 395		ret = !mapping_unevictable(page_mapping(page)) && !PageMlocked(page);
>     396		rcu_read_unlock();
>     397		return ret;
>     398	}
>     399	
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

