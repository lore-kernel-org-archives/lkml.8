Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF96C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB4F520CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yMPLzY/o";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="sLBSB/X5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgA1QXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 11:23:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50655 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgA1QXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 11:23:43 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 93C92BDBCB;
        Tue, 28 Jan 2020 11:23:37 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=jYpALN1fbxMFSVVBUXE7zg9UxeE=; b=yMPLzY
        /oEE7pHkRhjtDKzYsKfgr6OB8Ve0ryTdCW67B9Ykhu5gOrTWF5hoN+XLvdLmlNN1
        ijt8AMi/QxwlMLjff8CURMK/UDBlsAhlMvzuAC64GCCLlPjXYTu0hisGNT7viU7o
        GhpOXjdyxdzyAos0sDbbHNMuJK3qSEMaBu6pg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 88261BDBCA;
        Tue, 28 Jan 2020 11:23:37 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=1LSD1SXyHfZByrcKZiHw6WOuFn+XRuVq7AgxFxAf94Y=; b=sLBSB/X56XRODwmvf4UnhZTlcIQSH43t+irzIPlKOxjm0DKulSd8hl4vCdQ1dKIgaTLbp1znFBmLV+xirJyvIb6qbDGKtcn3gJTylkmwjoRjuy97rlCTNf6QMQIR8xtpdYR4QgoWvobzKzM87wARIZM6naUno/JYtDb+QmjOJJI=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5DC82BDBC8;
        Tue, 28 Jan 2020 11:23:34 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 5A1A22DA00E3;
        Tue, 28 Jan 2020 11:23:32 -0500 (EST)
Date:   Tue, 28 Jan 2020 11:23:32 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Lukas Wunner <lukas@wunner.de>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Matthew Whitehead <tedheadster@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vt: Fix non-blinking cursor regression
In-Reply-To: <20200128111107.ppqeebsctffmk7n6@wunner.de>
Message-ID: <nycvar.YSQ.7.76.2001281121340.1655@knanqh.ubzr>
References: <575cb82102aa59a7a8e34248821b78e1dd844777.1579701673.git.lukas@wunner.de> <nycvar.YSQ.7.76.2001221032210.1655@knanqh.ubzr> <20200126124834.ea7uxyprz2uaek5x@wunner.de> <nycvar.YSQ.7.76.2001261208030.1655@knanqh.ubzr>
 <20200128111107.ppqeebsctffmk7n6@wunner.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 87C1ABFC-41EA-11EA-A842-8D86F504CC47-78420484!pb-smtp21.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jan 2020, Lukas Wunner wrote:

> On Sun, Jan 26, 2020 at 12:32:10PM -0500, Nicolas Pitre wrote:
> > On Sun, 26 Jan 2020, Lukas Wunner wrote:
> > > On Wed, Jan 22, 2020 at 11:40:38AM -0500, Nicolas Pitre wrote:
> > > > On Wed, 22 Jan 2020, Lukas Wunner wrote:
> > > > > Since commit a6dbe4427559 ("vt: perform safe console erase in the right
> > > > > order"), when userspace clears both the scrollback buffer and the screen
> > > > > by writing "\e[3J" to an fbdev virtual console, the cursor stops blinking
> > > > > if that virtual console is not in the foreground.  I'm witnessing this
> > > > > on every boot of Raspbian since updating to v4.19.37+ because agetty
> > > > > writes the sequence to /dev/tty6 while the console is still switched to
> > > > > /dev/tty1.  Switching consoles once makes the cursor blink again.
> > > > > 
> > > > > The commit added an invocation of ->con_switch() to flush_scrollback().
> > > > > Normally this is only invoked from switch_screen() to switch consoles.
> > > > > switch_screen() updates *vc->vc_display_fg to the new console and
> > > > > fbcon_switch() updates ops->currcon.  Because the commit only invokes
> > > > > fbcon_switch() but doesn't update *vc->vc_display_fg, it performs an
> > > > > incomplete console switch.
> > > > > 
> > > > > When fb_flashcursor() subsequently blinks the cursor, it retrieves the
> > > > > foreground console from ops->currcon.  Because *vc->vc_display_fg wasn't
> > > > > updated, con_is_visible() incorrectly returns false and as a result,
> > > > > fb_flashcursor() bails out without blinking the cursor.
> > > > > 
> > > > > The invocation of ->con_switch() appears to have been erroneous.  After
> > > > > all, why should a console switch be performed when clearing the screen?
> > > > > The commit message doesn't provide a rationale either.  So delete it.
> > > > 
> > > > The problem here is that only vgacon provides a con_flush_scrollback 
> > > > method. When not provided, the only way to flush the scrollback buffer 
> > > > is to invoke the switch method. If you remove it the scrollback buffer 
> > > > of the foreground console won't be flushed in the fb case and possibly 
> > > > others.
> [...]
> > Still, I'd prefer to get back to the same functional state from before 
> > commit a6dbe44275 with the switch method first. Can you confirm that the 
> > patch I propose does fix it for you?
> 
> Yes, your patch is
> 
> Reported-and-tested-by: Lukas Wunner <lukas@wunner.de>

OK, thanks.

> I'm withdrawing my own patch because further testing has shown that while it
> fixes the non-blinking cursor issue, it doesn't flush scrollback if "\e[3J"
> is written to the foreground console.
> 
> Would you prefer me to submit your patch with your Signed-off-by or rather
> submit it yourself with my Tested-by?  If the latter, please include a code
> comment explaining that ->con_switch() has the side effect of flushing
> scrollback.  That seems quite non-obvious to me.

I'll submit it with a comment stating the non-obvious.


Nicolas
