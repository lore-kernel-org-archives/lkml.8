Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E97C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 11:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650B920721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 11:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgBCLIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 06:08:14 -0500
Received: from smtprelay0053.hostedemail.com ([216.40.44.53]:53054 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727509AbgBCLIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 06:08:14 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id BD3E72816;
        Mon,  3 Feb 2020 11:08:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cause64_d4df4aac5c17
X-Filterd-Recvd-Size: 2662
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon,  3 Feb 2020 11:08:11 +0000 (UTC)
Message-ID: <ce81e9b1ac6ede9f7a16823175192ef69613ec07.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: correct entries for ISDN/mISDN section
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Karsten Keil <isdn@linux-pingi.de>,
        Arnd Bergmann <arnd@arndb.de>,
        isdn4linux@listserv.isdn4linux.de, netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 03 Feb 2020 03:07:01 -0800
In-Reply-To: <CAHp75VdVXqz7fab4MKH2jZozx4NGGkQnJyTWHDKCdgSwD2AtpA@mail.gmail.com>
References: <20200201124301.21148-1-lukas.bulwahn@gmail.com>
         <20200202124306.54bcabea@cakuba.hsd1.ca.comcast.net>
         <CAHp75VdVXqz7fab4MKH2jZozx4NGGkQnJyTWHDKCdgSwD2AtpA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-03 at 12:13 +0200, Andy Shevchenko wrote:
> On Sun, Feb 2, 2020 at 10:45 PM Jakub Kicinski <kuba@kernel.org> wrote:
> > On Sat,  1 Feb 2020 13:43:01 +0100, Lukas Bulwahn wrote:
> > > Commit 6d97985072dc ("isdn: move capi drivers to staging") cleaned up the
> > > isdn drivers and split the MAINTAINERS section for ISDN, but missed to add
> > > the terminal slash for the two directories mISDN and hardware. Hence, all
> > > files in those directories were not part of the new ISDN/mISDN SUBSYSTEM,
> > > but were considered to be part of "THE REST".
> > > 
> > > Rectify the situation, and while at it, also complete the section with two
> > > further build files that belong to that subsystem.
> > > 
> > > This was identified with a small script that finds all files belonging to
> > > "THE REST" according to the current MAINTAINERS file, and I investigated
> > > upon its output.
> > > 
> > > Fixes: 6d97985072dc ("isdn: move capi drivers to staging")
> > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > 
> > Applied to net, thanks!
> 
> I'm not sure it's ready. I think parse-maintainers.pl will change few
> lines here.

parse-maintainers would change a _lot_ of the MAINTAINERS file
by reordering section letters.

$ perl ./scripts/parse-maintainers.pl --output=MAINTAINERS
$ git diff --stat MAINTAINERS
 MAINTAINERS | 5572 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 2786 insertions(+), 2786 deletions(-)


