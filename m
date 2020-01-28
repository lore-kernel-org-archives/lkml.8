Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED38C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 11:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EE3421739
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 11:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgA1LLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 06:11:12 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:52717 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgA1LLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 06:11:10 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id E34B32800935A;
        Tue, 28 Jan 2020 12:11:07 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B35AE1EB443; Tue, 28 Jan 2020 12:11:07 +0100 (CET)
Date:   Tue, 28 Jan 2020 12:11:07 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Matthew Whitehead <tedheadster@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vt: Fix non-blinking cursor regression
Message-ID: <20200128111107.ppqeebsctffmk7n6@wunner.de>
References: <575cb82102aa59a7a8e34248821b78e1dd844777.1579701673.git.lukas@wunner.de>
 <nycvar.YSQ.7.76.2001221032210.1655@knanqh.ubzr>
 <20200126124834.ea7uxyprz2uaek5x@wunner.de>
 <nycvar.YSQ.7.76.2001261208030.1655@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.2001261208030.1655@knanqh.ubzr>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2020 at 12:32:10PM -0500, Nicolas Pitre wrote:
> On Sun, 26 Jan 2020, Lukas Wunner wrote:
> > On Wed, Jan 22, 2020 at 11:40:38AM -0500, Nicolas Pitre wrote:
> > > On Wed, 22 Jan 2020, Lukas Wunner wrote:
> > > > Since commit a6dbe4427559 ("vt: perform safe console erase in the right
> > > > order"), when userspace clears both the scrollback buffer and the screen
> > > > by writing "\e[3J" to an fbdev virtual console, the cursor stops blinking
> > > > if that virtual console is not in the foreground.  I'm witnessing this
> > > > on every boot of Raspbian since updating to v4.19.37+ because agetty
> > > > writes the sequence to /dev/tty6 while the console is still switched to
> > > > /dev/tty1.  Switching consoles once makes the cursor blink again.
> > > > 
> > > > The commit added an invocation of ->con_switch() to flush_scrollback().
> > > > Normally this is only invoked from switch_screen() to switch consoles.
> > > > switch_screen() updates *vc->vc_display_fg to the new console and
> > > > fbcon_switch() updates ops->currcon.  Because the commit only invokes
> > > > fbcon_switch() but doesn't update *vc->vc_display_fg, it performs an
> > > > incomplete console switch.
> > > > 
> > > > When fb_flashcursor() subsequently blinks the cursor, it retrieves the
> > > > foreground console from ops->currcon.  Because *vc->vc_display_fg wasn't
> > > > updated, con_is_visible() incorrectly returns false and as a result,
> > > > fb_flashcursor() bails out without blinking the cursor.
> > > > 
> > > > The invocation of ->con_switch() appears to have been erroneous.  After
> > > > all, why should a console switch be performed when clearing the screen?
> > > > The commit message doesn't provide a rationale either.  So delete it.
> > > 
> > > The problem here is that only vgacon provides a con_flush_scrollback 
> > > method. When not provided, the only way to flush the scrollback buffer 
> > > is to invoke the switch method. If you remove it the scrollback buffer 
> > > of the foreground console won't be flushed in the fb case and possibly 
> > > others.
[...]
> Still, I'd prefer to get back to the same functional state from before 
> commit a6dbe44275 with the switch method first. Can you confirm that the 
> patch I propose does fix it for you?

Yes, your patch is

Reported-and-tested-by: Lukas Wunner <lukas@wunner.de>

I'm withdrawing my own patch because further testing has shown that while it
fixes the non-blinking cursor issue, it doesn't flush scrollback if "\e[3J"
is written to the foreground console.

Would you prefer me to submit your patch with your Signed-off-by or rather
submit it yourself with my Tested-by?  If the latter, please include a code
comment explaining that ->con_switch() has the side effect of flushing
scrollback.  That seems quite non-obvious to me.


> > A dumb question perhaps, but why is it necessary to hide the cursor?
> 
> Many console implements the cursor by changing the background color of 
> the cursor position. If the switch occurs while the cursor is in its 
> visible period, the rest of the code will assume that the cursor is the 
> actual background color, effectively leaving the drawn cursor there 
> after it moved.

I see, thanks for the explanation.

Lukas
