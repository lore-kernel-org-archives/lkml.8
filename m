Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81803C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EB96207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgHRM2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:28:02 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2615 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726745AbgHRM16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:27:58 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id DD78C3F249352D8EDAFF;
        Tue, 18 Aug 2020 13:27:56 +0100 (IST)
Received: from localhost (10.52.121.15) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 18 Aug
 2020 13:27:56 +0100
Date:   Tue, 18 Aug 2020 13:26:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
CC:     <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Suzuki Poulose" <suzuki.poulose@arm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] arm64/mm: Change THP helpers to comply with generic
 MM semantics
Message-ID: <20200818132625.00003d05@Huawei.com>
In-Reply-To: <8db455b6-8fe5-b552-119f-4abab0cc8501@arm.com>
References: <1597655984-15428-1-git-send-email-anshuman.khandual@arm.com>
        <1597655984-15428-2-git-send-email-anshuman.khandual@arm.com>
        <20200818101301.000027ef@Huawei.com>
        <8db455b6-8fe5-b552-119f-4abab0cc8501@arm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.15]
X-ClientProxiedBy: lhreml723-chm.china.huawei.com (10.201.108.74) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 15:11:58 +0530
Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> On 08/18/2020 02:43 PM, Jonathan Cameron wrote:
> > On Mon, 17 Aug 2020 14:49:43 +0530
> > Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> >   
> >> pmd_present() and pmd_trans_huge() are expected to behave in the following
> >> manner during various phases of a given PMD. It is derived from a previous
> >> detailed discussion on this topic [1] and present THP documentation [2].
> >>
> >> pmd_present(pmd):
> >>
> >> - Returns true if pmd refers to system RAM with a valid pmd_page(pmd)
> >> - Returns false if pmd does not refer to system RAM - Invalid pmd_page(pmd)
> >>
> >> pmd_trans_huge(pmd):
> >>
> >> - Returns true if pmd refers to system RAM and is a trans huge mapping
> >>
> >> -------------------------------------------------------------------------
> >> |	PMD states	|	pmd_present	|	pmd_trans_huge	|
> >> -------------------------------------------------------------------------
> >> |	Mapped		|	Yes		|	Yes		|
> >> -------------------------------------------------------------------------
> >> |	Splitting	|	Yes		|	Yes		|
> >> -------------------------------------------------------------------------
> >> |	Migration/Swap	|	No		|	No		|
> >> -------------------------------------------------------------------------
> >>
> >> The problem:
> >>
> >> PMD is first invalidated with pmdp_invalidate() before it's splitting. This
> >> invalidation clears PMD_SECT_VALID as below.
> >>
> >> PMD Split -> pmdp_invalidate() -> pmd_mkinvalid -> Clears PMD_SECT_VALID
> >>
> >> Once PMD_SECT_VALID gets cleared, it results in pmd_present() return false
> >> on the PMD entry. It will need another bit apart from PMD_SECT_VALID to re-
> >> affirm pmd_present() as true during the THP split process. To comply with
> >> above mentioned semantics, pmd_trans_huge() should also check pmd_present()
> >> first before testing presence of an actual transparent huge mapping.
> >>
> >> The solution:
> >>
> >> Ideally PMD_TYPE_SECT should have been used here instead. But it shares the
> >> bit position with PMD_SECT_VALID which is used for THP invalidation. Hence
> >> it will not be there for pmd_present() check after pmdp_invalidate().
> >>
> >> A new software defined PMD_PRESENT_INVALID (bit 59) can be set on the PMD
> >> entry during invalidation which can help pmd_present() return true and in
> >> recognizing the fact that it still points to memory.
> >>
> >> This bit is transient. During the split process it will be overridden by a
> >> page table page representing normal pages in place of erstwhile huge page.
> >> Other pmdp_invalidate() callers always write a fresh PMD value on the entry
> >> overriding this transient PMD_PRESENT_INVALID bit, which makes it safe.
> >>
> >> [1]: https://lkml.org/lkml/2018/10/17/231
> >> [2]: https://www.kernel.org/doc/Documentation/vm/transhuge.txt  
> > 
> > Hi Anshuman,
> > 
> > One query on this.  From my reading of the ARM ARM, bit 59 is not
> > an ignored bit.  The exact requirements for hardware to be using
> > it are a bit complex though.
> > 
> > It 'might' be safe to use it for this, but if so can we have a comment
> > explaining why.  Also more than possible I'm misunderstanding things!   
> 
> We are using this bit 59 only when the entry is not active from MMU
> perspective i.e PMD_SECT_VALID is clear.
> 

Understood. I guess we ran out of bits that were always ignored so had
to start using ones that are ignored in this particular state.

Jonathan


