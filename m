Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF90C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F4E20738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 21:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgCQVgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 17:36:24 -0400
Received: from smtprelay0229.hostedemail.com ([216.40.44.229]:48396 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726789AbgCQVgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 17:36:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 0B53645A8;
        Tue, 17 Mar 2020 21:36:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tax31_8e64a60b0ff18
X-Filterd-Recvd-Size: 3175
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Tue, 17 Mar 2020 21:36:18 +0000 (UTC)
Message-ID: <1e52a8441a319e55b913376ad47c6b18843742cd.camel@perches.com>
Subject: Re: [PATCH] treewide: Rename "unencrypted" to "decrypted"
From:   Joe Perches <joe@perches.com>
To:     Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     Borislav Petkov <bp@suse.de>, lkml <linux-kernel@vger.kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Shutemov, Kirill" <kirill.shutemov@intel.com>
Date:   Tue, 17 Mar 2020 14:34:30 -0700
In-Reply-To: <f3e520c6-f455-9c82-abfc-d014ca63eeb5@intel.com>
References: <20200317111822.GA15609@zn.tnic>
         <2cb4a8ae-3b13-67bd-c021-aee47fdf58c5@intel.com>
         <20200317210602.GG15609@zn.tnic>
         <f3e520c6-f455-9c82-abfc-d014ca63eeb5@intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-03-17 at 14:24 -0700, Dave Hansen wrote:
> On 3/17/20 2:06 PM, Borislav Petkov wrote:
> > On Tue, Mar 17, 2020 at 01:35:12PM -0700, Dave Hansen wrote:
> > > On 3/17/20 4:18 AM, Borislav Petkov wrote:
> > > > Back then when the whole SME machinery started getting mainlined, it
> > > > was agreed that for simplicity, clarity and sanity's sake, the terms
> > > > denoting encrypted and not-encrypted memory should be "encrypted" and
> > > > "decrypted". And the majority of the code sticks to that convention
> > > > except those two. So rename them.
> > > Don't "unencrypted" and "decrypted" mean different things?
> > > 
> > > Unencrypted to me means "encryption was never used for this data".
> > > 
> > > Decrypted means "this was/is encrypted but here is a plaintext copy".
> > Maybe but linguistical semantics is not the point here.
> > 
> > The idea is to represent a "binary" concept of memory being encrypted
> > or memory being not encrypted. And at the time we decided to use
> > "encrypted" and "decrypted" for those two things.
> 
> Yeah, agreed.  We're basically trying to name "!encrypted".
> 
> > Do you see the need to differentiate a third "state", so to speak, of
> > memory which was never encrypted?
> 
> No, there are just two states.  I just think the "!encrypted" case
> should not be called "decrypted".

Nor do I, it's completely misleading.


