Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1386CC55185
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7BC1206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgDUWjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 18:39:48 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51534 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726061AbgDUWjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 18:39:47 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03LMdGMJ026666
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Apr 2020 18:39:16 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D771542030C; Tue, 21 Apr 2020 18:39:15 -0400 (EDT)
Date:   Tue, 21 Apr 2020 18:39:15 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Becker <jlbec@evilplan.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 08/29] docs: filesystems: convert configfs.txt to ReST
Message-ID: <20200421223915.GA4278@mit.edu>
References: <cover.1587487612.git.mchehab+huawei@kernel.org>
 <278a9befc98b49ea866c9b687d070c70cde20628.1587487612.git.mchehab+huawei@kernel.org>
 <20200421165534.GA16511@lst.de>
 <20200421170223.GP5820@bombadil.infradead.org>
 <20200421172337.GA18305@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421172337.GA18305@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 07:23:37PM +0200, Christoph Hellwig wrote:
> On Tue, Apr 21, 2020 at 10:02:23AM -0700, Matthew Wilcox wrote:
> > On Tue, Apr 21, 2020 at 06:55:34PM +0200, Christoph Hellwig wrote:
> > > NAK, this makes the document significantly harder to read.
> > 
> > Really?  It reads more easily to me in the new format.  Enclosing
> > section headers in [] is really weird.
> 
> It wasn't entirely uncommon, but that's not really the point.  The
> Problem is all the weird ".." or "::" annotations that really kill
> the flow, or things like "|copy|" that have no reason to exist.

FWIW, I consider the rst transformations to be an improvement, even
when reading them as a text mode.

				- Ted

