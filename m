Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132ECC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E587A2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgIAJLN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 05:11:13 -0400
Received: from verein.lst.de ([213.95.11.211]:52607 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgIAJLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:11:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5724168B05; Tue,  1 Sep 2020 11:11:05 +0200 (CEST)
Date:   Tue, 1 Sep 2020 11:11:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com, tony.luck@intel.com,
        fenghua.yu@intel.com, schnelle@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, sfr@canb.auug.org.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: Re: [RESEND][PATCH 0/7] Avoid overflow at boundary_size
Message-ID: <20200901091105.GA4959@lst.de>
References: <20200831203811.8494-1-nicoleotsuka@gmail.com> <20200901073623.GA30418@lst.de> <20200901075401.GA5667@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901075401.GA5667@Asurada-Nvidia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 12:54:01AM -0700, Nicolin Chen wrote:
> Hi Christoph,
> 
> On Tue, Sep 01, 2020 at 09:36:23AM +0200, Christoph Hellwig wrote:
> > I really don't like all the open coded smarts in the various drivers.
> > What do you think about a helper like the one in the untested patch
> 
> A helper function will be actually better. I was thinking of
> one yet not very sure about the naming and where to put it.
> 
> > below (on top of your series).  Also please include the original
> > segment boundary patch with the next resend so that the series has
> > the full context.
> 
> I will use your change instead and resend with the ULONG_MAX
> change. But in that case, should I make separate changes for
> different files like this series, or just one single change
> like yours?
> 
> Asking this as I was expecting that those changes would get
> applied by different maintainers. But now it feels like you
> will merge it to your tree at once?

I guess one patch is fine.  I can queue it up in the dma-mapping
tree as a prep patch for the default boundary change.
