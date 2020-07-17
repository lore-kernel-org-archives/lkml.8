Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F230C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7508520734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgGQGue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:50:34 -0400
Received: from verein.lst.de ([213.95.11.211]:37461 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbgGQGud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:50:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C7D3168BEB; Fri, 17 Jul 2020 08:50:30 +0200 (CEST)
Date:   Fri, 17 Jul 2020 08:50:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the sound tree
Message-ID: <20200717065030.GA10829@lst.de>
References: <20200717130112.469f8f8f@canb.auug.org.au> <20200717053324.GA9319@lst.de> <s5h8sfilke0.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5h8sfilke0.wl-tiwai@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 08:34:47AM +0200, Takashi Iwai wrote:
> On Fri, 17 Jul 2020 07:33:24 +0200,
> Christoph Hellwig wrote:
> > 
> > On Fri, Jul 17, 2020 at 01:01:12PM +1000, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > After merging the sound tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > 
> > No, the sound commit needs to be reverted.  Drivers has absolutely not
> > business poking into DMA layer internals.
> 
> OK, I'll drop that stuff again.  It was the thing posted in the thread
> of DMA regression with AMD SEV on 5.8-rc1.  Meanwhile it was fixed in
> the proper Kconfig dependency.

We have other x86 changes that will not support just remapping stuff
ignoring the API in the pipe, so this will need to get sorted out.  And
with that I mean sorted out properly instead of poking into undocumented
DMA API internals and coming to the wrong conclusions again..
