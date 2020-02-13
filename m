Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EE0C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB1720848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dKSbfTBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbgBMJKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:10:10 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:40177 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729515AbgBMJKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:10:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1581585009; x=1613121009;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=5zK64KITLcQjS6f6/zvuoFVwDohflsNQOJAoV/nzry0=;
  b=dKSbfTBIgH+LzbItQMLN/sBhvF9Idpxc9GxK7uD5vUze9X+lmq/RgAAy
   JzNiLANvG0ugBqUZOel1d8JB8lbZ+4KuJGzq2uCcmjq/gcaLI/09pM/n6
   cwPnVJ/C82H7ueKP9x8mR/eojoHQrU4ECatVzz6jjJQmIuuGdW7Pklz4r
   M=;
IronPort-SDR: 3+SNpXZS1vv6k+McXcBL93v+BWSeBf4hX7OpFmadPl/isR6s0UEw/8BDFRt5AeB1LVWMgIRs3S
 gGb6YZZOw2Jw==
X-IronPort-AV: E=Sophos;i="5.70,436,1574121600"; 
   d="scan'208";a="26169876"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 13 Feb 2020 09:10:06 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id 25895A18BA;
        Thu, 13 Feb 2020 09:10:05 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Thu, 13 Feb 2020 09:10:04 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.160.92) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 13 Feb 2020 09:09:53 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     kbuild test robot <lkp@intel.com>
CC:     <sjpark@amazon.com>, <kbuild-all@lists.01.org>,
        <akpm@linux-foundation.org>, SeongJae Park <sjpark@amazon.de>,
        <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <amit@kernel.org>, <brendan.d.gregg@gmail.com>,
        <brendanhiggins@google.com>, <cai@lca.pw>,
        <colin.king@canonical.com>, <corbet@lwn.net>, <dwmw@amazon.com>,
        <jolsa@redhat.com>, <kirill@shutemov.name>, <mark.rutland@arm.com>,
        <mgorman@suse.de>, <minchan@kernel.org>, <mingo@redhat.com>,
        <namhyung@kernel.org>, <peterz@infradead.org>,
        <rdunlap@infradead.org>, <rostedt@goodmis.org>,
        <sj38.park@gmail.com>, <vdavydov.dev@gmail.com>,
        <linux-mm@kvack.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v4 05/11] mm/damon: Implement kernel space API
Date:   Thu, 13 Feb 2020 10:09:37 +0100
Message-ID: <20200213090937.9368-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <202002130710.3P1Y98f7%lkp@intel.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.92]
X-ClientProxiedBy: EX13D23UWC003.ant.amazon.com (10.43.162.81) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2020 07:21:37 +0800 kbuild test robot <lkp@intel.com> wrote:

> [-- Attachment #1: Type: text/plain, Size: 937 bytes --]
> 
> Hi,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on d5226fa6dbae0569ee43ecfc08bdcd6770fc4755]
> 
> url:    https://github.com/0day-ci/linux/commits/sjpark-amazon-com/Introduce-Data-Access-MONitor-DAMON/20200213-003254
> base:    d5226fa6dbae0569ee43ecfc08bdcd6770fc4755
> config: m68k-allmodconfig (attached as .config)
> compiler: m68k-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=m68k 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> ERROR: "lookup_page_ext" [mm/damon.ko] undefined!

Thank you for finding this problem, kbuild!


This problem comes when `CONFIG_DAMON=m` and `CONFIG_64BIT` unset because
`lookup_page_ext()`, which is used by `page_idle.h` if `CONFIG_64BIT` unset, is
not exported.  Most simple fix would be avoiding module build of DAMON as
below::

    diff --git a/mm/Kconfig b/mm/Kconfig
    index b279ab9c78d0..f24dd670baad 100644
    --- a/mm/Kconfig
    +++ b/mm/Kconfig
    @@ -740,7 +740,7 @@ config MAPPING_DIRTY_HELPERS
             bool
    
     config DAMON
    -       tristate "Data Access Monitor"
    +       bool "Data Access Monitor"
            depends on MMU
            default n
            help

Or, exporting the symbol as below::

    diff --git a/mm/page_ext.c b/mm/page_ext.c
    index 4ade843ff588..e6e6b7e625e4 100644
    --- a/mm/page_ext.c
    +++ b/mm/page_ext.c
    @@ -131,6 +131,7 @@ struct page_ext *lookup_page_ext(const struct page *page)
                                            MAX_ORDER_NR_PAGES);
            return get_entry(base, index);
     }
    +EXPORT_SYMBOL(lookup_page_ext);
    
     static int __init alloc_node_page_ext(int nid)
     {

I of course prefer this fix but unsure whether exporting this symbol is ok or
not.  May I ask your opinions?


Thanks,
SeongJae Park

> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> [-- Attachment #2: .config.gz --]
> [-- Type: application/gzip, Size: 51870 bytes --]
