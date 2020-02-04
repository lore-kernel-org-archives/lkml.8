Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8428C3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 05:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9627A2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 05:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgBDFgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 00:36:18 -0500
Received: from smtprelay0046.hostedemail.com ([216.40.44.46]:54753 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726189AbgBDFgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 00:36:17 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 71695182CED34;
        Tue,  4 Feb 2020 05:36:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: smash54_53b153a945116
X-Filterd-Recvd-Size: 2936
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue,  4 Feb 2020 05:36:15 +0000 (UTC)
Message-ID: <7040e0501f1a04cf09195bdccfcfb05df25962ec.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: correct entries for ISDN/mISDN section
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Karsten Keil <isdn@linux-pingi.de>,
        Arnd Bergmann <arnd@arndb.de>,
        isdn4linux@listserv.isdn4linux.de, netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 03 Feb 2020 21:35:04 -0800
In-Reply-To: <alpine.DEB.2.21.2002040550540.3062@felia>
References: <20200201124301.21148-1-lukas.bulwahn@gmail.com>
         <20200202124306.54bcabea@cakuba.hsd1.ca.comcast.net>
         <CAHp75VdVXqz7fab4MKH2jZozx4NGGkQnJyTWHDKCdgSwD2AtpA@mail.gmail.com>
         <ce81e9b1ac6ede9f7a16823175192ef69613ec07.camel@perches.com>
         <CAHp75VdaaOW0ktt4eo4NsLFu2QT1K1mHK8DZeycOPhbvcMq4wQ@mail.gmail.com>
         <alpine.DEB.2.21.2002040550540.3062@felia>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-04 at 06:08 +0100, Lukas Bulwahn wrote:
> 
> On Mon, 3 Feb 2020, Andy Shevchenko wrote:
> 
> > On Mon, Feb 3, 2020 at 1:08 PM Joe Perches <joe@perches.com> wrote:
> > > On Mon, 2020-02-03 at 12:13 +0200, Andy Shevchenko wrote:
> > > > On Sun, Feb 2, 2020 at 10:45 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > 
> > ...
> > 
> > > > I'm not sure it's ready. I think parse-maintainers.pl will change few
> > > > lines here.
> > > 
> > > parse-maintainers would change a _lot_ of the MAINTAINERS file
> > > by reordering section letters.
> > 
> > I think it's quite easy to find out if it had changed the record in question.
> > 
> I checked it and it does change a bit. My patch adds to a list of file 
> entries sorted by "relevance" (not alphabetically) two further minor (by 
> relevance) entries, i.e., Kconfig and Makefile, to the end of that list.
> 
> The other reorderings would have already applied to the original state; 
> rather than trying to "fix" this locally for this one patch here, I would 
> prefer to understand why the discussion on splitting the MAINTAINERS file,
> summarized at https://lwn.net/Articles/730509/, got stuck and how I can 
> contribute to that. If that bigger change would happen, we could 
> automatically clean up all the entries when the things are splitted, 
> rather than sending reordering patches to the maintainers that then spend 
> time on trying to merge that all back together.

Realistically, ISDN is all but dead.

Perhaps it'd be better to change the entries here to:

F:	drivers/isdn/
X:	drivers/isdn/capi/





