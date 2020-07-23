Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EE5C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CCE5207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728870AbgGWNTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:19:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10782 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726521AbgGWNTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:19:52 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06ND1VeK180469;
        Thu, 23 Jul 2020 09:18:45 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32fafphuyr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 09:18:45 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06NDFFno032718;
        Thu, 23 Jul 2020 13:18:43 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04fra.de.ibm.com with ESMTP id 32dbmn20ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 13:18:43 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06NDIfam61997292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 13:18:41 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 668B94C058;
        Thu, 23 Jul 2020 13:18:41 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B45894C04E;
        Thu, 23 Jul 2020 13:18:39 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.202.80])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 23 Jul 2020 13:18:39 +0000 (GMT)
Date:   Thu, 23 Jul 2020 16:18:37 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     "liwei (CM)" <liwei213@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "Xiaqing (A)" <saberlily.xia@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        butao <butao@hisilicon.com>,
        fengbaopeng <fengbaopeng2@hisilicon.com>,
        "nsaenzjulienne@suse.de" <nsaenzjulienne@suse.de>,
        "steve.capper@arm.com" <steve.capper@arm.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        sujunfei <sujunfei2@hisilicon.com>,
        zhaojiapeng <zhaojiapeng@huawei.com>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IFtQQVRD?=
 =?utf-8?Q?H=5D_arm64=3A_mm=3A_fre?= =?utf-8?Q?e?= unused memmap for sparse
 memory model that define VMEMMAP
Message-ID: <20200723131837.GC1975360@linux.ibm.com>
References: <20200721073203.107862-1-liwei213@huawei.com>
 <20200722060705.GK802087@linux.ibm.com>
 <1699CE87DE933F49876AD744B5DC140F2312E948@dggemm526-mbx.china.huawei.com>
 <20200722124910.GE27540@gaia>
 <1699CE87DE933F49876AD744B5DC140F2312F0D6@dggemm526-mbx.china.huawei.com>
 <20200723112926.GB7315@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723112926.GB7315@gaia>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_05:2020-07-23,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 mlxscore=0 suspectscore=5 mlxlogscore=988 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230093
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 12:29:26PM +0100, Catalin Marinas wrote:
> On Wed, Jul 22, 2020 at 01:40:34PM +0000, liwei (CM) wrote:
> > Catalin Marinas wrote:
> > > On Wed, Jul 22, 2020 at 08:41:17AM +0000, liwei (CM) wrote:
> > > > Mike Rapoport wrote:
> > > > > On Tue, Jul 21, 2020 at 03:32:03PM +0800, Wei Li wrote:
> > > > > > For the memory hole, sparse memory model that define 
> > > > > > SPARSEMEM_VMEMMAP do not free the reserved memory for the page
> > > > > > map, this patch do it.
> > > > > 
> > > > > Are there numbers showing how much memory is actually freed?
> > > > > 
> > > > > The freeing of empty memmap would become rather complex with these 
> > > > > changes, do the memory savings justify it?
> > > > 
> > > > In the sparse memory model, the size of a section is 1 GB 
> > > > (SECTION_SIZE_BITS 30) by default.
> > > 
> > > Can we reduce SECTION_SIZE_BITS instead? Say 26?
> > 
> > Yes, you are right, reduce SECTION_SIZE_BITS to 26 can save almost the
> > same memory as the patch. 
> > 
> > 1) However, it is not clear whether changing the section size has any
> > other impact.
> 
> Well, we should analyse this.
> 
> > 2) Just like the flat memory model and the sparse memory model that
> > does not define VMEMMAP, both of them have their own ways to free
> > unused memmap. I think we've given a similar way for sparse memory
> > define VMEMMAP.
> 
> I think we did it for flatmem initially (on arm32) and added support for
> sparsemem later on, so free_unused_memmap() had to cope with sparse
> sections. On arm64 we introduced vmemmap support and didn't bother with
> the freeing at all because of the added complexity of the vmemmap page
> tables.
> 
> I wonder whether we should just disallow flatmem and non-vmemmap
> sparsemem on arm64. Is there any value in keeping them around?

FLATMEM is useful for UMA systems with a single memory bank, so probably
it's worth keeping it for low end machines.

Non-vmemmap sparsemem is essentially disable in arch/arm64/Kconfig, so
for NUMA configurations SPARSEMEM_VMEMMAP is the only choice.
 
> > 3) This explicit free unused memmap method does reduce unnecessary
> > memory waste for users who do not notice the section size
> > modification.
> 
> But if we changed SECTION_SIZE_BITS in the mainline kernel, then we
> wouldn't need additional code to free the unused memmap.

Moreover if we reduce SECTION_SIZE_BITS, we can drop
free_unused_memmap() and since the arm64 memory map for sparse will not
differ from other arches we can drop custom pfn_valid() as well.
 
> -- 
> Catalin

-- 
Sincerely yours,
Mike.
