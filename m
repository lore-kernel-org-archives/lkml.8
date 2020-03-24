Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA9FC54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 00:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A3C32070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 00:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i0k4De3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbgCXAnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 20:43:17 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45192 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgCXAnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 20:43:16 -0400
Received: by mail-oi1-f196.google.com with SMTP id l22so6046439oii.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 17:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5XccjSmzQSYluJiyPzbiNHYe0YLLyvddDurt0q9/XDU=;
        b=i0k4De3b34CqM8gnM5JGiwY0ry7/ZrLpmzktSW0KiYPpha1vXvZ6wse2JF4KOZxVnD
         EvQKDMJyxbQBAohPuAtor1+p5fdwNmCCleq9CZv5MH/K0Typsq6VX/h+HiBxyMSITLFI
         1zE9FFUnbH8lRcKH3LGjUdaDuM7j39TaZnPdg+9Irg+53LlaHdNuQO8FXCXwTEJNtQWf
         Hx25W6E5EVV7YjtXB8bV9UsFQXdrV3gzCscw1XOQnO5vKf2wtgnduAlQ6d/npzVosWTQ
         wsFC0bSpKMWWzljnO8WmBULkYUJ3j2VxltB1tjkDBKGyMg3Di8aGhK8E+knTKXDDf4ds
         2eRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5XccjSmzQSYluJiyPzbiNHYe0YLLyvddDurt0q9/XDU=;
        b=k4h6MptmBBiwe3sut+8P2oRT5MfLK6VlojId6IuXDJ/UM4330Gg770cAnXqCguIskU
         oVZEF9jDfbukELwDljhbNzyKJVBCkXMzXRxHzWnWPXkIQcrhdbJglKo1vrcqTxvvaqb4
         +eLv8PL/qkyU95HYUY3dP+1OTlCtDQSzfPS3J0j7+LaM59g7T1/CTMk9PVUhUqc0JRiC
         bp3fetk0AmTuZ41bcGvAMIXjZ1UJIo8UeiKrT9Z8jVrP5LMh11Q24prSlRG4gKpWdpw+
         xjehw6SJNr1ewX5Wb2y5ou+YTeyJVTq7EPg5rqmYPWY8Y+/pZGpLBksq72BXm1nHlCWU
         ch9w==
X-Gm-Message-State: ANhLgQ3wD/I3x/1pv4x2ZvxAgeQSbLlZ0Ba/KLr4K+48IoN9hkXcHXsr
        5J8FixJDBMvHWN6KwI9WJh4wPBgu2UMjOC0E99Rksg==
X-Google-Smtp-Source: ADFU+vtYBVk3tWWGsOMAMHUFEJFhvxQroU9ZV5f98ByE8nUcZKV6aGcbbi70XDgVtV9LxWY6a+Fz0IqYMsBbQbFZO5E=
X-Received: by 2002:aca:a857:: with SMTP id r84mr1597815oie.65.1585010593973;
 Mon, 23 Mar 2020 17:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200318220634.32100-1-mike.kravetz@oracle.com> <20200318220634.32100-5-mike.kravetz@oracle.com>
In-Reply-To: <20200318220634.32100-5-mike.kravetz@oracle.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 23 Mar 2020 17:43:03 -0700
Message-ID: <CAHS8izOhjvNVDXsx_SqP_oUQhCw-i_xcG9hxbvV86fFDeY_SAw@mail.gmail.com>
Subject: Re: [PATCH 4/4] hugetlbfs: clean up command line processing
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Longpeng <longpeng2@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 3:07 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> With all hugetlb page processing done in a single file clean up code.

Now that all hugepage page processing is done in a single file, clean
up the code.

> - Make code match desired semantics
>   - Update documentation with semantics
> - Make all warnings and errors messages start with 'HugeTLB:'.
> - Consistently name command line parsing routines.
> - Add comments to code
>   - Describe some of the subtle interactions
>   - Describe semantics of command line arguments
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>  Documentation/admin-guide/mm/hugetlbpage.rst | 26 +++++++
>  mm/hugetlb.c                                 | 78 +++++++++++++++-----
>  2 files changed, 87 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
> index 1cc0bc78d10e..afc8888f33c3 100644
> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
> @@ -100,6 +100,32 @@ with a huge page size selection parameter "hugepagesz=<size>".  <size> must
>  be specified in bytes with optional scale suffix [kKmMgG].  The default huge
>  page size may be selected with the "default_hugepagesz=<size>" boot parameter.
>
> +Hugetlb boot command line parameter semantics
> +hugepagesz - Specify a huge page size.  Used in conjunction with hugepages
> +       parameter to preallocate a number of huge pages of the specified
> +       size.  Hence, hugepagesz and hugepages are typically specified in
> +       pairs such as:
> +               hugepagesz=2M hugepages=512
> +       hugepagesz can only be specified once on the command line for a
> +       specific huge page size.  Valid huge page sizes are architecture
> +       dependent.
> +hugepages - Specify the number of huge pages to preallocate.  This typically
> +       follows a valid hugepagesz parameter.  However, if hugepages is the
> +       first or only hugetlb command line parameter it specifies the number
> +       of huge pages of default size to allocate.  The number of huge pages
> +       of default size specified in this manner can be overwritten by a
> +       hugepagesz,hugepages parameter pair for the default size.
> +       For example, on an architecture with 2M default huge page size:
> +               hugepages=256 hugepagesz=2M hugepages=512
> +       will result in 512 2M huge pages being allocated.  If a hugepages
> +       parameter is preceded by an invalid hugepagesz parameter, it will
> +       be ignored.
> +default_hugepagesz - Specify the default huge page size.  This parameter can
> +       only be specified on the command line.  No other hugetlb command line
> +       parameter is associated with default_hugepagesz.  Therefore, it can
> +       appear anywhere on the command line.  Valid default huge page size is
> +       architecture dependent.

Maybe specify what happens/should happen in a case like:

hugepages=100 default_hugepagesz=1G

Does that allocate 100 2MB pages or 100 1G pages? Assuming the default
size is 2MB.

Also, regarding Randy's comment. It may be nice to keep these docs in
one place only, so we don't have to maintain 2 docs in sync.


> +
>  When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
>  indicates the current number of pre-allocated huge pages of the default size.
>  Thus, one can use the following command to dynamically allocate/deallocate
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index cc85b4f156ca..2b9bf01db2b6 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2954,7 +2954,7 @@ static void __init hugetlb_sysfs_init(void)
>                 err = hugetlb_sysfs_add_hstate(h, hugepages_kobj,
>                                          hstate_kobjs, &hstate_attr_group);
>                 if (err)
> -                       pr_err("Hugetlb: Unable to add hstate %s", h->name);
> +                       pr_err("HugeTLB: Unable to add hstate %s", h->name);
>         }
>  }
>
> @@ -3058,7 +3058,7 @@ static void hugetlb_register_node(struct node *node)
>                                                 nhs->hstate_kobjs,
>                                                 &per_node_hstate_attr_group);
>                 if (err) {
> -                       pr_err("Hugetlb: Unable to add hstate %s for node %d\n",
> +                       pr_err("HugeTLB: Unable to add hstate %s for node %d\n",
>                                 h->name, node->dev.id);
>                         hugetlb_unregister_node(node);
>                         break;
> @@ -3109,19 +3109,35 @@ static int __init hugetlb_init(void)
>         if (!hugepages_supported())
>                 return 0;
>
> -       if (!size_to_hstate(default_hstate_size)) {
> -               if (default_hstate_size != 0) {
> -                       pr_err("HugeTLB: unsupported default_hugepagesz %lu. Reverting to %lu\n",
> -                              default_hstate_size, HPAGE_SIZE);
> -               }
> -
> +       /*
> +        * Make sure HPAGE_SIZE (HUGETLB_PAGE_ORDER) hstate exists.  Some
> +        * architectures depend on setup being done here.
> +        *
> +        * If a valid default huge page size was specified on the command line,
> +        * add associated hstate if necessary.  If not, set default_hstate_size
> +        * to default size.  default_hstate_idx is used at runtime to identify
> +        * the default huge page size/hstate.
> +        */
> +       hugetlb_add_hstate(HUGETLB_PAGE_ORDER);
> +       if (default_hstate_size)
> +               hugetlb_add_hstate(ilog2(default_hstate_size) - PAGE_SHIFT);
> +       else
>                 default_hstate_size = HPAGE_SIZE;
> -               hugetlb_add_hstate(HUGETLB_PAGE_ORDER);
> -       }
>         default_hstate_idx = hstate_index(size_to_hstate(default_hstate_size));
> +
> +       /*
> +        * default_hstate_max_huge_pages != 0 indicates a count (hugepages=)
> +        * specified before a size (hugepagesz=).  Use this count for the
> +        * default huge page size, unless a specific value was specified for
> +        * this size in a hugepagesz/hugepages pair.
> +        */
>         if (default_hstate_max_huge_pages) {
>                 if (!default_hstate.max_huge_pages)
> -                       default_hstate.max_huge_pages = default_hstate_max_huge_pages;
> +                       default_hstate.max_huge_pages =
> +                               default_hstate_max_huge_pages;
> +               else
> +                       pr_warn("HugeTLB: First hugepages=%lu kB ignored\n",
> +                               default_hstate_max_huge_pages);
>         }
>
>         hugetlb_init_hstates();
> @@ -3174,20 +3190,27 @@ void __init hugetlb_add_hstate(unsigned int order)
>         parsed_hstate = h;
>  }
>
> -static int __init hugetlb_nrpages_setup(char *s)
> +/*
> + * hugepages command line processing
> + * hugepages must normally follows a valid hugepagsz specification.  If not,

'hugepages must' or 'hugepages normally follows'
> + * ignore the hugepages value.  hugepages can also be the first huge page
> + * command line option in which case it specifies the number of huge pages
> + * for the default size.
> + */
> +static int __init hugepages_setup(char *s)
>  {
>         unsigned long *mhp;
>         static unsigned long *last_mhp;
>
>         if (!parsed_valid_hugepagesz) {
> -               pr_warn("hugepages = %s preceded by "
> +               pr_warn("HugeTLB: hugepages = %s preceded by "
>                         "an unsupported hugepagesz, ignoring\n", s);
>                 parsed_valid_hugepagesz = true;
>                 return 1;
>         }
>         /*
> -        * !hugetlb_max_hstate means we haven't parsed a hugepagesz= parameter yet,
> -        * so this hugepages= parameter goes to the "default hstate".
> +        * !hugetlb_max_hstate means we haven't parsed a hugepagesz= parameter
> +        * yet, so this hugepages= parameter goes to the "default hstate".
>          */
>         else if (!hugetlb_max_hstate)
>                 mhp = &default_hstate_max_huge_pages;

We don't set parsed_valid_hugepagesz to false at the end of this
function, shouldn't we? Parsing a hugepages= value should 'consume' a
previously defined hugepagesz= value, so that this is invalid IIUC:

hugepagesz=x hugepages=z hugepages=y

> @@ -3195,7 +3218,8 @@ static int __init hugetlb_nrpages_setup(char *s)
>                 mhp = &parsed_hstate->max_huge_pages;
>
>         if (mhp == last_mhp) {
> -               pr_warn("hugepages= specified twice without interleaving hugepagesz=, ignoring\n");
> +               pr_warn("HugeTLB: hugepages= specified twice without interleaving hugepagesz=, ignoring hugepages=%s\n",
> +                       s);
>                 return 1;
>         }
>
> @@ -3214,8 +3238,15 @@ static int __init hugetlb_nrpages_setup(char *s)
>
>         return 1;
>  }
> -__setup("hugepages=", hugetlb_nrpages_setup);
> +__setup("hugepages=", hugepages_setup);
>
> +/*
> + * hugepagesz command line processing
> + * A specific huge page size can only be specified once with hugepagesz.
> + * hugepagesz is followed by hugepages on the commnad line.  The global
> + * variable 'parsed_valid_hugepagesz' is used to determine if prior
> + * hugepagesz argument was valid.
> + */
>  static int __init hugepagesz_setup(char *s)
>  {
>         unsigned long long size;
> @@ -3230,16 +3261,23 @@ static int __init hugepagesz_setup(char *s)
>         }
>
>         if (size_to_hstate(size)) {
> +               parsed_valid_hugepagesz = false;
>                 pr_warn("HugeTLB: hugepagesz %s specified twice, ignoring\n",
>                         saved_s);
>                 return 0;
>         }
>
> +       parsed_valid_hugepagesz = true;
>         hugetlb_add_hstate(ilog2(size) - PAGE_SHIFT);
>         return 1;
>  }
>  __setup("hugepagesz=", hugepagesz_setup);
>
> +/*
> + * default_hugepagesz command line input
> + * Only one instance of default_hugepagesz allowed on command line.  Do not
> + * add hstate here as that will confuse hugepagesz/hugepages processing.
> + */
>  static int __init default_hugepagesz_setup(char *s)
>  {
>         unsigned long long size;
> @@ -3252,6 +3290,12 @@ static int __init default_hugepagesz_setup(char *s)
>                 return 0;
>         }
>
> +       if (default_hstate_size) {
> +               pr_err("HugeTLB: default_hugepagesz previously specified, ignoring %s\n",
> +                       saved_s);
> +               return 0;
> +       }
> +
>         default_hstate_size = size;
>         return 1;
>  }
> --
> 2.24.1
>
>
