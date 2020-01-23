Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F99AC33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 08:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BB22467B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 08:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579769331;
	bh=h8c6qpoT6AS+fP+75iEFRN1LQXuDvKgxp9gV8ORoSKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xBXeDosE9hsZkH1SGJkKVVJ67NK9QIsL4Qt91uFzZ09Lm0WCOX04yH6V3tcRU7jZH
	 xs+DuKmhrAMOXdpEj3uCtGjRPP26hwiFEBV9UNb8DK9wHtg5iEJi1uZ2wh+7W28U1u
	 dmg9s57reEHwBMZejipPnj4nmbyeuM6HruG/kvF0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgAWIsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 03:48:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:57060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgAWIst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 03:48:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E86D92087E;
        Thu, 23 Jan 2020 08:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579769329;
        bh=h8c6qpoT6AS+fP+75iEFRN1LQXuDvKgxp9gV8ORoSKU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VTCqSkZsZugphWWeexxmwJrhAfBtkjFQKo7j2NEZyK9DETb5IvMOLqUUvGzVsn5Al
         tC+R8rjcjHv9OWOmg/Syf6vNfoA/hu8GnDyvH/uwZJojmYVQkxl7K0v0QPjDmEgB0I
         xpZxtefgMvruErtQTyVKL8ghBPPq10SnmoLTU/DA=
Date:   Thu, 23 Jan 2020 09:48:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jason Baron <jbaron@akamai.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3] dynamic_debug: allow to work if debugfs is disabled
Message-ID: <20200123084847.GA435637@kroah.com>
References: <20200122074343.GA2099098@kroah.com>
 <20200122080352.GA15354@willie-the-truck>
 <20200122081205.GA2227985@kroah.com>
 <20200122135352.GA9458@kroah.com>
 <8d68b75c-05b8-b403-0a10-d17b94a73ba7@akamai.com>
 <20200122192940.GA88549@kroah.com>
 <20200122193118.GA88722@kroah.com>
 <ef1172ac-ea78-146e-575e-93e2d65b4606@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef1172ac-ea78-146e-575e-93e2d65b4606@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 01:43:46PM -0800, Randy Dunlap wrote:
> Hi Greg,
> 
> If you make any more changes:
> 
> On 1/22/20 11:31 AM, Greg Kroah-Hartman wrote:
> > diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> > index 252e5ef324e5..41f43a373a6a 100644
> > --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> > +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> > @@ -54,6 +54,9 @@ If you make a mistake with the syntax, the write will fail thus::
> >  				<debugfs>/dynamic_debug/control
> >    -bash: echo: write error: Invalid argument
> >  
> > +Note, for systems without 'debugfs' enabled, the control file can be
> > +also found in ``/proc/dynamic_debug/control``.
> 
> Mostly drop the "also".  How about:
> 
> > +Note, for systems without 'debugfs' enabled, the control file is located
> > +in ``/proc/dynamic_debug/control``.

Much nicer, I'll respin it with this change, thanks for the review!

greg k-h
