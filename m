Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D0AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83671206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466772;
	bh=EBDtinNOva015/ML4sKnL+2OBnBOq3SojlUKZ6fF8Xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lVw6rKzImwiHpsoZ6XAHEGx5zo8TYq7QPUJptKU9u49Rff0y4wRwX1cDkQPQDGWay
	 2NuzJAIitECBwoD0dbJ/ABeLHVVse/aZyNFbZAvEmwE42yipClAdXgoHFiHrRxdkad
	 06qiE/LU93/JyOlLg0l7q1BB++gKoc5pHKsY662c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731931AbgF2Vja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:39:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728324AbgF2Skb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:31 -0400
Received: from kernel.org (unknown [87.71.40.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C5E4206C3;
        Mon, 29 Jun 2020 04:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593404104;
        bh=EBDtinNOva015/ML4sKnL+2OBnBOq3SojlUKZ6fF8Xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vCSTzeVaasExtW6XX2YsOlizrbTNMNGOW8n2P6rB7m/n0T8zkZZEHLjHelmv+dTNB
         NHSs4NtNSmojBJBpDyU/1orfLrycrtGONbdWi0H3vjUL21r9cLuiO8S07AEp2Bek5z
         ROwsE9Gi9enoFY2lNVZp8e9FLlfajMCx6sWG6xy4=
Date:   Mon, 29 Jun 2020 07:14:59 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 1/2] m68k: nommu: register start of the memory with
 memblock
Message-ID: <20200629041459.GA1492837@kernel.org>
References: <20200617065341.32160-1-rppt@kernel.org>
 <20200617065341.32160-2-rppt@kernel.org>
 <45cb9ecf-44c2-d307-4342-e66851ef67a7@linux-m68k.org>
 <4a988de6-b194-5831-9eec-3dd7417bc3c7@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a988de6-b194-5831-9eec-3dd7417bc3c7@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Jun 29, 2020 at 11:10:16AM +1000, Greg Ungerer wrote:
> Hi Mike,
> 
> On 17/6/20 10:33 pm, Greg Ungerer wrote:
> > Hi Mike,
> > 
> > On 17/6/20 4:53 pm, Mike Rapoport wrote:
> > > From: Mike Rapoport <rppt@linux.ibm.com>
> > > 
> > > The m68k nommu setup code didn't register the beginning of the physical
> > > memory with memblock because it was anyway occupied by the kernel. However,
> > > commit fa3354e4ea39 ("mm: free_area_init: use maximal zone PFNs rather than
> > > zone sizes") changed zones initialization to use memblock.memory to detect
> > > the zone extents and this caused inconsistency between zone PFNs and the
> > > actual PFNs:
> > > 
> > > BUG: Bad page state in process swapper  pfn:20165
> > > page:41fe0ca0 refcount:0 mapcount:1 mapping:00000000 index:0x0 flags: 0x0()
> > > raw: 00000000 00000100 00000122 00000000 00000000 00000000 00000000 00000000
> > > page dumped because: nonzero mapcount
> > > CPU: 0 PID: 1 Comm: swapper Not tainted 5.8.0-rc1-00001-g3a38f8a60c65-dirty #1
> > > Stack from 404c9ebc:
> > >          404c9ebc 4029ab28 4029ab28 40088470 41fe0ca0 40299e21 40299df1 404ba2a4
> > >          00020165 00000000 41fd2c10 402c7ba0 41fd2c04 40088504 41fe0ca0 40299e21
> > >          00000000 40088a12 41fe0ca0 41fe0ca4 0000020a 00000000 00000001 402ca000
> > >          00000000 41fe0ca0 41fd2c10 41fd2c10 00000000 00000000 402b2388 00000001
> > >          400a0934 40091056 404c9f44 404c9f44 40088db4 402c7ba0 00000001 41fd2c04
> > >          41fe0ca0 41fd2000 41fe0ca0 40089e02 4026ecf4 40089e4e 41fe0ca0 ffffffff
> > > Call Trace:
> > >          [<40088470>] 0x40088470
> > >   [<40088504>] 0x40088504
> > >   [<40088a12>] 0x40088a12
> > >   [<402ca000>] 0x402ca000
> > >   [<400a0934>] 0x400a0934
> > > 
> > > Adjust the memory registration with memblock to include the beginning of
> > > the physical memory and make sure that the area occupied by the kernel is
> > > marked as reserved.
> > > 
> > > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > Acked-by: Greg Ungerer <gerg@linux-m68k.org>
> 
> What path do you anticipate this taking into mainline?
> I see it is still broken in 5.8-rc3.

I thought it will go through m68k tree.

> Regards
> Greg
> 
> 
> 
> > > ---
> > >   arch/m68k/kernel/setup_no.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/m68k/kernel/setup_no.c b/arch/m68k/kernel/setup_no.c
> > > index e779b19e0193..f66f4b1d062e 100644
> > > --- a/arch/m68k/kernel/setup_no.c
> > > +++ b/arch/m68k/kernel/setup_no.c
> > > @@ -138,7 +138,8 @@ void __init setup_arch(char **cmdline_p)
> > >       pr_debug("MEMORY -> ROMFS=0x%p-0x%06lx MEM=0x%06lx-0x%06lx\n ",
> > >            __bss_stop, memory_start, memory_start, memory_end);
> > > -    memblock_add(memory_start, memory_end - memory_start);
> > > +    memblock_add(_rambase, memory_end - _rambase);
> > > +    memblock_reserve(_rambase, memory_start - _rambase);
> > >       /* Keep a copy of command line */
> > >       *cmdline_p = &command_line[0];
> > > 

-- 
Sincerely yours,
Mike.
