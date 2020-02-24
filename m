Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74B4C38BE2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF4920838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgBXS7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:59:00 -0500
Received: from ms.lwn.net ([45.79.88.28]:46990 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727755AbgBXS67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:58:59 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F2C462B7;
        Mon, 24 Feb 2020 18:58:56 +0000 (UTC)
Date:   Mon, 24 Feb 2020 11:58:51 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>,
        linux-doc@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: process: changes.rst: Escape --version to fix
 Sphinx output
Message-ID: <20200224115851.6684d516@lwn.net>
In-Reply-To: <20200224185227.GO24185@bombadil.infradead.org>
References: <20200223222228.27089-1-j.neuschaefer@gmx.net>
        <20200224110815.6f7561d1@lwn.net>
        <20200224184719.GA2363@latitude>
        <20200224185227.GO24185@bombadil.infradead.org>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020 10:52:27 -0800
Matthew Wilcox <willy@infradead.org> wrote:

> On Mon, Feb 24, 2020 at 07:47:19PM +0100, Jonathan Neuschäfer wrote:
> > On Mon, Feb 24, 2020 at 11:08:15AM -0700, Jonathan Corbet wrote:  
> > > On Sun, 23 Feb 2020 23:22:27 +0100
> > > Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:
> > >   
> > > > Without double-backticks, Sphinx wrongly turns "--version" into
> > > > "–version" with a Unicode EN DASH (U+2013), that is visually easy to
> > > > confuse with a single ASCII dash.
> > > > 
> > > > Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>  
> > > 
> > > This certainly seems worth addressing.  But I would *really* rather find
> > > a way to tell Sphinx not to do that rather than making all of these
> > > tweaks - which we will certainly find ourselves having to do over and
> > > over again.  I can try to look into that in a bit, but if somebody were
> > > to beat me to it ... :)  
> > 
> > This seems to do the trick:
> > 
> > diff --git a/Documentation/conf.py b/Documentation/conf.py
> > index 3c7bdf4cd31f..8f2a7ae95184 100644
> > --- a/Documentation/conf.py
> > +++ b/Documentation/conf.py
> > @@ -587,6 +587,9 @@ pdf_documents = [
> >  kerneldoc_bin = '../scripts/kernel-doc'
> >  kerneldoc_srctree = '..'
> > 
> > +# Render -- as two dashes
> > +smartquotes = False  
> 
> I think what Jon was looking for was the ability to selectively turn
> smartquotes off for a section and then reenable it?

No that's not what I was thinking, actually.  Unless somebody can come up
with a good reason to the contrary, just disabling that behavior globally
strikes me as the right thing to do.

Assuming there are no objections, it would be great to have this as a
patch with a proper changelog.  Said changelog should describe all of the
changes we'll see in the output with that option set, though, so there
are no surprises later.

Thanks,

jon
