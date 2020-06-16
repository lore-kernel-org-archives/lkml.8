Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2F6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE9E420810
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 07:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592291973;
	bh=pF2mfGeuTkIK61PJYe3gXKNT6PbuRpb4orz5pBUOhmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=g0Fhsp+73WYYYYgI/lL83abfmvbZ9H9Z5c/tfBQx65IZYrZ2Z1oISZpgypbxnarp2
	 X5BeGk/9rGws7Z7uUf+iobLseIwRerk+XxiNkHUmKlLchStzn8+XDzQyJu2RthZACK
	 OssVcevcH2JlzYTA/nMnqoIvrVSsUFF99U8K7ZlQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgFPHTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 03:19:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgFPHTb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:19:31 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7221C2074D;
        Tue, 16 Jun 2020 07:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592291971;
        bh=pF2mfGeuTkIK61PJYe3gXKNT6PbuRpb4orz5pBUOhmE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n9cT4V7heVaz5IdegaMJZXPMwCjuvW6FuRHJDN4vPy7mW1xeGuYsQXbymEeEH6OCE
         f0Cu5jrNv2B/Y4GOWKYrhq5h3Vexr64UQntCwLmu1hvI0NNKx99q7XZzsBIz9I5jJk
         RNgU/3BQJwpMKISQbylgwLNcG0oxzahEl7uqLZ/Q=
Date:   Tue, 16 Jun 2020 09:19:26 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-spdx@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [PATCH 18/22] docs: trace: ring-buffer-design.txt: convert to
 ReST format
Message-ID: <20200616091926.7f109860@coco.lan>
In-Reply-To: <4e00b2fa91f1f818de4658f2695d4b433852959d.camel@perches.com>
References: <cover.1592203650.git.mchehab+huawei@kernel.org>
        <c11ee0be2bf63626887d7cd38e7572b31e2a2ce2.1592203650.git.mchehab+huawei@kernel.org>
        <4e00b2fa91f1f818de4658f2695d4b433852959d.camel@perches.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 15 Jun 2020 10:48:10 -0700
Joe Perches <joe@perches.com> escreveu:

> On Mon, 2020-06-15 at 08:50 +0200, Mauro Carvalho Chehab wrote:
> > - Just like some media documents, this file is dual licensed
> >   with GPL and GFDL. As right now the GFDL SPDX definition is
> >   bogus (as it doesn't tell anything about invariant parts),
> >   let's not use SPDX here. Let's use, instead, the same test
> >   as we have on media. =20
> []
> > diff --git a/Documentation/trace/ring-buffer-design.txt b/Documentation=
/trace/ring-buffer-design.rst
> > []
> > +.. Or, alternatively,
> > +..
> > +.. b) Permission is granted to copy, distribute and/or modify this
> > +..    document under the terms of the GNU Free Documentation License,
> > +..    Version 1.1 or any later version published by the Free Software
> > +..    Foundation, with no Invariant Sections, no Front-Cover Texts
> > +..    and no Back-Cover Texts. A copy of the license is available at
> > +..    https://www.gnu.org/licenses/old-licenses/fdl-1.2.html =20
>=20
> Use of a version 1.1 reference with a 1.2 link.

Right. I'll fix it.

>=20
> Perhaps the link should be:
> https://www.gnu.org/licenses/old-licenses/fdl-1.1.html
>=20
> > +..
> > +.. TODO: replace it to GPL-2.0 OR GFDL-1.2-or-later WITH no-invariant-=
sections =20
>=20
> Is there some reason a new GFDL entry has not yet been added
> to the LICENSES directory?

Yes:

	https://github.com/spdx/license-list-XML/issues/686
	https://github.com/spdx/license-list-XML/issues/970

In summary, GFDL can either be a free or non-free license, depending
on having or not "invariant sections", but SPDX spec is incomplete on
that matter.

=46rom the discussions, it *seems* that we'll end having a SPDX header
like:=20

	GFDL-1.2-or-later-no-invariant	https://github.com/spdx/license-list-XML/mi=
lestone/12


But the discussion is still open, and so far there's no such tag.
So, we'll need to keep track at the above issues, until they finally
create the new ones.

It sounds that this is expected to happen on SPDX version 3.10:

	https://github.com/spdx/license-list-XML/milestone/12

Btw, thanks for asking. I just added some comments there, in order
to indicate what it is needed for the Linux Kernel.

Thanks,
Mauro
