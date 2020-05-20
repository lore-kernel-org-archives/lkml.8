Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A81C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49161207F9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590018981;
	bh=b+7RuEJNy8D/QcJ0wriRra2UVUAspE2s+m1lbqHAsB0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=dEpZ0p93ZhT+2OhMp04jynWLAkYlwSPweCgddyVmwjZ5UNNRAQ/rtXcSTDEKUfnUx
	 lID9lMjd5+gS8+7tneuEDnXYpOUCfrjkllAwo7WjlIzQ04CJh32lq2hAlRuHM+MnIq
	 mJ8coyDNAdq7Ff7wdJmjy1g17zISV4NDXCQV615Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgETX4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:56:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgETX4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:56:20 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7773220708;
        Wed, 20 May 2020 23:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590018979;
        bh=b+7RuEJNy8D/QcJ0wriRra2UVUAspE2s+m1lbqHAsB0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=l2UoEQEzsRADKyvFaNG6S8GjntlJDaSWSTSicqkJe5Jzsc4y5ZqffdC9pc/WobvTJ
         XDhda7d9E/z8h6aUD/kiErxVMDFOwyqPxeOOewgJg/JGosWUhzo7V6kpi1O13U8R84
         6SGCtDLy2ymm24kRznYs+6GNzvx50a6okZAfHW6Q=
Date:   Wed, 20 May 2020 16:56:19 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Roman Shaposhnik <roman@zededa.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        Xen-devel <xen-devel@lists.xenproject.org>,
        linux-kernel@vger.kernel.org, tamas@tklengyel.com
Subject: Re: [PATCH 00/10] fix swiotlb-xen for RPi4
In-Reply-To: <CAMmSBy9VBxjSCRcfyiZ-RY8eyYOooeNfCqrvirhWzfpSbAQyuw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2005201653310.27502@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s> <CAMmSBy9VBxjSCRcfyiZ-RY8eyYOooeNfCqrvirhWzfpSbAQyuw@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020, Roman Shaposhnik wrote:
> On Wed, May 20, 2020 at 4:45 PM Stefano Stabellini
> <sstabellini@kernel.org> wrote:
> >
> > Hi all,
> >
> > This series is a collection of fixes to get Linux running on the RPi4 as
> > dom0.
> >
> > Conceptually there are only two significant changes:
> >
> > - make sure not to call virt_to_page on vmalloc virt addresses (patch
> >   #1)
> > - use phys_to_dma and dma_to_phys to translate phys to/from dma
> >   addresses (all other patches)
> >
> > In particular in regards to the second part, the RPi4 is the first
> > board where Xen can run that has the property that dma addresses are
> > different from physical addresses, and swiotlb-xen was written with the
> > assumption that phys addr == dma addr.
> >
> > This series adds the phys_to_dma and dma_to_phys calls to make it work.
> 
> Great to see this! Stefano, any chance you can put it in a branch some place
> so I can test the final version?

Here it is, but keep in mind that it is based on Linux master (because
it is meant to go upstream):

  git://git.kernel.org/pub/scm/linux/kernel/git/sstabellini/xen.git fix-rip4-v1
