Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91107C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE7620678
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597134243;
	bh=e4cpDk0boX/iV+YqjkiI+GIWkiE8A7x1ApDty9mkzMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Tw3tqI//xSUx1nSM3c/CaCN10AVoG6QBsDIKmJ1UAjqCoTQc8ZDzBst8rRnLV99w1
	 judbdtDzyz/oRf7jvOZ7wnUvqTK4tYV9Z6VA0WFVS4pWlp0a7p1y8LFH8lqgRwvZGJ
	 qZGkWAuNGUaMS7tNrtnFNVwM6w8elPVO52ByDHxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgHKIYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 04:24:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbgHKIX7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 04:23:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BBF020678;
        Tue, 11 Aug 2020 08:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597134238;
        bh=e4cpDk0boX/iV+YqjkiI+GIWkiE8A7x1ApDty9mkzMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wEavTbVdt8q7mUrlUwpzGN2eaGWliSSG83YFiI8j/AuAaER7ylyflD91gAR09lDnr
         Qi1iuOqM6tjTFzdpVEJx0AWgMRxQf7m/83lP7EJe+sIuU6MAwROUX5bLYJIb/tFEga
         32hgbtD+Qus42MeGoqgYVG3N2cIP75iqRFFQi2zg=
Date:   Tue, 11 Aug 2020 10:24:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>, linux-doc@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Jonathan Corbet <corbet@lwn.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [v3] documentation: coccinelle: Improve command example for make
 C={1, 2}
Message-ID: <20200811082408.GE113774@kroah.com>
References: <478715f8-87dd-7b4d-d3fd-01585f5f3bd7@web.de>
 <alpine.DEB.2.22.394.2008102249570.2466@hadrien>
 <d6dcb49d-3dca-327e-e782-2cae789e31b7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d6dcb49d-3dca-327e-e782-2cae789e31b7@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 09:03:09AM +0200, Markus Elfring wrote:
> >>> the usage of the makefile C variable flag by coccicheck.
> >>
> >> * Can it be confusing to denote an item as a variable and a flag?
> >>
> >> * Would you really like to stress here that a flag can be variable?
> >
> > This is not part of the documentation, so it doesn't really matter.
> 
> It seems then that your expectations for the clarity of change descriptions
> (or commit messages) can vary considerably.
> 
> 
> > Nevertheless, Sumera, there is stail an occurrence of flag in the proposed
> > change to the documentation, so you could indeed change that one to variable.
> 
> Will any related adjustments become more interesting?
> 
> 
> >>> +This variable can be used to run scripts for …
> >>
> >> Can the scope for a make command be selected also without such a variable?
> >
> > If you know something that is different than what is in the documentation,
> > then please say what it is.  Don't just ask questions.
> 
> I suggest to increase the distinction for the application of such command parameters.
> 
> 
> >> Will clarification requests for previously mentioned background information
> >> influence the proposed descriptions any further?
> >
> > The point is to document the use of make coccicheck,
> 
> Another attempt is evolving for the affected software documentation.
> 
> 
> > not the C variables.
> 
> I got an other impression here.
> 
> 
> > So the point about KBUILD_CHECK, while interesting, does not seem
> > appropriate for this documentation.
> 
> How do you think about to clarify the influence of a macro like “KBUILD_CHECKSRC”
> (or the specification “$(call cmd,force_checksrc)”)?
> 
> Will a cross reference for the applied make scripts help to achieve
> a better common understanding (and corresponding descriptions) of
> the involved dependencies?
> 
> Regards,
> Markus



Hi,

This is the friendly semi-automated patch-bot of Greg Kroah-Hartman.
You have sent him a patch that has triggered this response.

Right now, the development tree you have sent a patch for is "closed"
due to the timing of the merge window.  Don't worry, the patch(es) you
have sent are not lost, and will be looked at after the merge window is
over (after the -rc1 kernel is released by Linus).

So thank you for your patience and your patches will be reviewed at this
later time, you do not have to do anything further, this is just a short
note to let you know the patch status and so you don't worry they didn't
make it through.

thanks,

greg k-h's patch email bot
