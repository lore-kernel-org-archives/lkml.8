Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F01C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D6C208C3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583778371;
	bh=eT0kOzEakczMXlQYl1J8bn5DoxtQ2UnGAnmkEdwTmgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q3pkEKfZxPno/qLWPoe6OGHzr9ekednlg6VRLZIahx2IjZfWHf/SLCF3tQyGNMggd
	 DCJXvbKYwxz/BB3PSZ/K/JaWkjDsDnX1ZpNZJ0rvnItHXkg2kgUPikOJT/1Ig25M43
	 SVkcPPeHrldblLSf+tsuFUrJgCGl9BW9KwkOR6cY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCIS0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:35992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727263AbgCIS0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:26:10 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BD39205F4;
        Mon,  9 Mar 2020 18:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583778369;
        bh=eT0kOzEakczMXlQYl1J8bn5DoxtQ2UnGAnmkEdwTmgk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uPDGYdnddJT0uTL17VGEK3PrRwbbVptbQmCBeHhmxmOEDzXlabplCxwWejYRzDz2F
         YjHeHWZtvooRfv3hThH8oM4cid//RR4ZQzbALsq5XpN7WZIQHOqNvZCaNepFmNvVCr
         cMqY0Ywiyk3ra0gJHqQYK+EjW/QCJhUQ4sgOsxOg=
Date:   Mon, 9 Mar 2020 11:26:08 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Jann Horn <jannh@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: general protection fault in syscall_return_slowpath
Message-ID: <20200309182608.GC1073@sol.localdomain>
References: <000000000000ff323f05a053100c@google.com>
 <CALCETrV7JcVt3ejMbHxTs4-CFmKjcmSbW2eMmmMZUM7dg2mBuA@mail.gmail.com>
 <87eeu28zzl.fsf@nanos.tec.linutronix.de>
 <CACT4Y+YX72sz2LsqQOTQ=TdDK_f7zURjA9j9VyYwj7GgLrajkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YX72sz2LsqQOTQ=TdDK_f7zURjA9j9VyYwj7GgLrajkQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 09:34:25AM +0100, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> 
> I see the repro opens /dev/fb0, so this may be related to the exact
> type of framebuffer on the machine. That's what Jann tried to figure
> out.
> 
> There is a plenty of open bugs on dashboard related to fb/tty, just
> doing a quick grep based on titles:
> 
> https://syzkaller.appspot.com/upstream
> BUG: unable to handle kernel paging request in
> drm_fb_helper_dirty_work 7 4d20h 90d
> BUG: unable to handle kernel paging request in vga16fb_imageblit 1 74d 73d
> divide error in fbcon_switch C cause 141 3d15h 96d
> general protection fault in fbcon_cursor C cause 12 13h48m 87d
> general protection fault in fbcon_fb_blanked 3 88d 90d
> general protection fault in fbcon_invert_region 1 49d 48d
> general protection fault in fbcon_modechanged 3 89d 90d
> INFO: task hung in do_fb_ioctl 6 36d 57d
> INFO: task hung in fb_compat_ioctl 1 87d 87d
> INFO: task hung in fb_open C cause 171 1h06m 96d
> INFO: task hung in fb_release C cause 23 2d12h 77d
> INFO: task hung in release_tty 3 6d16h 62d
> INFO: task hung in tty_ldisc_hangup C cause 15 17d 92d
> INFO: trying to register non-static key in hci_uart_tty_receive (2) 1 103d 99d
> KASAN: global-out-of-bounds Read in fbcon_get_font C cause 19 7d06h 90d
> KASAN: global-out-of-bounds Read in fb_pad_aligned_buffer C cause 5 4d22h 92d
> KASAN: global-out-of-bounds Read in vga16fb_imageblit C cause 225 1d11h 96d
> KASAN: slab-out-of-bounds Read in fbcon_get_font C cause 42 5d04h 96d
> KASAN: slab-out-of-bounds Read in fb_pad_aligned_buffer 4 9d00h 48d
> KASAN: slab-out-of-bounds Write in fbcon_scroll 1 75d 73d
> KASAN: use-after-free Read in fbcon_cursor syz cause 3 41d 84d
> KASAN: use-after-free Read in fb_mode_is_equal syz cause 70 5h49m 92d
> KASAN: use-after-free Read in tty_open C cause 7 42d 96d
> KASAN: use-after-free Write in release_tty C cause 544 4h01m 96d
> KASAN: vmalloc-out-of-bounds Read in drm_fb_helper_dirty_work 1 80d 80d
> KASAN: vmalloc-out-of-bounds Write in drm_fb_helper_dirty_work 2 64d 76d
> KCSAN: data-race in echo_char / n_tty_receive_buf_common 11 21d 125d
> KMSAN: kernel-infoleak in tty_compat_ioctl C 81 2h17m 14d
> memory leak in tty_init_dev C 3 121d 192d
> possible deadlock in n_tty_receive_buf_common C cause 585 1h18m 23d
> possible deadlock in tty_port_close_start C cause 4 9d18h 25d
> WARNING in dlfb_submit_urb/usb_submit_urb C 190 8d23h 251d
> 
> So if you don't see something obvious here, it may be not worth
> spending more time until these, more obvious ones are fixed. This may
> be a previous silent memory corruption that wasn't caught by KASAN.

Yesterday I was looking at a similar bug
"general protection fault in do_con_write"
(https://syzkaller.appspot.com/bug?id=f82ab89451323208e343f4a8632014ef12b1252d).

It has a simple single-threaded reproducer at
https://syzkaller.appspot.com/text?tag=ReproC&x=169c4c81e00000 that just:

	1. Calls FBIOPUT_VSCREENINFO on /dev/fb0
	2. Opens /dev/tty20 and writes something to it

Presumably, to reproduce this you at least need some graphics hardware with a
corresponding framebuffer driver (to get /dev/fb0), as well as
CONFIG_FRAMEBUFFER_CONSOLE=y (so that the virtual console /dev/tty20 uses a
framebuffer console and not something else like a VGA text mode console).

However, when I tried to reproduce this locally in QEMU with the same kconfig
(https://syzkaller.appspot.com/text?tag=KernelConfig&x=31018567b8f0fc70) and
with graphics enabled (-vga std), it didn't work.

I then tried to reproduce on a Google Compute Engine VM with the exact same
kconfig, and it worked.  I think the framebuffer driver in use was vga16fb.c.
It's odd because the same driver seems to be used in the QEMU case, and in both
cases the virtual consoles were bound to the framebuffer console.

I need to double-check all this though.

And yes, probably many of the above bugs have the same cause.

- Eric
