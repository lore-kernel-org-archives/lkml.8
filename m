Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6971C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78A762073B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 20:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590179783;
	bh=IK1thAcWlCaqCoeU+81mOVb4TLhtZ5VdD8ydtfEDSgs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=Zd8qhRv/B5rcVxu+HA07eJeS+bWIhTuucfsMyMzUCgdjsRsFu1AZrHbj+3yn7nlzc
	 vylq7QE8apgTFytctllXJwSAYNpr6feWuCiNn0vWQ2pag3RNKrvZd5KZHzbSrTENHG
	 je3SbEm3BXyR//2Fv4H+OdRsyyrivCSRJGWtaCl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbgEVUgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 16:36:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730976AbgEVUgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 16:36:21 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAB8C20723;
        Fri, 22 May 2020 20:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590179781;
        bh=IK1thAcWlCaqCoeU+81mOVb4TLhtZ5VdD8ydtfEDSgs=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=RmpDsrr5nt9VA49OfsdkCWmcG0mYVN1lGMYIb4+IQoZLGBtI/9xzwXOBng+nnnv/q
         s+CeSUi8X84jzr1XX2my8nGSl5T199PQ2Se5rhGEzgd8/K3xyp86L02PEim92xLt+R
         WdnSgson2U54CaVck5NBfmV5zlQWQ3kK7kcOlk7U=
Date:   Fri, 22 May 2020 13:36:20 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Julien Grall <julien@xen.org>
cc:     Stefano Stabellini <sstabellini@kernel.org>, jgross@suse.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH 01/10] swiotlb-xen: use vmalloc_to_page on vmalloc virt
 addresses
In-Reply-To: <a7f1d5c1-1ee1-61e3-22be-1db4dced08eb@xen.org>
Message-ID: <alpine.DEB.2.21.2005221329590.27502@sstabellini-ThinkPad-T480s>
References: <alpine.DEB.2.21.2005201628330.27502@sstabellini-ThinkPad-T480s> <20200520234520.22563-1-sstabellini@kernel.org> <23e5b6d8-c5d9-b43f-41cd-9d02d8ec0a7f@xen.org> <alpine.DEB.2.21.2005211235590.27502@sstabellini-ThinkPad-T480s>
 <a7f1d5c1-1ee1-61e3-22be-1db4dced08eb@xen.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 May 2020, Julien Grall wrote:
> Hi Stefano,
> 
> On 22/05/2020 04:54, Stefano Stabellini wrote:
> > On Thu, 21 May 2020, Julien Grall wrote:
> > > Hi,
> > > 
> > > On 21/05/2020 00:45, Stefano Stabellini wrote:
> > > > From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > > > 
> > > > Don't just assume that virt_to_page works on all virtual addresses.
> > > > Instead add a is_vmalloc_addr check and use vmalloc_to_page on vmalloc
> > > > virt addresses.
> > > 
> > > Can you provide an example where swiotlb is used with vmalloc()?
> > 
> > The issue was reported here happening on the Rasperry Pi 4:
> > https://marc.info/?l=xen-devel&m=158862573216800
> 
> Thanks, it would be good if the commit message contains a bit more details.
> 
> > 
> > If you are asking where in the Linux codebase the vmalloc is happening
> > specifically, I don't know for sure, my information is limited to the
> > stack trace that you see in the link (I don't have a Rasperry Pi 4 yet
> > but I shall have one soon.)
> 
> Looking at the code there is a comment in xen_swiotlb_alloc_coherent()
> suggesting that xen_alloc_coherent_pages() may return an ioremap'ped region on
> Arm. So it feels to me that commit b877ac9815a8fe7e5f6d7fdde3dc34652408840a
> "xen/swiotlb: remember having called xen_create_contiguous_region()" has
> always been broken on Arm.

Yes, I think you are right


> As an aside, your commit message also suggests this is an issue for every
> virtual address used in swiotlb. But only the virt_to_page() call in
> xen_swiotlb_free_coherent() is modified. Is it intended? If yes, I think you
> want to update your commit message.

I see, yes I can explain better

