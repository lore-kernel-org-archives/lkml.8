Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9FBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF1320767
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592900701;
	bh=hlJ9LORbnEGGoe61FJRAAwA6gCTDCRI6rwTib7m7SFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Wktiv4ka4U50JPQg3UR9pUWxoNuDqoWxL9RY06U+AtW/QhCk8fHOwTeV5RAe/FW5F
	 qoSB+WQbZ5qVrb+c08dK2T4+US+MpQF7cpj6xvWh8Mi61AKkVNulqvkpXJG69vPt1/
	 ajhbJybgpbznfrV8IMhy+xqQp1sFxibI6WASx2qU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731732AbgFWIY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:24:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:51916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731567AbgFWIY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:24:59 -0400
Received: from coco.lan (unknown [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43FEE2072E;
        Tue, 23 Jun 2020 08:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592900698;
        bh=hlJ9LORbnEGGoe61FJRAAwA6gCTDCRI6rwTib7m7SFU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JPNdRhZBYg7QeDl5hOx4AJ7HAdJPHLP3k/shl92PI6pXgDw+Kncj4Cv0dqYcK/7/Y
         EhEvrtC3isHRy3poyej0xQyl3LSpY/jIZlZ4FgEp7SQV0KiFQwRwClDMR+4ZGoxMRU
         rcmEsa4hJtnTG/dpgAPMqgquFDNRgjCgWbFrEozw=
Date:   Tue, 23 Jun 2020 10:24:54 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/22] docs: trace: ring-buffer-design.txt: convert to
 ReST format
Message-ID: <20200623102454.4ca57b61@coco.lan>
In-Reply-To: <20200619164114.00379740@oasis.local.home>
References: <cover.1592203650.git.mchehab+huawei@kernel.org>
        <c11ee0be2bf63626887d7cd38e7572b31e2a2ce2.1592203650.git.mchehab+huawei@kernel.org>
        <20200619141329.3867e57e@lwn.net>
        <20200619164114.00379740@oasis.local.home>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 19 Jun 2020 16:41:14 -0400
Steven Rostedt <rostedt@goodmis.org> escreveu:

> On Fri, 19 Jun 2020 14:13:29 -0600
> Jonathan Corbet <corbet@lwn.net> wrote:
> 
> > On Mon, 15 Jun 2020 08:50:23 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > 
> > [CC += Steve]  
> 
> Thanks.
> 
> >   
> > > - Just like some media documents, this file is dual licensed
> > >   with GPL and GFDL. As right now the GFDL SPDX definition is
> > >   bogus (as it doesn't tell anything about invariant parts),
> > >   let's not use SPDX here. Let's use, instead, the same test
> > >   as we have on media.    
> > 
> > The dual-licensing really can't be expressed with an SPDX tag?  Because...  
> 
> A SPDX dual license should be possible, as it's used for GPL and BSD in
> several locations.

Until one week ago, this was not possible, because SPDX headers
were broken for GFDL:

	https://github.com/spdx/license-list-XML/issues/686
	https://github.com/spdx/license-list-XML/issues/970

There are 2 types of GFDL licenses:
	- a Free license where the entire document allows
	  reviewing/changing;
	- a non-free variant, were some parts of the document
	  have a non-free license, where only the author can
	  change (called invariant parts).

Basically, some distro policies don't allow shipping documents
under the non-free version of GFDL.

The SPDX spec (up to version 3.9) doesn't allow differentiating
between them.

-

There's now an upstream patch (at SPDX) to be merged on the upcoming
versin 3.10 that will allow us to finally get rid of those:

	https://github.com/spdx/license-list-XML/pull/1048/commits/f695d2ac65230d0f4161ba58fff2f9d87bb5a053#diff-b948674e5c5cf6341e44e76b2565e80c

The GFDL-1.2 with no invariant sections is defined as:

	<SPDXLicenseCollection xmlns="http://www.spdx.org/license">
	  <license licenseId="GFDL-1.2-only-no-invariants" isOsiApproved="false"
	  name="GNU Free Documentation License v1.2 only - no invariants">
	    <crossRefs>
	      <crossRef>https://www.gnu.org/licenses/old-licenses/fdl-1.2.txt</crossRef>
	    </crossRefs>
	    <standardLicenseHeader>
	      Copyright (c) <alt name="copyright" match=".+">YEAR YOUR NAME</alt>.
	      Permission is granted to copy, distribute and/or modify this
	      document under the terms of the GNU Free Documentation License,
	      Version 1.2; with no Invariant Sections, no Front-Cover Texts,
	      and no Back-Cover Texts. A copy of the license is included
	      in the section entitled "GNU Free Documentation License".
	    </standardLicenseHeader>
	    <notes>
	      This license was released November 2002. The identifier 
	      GFDL-1.2-only-no-invariants should only be used when there are 
	      no Invariant Sections, Front-Cover Texts or Back-Cover Texts. 
	      See GFDL-1.2-only and GFDL-1.2-only-invariants for alternatives.
	    </notes>

> 
> > 
> > [...]
> >   
> > > +.. This file is dual-licensed: you can use it either under the terms
> > > +.. of the GPL 2.0 or the GFDL 1.2+ license, at your option. Note that this  
> 
> And I never said GFDL 1.2+

Ah, right. I'll fix it.

> 
>  Copyright 2009 Red Hat Inc.                                                                                                                                                                  
> -   Author:   Steven Rostedt <srostedt@redhat.com>                                                                                                                                            
> -  License:   The GNU Free Documentation License, Version 1.2                                                                                                                                 
> -               (dual licensed under the GPL v2)                                                                                                                                              
> -Reviewers:   Mathieu Desnoyers, Huang Ying, Hidetoshi Seto,
> 
> There is no "+" sign here.
> 
> 
> > > +.. dual licensing only applies to this file, and not this project as a
> > > +.. whole.
> > > +..
> > > +.. a) This file is free software; you can redistribute it and/or
> > > +..    modify it under the terms of the GNU General Public License as
> > > +..    published by the Free Software Foundation version 2 of
> > > +..    the License.
> > > +..
> > > +..    This file is distributed in the hope that it will be useful,
> > > +..    but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > +..    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > +..    GNU General Public License for more details.
> > > +..
> > > +.. Or, alternatively,
> > > +..
> > > +.. b) Permission is granted to copy, distribute and/or modify this
> > > +..    document under the terms of the GNU Free Documentation License,
> > > +..    Version 1.1 or any later version published by the Free Software
> > > +..    Foundation, with no Invariant Sections, no Front-Cover Texts
> > > +..    and no Back-Cover Texts. A copy of the license is available at
> > > +..    https://www.gnu.org/licenses/old-licenses/fdl-1.2.html
> > > +..
> > > +.. TODO: replace it to GPL-2.0 OR GFDL-1.2-or-later WITH no-invariant-sections    
> 
>   "GPL-2.0 OR GFDL-1.2"

It should actually be:

	"GPL-2.0 OR GFDL-1.2-only-no-invariants"

Thanks,
Mauro
