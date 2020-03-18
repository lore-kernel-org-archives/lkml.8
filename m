Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7621C4332B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2FC20754
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YRFM8a6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbgCRWjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 18:39:49 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50512 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgCRWjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 18:39:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02IMd6da003668;
        Wed, 18 Mar 2020 22:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=H1MqLvxMQu57KLqvhSHFxWcNzIe9uVH2pzVyel8x3lY=;
 b=YRFM8a6G/Nlx2vr+v00SsVqX8z+MTuEh6bQcPh317YpuKbvbvW/V1YrZ4GafwKwUWFAM
 CLTRLGdG/wGJv4fvSn/OIsLtkEOrE1kTK7QLdLjaOPhFHxLExj4mvQNWrxwRUaTodqK9
 Yu66Qcg0aAbs0n1iKUfXdYUkL/lWY9RSzX635I6NqpyjvMqP23tsyz9CXmmiHVHW+XDv
 Dpvkszh0PGrln064nj1pqUqZWPmLM94FcgPKTGY0wczu7fBtU89e7l2RIiDXGcwbcY36
 vT+6bjLnrYqH9P3W09Sh/G4ZPGweC2OG1tYuva0v3txraGIhO3Ko2ocoPmPlwXsDpdc/ Ag== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2yrq7m57nx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Mar 2020 22:39:05 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02IMaggY070076;
        Wed, 18 Mar 2020 22:39:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2ys8tuvjum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Mar 2020 22:39:05 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02IMctjE013967;
        Wed, 18 Mar 2020 22:38:56 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Mar 2020 15:38:55 -0700
Subject: Re: [PATCH 1/4] hugetlbfs: add arch_hugetlb_valid_size
To:     Will Deacon <will@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S.Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Longpeng <longpeng2@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200318220634.32100-1-mike.kravetz@oracle.com>
 <20200318220634.32100-2-mike.kravetz@oracle.com>
 <20200318220954.GD8477@willie-the-truck>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <43735ae0-f5f6-1e7b-2d0f-a46f9af1627e@oracle.com>
Date:   Wed, 18 Mar 2020 15:38:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318220954.GD8477@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9564 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003180097
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9564 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1015
 malwarescore=0 mlxscore=0 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003180097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/20 3:09 PM, Will Deacon wrote:
> On Wed, Mar 18, 2020 at 03:06:31PM -0700, Mike Kravetz wrote:
>> The architecture independent routine hugetlb_default_setup sets up
>> the default huge pages size.  It has no way to verify if the passed
>> value is valid, so it accepts it and attempts to validate at a later
>> time.  This requires undocumented cooperation between the arch specific
>> and arch independent code.
>>
>> For architectures that support more than one huge page size, provide
>> a routine arch_hugetlb_valid_size to validate a huge page size.
>> hugetlb_default_setup can use this to validate passed values.
>>
>> arch_hugetlb_valid_size will also be used in a subsequent patch to
>> move processing of the "hugepagesz=" in arch specific code to a common
>> routine in arch independent code.
>>
>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>> ---
>>  arch/arm64/include/asm/hugetlb.h   |  2 ++
>>  arch/arm64/mm/hugetlbpage.c        | 19 ++++++++++++++-----
>>  arch/powerpc/include/asm/hugetlb.h |  3 +++
>>  arch/powerpc/mm/hugetlbpage.c      | 20 +++++++++++++-------
>>  arch/riscv/include/asm/hugetlb.h   |  3 +++
>>  arch/riscv/mm/hugetlbpage.c        | 28 ++++++++++++++++++----------
>>  arch/s390/include/asm/hugetlb.h    |  3 +++
>>  arch/s390/mm/hugetlbpage.c         | 18 +++++++++++++-----
>>  arch/sparc/include/asm/hugetlb.h   |  3 +++
>>  arch/sparc/mm/init_64.c            | 23 ++++++++++++++++-------
>>  arch/x86/include/asm/hugetlb.h     |  3 +++
>>  arch/x86/mm/hugetlbpage.c          | 21 +++++++++++++++------
>>  include/linux/hugetlb.h            |  7 +++++++
>>  mm/hugetlb.c                       | 16 +++++++++++++---
>>  14 files changed, 126 insertions(+), 43 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
>> index 2eb6c234d594..3248f35213ee 100644
>> --- a/arch/arm64/include/asm/hugetlb.h
>> +++ b/arch/arm64/include/asm/hugetlb.h
<snip>
>> +
>> +static __init int setup_hugepagesz(char *opt)
>> +{
>> +	unsigned long long ps = memparse(opt, &opt);
>> +
>> +	if arch_hugetlb_valid_size(ps)) {
> 
> Please compile your changes if you're touching multiple architectures. You
> can get cross-compiler binaries from:
> 

My apologies.  I only cross compiled the result of the series on each
architecture.  The above code is obviously bad.

-- 
Mike Kravetz
