Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC8AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0DA52072E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592976582;
	bh=/S29OKDMgCl0SSpstPHAv4cWon8cdKUeMep4TCz4/Pg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=S7QCLDnmf6PnrXMiWVwDiRz3gpIT+YLc/t3kHZA+18WWS5FSqE42xOooVPo0T4sql
	 qEPJ3Sa1AeHD2f7xA638xh8rLVxZkwtnKaV5h2J+QekAwj1AZ3iVVpKo9Q8P6/Ve/G
	 dUCAgL6mv1w7yVgzF3lOQHHqcEI3l7TYZYbzcr+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388898AbgFXF3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 01:29:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbgFXF3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:29:40 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33BC22072E;
        Wed, 24 Jun 2020 05:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592976580;
        bh=/S29OKDMgCl0SSpstPHAv4cWon8cdKUeMep4TCz4/Pg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U2ukEddCkUceHQyvUMpQ1grdM1FN+ISW8dpXspr8gwoAtECxHuXlkPGdYMjlL0mVB
         NA8D6DXeZ13AX/4//oB0ZlSvW30EopwAaIW6xWpprx1VY/D2LPWpMWpyYhijXPyTud
         hsRx6Uz7SvYyfo/+3AYT4RTlFLBxpVDxbCk/8gF8=
Date:   Wed, 24 Jun 2020 07:29:36 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 9/9] docs: staging: use small font for literal
 includes
Message-ID: <20200624072936.3700fae0@coco.lan>
In-Reply-To: <f47454785a47df6758625d52974753d1a519163d.camel@perches.com>
References: <cover.1592905407.git.mchehab+huawei@kernel.org>
        <22bcadb42ba2c391d13a9f8cd1ccfa9349e3b555.1592905407.git.mchehab+huawei@kernel.org>
        <f47454785a47df6758625d52974753d1a519163d.camel@perches.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 23 Jun 2020 16:12:04 -0700
Joe Perches <joe@perches.com> escreveu:

> On Tue, 2020-06-23 at 11:53 +0200, Mauro Carvalho Chehab wrote:
> > The normal font is too big to display 80 columns, causing extra
> > breaks to be added at weird places.
> > 
> > change to the footnotesize, as this would fit a little bit
> > better.  
> []
> > diff --git a/Documentation/staging/index.rst b/Documentation/staging/index.rst  
> []
> > @@ -19,14 +19,41 @@ Unsorted Documentation
> >  Atomic Types
> >  ============
> >  
> > -.. literalinclude:: ../atomic_t.txt
> > +.. raw:: latex
> > +
> > +    \footnotesize
> > +
> > +.. include:: ../atomic_t.txt
> > +   :literal:
> > +
> > +.. raw:: latex
> > +
> > +    \normalsize  
> 
> Is there something like push/pop for styles?
> Maybe some variant of include:: with a style?

Well, one could use, instead:

	.. css-class:: some_footnote_class 

Which should then require a "some_footnote_class" css file defined for
html output and a set of macros to be added at the "latex_elements"
section of conf.py. 

If properly defined, I guess it should be possible to avoid the need
of returning to the normal size after using it.

This is easily said than done.

One of the problems with using such macros is that the macro
should be prepared to work not only with plain text but also with
more complex structures like tables or graphics.

We do need to use tricks like changing the font size on media docs,
in order to display tables with long lines. We have several of them
there, with bit mappings.

I tried a few times to play with that for PDF. I ended needing to 
revert all such attempts[1]. The main problem playing with those is that
You'll end needing to play with the already defined macros found on
sphinx.sty, which is shipped together with Sphinx. The macros there
changed a lot over the time. Making something that would work with
different versions is really hard. 

[1] I used those when I ported media docs from DocBook, but had to
drop several macros because version 1.7 broke the ones I defined.

On that time, I spent several days writing the first version, and,
when they broke, I spent a long time figuring out what would be the
best.

At the end, using the "raw:: latex" like the above was the only
thing that worked reliable among different Sphinx versions.

Thanks,
Mauro
