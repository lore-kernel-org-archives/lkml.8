Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25755C54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 03:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9B4B20724
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 03:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgCXDrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 23:47:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12181 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727060AbgCXDrn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 23:47:43 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7CA9B539151FD28DDA6A;
        Tue, 24 Mar 2020 11:47:38 +0800 (CST)
Received: from [10.173.228.124] (10.173.228.124) by smtp.huawei.com
 (10.3.19.202) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 24 Mar
 2020 11:47:36 +0800
Subject: Re: [PATCH 4/4] hugetlbfs: clean up command line processing
To:     Mina Almasry <almasrymina@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
CC:     Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
        <linux-s390@vger.kernel.org>, <sparclinux@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "Christian Borntraeger" <borntraeger@de.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200318220634.32100-1-mike.kravetz@oracle.com>
 <20200318220634.32100-5-mike.kravetz@oracle.com>
 <CAHS8izOhjvNVDXsx_SqP_oUQhCw-i_xcG9hxbvV86fFDeY_SAw@mail.gmail.com>
From:   "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Message-ID: <d067c5d1-89b8-a71b-7b71-a8bbbd613efa@huawei.com>
Date:   Tue, 24 Mar 2020 11:47:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHS8izOhjvNVDXsx_SqP_oUQhCw-i_xcG9hxbvV86fFDeY_SAw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.228.124]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/3/24 8:43, Mina Almasry wrote:
> On Wed, Mar 18, 2020 at 3:07 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> With all hugetlb page processing done in a single file clean up code.
> 
> Now that all hugepage page processing is done in a single file, clean
> up the code.
> 
>> - Make code match desired semantics
>>   - Update documentation with semantics
>> - Make all warnings and errors messages start with 'HugeTLB:'.
>> - Consistently name command line parsing routines.
>> - Add comments to code
>>   - Describe some of the subtle interactions
>>   - Describe semantics of command line arguments
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  Documentation/admin-guide/mm/hugetlbpage.rst | 26 +++++++
>>  mm/hugetlb.c                                 | 78 +++++++++++++++-----
>>  2 files changed, 87 insertions(+), 17 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/mm/hugetlbpage.rst b/Documentation/admin-guide/mm/hugetlbpage.rst
>> index 1cc0bc78d10e..afc8888f33c3 100644
>> --- a/Documentation/admin-guide/mm/hugetlbpage.rst
>> +++ b/Documentation/admin-guide/mm/hugetlbpage.rst
>> @@ -100,6 +100,32 @@ with a huge page size selection parameter "hugepagesz=<size>".  <size> must
>>  be specified in bytes with optional scale suffix [kKmMgG].  The default huge
>>  page size may be selected with the "default_hugepagesz=<size>" boot parameter.
>>
>> +Hugetlb boot command line parameter semantics
>> +hugepagesz - Specify a huge page size.  Used in conjunction with hugepages
>> +       parameter to preallocate a number of huge pages of the specified
>> +       size.  Hence, hugepagesz and hugepages are typically specified in
>> +       pairs such as:
>> +               hugepagesz=2M hugepages=512
>> +       hugepagesz can only be specified once on the command line for a
>> +       specific huge page size.  Valid huge page sizes are architecture
>> +       dependent.
>> +hugepages - Specify the number of huge pages to preallocate.  This typically
>> +       follows a valid hugepagesz parameter.  However, if hugepages is the
>> +       first or only hugetlb command line parameter it specifies the number
>> +       of huge pages of default size to allocate.  The number of huge pages
>> +       of default size specified in this manner can be overwritten by a
>> +       hugepagesz,hugepages parameter pair for the default size.
>> +       For example, on an architecture with 2M default huge page size:
>> +               hugepages=256 hugepagesz=2M hugepages=512
>> +       will result in 512 2M huge pages being allocated.  If a hugepages
>> +       parameter is preceded by an invalid hugepagesz parameter, it will
>> +       be ignored.
>> +default_hugepagesz - Specify the default huge page size.  This parameter can
>> +       only be specified on the command line.  No other hugetlb command line
>> +       parameter is associated with default_hugepagesz.  Therefore, it can
>> +       appear anywhere on the command line.  Valid default huge page size is
>> +       architecture dependent.
> 
> Maybe specify what happens/should happen in a case like:
> 
> hugepages=100 default_hugepagesz=1G
> 
> Does that allocate 100 2MB pages or 100 1G pages? Assuming the default
> size is 2MB.
> 
> Also, regarding Randy's comment. It may be nice to keep these docs in
> one place only, so we don't have to maintain 2 docs in sync.
> 
> 
>> +
>>  When multiple huge page sizes are supported, ``/proc/sys/vm/nr_hugepages``
>>  indicates the current number of pre-allocated huge pages of the default size.
>>  Thus, one can use the following command to dynamically allocate/deallocate
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index cc85b4f156ca..2b9bf01db2b6 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -2954,7 +2954,7 @@ static void __init hugetlb_sysfs_init(void)
>>                 err = hugetlb_sysfs_add_hstate(h, hugepages_kobj,
>>                                          hstate_kobjs, &hstate_attr_group);
>>                 if (err)
>> -                       pr_err("Hugetlb: Unable to add hstate %s", h->name);
>> +                       pr_err("HugeTLB: Unable to add hstate %s", h->name);
>>         }
>>  }
>>
>> @@ -3058,7 +3058,7 @@ static void hugetlb_register_node(struct node *node)
>>                                                 nhs->hstate_kobjs,
>>                                                 &per_node_hstate_attr_group);
>>                 if (err) {
>> -                       pr_err("Hugetlb: Unable to add hstate %s for node %d\n",
>> +                       pr_err("HugeTLB: Unable to add hstate %s for node %d\n",
>>                                 h->name, node->dev.id);
>>                         hugetlb_unregister_node(node);
>>                         break;
>> @@ -3109,19 +3109,35 @@ static int __init hugetlb_init(void)
>>         if (!hugepages_supported())
>>                 return 0;
>>
>> -       if (!size_to_hstate(default_hstate_size)) {
>> -               if (default_hstate_size != 0) {
>> -                       pr_err("HugeTLB: unsupported default_hugepagesz %lu. Reverting to %lu\n",
>> -                              default_hstate_size, HPAGE_SIZE);
>> -               }
>> -
>> +       /*
>> +        * Make sure HPAGE_SIZE (HUGETLB_PAGE_ORDER) hstate exists.  Some
>> +        * architectures depend on setup being done here.
>> +        *
>> +        * If a valid default huge page size was specified on the command line,
>> +        * add associated hstate if necessary.  If not, set default_hstate_size
>> +        * to default size.  default_hstate_idx is used at runtime to identify
>> +        * the default huge page size/hstate.
>> +        */
>> +       hugetlb_add_hstate(HUGETLB_PAGE_ORDER);
>> +       if (default_hstate_size)
>> +               hugetlb_add_hstate(ilog2(default_hstate_size) - PAGE_SHIFT);
>> +       else
>>                 default_hstate_size = HPAGE_SIZE;
>> -               hugetlb_add_hstate(HUGETLB_PAGE_ORDER);
>> -       }
>>         default_hstate_idx = hstate_index(size_to_hstate(default_hstate_size));
>> +
>> +       /*
>> +        * default_hstate_max_huge_pages != 0 indicates a count (hugepages=)
>> +        * specified before a size (hugepagesz=).  Use this count for the
>> +        * default huge page size, unless a specific value was specified for
>> +        * this size in a hugepagesz/hugepages pair.
>> +        */
>>         if (default_hstate_max_huge_pages) {
>>                 if (!default_hstate.max_huge_pages)
>> -                       default_hstate.max_huge_pages = default_hstate_max_huge_pages;
>> +                       default_hstate.max_huge_pages =
>> +                               default_hstate_max_huge_pages;
>> +               else
>> +                       pr_warn("HugeTLB: First hugepages=%lu kB ignored\n",
>> +                               default_hstate_max_huge_pages);
>>         }
>>
>>         hugetlb_init_hstates();
>> @@ -3174,20 +3190,27 @@ void __init hugetlb_add_hstate(unsigned int order)
>>         parsed_hstate = h;
>>  }
>>
>> -static int __init hugetlb_nrpages_setup(char *s)
>> +/*
>> + * hugepages command line processing
>> + * hugepages must normally follows a valid hugepagsz specification.  If not,
> 
> 'hugepages must' or 'hugepages normally follows'
>> + * ignore the hugepages value.  hugepages can also be the first huge page
>> + * command line option in which case it specifies the number of huge pages
>> + * for the default size.
>> + */
>> +static int __init hugepages_setup(char *s)
>>  {
>>         unsigned long *mhp;
>>         static unsigned long *last_mhp;
>>
>>         if (!parsed_valid_hugepagesz) {
>> -               pr_warn("hugepages = %s preceded by "
>> +               pr_warn("HugeTLB: hugepages = %s preceded by "
>>                         "an unsupported hugepagesz, ignoring\n", s);
>>                 parsed_valid_hugepagesz = true;
>>                 return 1;
>>         }
>>         /*
>> -        * !hugetlb_max_hstate means we haven't parsed a hugepagesz= parameter yet,
>> -        * so this hugepages= parameter goes to the "default hstate".
>> +        * !hugetlb_max_hstate means we haven't parsed a hugepagesz= parameter
>> +        * yet, so this hugepages= parameter goes to the "default hstate".
>>          */
>>         else if (!hugetlb_max_hstate)
>>                 mhp = &default_hstate_max_huge_pages;
> 
> We don't set parsed_valid_hugepagesz to false at the end of this
> function, shouldn't we? Parsing a hugepages= value should 'consume' a
> previously defined hugepagesz= value, so that this is invalid IIUC:
> 
> hugepagesz=x hugepages=z hugepages=y
> 
In this case, we'll get:
"HugeTLB: hugepages= specified twice without interleaving hugepagesz=, ignoring
hugepages=y"

>> @@ -3195,7 +3218,8 @@ static int __init hugetlb_nrpages_setup(char *s)
>>                 mhp = &parsed_hstate->max_huge_pages;
>>
>>         if (mhp == last_mhp) {
>> -               pr_warn("hugepages= specified twice without interleaving hugepagesz=, ignoring\n");
>> +               pr_warn("HugeTLB: hugepages= specified twice without interleaving hugepagesz=, ignoring hugepages=%s\n",
>> +                       s);
>>                 return 1;
>>         }
>>
>> @@ -3214,8 +3238,15 @@ static int __init hugetlb_nrpages_setup(char *s)
>>
>>         return 1;
>>  }
>> -__setup("hugepages=", hugetlb_nrpages_setup);
>> +__setup("hugepages=", hugepages_setup);
>>
>> +/*
>> + * hugepagesz command line processing
>> + * A specific huge page size can only be specified once with hugepagesz.
>> + * hugepagesz is followed by hugepages on the commnad line.  The global
>> + * variable 'parsed_valid_hugepagesz' is used to determine if prior
>> + * hugepagesz argument was valid.
>> + */
>>  static int __init hugepagesz_setup(char *s)
>>  {
>>         unsigned long long size;
>> @@ -3230,16 +3261,23 @@ static int __init hugepagesz_setup(char *s)
>>         }
>>
>>         if (size_to_hstate(size)) {
>> +               parsed_valid_hugepagesz = false;
>>                 pr_warn("HugeTLB: hugepagesz %s specified twice, ignoring\n",
>>                         saved_s);
>>                 return 0;
>>         }
>>
>> +       parsed_valid_hugepagesz = true;
>>         hugetlb_add_hstate(ilog2(size) - PAGE_SHIFT);
>>         return 1;
>>  }
>>  __setup("hugepagesz=", hugepagesz_setup);
>>
>> +/*
>> + * default_hugepagesz command line input
>> + * Only one instance of default_hugepagesz allowed on command line.  Do not
>> + * add hstate here as that will confuse hugepagesz/hugepages processing.
>> + */
>>  static int __init default_hugepagesz_setup(char *s)
>>  {
>>         unsigned long long size;
>> @@ -3252,6 +3290,12 @@ static int __init default_hugepagesz_setup(char *s)
>>                 return 0;
>>         }
>>
>> +       if (default_hstate_size) {
>> +               pr_err("HugeTLB: default_hugepagesz previously specified, ignoring %s\n",
>> +                       saved_s);
>> +               return 0;
>> +       }
>> +
>>         default_hstate_size = size;
>>         return 1;
>>  }
>> --
>> 2.24.1
>>
>>
> .
>
---
Regards,
Longpeng(Mike)
