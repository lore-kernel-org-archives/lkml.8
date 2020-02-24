Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195FDC38BE2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E589E20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oZiPir4x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgBXVKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:10:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52568 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbgBXVKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=L0GIM9MAsSIaJJiexM0xuoxKVH/JVljqr41EeL13Z0g=; b=oZiPir4xFnYRx0BLoPhBMvRQvU
        V2Tqtk080yr3krPKTvNMG68B26yasVH+F5S2xLrS1PuijKxvfc/3P2oKVTTbOY8eZTLoANQ4Eulkm
        RrpnaIPipGkPUvZE0xa9wy0Agla7DdEbmPTa5IjoXQZ8fekzdNHtgJYhxgZ41X3vXL7eVCUNMNZt1
        V2Gr7rARQa3KZCFAySIv7eh/BNc9MLOj7fssjEOir6qfNbqXhAj7YxY6cx/k3NR7Ps/dGRKRBXhuA
        PlapI3r6HoV1kgfepTRY8bTgHEzez+spvlYPJUXSl+aNh+H8E0LlCauWnxvvSCJAMdlDhL8jVa2iK
        pALRl0Tw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6L00-0002hH-4Z; Mon, 24 Feb 2020 21:10:44 +0000
Date:   Mon, 24 Feb 2020 13:10:44 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        linux-doc@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: process: changes.rst: Escape --version to fix
 Sphinx output
Message-ID: <20200224211044.GQ24185@bombadil.infradead.org>
References: <20200223222228.27089-1-j.neuschaefer@gmx.net>
 <20200224110815.6f7561d1@lwn.net>
 <20200224184719.GA2363@latitude>
 <20200224185227.GO24185@bombadil.infradead.org>
 <20200224115851.6684d516@lwn.net>
 <20200224191248.GP24185@bombadil.infradead.org>
 <e31ce703-c88b-7901-60a7-62fd5e78a1e0@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e31ce703-c88b-7901-60a7-62fd5e78a1e0@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 01:08:13PM -0800, Randy Dunlap wrote:
> On 2/24/20 11:12 AM, Matthew Wilcox wrote:
> > On Mon, Feb 24, 2020 at 11:58:51AM -0700, Jonathan Corbet wrote:
> >> On Mon, 24 Feb 2020 10:52:27 -0800
> >> Matthew Wilcox <willy@infradead.org> wrote:
> >>
> >>> On Mon, Feb 24, 2020 at 07:47:19PM +0100, Jonathan Neuschäfer wrote:
> >>>> On Mon, Feb 24, 2020 at 11:08:15AM -0700, Jonathan Corbet wrote:  
> >>>>> On Sun, 23 Feb 2020 23:22:27 +0100
> >>>>> Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:
> >>>>>   
> >>>>>> Without double-backticks, Sphinx wrongly turns "--version" into
> >>>>>> "–version" with a Unicode EN DASH (U+2013), that is visually easy to
> >>>>>> confuse with a single ASCII dash.
> >>>>>>
> >>>>>> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>  
> >>>>>
> >>>>> This certainly seems worth addressing.  But I would *really* rather find
> >>>>> a way to tell Sphinx not to do that rather than making all of these
> >>>>> tweaks - which we will certainly find ourselves having to do over and
> >>>>> over again.  I can try to look into that in a bit, but if somebody were
> >>>>> to beat me to it ... :)  
> >>>>
> >>>> This seems to do the trick:
> >>>>
> >>>> diff --git a/Documentation/conf.py b/Documentation/conf.py
> >>>> index 3c7bdf4cd31f..8f2a7ae95184 100644
> >>>> --- a/Documentation/conf.py
> >>>> +++ b/Documentation/conf.py
> >>>> @@ -587,6 +587,9 @@ pdf_documents = [
> >>>>  kerneldoc_bin = '../scripts/kernel-doc'
> >>>>  kerneldoc_srctree = '..'
> >>>>
> >>>> +# Render -- as two dashes
> >>>> +smartquotes = False  
> >>>
> >>> I think what Jon was looking for was the ability to selectively turn
> >>> smartquotes off for a section and then reenable it?
> >>
> >> No that's not what I was thinking, actually.  Unless somebody can come up
> >> with a good reason to the contrary, just disabling that behavior globally
> >> strikes me as the right thing to do.
> > 
> > Well, sometimes -- when the time is right -- I like to use en-dashes.
> > It's probably no great loss, though.
> > 
> > grep finds me these interesting examples:
> > 
> > Documentation/RCU/Design/Memory-Ordering/Tree-RCU-Memory-Ordering.rst:Tree RCU's grace--period memory-ordering guarantees rely most heavily on
> > Documentation/accounting/psi.rst:scarcity aids users in sizing workloads to hardware--or provisioning
> > Documentation/admin-guide/acpi/cppc_sysfs.rst:  -r--r--r-- 1 root root 65536 Mar  5 19:38 feedback_ctrs
> > Documentation/admin-guide/mm/hugetlbpage.rst:task that modifies ``nr_hugepages``. The default for the allowed nodes--when the
> > Documentation/block/null_blk.rst:home_node=[0--nr_nodes]: Default: NUMA_NO_NODE
> > Documentation/admin-guide/svga.rst::Copyright: |copy| 1995--1999 Martin Mares, <mj@ucw.cz>
> > Documentation/media/uapi/v4l/pixfmt-srggb10-ipu3.rst:        G\ :sub:`0108high`\ (bits 1--0)
> > 
> > (in all, 368 lines, but they're not all in .rst files)
> > 
> 
> Not trying to be contrary, but I would prefer to keep .rst files as much
> ASCII as possible.

I don't think anybody is arguing otherwise.  The question is whether
minusminus should be left as a pair of minus signs or whether it should
be converted into an en-dash.
