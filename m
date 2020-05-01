Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15862C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1148206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgEAVn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgEAVn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:43:58 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79507C061A0C;
        Fri,  1 May 2020 14:43:58 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUdRr-00GF1O-Dm; Fri, 01 May 2020 21:43:55 +0000
Date:   Fri, 1 May 2020 22:43:55 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        aaw@google.com
Subject: Re: [PATCH 2/2] exec: open code copy_string_kernel
Message-ID: <20200501214355.GP23230@ZenIV.linux.org.uk>
References: <20200501104105.2621149-1-hch@lst.de>
 <20200501104105.2621149-3-hch@lst.de>
 <20200501125049.GL23230@ZenIV.linux.org.uk>
 <20200501192639.GA25896@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501192639.GA25896@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 09:26:39PM +0200, Christoph Hellwig wrote:
> On Fri, May 01, 2020 at 01:50:49PM +0100, Al Viro wrote:
> > On Fri, May 01, 2020 at 12:41:05PM +0200, Christoph Hellwig wrote:
> > > Currently copy_string_kernel is just a wrapper around copy_strings that
> > > simplifies the calling conventions and uses set_fs to allow passing a
> > > kernel pointer.  But due to the fact the we only need to handle a single
> > > kernel argument pointer, the logic can be sigificantly simplified while
> > > getting rid of the set_fs.
> > 
> > I can live with that...  BTW, why do we bother with flush_cache_page() (by
> > way of get_arg_page()) here and in copy_strings()?  How could *anything*
> > have accessed that page by its address in new mm - what are we trying to
> > flush here?
> 
> s/get_arg_page/flush_arg_page/ ?

of course - sorry...

> No idea, what the use case is, but this comes from:
> 
> commit b6a2fea39318e43fee84fa7b0b90d68bed92d2ba
> Author: Ollie Wild <aaw@google.com>
> Date:   Thu Jul 19 01:48:16 2007 -0700
> 
>     mm: variable length argument support

I know.  And it comes with no explanations in there ;-/  AFAICS, back then
the situation hadn't been any different - mm we are inserting the arg pages
into is not active, so there shouldn't be anything in anyone's cache for
that virtual address in that vma...
