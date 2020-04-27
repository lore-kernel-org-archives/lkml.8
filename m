Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6748C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8000E20775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 21:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588021734;
	bh=OE1L3adloJPBNIWK7KMwVjp8IfJnonnlx6M5z4vCT00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lS7kN13kipOPAR3mPvm0tJPLH3qApqy0eNCuzkxZ//nglgbP6Xr70rr9kf8o3L/8o
	 0qgi3AzyQVp9U//ukkiMTgA7BaQ6xzz6WR+XofJtUvJT2wUEuS1S+nSucuCF2/YWu+
	 H8yd1cu+19EO+rZc62n3gYK6qkSwZ0xdCgXE5Zo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgD0VIx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 17:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726285AbgD0VIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:08:51 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D382206BF;
        Mon, 27 Apr 2020 21:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588021731;
        bh=OE1L3adloJPBNIWK7KMwVjp8IfJnonnlx6M5z4vCT00=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BqpRmjaFGMXdVnyWXrXObfrVvHfw0wsJU66EKo5OWVhewGtILMhWeFtnjixp5iktE
         Gl+BaGZBsahbePMkmaMUBIyzCPKLCRsGZNX+L5+vZxcPOgE4Oj23C8j4IUTTJv9Yd5
         WqPCMR+uLOlK8ocLaP8BT6KZovtXt7E91neN1GhQ=
Date:   Mon, 27 Apr 2020 23:08:45 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Becker <jlbec@evilplan.org>, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 08/29] docs: filesystems: convert configfs.txt to
 ReST
Message-ID: <20200427230845.6716e945@coco.lan>
In-Reply-To: <20200421165317.277f52ee@lwn.net>
References: <cover.1587487612.git.mchehab+huawei@kernel.org>
        <278a9befc98b49ea866c9b687d070c70cde20628.1587487612.git.mchehab+huawei@kernel.org>
        <20200421165534.GA16511@lst.de>
        <20200421170223.GP5820@bombadil.infradead.org>
        <20200421172337.GA18305@lst.de>
        <20200421165317.277f52ee@lwn.net>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 21 Apr 2020 16:53:17 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Tue, 21 Apr 2020 19:23:37 +0200
> Christoph Hellwig <hch@lst.de> wrote:
>=20
> > On Tue, Apr 21, 2020 at 10:02:23AM -0700, Matthew Wilcox wrote: =20
> > > On Tue, Apr 21, 2020 at 06:55:34PM +0200, Christoph Hellwig wrote:   =
=20
> > > > NAK, this makes the document significantly harder to read.   =20
> > >=20
> > > Really?  It reads more easily to me in the new format.  Enclosing
> > > section headers in [] is really weird.   =20
> >=20
> > It wasn't entirely uncommon, but that's not really the point.  The
> > Problem is all the weird ".." or "::" annotations that really kill
> > the flow, or things like "|copy|" that have no reason to exist. =20
>=20
> This sounds sort of like "my markup is good, yours is bad", honestly.  If
> somebody were trying to add bracketed headings to a new document, I
> suspect we'd get similar complaints.
>=20
> The markup can certainly be toned down.  If you don't like |copy|, it can
> just as easily remain "(c)" or become =C2=A9, or just go away entirely.  =
That
> would get rid of the ".. include:: <isonum.txt>" line too.  I would
> happily make a rule that we don't bother with markup like |copy|
> anywhere in the kernel docs.
>=20
> The SPDX line is supposed to exist in all files, of course.
>=20
> If Mauro does that, can you live with "::" to mark a literal block?  It
> doesn't seem like a whole lot of noise...?

Yeah, I can remove most of the markups, preserving the "::".

Will send a new patchset in a few.

Thanks,
Mauro
