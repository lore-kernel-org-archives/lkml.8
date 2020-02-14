Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77109C3B196
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 11:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E352187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 11:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tvGMtkBZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgBNLTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 06:19:55 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:41177 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729007AbgBNLTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 06:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1581679195; x=1613215195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=PME62rzjRT944kut2rGoWJ6pM+hn9jgpFki6Z+JYUeQ=;
  b=tvGMtkBZDl8mJH444fUvcwd5xH6JW5OT0kfexwLBIHV31T90obJL3TR+
   qqs7MtZLt0Pt0j6A1es0B97iE9S1r8Y+cUUEMbPpKMT2KYIKpBglyYYCE
   kJVZHOXtlCVeDFPLJgR3cJJtF1QRyAnDF8RJBU0i4qdRV8ylzcqlwIKPb
   c=;
IronPort-SDR: wZMG1CVCgh6hNDSyLaitOTVHUuzmNUPY2IH+MU39yYF+33GCoziAhrPUcdijDhuxkhod1IMKd+
 rTJHgVvah00w==
X-IronPort-AV: E=Sophos;i="5.70,440,1574121600"; 
   d="scan'208";a="17095548"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 14 Feb 2020 11:19:42 +0000
Received: from EX13MTAUEA002.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (Postfix) with ESMTPS id DDCB2A420A;
        Fri, 14 Feb 2020 11:19:33 +0000 (UTC)
Received: from EX13D31EUA001.ant.amazon.com (10.43.165.15) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Fri, 14 Feb 2020 11:19:32 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.54) by
 EX13D31EUA001.ant.amazon.com (10.43.165.15) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 14 Feb 2020 11:19:22 +0000
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
Subject: Re: Re: [PATCH v4 10/11] mm/damon: Add kunit tests
Date:   Fri, 14 Feb 2020 12:19:07 +0100
Message-ID: <20200214111907.7017-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <202002140021.Pr9vTFO6%lkp@intel.com> (raw)
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.54]
X-ClientProxiedBy: EX13D22UWB002.ant.amazon.com (10.43.161.28) To
 EX13D31EUA001.ant.amazon.com (10.43.165.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Feb 2020 00:56:50 +0800 kbuild test robot <lkp@intel.com> wrote:

> [-- Attachment #1: Type: text/plain, Size: 3435 bytes --]
> 
> Hi,
> 
> Thank you for the patch! Yet something to improve:
> 
> [auto build test ERROR on d5226fa6dbae0569ee43ecfc08bdcd6770fc4755]
> 
> url:    https://github.com/0day-ci/linux/commits/sjpark-amazon-com/Introduce-Data-Access-MONitor-DAMON/20200213-003254
> base:    d5226fa6dbae0569ee43ecfc08bdcd6770fc4755
> config: x86_64-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.5.0-4) 7.5.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from mm/damon.c:19:0:
> >> include/linux/module.h:131:42: error: redefinition of '__inittest'
>      static inline initcall_t __maybe_unused __inittest(void)  \
>                                              ^
>    include/linux/module.h:124:28: note: in expansion of macro 'module_init'
>     #define late_initcall(fn)  module_init(fn)
>                                ^~~~~~~~~~~
>    include/kunit/test.h:224:2: note: in expansion of macro 'late_initcall'
>      late_initcall(kunit_suite_init##suite)
>      ^~~~~~~~~~~~~
>    mm/damon-test.h:600:1: note: in expansion of macro 'kunit_test_suite'
>     kunit_test_suite(damon_test_suite);
>     ^~~~~~~~~~~~~~~~
>    include/linux/module.h:131:42: note: previous definition of '__inittest' was here
>      static inline initcall_t __maybe_unused __inittest(void)  \
>                                              ^
>    mm/damon.c:1406:1: note: in expansion of macro 'module_init'
>     module_init(damon_init);
>     ^~~~~~~~~~~
> >> include/linux/module.h:133:6: error: redefinition of 'init_module'
>      int init_module(void) __copy(initfn) __attribute__((alias(#initfn)));
>          ^
>    include/linux/module.h:124:28: note: in expansion of macro 'module_init'
>     #define late_initcall(fn)  module_init(fn)
>                                ^~~~~~~~~~~
>    include/kunit/test.h:224:2: note: in expansion of macro 'late_initcall'
>      late_initcall(kunit_suite_init##suite)
>      ^~~~~~~~~~~~~
>    mm/damon-test.h:600:1: note: in expansion of macro 'kunit_test_suite'
>     kunit_test_suite(damon_test_suite);
>     ^~~~~~~~~~~~~~~~
>    include/linux/module.h:133:6: note: previous definition of 'init_module' was here
>      int init_module(void) __copy(initfn) __attribute__((alias(#initfn)));
>          ^
>    mm/damon.c:1406:1: note: in expansion of macro 'module_init'
>     module_init(damon_init);
>     ^~~~~~~~~~~
> 
> vim +/__inittest +131 include/linux/module.h
> 
> 0fd972a7d91d6e1 Paul Gortmaker 2015-05-01  128  
> 0fd972a7d91d6e1 Paul Gortmaker 2015-05-01  129  /* Each module must use one module_init(). */
> 0fd972a7d91d6e1 Paul Gortmaker 2015-05-01  130  #define module_init(initfn)					\
> 1f318a8bafcfba9 Arnd Bergmann  2017-02-01 @131  	static inline initcall_t __maybe_unused __inittest(void)		\
> 0fd972a7d91d6e1 Paul Gortmaker 2015-05-01  132  	{ return initfn; }					\
> a6e60d84989fa0e Miguel Ojeda   2019-01-19 @133  	int init_module(void) __copy(initfn) __attribute__((alias(#initfn)));
> 0fd972a7d91d6e1 Paul Gortmaker 2015-05-01  134  
> 
> :::::: The code at line 131 was first introduced by commit
> :::::: 1f318a8bafcfba9f0d623f4870c4e890fd22e659 modules: mark __inittest/__exittest as __maybe_unused
> 
> :::::: TO: Arnd Bergmann <arnd@arndb.de>
> :::::: CC: Jessica Yu <jeyu@redhat.com>

Thank you for finding yet another problem!  The problem is reproducible if
`CONFIG_DAMON=m` but `CONFIG_DAMON_KUNIT_TEST=y`.  Will fix this problem by
simply adjusting the dependency of the tests as below.  It will avoid the build
of the test code when DAMON is configured to be built as a module::

    diff --git a/mm/Kconfig b/mm/Kconfig
    index b279ab9c78d0..1a745ce0cbcb 100644
    --- a/mm/Kconfig
    +++ b/mm/Kconfig
    @@ -753,7 +753,7 @@ config DAMON
    
     config DAMON_KUNIT_TEST
            bool "Test for damon"
    -       depends on DAMON && KUNIT
    +       depends on DAMON=y && KUNIT
            help
              This builds the DAMON Kunit test suite.

I think this is fair enough as KUNIT is not exporting its main functions to
modules and thus cannot be used by modules anyway.


Thanks,
SeongJae Park

> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> [-- Attachment #2: .config.gz --]
> [-- Type: application/gzip, Size: 71807 bytes --]
