Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C7FC433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DE8820771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732364AbgGVMtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 08:49:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:45756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732253AbgGVMtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:49:15 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 471B520729;
        Wed, 22 Jul 2020 12:49:13 +0000 (UTC)
Date:   Wed, 22 Jul 2020 13:49:10 +0100
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
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIGFybTY0?=
 =?utf-8?B?OiBtbTogZnJl?= =?utf-8?Q?e?= unused memmap for sparse memory model
 that define VMEMMAP
Message-ID: <20200722124910.GE27540@gaia>
References: <20200721073203.107862-1-liwei213@huawei.com>
 <20200722060705.GK802087@linux.ibm.com>
 <1699CE87DE933F49876AD744B5DC140F2312E948@dggemm526-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1699CE87DE933F49876AD744B5DC140F2312E948@dggemm526-mbx.china.huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 08:41:17AM +0000, liwei (CM) wrote:
> Mike Rapoport wrote:
> > On Tue, Jul 21, 2020 at 03:32:03PM +0800, Wei Li wrote:
> > > For the memory hole, sparse memory model that define SPARSEMEM_VMEMMAP 
> > > do not free the reserved memory for the page map, this patch do it.
> > 
> > Are there numbers showing how much memory is actually freed?
> > 
> > The freeing of empty memmap would become rather complex with these
> > changes, do the memory savings justify it?
> 
> In the sparse memory model, the size of a section is 1 GB
> (SECTION_SIZE_BITS 30) by default.

Can we reduce SECTION_SIZE_BITS instead? Say 26?

-- 
Catalin
