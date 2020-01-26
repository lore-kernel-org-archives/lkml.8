Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFF1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 17:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983C7206A2
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 17:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="viK2RcQd";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="oCRtB2w4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgAZRcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 12:32:19 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55188 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgAZRcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 12:32:19 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D6D9AADDB9;
        Sun, 26 Jan 2020 12:32:15 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=D5trX9X8rTmSD/tx1qPl80IAEbw=; b=viK2Rc
        Qd7cS50xQz1M38Ll0rmcN3aXWxzMDEUhVb9t7BZvaqjt55Kscc7nMcAJOpb+7tQj
        Rjvm1nFxtXyd6aVtg8sZPT9Tm8p9PpPB+vsXamwufQTBUgYH24WD5NtL8vCeO7SK
        XNp8kp8xVVR9CUbuTuVINfVL2m5NlEaKMaAbo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CE99EADDB8;
        Sun, 26 Jan 2020 12:32:15 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=57kAV/MpDSDKyHMJ4hIl3Jul1bLmwkmpZCanJNaqqX4=; b=oCRtB2w4HQ672SBpElw2g7XDIK9syL0jbYUPz4ad5rhcPXGhOPlQL/yD1LMTR6wOOcCnMxKRXOs+yQjW01w42v95kSJ/cOI9YL8+6SBmMUNGq1/xc8MAvIQByHKNqiAv0+/yBq2Hh6GRzP8iu9t2+Oxd+IE8CIRyGaD73J2a2lQ=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B1411ADDB5;
        Sun, 26 Jan 2020 12:32:12 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 8D9E12DA03F4;
        Sun, 26 Jan 2020 12:32:10 -0500 (EST)
Date:   Sun, 26 Jan 2020 12:32:10 -0500 (EST)
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
In-Reply-To: <20200126124834.ea7uxyprz2uaek5x@wunner.de>
Message-ID: <nycvar.YSQ.7.76.2001261208030.1655@knanqh.ubzr>
References: <575cb82102aa59a7a8e34248821b78e1dd844777.1579701673.git.lukas@wunner.de> <nycvar.YSQ.7.76.2001221032210.1655@knanqh.ubzr> <20200126124834.ea7uxyprz2uaek5x@wunner.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: C9A7A948-4061-11EA-B4DD-8D86F504CC47-78420484!pb-smtp21.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jan 2020, Lukas Wunner wrote:

> On Wed, Jan 22, 2020 at 11:40:38AM -0500, Nicolas Pitre wrote:
> > On Wed, 22 Jan 2020, Lukas Wunner wrote:
> > > Since commit a6dbe4427559 ("vt: perform safe console erase in the right
> > > order"), when userspace clears both the scrollback buffer and the screen
> > > by writing "\e[3J" to an fbdev virtual console, the cursor stops blinking
> > > if that virtual console is not in the foreground.  I'm witnessing this
> > > on every boot of Raspbian since updating to v4.19.37+ because agetty
> > > writes the sequence to /dev/tty6 while the console is still switched to
> > > /dev/tty1.  Switching consoles once makes the cursor blink again.
> > > 
> > > The commit added an invocation of ->con_switch() to flush_scrollback().
> > > Normally this is only invoked from switch_screen() to switch consoles.
> > > switch_screen() updates *vc->vc_display_fg to the new console and
> > > fbcon_switch() updates ops->currcon.  Because the commit only invokes
> > > fbcon_switch() but doesn't update *vc->vc_display_fg, it performs an
> > > incomplete console switch.
> > > 
> > > When fb_flashcursor() subsequently blinks the cursor, it retrieves the
> > > foreground console from ops->currcon.  Because *vc->vc_display_fg wasn't
> > > updated, con_is_visible() incorrectly returns false and as a result,
> > > fb_flashcursor() bails out without blinking the cursor.
> > > 
> > > The invocation of ->con_switch() appears to have been erroneous.  After
> > > all, why should a console switch be performed when clearing the screen?
> > > The commit message doesn't provide a rationale either.  So delete it.
> > 
> > The problem here is that only vgacon provides a con_flush_scrollback 
> > method. When not provided, the only way to flush the scrollback buffer 
> > is to invoke the switch method. If you remove it the scrollback buffer 
> > of the foreground console won't be flushed in the fb case and possibly 
> > others.
> 
> Okay.  I guess it's somewhat counter-intuitive that ->con_switch()
> is called only because it has the side effect of flushing scrollback.
> In particular, this approach doesn't work for nonvisible consoles.

Normally, only the foreground console has a scrollback, so by not being 
visible it therefore has no scrollback to flush. When the scrollback is 
persistent (only vgacon implements that) then there must be a 
con_flush_scrollback method.

> So the proper solution might be to amend the fb_con struct with a
> ->con_flush_scrollback() hook.

Yes, and every other console drivers as well.

> Which portions of fbcon_switch()
> would have to be duplicated in that hook?  The softback code at the
> top of the function would seem like an obvious candidate.

Most likely, yes, after making sure the scrollback does correspond to 
the vc argument.

> What about the invocation of fb_set_var() (which in turn calls 
> fb_pan_display())? Anything else?

I don't know enough about the fbcon code to be sure of all the 
implications here.

Still, I'd prefer to get back to the same functional state from before 
commit a6dbe44275 with the switch method first. Can you confirm that the 
patch I propose does fix it for you?

> > @@ -936,10 +936,13 @@ static void flush_scrollback(struct vc_data *vc)
> >  	WARN_CONSOLE_UNLOCKED();
> >  
> >  	set_origin(vc);
> > -	if (vc->vc_sw->con_flush_scrollback)
> > +	if (vc->vc_sw->con_flush_scrollback) {
> >  		vc->vc_sw->con_flush_scrollback(vc);
> > -	else
> > +	} else if (con_is_visible(vc)) {
> > +		hide_cursor(vc);
> >  		vc->vc_sw->con_switch(vc);
> > +		set_cursor(vc);
> > +	}
> 
> A dumb question perhaps, but why is it necessary to hide the cursor?

Many console implements the cursor by changing the background color of 
the cursor position. If the switch occurs while the cursor is in its 
visible period, the rest of the code will assume that the cursor is the 
actual background color, effectively leaving the drawn cursor there 
after it moved.


Nicolas
