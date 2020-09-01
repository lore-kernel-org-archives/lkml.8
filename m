Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3F3C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 831ED20767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598963011;
	bh=p4M/L1yz/ek8/chpzyAF+xMHJfMK5wQCHUgID8EQdmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q1CguhUWHUZmLCO4HJbcUKjnICy81DLI1EeHbwE045N48kDvuZPj+K9J7vqscoEO7
	 RstfM4eqPAGTmLv0+dPRM5miKxHEm0j7HvGavcFhudCa/pOhkPuj+uNXDtzbO7nsO7
	 3E39ZbaTkdkqm6MsO462s1gaZVhL8j8T5ALKS/w4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgIAMXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:23:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:59694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728177AbgIAMLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 08:11:36 -0400
Received: from kernel.org (unknown [77.127.89.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EDE9206EF;
        Tue,  1 Sep 2020 12:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598962296;
        bh=p4M/L1yz/ek8/chpzyAF+xMHJfMK5wQCHUgID8EQdmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dEqOWpAz2kvlKimlO8dARzBFcrklfu8cSe+2aBF7CkJogzpcFaPoSG4sCMG8qyzbm
         ZMT4ghik9IujpTvBZZvnOyJQ3FEHNmSceRhtvrncuQUYwdh1STPOtZ5hDvRfEgtVCc
         sCotdF9hRvqJ/eYyBX3v/Yw22a9waEHIR0NqLKK4=
Date:   Tue, 1 Sep 2020 15:11:30 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH] openrisc: Reserve memblock for initrd
Message-ID: <20200901121130.GA698558@kernel.org>
References: <20200831212102.4014642-1-shorne@gmail.com>
 <20200901055924.GC432455@kernel.org>
 <20200901102044.GB3562056@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901102044.GB3562056@lianli.shorne-pla.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 07:20:44PM +0900, Stafford Horne wrote:
> On Tue, Sep 01, 2020 at 08:59:24AM +0300, Mike Rapoport wrote:
> > On Tue, Sep 01, 2020 at 06:21:01AM +0900, Stafford Horne wrote:
> > > Recently OpenRISC added support for external initrd images, but I found
> > > some instability when using larger buildroot initrd images. It turned
> > > out that I forgot to reserve the memblock space for the initrd image.
> > > 
> > > This patch fixes the instability issue by reserving memblock space.
> > > 
> > > Fixes: ff6c923dbec3 ("openrisc: Add support for external initrd images")
> > > Signed-off-by: Stafford Horne <shorne@gmail.com>
> > > ---
> > >  arch/openrisc/kernel/setup.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> > > index b18e775f8be3..2c8aa53cc7ba 100644
> > > --- a/arch/openrisc/kernel/setup.c
> > > +++ b/arch/openrisc/kernel/setup.c
> > > @@ -80,6 +80,15 @@ static void __init setup_memory(void)
> > >  	 */
> > >  	memblock_reserve(__pa(_stext), _end - _stext);
> > >  
> > > +#ifdef CONFIG_BLK_DEV_INITRD
> > > +	/* Then reserve the initrd, if any */
> > > +	if (initrd_start && (initrd_end > initrd_start)) {
> > > + 	memblock_reserve(ALIGN_DOWN(__pa(initrd_start), PAGE_SIZE),
> > > +		ALIGN(initrd_end, PAGE_SIZE) -
> > > +		ALIGN_DOWN(initrd_start, PAGE_SIZE));
> > > +	}
> > 
> > The core mm takes care of reserving the entrire pages for the memory
> > reserved with memblock, so it is not necessary to do it here.
> 
> Thanks for the pointer
> 
> I guess what you mean is it is not required to do the page alignment.

Right. 

> I used other architectures as an example and most do the alignment, I
> think for most architectures this can be pulled out to generic code.

You are more than welcome :)
We already have a generic free_initrd_mem(), maybe it's time to have a
generic reserve_initrd_mem().

I'm ok with openrisc doing the alignment, but I think using local
variables would make the core more readable, e.g

	if (initd_start && (initrd_end)) {
		unsigned long aligned_start = ALIGN_DOWN(initrd_start, PAGE_SIZE);
		unsigned long aligned_end = ALIGN(end, PAGE_SIZE);

		memblock_reserve(aligned_start, aligned_end);
	}

What do you say?

> -Stafford
> 
> > > +#endif /* CONFIG_BLK_DEV_INITRD */
> > > +
> > >  	early_init_fdt_reserve_self();
> > >  	early_init_fdt_scan_reserved_mem();
> > >  
> > > -- 
> > > 2.26.2
> > > 
> > 
> > -- 
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.
