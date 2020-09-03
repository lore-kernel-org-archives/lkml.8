Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061D0C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 12:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C168720639
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 12:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UaBHDH1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgICMbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 08:31:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39356 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728596AbgICM2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:28:10 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 083C2pOp125403;
        Thu, 3 Sep 2020 08:27:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=WJwCBuFxd5vziX0FDrayWlIA3JKtbOD6D5rCPqz+aHY=;
 b=UaBHDH1ED3Vo7dUZGXi3Ikxi3g2X+aIzTnh7NHe9iXXL51K8tjNf4yoDQYxad2mVIq/I
 5V9clDsYCwUwzPbCZ3XJAC1xmgnl+505vKYYMGUIlC7u1jbjAPYHLhAARSowDguYDDUZ
 mYgIlKNUnUrjriJSo3yZyiMTEtZzLW70hN60zdv1RmcqwAWUugi+VUa7L1lX0JHR9bJt
 5ssuB4N1H/TyMqeIZyt3Fb5t4bDQd9ChDXFnF5tuf83h2DO57HpUIPs+3YdwSbm2HA+X
 6qRBBnctyB1t09T+3/bNaoyAA6gZxUkvDqBVM0bZeatjWl7oM5+aPCl1FKPT0RVD5t/c 6A== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33ax66mep3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Sep 2020 08:27:30 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 083CR7W0031119;
        Thu, 3 Sep 2020 12:27:28 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 339ap7sw6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Sep 2020 12:27:28 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 083CRQCZ65667342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Sep 2020 12:27:26 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E295442047;
        Thu,  3 Sep 2020 12:27:25 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4476D4204B;
        Thu,  3 Sep 2020 12:27:24 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.148.206.90])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  3 Sep 2020 12:27:24 +0000 (GMT)
Date:   Thu, 3 Sep 2020 15:27:22 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Wei Li <liwei213@huawei.com>, will@kernel.org,
        saberlily.xia@hisilicon.com, puck.chen@hisilicon.com,
        butao@hisilicon.com, fengbaopeng2@hisilicon.com,
        nsaenzjulienne@suse.de, steve.capper@arm.com,
        song.bao.hua@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, sujunfei2@hisilicon.com
Subject: Re: [PATCH v2] arm64: mm: free unused memmap for sparse memory model
 that define VMEMMAP
Message-ID: <20200903122722.GI424181@linux.ibm.com>
References: <20200812010655.96339-1-liwei213@huawei.com>
 <20200817080405.GL969206@linux.ibm.com>
 <20200903120558.GB31409@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903120558.GB31409@gaia>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-03_05:2020-09-03,2020-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 bulkscore=0 mlxlogscore=715 phishscore=0
 spamscore=0 suspectscore=5 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030113
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 01:05:58PM +0100, Catalin Marinas wrote:
> On Mon, Aug 17, 2020 at 11:04:05AM +0300, Mike Rapoport wrote:
> > On Wed, Aug 12, 2020 at 09:06:55AM +0800, Wei Li wrote:
> > > For the memory hole, sparse memory model that define SPARSEMEM_VMEMMAP
> > > do not free the reserved memory for the page map, this patch do it.
> > 
> > I've been thinking about it a bit more and it seems that instead of
> > freeing unused memory map it would be better to allocate the exact
> > memory map from the beginning.
> > 
> > In sparse_init_nid() we can replace PAGES_PER_SECTION parameter to
> > __populate_section_memmap() with the calculated value for architectures
> > that define HAVE_ARCH_PFN_VALID.
> 
> Or just use a smaller PAGES_PER_SECTION and reduce the waste ;).
> 
> Just to be clear, are you suggesting that we should use pfn_valid() on
> the pages within a section to calculate the actual range? The
> pfn_valid() implementation on arm64 checks for the validity of a sparse
> section, so this would be called from within the sparse_init() code
> path. I hope there's no dependency but I haven't checked. If it works,
> it's fine by me, it solves the FLATMEM mem_map freeing as well.

What I meant was that sparse_init()->__populate_section_memmap() would
not blindly presume that the entire section is valid, but would take
into account The actual DRAM banks listed in memblock.memory.
For that to work we'll need a version of pfn_valid() that does not rely
on the validity of sparse section, but uses some other means, e.g.
memblock. Apparently, I've looked at arm32 version of pfn_valid() and
missed the section validity check :)

I was thinking about doing something like this for 32-bit systems
(non-ARM) that cannot affort small sections because of the limited space
in the page->flags.

> With 4KB pages on arm64, vmemmap_populate() stops at the pmd level, so
> it always allocates PMD_SIZE. Wei's patch also only frees in PMD_SIZE
> amounts. So, with a sizeof(struct page) of 64 (2^6), a PMD_SIZE mem_map
> section would cover 2^(21-6) pages, so that's equivalent to a
> SECTION_SIZE_BITS of 21-6+12 = 27.
> 
> If we reduce SECTION_SIZE_BITS to 27 or less, this patch is a no-op.
>
> -- 
> Catalin

-- 
Sincerely yours,
Mike.
