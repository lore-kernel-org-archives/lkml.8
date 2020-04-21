Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E70C55186
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77026206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgDUWxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 18:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725850AbgDUWxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 18:53:19 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81917C0610D5;
        Tue, 21 Apr 2020 15:53:19 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CB82D378;
        Tue, 21 Apr 2020 22:53:18 +0000 (UTC)
Date:   Tue, 21 Apr 2020 16:53:17 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Becker <jlbec@evilplan.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 08/29] docs: filesystems: convert configfs.txt to
 ReST
Message-ID: <20200421165317.277f52ee@lwn.net>
In-Reply-To: <20200421172337.GA18305@lst.de>
References: <cover.1587487612.git.mchehab+huawei@kernel.org>
        <278a9befc98b49ea866c9b687d070c70cde20628.1587487612.git.mchehab+huawei@kernel.org>
        <20200421165534.GA16511@lst.de>
        <20200421170223.GP5820@bombadil.infradead.org>
        <20200421172337.GA18305@lst.de>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Apr 2020 19:23:37 +0200
Christoph Hellwig <hch@lst.de> wrote:

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

This sounds sort of like "my markup is good, yours is bad", honestly.  If
somebody were trying to add bracketed headings to a new document, I
suspect we'd get similar complaints.

The markup can certainly be toned down.  If you don't like |copy|, it can
just as easily remain "(c)" or become ©, or just go away entirely.  That
would get rid of the ".. include:: <isonum.txt>" line too.  I would
happily make a rule that we don't bother with markup like |copy|
anywhere in the kernel docs.

The SPDX line is supposed to exist in all files, of course.

If Mauro does that, can you live with "::" to mark a literal block?  It
doesn't seem like a whole lot of noise...?

Thanks,

jon
