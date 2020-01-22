Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB4FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AF0024656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wknxobfb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="tizz4lWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgAVQkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:40:45 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51435 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgAVQkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:40:45 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 48C2EAABAF;
        Wed, 22 Jan 2020 11:40:43 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=nm4+AllZt0xaKzJosnEhrST2Js8=; b=Wknxob
        fbY9/d9ilbkbi5SWP4zLtOZRg+xnQE+icEvid8r5yl7ZW3RyIb0/xZ4iyRYh1tCq
        k2yr2SD5jhl3g4ec7HjsWZ7HC+ddnEdxr/1jyTKsy+aqczATJQVsmG8Fr2diiTBC
        9OS8QC3MoE9pepsExA4iJ9SBqLwbEfWO36j3g=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4083CAABAE;
        Wed, 22 Jan 2020 11:40:43 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=htryAvkzPUayXcHLCDdZuj4Za0JJ4NkSs6AjxwfUoHc=; b=tizz4lWiNUT4myJCvvfT/5prD8HXoXbGd8rZHVOf+kAsTHNqnJZWeh9i7COEBa2CmxyjtXr4p8sdonfrmY392XBLjIlttj8gdpYv7QeD5VIPDvjy8Z8pZyDzmRAVs/yxSN1PtWOb4n4DDCcbfMlDSkUJ+VPhYUOTBqlDBDOsJ7A=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3034BAABAD;
        Wed, 22 Jan 2020 11:40:40 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 5EC3D2DA010B;
        Wed, 22 Jan 2020 11:40:38 -0500 (EST)
Date:   Wed, 22 Jan 2020 11:40:38 -0500 (EST)
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
In-Reply-To: <575cb82102aa59a7a8e34248821b78e1dd844777.1579701673.git.lukas@wunner.de>
Message-ID: <nycvar.YSQ.7.76.2001221032210.1655@knanqh.ubzr>
References: <575cb82102aa59a7a8e34248821b78e1dd844777.1579701673.git.lukas@wunner.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: ECB65F08-3D35-11EA-869D-8D86F504CC47-78420484!pb-smtp21.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jan 2020, Lukas Wunner wrote:

> Since commit a6dbe4427559 ("vt: perform safe console erase in the right
> order"), when userspace clears both the scrollback buffer and the screen
> by writing "\e[3J" to an fbdev virtual console, the cursor stops blinking
> if that virtual console is not in the foreground.  I'm witnessing this
> on every boot of Raspbian since updating to v4.19.37+ because agetty
> writes the sequence to /dev/tty6 while the console is still switched to
> /dev/tty1.  Switching consoles once makes the cursor blink again.
> 
> The commit added an invocation of ->con_switch() to flush_scrollback().
> Normally this is only invoked from switch_screen() to switch consoles.
> switch_screen() updates *vc->vc_display_fg to the new console and
> fbcon_switch() updates ops->currcon.  Because the commit only invokes
> fbcon_switch() but doesn't update *vc->vc_display_fg, it performs an
> incomplete console switch.
> 
> When fb_flashcursor() subsequently blinks the cursor, it retrieves the
> foreground console from ops->currcon.  Because *vc->vc_display_fg wasn't
> updated, con_is_visible() incorrectly returns false and as a result,
> fb_flashcursor() bails out without blinking the cursor.
> 
> The invocation of ->con_switch() appears to have been erroneous.  After
> all, why should a console switch be performed when clearing the screen?
> The commit message doesn't provide a rationale either.  So delete it.

The problem here is that only vgacon provides a con_flush_scrollback 
method. When not provided, the only way to flush the scrollback buffer 
is to invoke the switch method. If you remove it the scrollback buffer 
of the foreground console won't be flushed in the fb case and possibly 
others.

Originally the con_switch method was invoked via update_screen(). The 
code rationalization in commit a6dbe4427559 failed to carry over a few 
details though.

So I think the actual fix should instead be like this:

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 34aa39d1ae..93314a2f26 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -936,10 +936,13 @@ static void flush_scrollback(struct vc_data *vc)
 	WARN_CONSOLE_UNLOCKED();
 
 	set_origin(vc);
-	if (vc->vc_sw->con_flush_scrollback)
+	if (vc->vc_sw->con_flush_scrollback) {
 		vc->vc_sw->con_flush_scrollback(vc);
-	else
+	} else if (con_is_visible(vc)) {
+		hide_cursor(vc);
 		vc->vc_sw->con_switch(vc);
+		set_cursor(vc);
+	}
 }
 
 /*


Nicolas
