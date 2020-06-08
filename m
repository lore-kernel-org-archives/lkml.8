Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52874C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3351E2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387882AbgFHXfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:35:21 -0400
Received: from smtprelay0186.hostedemail.com ([216.40.44.186]:42428 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732537AbgFHXdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:33:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 3E124485F;
        Mon,  8 Jun 2020 23:33:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: women05_3c11e0026dbd
X-Filterd-Recvd-Size: 3588
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon,  8 Jun 2020 23:33:07 +0000 (UTC)
Message-ID: <c25f5af83658ab9ef4ae8ef3825ea6540fe4e094.camel@perches.com>
Subject: Re: Forest Bond <forest@alittletooquiet.net>,Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,devel@driverdev.osuosl.org,linux-kernel@vger.kernel.org
From:   Joe Perches <joe@perches.com>
To:     Rodolfo C Villordo <rodolfovillordo@gmail.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Mon, 08 Jun 2020 16:33:06 -0700
In-Reply-To: <20200608225838.GA26559@ip-172-31-24-31.ec2.internal>
References: <20200607224156.GA24090@ip-172-31-24-31.ec2.internal>
         <20200608054614.GO23230@ZenIV.linux.org.uk>
         <alpine.DEB.2.21.2006080758510.2430@hadrien>
         <e3d7cc965eccec881bc35ae18d63f4bc23c33dfc.camel@perches.com>
         <20200608225838.GA26559@ip-172-31-24-31.ec2.internal>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-08 at 22:58 +0000, Rodolfo C Villordo wrote:
> On Mon, Jun 08, 2020 at 01:41:11AM -0700, Joe Perches wrote:
> > On Mon, 2020-06-08 at 07:59 +0200, Julia Lawall wrote:
> > > On Mon, 8 Jun 2020, Al Viro wrote:
> > > 
> > > > On Sun, Jun 07, 2020 at 10:41:56PM +0000, Rodolfo C. Villordo wrote:
> > > > > Multiple line over 80 characters fixes by splitting in multiple lines.
> > > > > Warning found by checkpatch.pl
> > > > 
> > > > I doubt that checkpatch.pl can catch the real problems there:
> > > > 
> > > > * Hungarian Notation Sucks.  Really.
> > > > * so does CamelCase, especially for wonders like s_uGetRTSCTSRsvTime
> 
> Yes, I agree with that.
> 
> > > Rodolfo,
> > > 
> > > If you work hard with Coccinelle and python scripting, it can help with
> > > the first two problems.
> > 
> > These VIA vt6655/vt6656 drivers have been in staging for more than
> > a decade.  There are relatively few checkpatch coding style
> > cleanups to do but there are many overall style issues to resolve.
> > 
> 
> Yes, vt6655/rxtx.c needs lots of work. I was avoiding submit bigger changes
> because this is my second patch submission.
> 
> Thank you all for the comments. I'm really sorry for the odd subject. 
> 
> How should I move forward with this?
> 
> 1 - Update this patch with the changes pointed by Dan Carpenter? 

Keep your changes small until you really know how this
style of linux kernel staging changes is done.

> 2 - Do a more elaborated and bigger change, like suggested by Al Viro
> and Joe Perches?

A patch series is much preferred to a single large change.

If you decide to refactor various functions, please do that
in separate, discrete patches.

Adding a #define and doing a sed like:

$ sed -i 's/(BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW/AL2230_RLEN_CTL/' drivers/staging/vt6655/*.[ch]

should be a single patch.

And if you do that, another should be done for AL7230

$ sed -i 's/(BY_AL7230_REG_LEN << 3) + IFREGCTL_REGW/AL7230_RLEN_CTL/' drivers/staging/vt6655/*.[ch]

etc...

Maybe the #define BY_AL2230_REG_LEN should be 0x17 so that
the << 3 is more obviously constrained to the low byte

Maybe the + uses in the macros should be bitwise |.

Go wild after you figure out the process, just keep your
patches to obvious, small and verifiable changes.


