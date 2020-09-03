Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456E7C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19EA3208C7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgICQNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:13:04 -0400
Received: from verein.lst.de ([213.95.11.211]:38543 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728294AbgICQM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:12:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0749867357; Thu,  3 Sep 2020 18:12:53 +0200 (CEST)
Date:   Thu, 3 Sep 2020 18:12:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT" 
        <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rth@twiddle.net, ink@jurassic.park.msu.ru,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        schnelle@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: Re: [PATCH 1/2] dma-mapping: introduce
 dma_get_seg_boundary_nr_pages()
Message-ID: <20200903161252.GA24841@lst.de>
References: <20200901221646.26491-1-nicoleotsuka@gmail.com> <20200901221646.26491-2-nicoleotsuka@gmail.com> <CAHp75VcVJBSnPQ6NfdF8FdEDfM+oQ=Sr+cH5VGX4SrAqrgpf-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcVJBSnPQ6NfdF8FdEDfM+oQ=Sr+cH5VGX4SrAqrgpf-g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 01:57:39PM +0300, Andy Shevchenko wrote:
> > +{
> > +       if (!dev)
> > +               return (U32_MAX >> page_shift) + 1;
> > +       return (dma_get_seg_boundary(dev) >> page_shift) + 1;
> 
> Can it be better to do something like
>   unsigned long boundary = dev ? dma_get_seg_boundary(dev) : U32_MAX;
> 
>   return (boundary >> page_shift) + 1;
> 
> ?

I don't really see what that would buy us.
