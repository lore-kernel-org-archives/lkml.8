Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93256C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FDE5207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgGWL3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 07:29:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbgGWL3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 07:29:32 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A9D120709;
        Thu, 23 Jul 2020 11:29:29 +0000 (UTC)
Date:   Thu, 23 Jul 2020 12:29:26 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "liwei (CM)" <liwei213@huawei.com>
Cc:     Mike Rapoport <rppt@linux.ibm.com>,
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
Message-ID: <20200723112926.GB7315@gaia>
References: <20200721073203.107862-1-liwei213@huawei.com>
 <20200722060705.GK802087@linux.ibm.com>
 <1699CE87DE933F49876AD744B5DC140F2312E948@dggemm526-mbx.china.huawei.com>
 <20200722124910.GE27540@gaia>
 <1699CE87DE933F49876AD744B5DC140F2312F0D6@dggemm526-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1699CE87DE933F49876AD744B5DC140F2312F0D6@dggemm526-mbx.china.huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 01:40:34PM +0000, liwei (CM) wrote:
> Catalin Marinas wrote:
> > On Wed, Jul 22, 2020 at 08:41:17AM +0000, liwei (CM) wrote:
> > > Mike Rapoport wrote:
> > > > On Tue, Jul 21, 2020 at 03:32:03PM +0800, Wei Li wrote:
> > > > > For the memory hole, sparse memory model that define 
> > > > > SPARSEMEM_VMEMMAP do not free the reserved memory for the page
> > > > > map, this patch do it.
> > > > 
> > > > Are there numbers showing how much memory is actually freed?
> > > > 
> > > > The freeing of empty memmap would become rather complex with these 
> > > > changes, do the memory savings justify it?
> > > 
> > > In the sparse memory model, the size of a section is 1 GB 
> > > (SECTION_SIZE_BITS 30) by default.
> > 
> > Can we reduce SECTION_SIZE_BITS instead? Say 26?
> 
> Yes, you are right, reduce SECTION_SIZE_BITS to 26 can save almost the
> same memory as the patch. 
> 
> 1) However, it is not clear whether changing the section size has any
> other impact.

Well, we should analyse this.

> 2) Just like the flat memory model and the sparse memory model that
> does not define VMEMMAP, both of them have their own ways to free
> unused memmap. I think we've given a similar way for sparse memory
> define VMEMMAP.

I think we did it for flatmem initially (on arm32) and added support for
sparsemem later on, so free_unused_memmap() had to cope with sparse
sections. On arm64 we introduced vmemmap support and didn't bother with
the freeing at all because of the added complexity of the vmemmap page
tables.

I wonder whether we should just disallow flatmem and non-vmemmap
sparsemem on arm64. Is there any value in keeping them around?

> 3) This explicit free unused memmap method does reduce unnecessary
> memory waste for users who do not notice the section size
> modification.

But if we changed SECTION_SIZE_BITS in the mainline kernel, then we
wouldn't need additional code to free the unused memmap.

-- 
Catalin
