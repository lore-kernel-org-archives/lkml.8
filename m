Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78D3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADADC2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598544421;
	bh=C25A5gWOyTwDkHaFdc3/vV0orgCo2bZHjdJ20mTjRfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xLVoXOTDWUMGSj2oXhmYK0VAoZWts7WVpe+E6XKTI1mk/mTzqeBsSZxTEhsIRFtzX
	 pOgEuI9WgW3yTIDrqz5aONqnRwiOT3UCSuEMUkaOEfdyjX5bDhoN0UOh29UzVSIuma
	 n+qlgpaZQRMi5vDEfUAtj9opxvpyYtwe+P+BsYLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgH0QHA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:07:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgH0QG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:06:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A22732080C;
        Thu, 27 Aug 2020 16:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598544419;
        bh=C25A5gWOyTwDkHaFdc3/vV0orgCo2bZHjdJ20mTjRfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r+HxZN3olu9nbrfh+nSElrtVYdvQuEnYmOldVYdxtXZ4Gr/93NfYCgbiG+Xt/q1+w
         yJT6HyWx6v37QVxzjyz+y9gB1jofObpbMYw0ZhEUq3ycZVDItQsMVfwBGx67qyMjZY
         I+Yv9kQ/Oq7CtzA4FFTYG286Qr51dr6Ubr9nz5yI=
Date:   Thu, 27 Aug 2020 18:07:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Security Officers <security@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add security docs to SECURITY CONTACT
Message-ID: <20200827160712.GD684514@kroah.com>
References: <20200827131330.3732-1-krzk@kernel.org>
 <20200827131827.GA546898@kroah.com>
 <20200827132016.GA4384@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827132016.GA4384@kozik-lap>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 03:20:16PM +0200, Krzysztof Kozlowski wrote:
> On Thu, Aug 27, 2020 at 03:18:27PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Aug 27, 2020 at 03:13:30PM +0200, Krzysztof Kozlowski wrote:
> > > When changing the documents related to kernel security workflow, notify
> > > the security mailing list as its concerned by this.
> > > 
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > > ---
> > >  MAINTAINERS | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 8107b3d5d6df..a1e07d0f3205 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -15620,6 +15620,8 @@ F:	include/uapi/linux/sed*
> > >  
> > >  SECURITY CONTACT
> > >  M:	Security Officers <security@kernel.org>
> > > +F:	Documentation/admin-guide/security-bugs.rst
> > > +F:	Documentation/process/embargoed-hardware-issues.rst
> > 
> > The hardware-issues document is "owned" by a different group of
> > suckers^Wdevelopers, that is independant of security@k.o, so that file
> > shouldn't be added to them here.
> 
> True, but isn't this broader security group involved in designing and
> discussing the HW security process?

While I think a number of the people did overlap, it was not everyone as
the processes are _VERY_ different for obvious reasons.

So please keep it separate for now.  There is a list of people who care
about this document, in the document itself, if anyone ever wants to
send changes to it.  No need to enumerate them all in the MAINTAINERS
file.

thanks,

greg k-h
