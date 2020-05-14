Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722DEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 462E42065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="avnJqP1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgENLoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:44:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42232 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgENLoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:44:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04EBb88o173202;
        Thu, 14 May 2020 11:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=sVoPDvoEVYEWB5BIXYxfVzexEGSpH2rDe1dkLm2MH6s=;
 b=avnJqP1A06hy/zQWkYvEKxaKDxLZlqIy5dC26RtVl6rcc8yVRIc1SDN6PlEUjPgK1yuy
 k9k0aTSvTaPG4GSZVkcfFZK4KJYqCPV6zTbSOqZgHAu6pRDxqc/S+2YHOcjlumjgms57
 cFDzSZgFpRmIXL2/JChZI2aQD/J3TcTBuap5+vFqtHaRHG9EDeB1apXxvCj/bceAlrpY
 gsag3gzJCCb33j8nFRiqPEaUUuH+zqRy0QquJFb5PomBb730RT5GEbQTNVa7YB/yPEIP
 y9ZOAQ2A75sf5xf3w/sCdkgkiuJ37mLf53L5c/Rx2pnW8P89ZU284yZZLm2X/17GkJ7S rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 3100xwsysq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 May 2020 11:43:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04EBc2ja075490;
        Thu, 14 May 2020 11:43:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 3100ycfxv2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 May 2020 11:43:33 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04EBhQW1005978;
        Thu, 14 May 2020 11:43:28 GMT
Received: from linux-1.home (/92.157.36.49)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 14 May 2020 04:43:26 -0700
Subject: Re: [RFC v4][PATCH part-2 00/13] ASI - Part II (Decorated Page-Table)
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com
References: <20200504145810.11882-1-alexandre.chartre@oracle.com>
 <20200514092953.GA1059226@linux.ibm.com>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Message-ID: <1f4dd88f-8125-eb24-dba4-95fa5e8d804a@oracle.com>
Date:   Thu, 14 May 2020 13:42:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200514092953.GA1059226@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9620 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 cotscore=-2147483648 bulkscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/14/20 11:29 AM, Mike Rapoport wrote:
> Hello Alexandre,
> 
> On Mon, May 04, 2020 at 04:57:57PM +0200, Alexandre Chartre wrote:
>> This is part II of ASI RFC v4. Please refer to the cover letter of
>> part I for an overview the ASI RFC.
>>
>>    https://lore.kernel.org/lkml/20200504144939.11318-1-alexandre.chartre@oracle.com/
>>
>> This part introduces decorated page-table which encapsulate native page
>> table (e.g. a PGD) in order to provide convenient page-table management
>> functions, such as tracking address range mapped in a page-table or
>> safely handling references to another page-table.
>>
>> Decorated page-table can then be used to easily create and manage page
>> tables to be used with ASI. It will be used by the ASI test driver (see
>> part III) and later by KVM ASI.
>>
>> Decorated page-table is independent of ASI, and can potentially be used
>> anywhere a page-table is needed.

Hi Mike,

> This is very impressive work!
> 
> I wonder why did you decide to make dpt x86-specific? Unless I've missed
> simething, the dpt implementation does not rely on anything architecture
> specific and can go straight to linux/mm.

Correct, this is not x86 specific. I put it in arch/x86 because that's currently
the only place were I use it, but it can be moved to linux/mm.

> Another thing that comes to mind is that we already have a very
> decorated page table, which is mm_struct.

mm_struct doesn't define a generic page-table encapsulation. mm_struct references
a page table (i.e. PGD) and adds all kind of attributes needed for mm management but
not necessarily related to page-table.

> I admit that my attempt to
> split out the core page table bits from the mm_struct [1] didn't  went
> far, but I still think we need a first class abstraction for the page
> table that will be used by both user memory management and the
> management of the reduced kernel address spaces.

Agree. I remember your attempt to extract the page-table from mm_struct; this is
not a simple work! For ASI, I didn't need mm, so it was simpler to built a simple
decorated page-table without attempting to use with mm (at least for now).

Thanks,

alex.

PS: if you want to play with dpt, there's a bug in dpt_destroy(), patch 08 adds a
a double free of dpt->backend_pages pages.

> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=pg_table/v0.0
> 
>> Thanks,
>>
>> alex.
>>
>> -----
>>
>> Alexandre Chartre (13):
>>    mm/x86: Introduce decorated page-table (dpt)
>>    mm/dpt: Track buffers allocated for a decorated page-table
>>    mm/dpt: Add decorated page-table entry offset functions
>>    mm/dpt: Add decorated page-table entry allocation functions
>>    mm/dpt: Add decorated page-table entry set functions
>>    mm/dpt: Functions to populate a decorated page-table from a VA range
>>    mm/dpt: Helper functions to map module into a decorated page-table
>>    mm/dpt: Keep track of VA ranges mapped in a decorated page-table
>>    mm/dpt: Functions to clear decorated page-table entries for a VA range
>>    mm/dpt: Function to copy page-table entries for percpu buffer
>>    mm/dpt: Add decorated page-table remap function
>>    mm/dpt: Handle decorated page-table mapped range leaks and overlaps
>>    mm/asi: Function to init decorated page-table with ASI core mappings
>>
>>   arch/x86/include/asm/asi.h |    2 +
>>   arch/x86/include/asm/dpt.h |   89 +++
>>   arch/x86/mm/Makefile       |    2 +-
>>   arch/x86/mm/asi.c          |   57 ++
>>   arch/x86/mm/dpt.c          | 1051 ++++++++++++++++++++++++++++++++++++
>>   5 files changed, 1200 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/x86/include/asm/dpt.h
>>   create mode 100644 arch/x86/mm/dpt.c
>>
>> -- 
>> 2.18.2
>>
> 
