Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13D1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4EAF2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgENJa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 05:30:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61850 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725878AbgENJa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 05:30:29 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04E9CphG102779;
        Thu, 14 May 2020 05:30:02 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3101kpjv5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 05:30:02 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04E934YQ047962;
        Thu, 14 May 2020 05:30:01 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3101kpjv4a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 05:30:01 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04E9Q6e0003587;
        Thu, 14 May 2020 09:29:59 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3100ubbbgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 09:29:59 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04E9TvFa32899398
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 May 2020 09:29:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B006A4057;
        Thu, 14 May 2020 09:29:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51199A4059;
        Thu, 14 May 2020 09:29:55 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.206.128])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 14 May 2020 09:29:55 +0000 (GMT)
Date:   Thu, 14 May 2020 12:29:53 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com
Subject: Re: [RFC v4][PATCH part-2 00/13] ASI - Part II (Decorated Page-Table)
Message-ID: <20200514092953.GA1059226@linux.ibm.com>
References: <20200504145810.11882-1-alexandre.chartre@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504145810.11882-1-alexandre.chartre@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_01:2020-05-13,2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 cotscore=-2147483648 mlxlogscore=999 adultscore=0 clxscore=1011
 suspectscore=0 spamscore=0 phishscore=0 priorityscore=1501 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexandre,

On Mon, May 04, 2020 at 04:57:57PM +0200, Alexandre Chartre wrote:
> This is part II of ASI RFC v4. Please refer to the cover letter of
> part I for an overview the ASI RFC.
> 
>   https://lore.kernel.org/lkml/20200504144939.11318-1-alexandre.chartre@oracle.com/
> 
> This part introduces decorated page-table which encapsulate native page
> table (e.g. a PGD) in order to provide convenient page-table management
> functions, such as tracking address range mapped in a page-table or
> safely handling references to another page-table.
> 
> Decorated page-table can then be used to easily create and manage page
> tables to be used with ASI. It will be used by the ASI test driver (see
> part III) and later by KVM ASI.
> 
> Decorated page-table is independent of ASI, and can potentially be used
> anywhere a page-table is needed.
 
This is very impressive work!

I wonder why did you decide to make dpt x86-specific? Unless I've missed
simething, the dpt implementation does not rely on anything architecture
specific and can go straight to linux/mm.

Another thing that comes to mind is that we already have a very
decorated page table, which is mm_struct. I admit that my attempt to
split out the core page table bits from the mm_struct [1] didn't  went
far, but I still think we need a first class abstraction for the page
table that will be used by both user memory management and the
management of the reduced kernel address spaces.


[1] https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=pg_table/v0.0

> Thanks,
> 
> alex.
> 
> -----
> 
> Alexandre Chartre (13):
>   mm/x86: Introduce decorated page-table (dpt)
>   mm/dpt: Track buffers allocated for a decorated page-table
>   mm/dpt: Add decorated page-table entry offset functions
>   mm/dpt: Add decorated page-table entry allocation functions
>   mm/dpt: Add decorated page-table entry set functions
>   mm/dpt: Functions to populate a decorated page-table from a VA range
>   mm/dpt: Helper functions to map module into a decorated page-table
>   mm/dpt: Keep track of VA ranges mapped in a decorated page-table
>   mm/dpt: Functions to clear decorated page-table entries for a VA range
>   mm/dpt: Function to copy page-table entries for percpu buffer
>   mm/dpt: Add decorated page-table remap function
>   mm/dpt: Handle decorated page-table mapped range leaks and overlaps
>   mm/asi: Function to init decorated page-table with ASI core mappings
> 
>  arch/x86/include/asm/asi.h |    2 +
>  arch/x86/include/asm/dpt.h |   89 +++
>  arch/x86/mm/Makefile       |    2 +-
>  arch/x86/mm/asi.c          |   57 ++
>  arch/x86/mm/dpt.c          | 1051 ++++++++++++++++++++++++++++++++++++
>  5 files changed, 1200 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/include/asm/dpt.h
>  create mode 100644 arch/x86/mm/dpt.c
> 
> -- 
> 2.18.2
> 

-- 
Sincerely yours,
Mike.
