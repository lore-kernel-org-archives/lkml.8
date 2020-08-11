Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBE0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52765206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597134129;
	bh=OO4EFsjzGd5rJJD96iMXdQbduCLY6udj+WhtnpLUMwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fMMIOHXYZdRdnCboe8rp3C/lMXP9x/N8gXZMFt85hm1OIH8/cqjKc02+Ojo7UxvO2
	 mukmPjrEP6oamH9xBcLsv0vRYsHi/xT19y+5/me6hq9gvKIhomD5vg4XphGQUbVt1O
	 dwjZTmRTyueQNRzRgVVAobFNPgKHACkS6rSzXEPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbgHKIWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 04:22:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:44706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728224AbgHKIWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 04:22:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27FBA20678;
        Tue, 11 Aug 2020 08:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597134127;
        bh=OO4EFsjzGd5rJJD96iMXdQbduCLY6udj+WhtnpLUMwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pDYWFW5ruzmAim++Kx+opDGkJFlIhoreqAMoPelwQd2iYWSIhO5XBY2/eSyhyEDDB
         zpJ4cWJFVsY3nXk11DpD5mq6Z+Rjve+4bJJYzJ+6eEQo+DtnrPRR5sraJu6IKqbY0B
         pQmalgYjKPXmHqt1qjOoUr2DYl40G0h5AeCjcpyg=
Date:   Tue, 11 Aug 2020 10:22:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH v4] documentation: coccinelle: Improve command example
 for make C={1, 2}
Message-ID: <20200811082218.GB113774@kroah.com>
References: <ed46e96e-a24b-b3f3-3bdc-cd8f0d50bac9@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed46e96e-a24b-b3f3-3bdc-cd8f0d50bac9@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 10:00:20AM +0200, Markus Elfring wrote:
> > +This variable can be used to run scripts for the entire kernel, a
> > +specific directory, or for a single file.
> 
> I imagine that this wording can be improved another bit (as I indicated it before).

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot
