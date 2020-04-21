Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AACAC55186
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2327206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="skhg49Ka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgDUWUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 18:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgDUWUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 18:20:02 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3420FC0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 15:20:02 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id h205so141295ybg.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 15:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MC0jPjUAF87njqcFfXpyBAMtvGlBWKw+opsjZyshW2I=;
        b=skhg49KaofoTpg/aElVY1IA1b6I+SlbfFSQAkyPYZus3M01ys9T36s4EGHkzpC/q6I
         5lGZ9hcZGO905lQWFO4mXczkMMhvSolqnLwFEb7xXzyHhvSYCtTS9LQcvj48kyHYt2Y+
         KJPxcGsKVzVvCqqZezgqCriIRAmVxeNaWV31jvWJOeTibs7fO4i6k5Ay+TOz3sPQiFgu
         jZVxVCp9dAGconaL5tfrQp8awoZLa/XFvZdyfW+Bo73s+aylPaUJb75abnh5ssju7gnj
         XdArXert6bzfC7lE5DgVwrKZ7XGDdejF9XCBpg6L9lo4X2RXOYya8lruwsqjA3wIeR8R
         9VYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MC0jPjUAF87njqcFfXpyBAMtvGlBWKw+opsjZyshW2I=;
        b=lg9w517Bh0CoYAnD7ywcigowOsFzV2lnwN2gglCBDTByHrJcEdx28EXSfkhZ3S1QQC
         e5RPRKJV+peOBvvTE9wxtfDdT8Vc1llED8tOfEkbERBnj/L/NLCCtYlnT4cmLfzoGJhH
         mtXai+qALGaKz8RnxRBxQ2xwU7353PSLwGphUGVdbRdUtAgcrSOfksSpilPer+loxJX5
         KkATKXSBd1Nk8J5tG2RIS6vVcsXpspeXNldcJYfubeXPvWQATeueDRVHySL8MF/Gs1Rd
         TJmsxdk4iuJPzixwEIbZ/zn3pvUrAvAtE8Pm2aNZUE+ffm2iIqa1+WSVMVjf4ZnyUU16
         z18Q==
X-Gm-Message-State: AGi0PuYbg0NBmb1UIMQHNdg8L+SJ8B4znVHzCSVAM0TQN/yg45D/25iJ
        UQD1YTx6Ga4R65YLYeU2a99Uri8dU93x2sw4PM7yb9/lOQM=
X-Google-Smtp-Source: APiQypK37BYP/Eez/Zhebxt8WCtCGQeewVQKmA9gIxCYMCxous5sLNrFWuF47M2PAkh4q4K5DT6nrBgQ+I3osamIpgI=
X-Received: by 2002:a25:12c1:: with SMTP id 184mr21241316ybs.162.1587507601048;
 Tue, 21 Apr 2020 15:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200415004353.130248-11-walken@google.com> <202004211357.utKPLP8t%lkp@intel.com>
In-Reply-To: <202004211357.utKPLP8t%lkp@intel.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Tue, 21 Apr 2020 15:19:48 -0700
Message-ID: <CANN689FB5M591_xcJC6M_5n3HMJk8nrYnV_Wepnnt85v0PK4ZQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] mmap locking API: rename mmap_sem to mmap_lock
To:     kbuild test robot <lkp@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the report. It's an easy fix, which I will fold into change
05/10 of the series.

On Mon, Apr 20, 2020 at 10:34 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Michel,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on rdma/for-next]
> [also build test ERROR on kvms390/next linus/master v5.7-rc2]
> [cannot apply to powerpc/next uml/linux-next next-20200420]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Michel-Lespinasse/Add-a-new-mmap-locking-API-wrapping-mmap_sem-calls/20200415-084649
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git for-next
> config: riscv-randconfig-a001-20200421 (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=riscv
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    arch/riscv/mm/pageattr.c: In function '__set_memory':
> >> arch/riscv/mm/pageattr.c:120:21: error: 'struct mm_struct' has no member named 'mmap_sem'; did you mean 'mmap_base'?
>      120 |  down_read(&init_mm.mmap_sem);
>          |                     ^~~~~~~~
>          |                     mmap_base
>    arch/riscv/mm/pageattr.c:123:19: error: 'struct mm_struct' has no member named 'mmap_sem'; did you mean 'mmap_base'?
>      123 |  up_read(&init_mm.mmap_sem);
>          |                   ^~~~~~~~
>          |                   mmap_base
>
> vim +120 arch/riscv/mm/pageattr.c
>
> d3ab332a502123 Zong Li 2020-03-10  105
> d3ab332a502123 Zong Li 2020-03-10  106  static int __set_memory(unsigned long addr, int numpages, pgprot_t set_mask,
> d3ab332a502123 Zong Li 2020-03-10  107                          pgprot_t clear_mask)
> d3ab332a502123 Zong Li 2020-03-10  108  {
> d3ab332a502123 Zong Li 2020-03-10  109          int ret;
> d3ab332a502123 Zong Li 2020-03-10  110          unsigned long start = addr;
> d3ab332a502123 Zong Li 2020-03-10  111          unsigned long end = start + PAGE_SIZE * numpages;
> d3ab332a502123 Zong Li 2020-03-10  112          struct pageattr_masks masks = {
> d3ab332a502123 Zong Li 2020-03-10  113                  .set_mask = set_mask,
> d3ab332a502123 Zong Li 2020-03-10  114                  .clear_mask = clear_mask
> d3ab332a502123 Zong Li 2020-03-10  115          };
> d3ab332a502123 Zong Li 2020-03-10  116
> d3ab332a502123 Zong Li 2020-03-10  117          if (!numpages)
> d3ab332a502123 Zong Li 2020-03-10  118                  return 0;
> d3ab332a502123 Zong Li 2020-03-10  119
> d3ab332a502123 Zong Li 2020-03-10 @120          down_read(&init_mm.mmap_sem);
> d3ab332a502123 Zong Li 2020-03-10  121          ret =  walk_page_range_novma(&init_mm, start, end, &pageattr_ops, NULL,
> d3ab332a502123 Zong Li 2020-03-10  122                                       &masks);
> d3ab332a502123 Zong Li 2020-03-10  123          up_read(&init_mm.mmap_sem);
> d3ab332a502123 Zong Li 2020-03-10  124
> d3ab332a502123 Zong Li 2020-03-10  125          flush_tlb_kernel_range(start, end);
> d3ab332a502123 Zong Li 2020-03-10  126
> d3ab332a502123 Zong Li 2020-03-10  127          return ret;
> d3ab332a502123 Zong Li 2020-03-10  128  }
> d3ab332a502123 Zong Li 2020-03-10  129
>
> :::::: The code at line 120 was first introduced by commit
> :::::: d3ab332a5021235a74fd832a49c6a99404920d88 riscv: add ARCH_HAS_SET_MEMORY support
>
> :::::: TO: Zong Li <zong.li@sifive.com>
> :::::: CC: Palmer Dabbelt <palmerdabbelt@google.com>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
