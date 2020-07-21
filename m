Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF76C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1553220709
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731411AbgGUXMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:12:12 -0400
Received: from kernel.crashing.org ([76.164.61.194]:41664 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgGUXML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:12:11 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 06LNB4EP017146
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 21 Jul 2020 18:11:11 -0500
Message-ID: <54af168083aee9dbda1b531227521a26b77ba2c8.camel@kernel.crashing.org>
Subject: Re: [PATCH v5 1/4] riscv: Move kernel mapping to vmalloc zone
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Alex Ghiti <alex@ghiti.fr>, Palmer Dabbelt <palmer@dabbelt.com>
Cc:     mpe@ellerman.id.au, paulus@samba.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>, zong.li@sifive.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-mm@kvack.org
Date:   Wed, 22 Jul 2020 09:11:02 +1000
In-Reply-To: <7cb2285e-68ba-6827-5e61-e33a4b65ac03@ghiti.fr>
References: <mhng-831c4073-aefa-4aa0-a583-6a17f9aff9b7@palmerdabbelt-glaptop1>
         <d7e3cbb7-c12a-bce2-f1db-c336d15f74bd@ghiti.fr>
         <7cb2285e-68ba-6827-5e61-e33a4b65ac03@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-21 at 14:36 -0400, Alex Ghiti wrote:
> > > I guess I don't understand why this is necessary at all.  
> > > Specifically: why
> > > can't we just relocate the kernel within the linear map?  That would 
> > > let the
> > > bootloader put the kernel wherever it wants, modulo the physical 
> > > memory size we
> > > support.  We'd need to handle the regions that are coupled to the 
> > > kernel's
> > > execution address, but we could just put them in an explicit memory 
> > > region
> > > which is what we should probably be doing anyway.
> > 
> > Virtual relocation in the linear mapping requires to move the kernel 
> > physically too. Zong implemented this physical move in its KASLR RFC 
> > patchset, which is cumbersome since finding an available physical spot 
> > is harder than just selecting a virtual range in the vmalloc range.
> > 
> > In addition, having the kernel mapping in the linear mapping prevents 
> > the use of hugepage for the linear mapping resulting in performance loss 
> > (at least for the GB that encompasses the kernel).
> > 
> > Why do you find this "ugly" ? The vmalloc region is just a bunch of 
> > available virtual addresses to whatever purpose we want, and as noted by 
> > Zong, arm64 uses the same scheme.

I don't get it :-)

At least on powerpc we move the kernel in the linear mapping and it
works fine with huge pages, what is your problem there ? You rely on
punching small-page size holes in there ?

At least in the old days, there were a number of assumptions that
the kernel text/data/bss resides in the linear mapping.

If you change that you need to ensure that it's still physically
contiguous and you'll have to tweak __va and __pa, which might induce
extra overhead.

Cheers,
Ben.
 

