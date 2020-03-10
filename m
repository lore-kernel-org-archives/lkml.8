Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D4F5C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 05:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B88D2464B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 05:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HpTP/XkF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgCJFl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 01:41:27 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:36591 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgCJFl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 01:41:27 -0400
Received: by mail-qv1-f67.google.com with SMTP id r15so5554736qve.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 22:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oJBIG/51r747h3DabsgMtgPriYpa81i3DgY6izBzsN4=;
        b=HpTP/XkFTb9fryvXSS1GfNQfQLZr0nUjTP+5JU7zZ8CoXYdCbf3EO5kYJzcMkLC+62
         NF8YyCcuUmiFgoxkzvYNkPJPfbwgmnQ/EIv//KHZ40qFdpVAP/LTdGBv/Efl5bWhmzVo
         xlQ9mh34miQbNyYrSQWQ2DJmpwFphd5Gwgie2Vtcid3J6jNySpWfecoTQSGvkGry/B7i
         Wi9FW5M1VFJaaRxMd1OkAOeyXrIBnSLimxLEE+/ab66tEdd31dCvlOvBTjlGr39tI1St
         5KMLezJ8iPtW28dubhK3Ga3WZ8bq4cvNPebTLmVOXBxWhrUvVRnSDcWAzY5cxZsgAuog
         LMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oJBIG/51r747h3DabsgMtgPriYpa81i3DgY6izBzsN4=;
        b=jTn1qzhoC7eI2HajWBitFIadDnDqIlojfIec96wtDKD6AldbDNy8YvqsvLu1mBwyZj
         NIhDpw9TQWiZGPFOKrnxhWiI0hlm+snCll7S6JhUY7gCprhu4tCz6MWQiysYMGgjo3+m
         hll6jfAvXt5ForggovAjsujA6ByVQaQOh2YX/506px0jWDfZCrt5dmNIsb5PSragPlYg
         r87z+XZO22x68gS2Huf1YV7YzzmJduCNOiGVabmXiquRf1vUkyHzZqubHYc6pWAwaWvR
         UjGMKUBHV5yq3zcMLd6fHbayrODXfe/4pFXUrnE0AwhDsVBDU/RN7Bi1dp8U2M+lAW/6
         +kyQ==
X-Gm-Message-State: ANhLgQ3AeKqowbRrRHsLLe7vUVcXcNcWKk2zJd4a+2+13gyyKv60GjUe
        slsWv2L0JR1rZcAYYWUmV0keZ38cfypLzUbjgjnzDA==
X-Google-Smtp-Source: ADFU+vu+k5Sw/N/fJfra4eE1vCQYLvVB24EmDGWKXn6sN5IAPUFbQJVURUJhqJ7BfC5FPcdFSi4aGL/bg3d/gOQgdf8=
X-Received: by 2002:a0c:f892:: with SMTP id u18mr17789908qvn.159.1583818885034;
 Mon, 09 Mar 2020 22:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000ff323f05a053100c@google.com> <CALCETrV7JcVt3ejMbHxTs4-CFmKjcmSbW2eMmmMZUM7dg2mBuA@mail.gmail.com>
 <87eeu28zzl.fsf@nanos.tec.linutronix.de> <CACT4Y+YX72sz2LsqQOTQ=TdDK_f7zURjA9j9VyYwj7GgLrajkQ@mail.gmail.com>
 <20200309182608.GC1073@sol.localdomain>
In-Reply-To: <20200309182608.GC1073@sol.localdomain>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 10 Mar 2020 06:41:13 +0100
Message-ID: <CACT4Y+ZpN1_HyVyb8Ux9CwpCMT0JBmEP=hJVyCYKfjz9p+p6VA@mail.gmail.com>
Subject: Re: general protection fault in syscall_return_slowpath
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Jann Horn <jannh@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 7:26 PM Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Mon, Mar 09, 2020 at 09:34:25AM +0100, 'Dmitry Vyukov' via syzkaller-bugs wrote:
> >
> > I see the repro opens /dev/fb0, so this may be related to the exact
> > type of framebuffer on the machine. That's what Jann tried to figure
> > out.
> >
> > There is a plenty of open bugs on dashboard related to fb/tty, just
> > doing a quick grep based on titles:
> >
> > https://syzkaller.appspot.com/upstream
> > BUG: unable to handle kernel paging request in
> > drm_fb_helper_dirty_work 7 4d20h 90d
> > BUG: unable to handle kernel paging request in vga16fb_imageblit 1 74d 73d
> > divide error in fbcon_switch C cause 141 3d15h 96d
> > general protection fault in fbcon_cursor C cause 12 13h48m 87d
> > general protection fault in fbcon_fb_blanked 3 88d 90d
> > general protection fault in fbcon_invert_region 1 49d 48d
> > general protection fault in fbcon_modechanged 3 89d 90d
> > INFO: task hung in do_fb_ioctl 6 36d 57d
> > INFO: task hung in fb_compat_ioctl 1 87d 87d
> > INFO: task hung in fb_open C cause 171 1h06m 96d
> > INFO: task hung in fb_release C cause 23 2d12h 77d
> > INFO: task hung in release_tty 3 6d16h 62d
> > INFO: task hung in tty_ldisc_hangup C cause 15 17d 92d
> > INFO: trying to register non-static key in hci_uart_tty_receive (2) 1 103d 99d
> > KASAN: global-out-of-bounds Read in fbcon_get_font C cause 19 7d06h 90d
> > KASAN: global-out-of-bounds Read in fb_pad_aligned_buffer C cause 5 4d22h 92d
> > KASAN: global-out-of-bounds Read in vga16fb_imageblit C cause 225 1d11h 96d
> > KASAN: slab-out-of-bounds Read in fbcon_get_font C cause 42 5d04h 96d
> > KASAN: slab-out-of-bounds Read in fb_pad_aligned_buffer 4 9d00h 48d
> > KASAN: slab-out-of-bounds Write in fbcon_scroll 1 75d 73d
> > KASAN: use-after-free Read in fbcon_cursor syz cause 3 41d 84d
> > KASAN: use-after-free Read in fb_mode_is_equal syz cause 70 5h49m 92d
> > KASAN: use-after-free Read in tty_open C cause 7 42d 96d
> > KASAN: use-after-free Write in release_tty C cause 544 4h01m 96d
> > KASAN: vmalloc-out-of-bounds Read in drm_fb_helper_dirty_work 1 80d 80d
> > KASAN: vmalloc-out-of-bounds Write in drm_fb_helper_dirty_work 2 64d 76d
> > KCSAN: data-race in echo_char / n_tty_receive_buf_common 11 21d 125d
> > KMSAN: kernel-infoleak in tty_compat_ioctl C 81 2h17m 14d
> > memory leak in tty_init_dev C 3 121d 192d
> > possible deadlock in n_tty_receive_buf_common C cause 585 1h18m 23d
> > possible deadlock in tty_port_close_start C cause 4 9d18h 25d
> > WARNING in dlfb_submit_urb/usb_submit_urb C 190 8d23h 251d
> >
> > So if you don't see something obvious here, it may be not worth
> > spending more time until these, more obvious ones are fixed. This may
> > be a previous silent memory corruption that wasn't caught by KASAN.
>
> Yesterday I was looking at a similar bug
> "general protection fault in do_con_write"
> (https://syzkaller.appspot.com/bug?id=f82ab89451323208e343f4a8632014ef12b1252d).
>
> It has a simple single-threaded reproducer at
> https://syzkaller.appspot.com/text?tag=ReproC&x=169c4c81e00000 that just:
>
>         1. Calls FBIOPUT_VSCREENINFO on /dev/fb0
>         2. Opens /dev/tty20 and writes something to it
>
> Presumably, to reproduce this you at least need some graphics hardware with a
> corresponding framebuffer driver (to get /dev/fb0), as well as
> CONFIG_FRAMEBUFFER_CONSOLE=y (so that the virtual console /dev/tty20 uses a
> framebuffer console and not something else like a VGA text mode console).
>
> However, when I tried to reproduce this locally in QEMU with the same kconfig
> (https://syzkaller.appspot.com/text?tag=KernelConfig&x=31018567b8f0fc70) and
> with graphics enabled (-vga std), it didn't work.
>
> I then tried to reproduce on a Google Compute Engine VM with the exact same
> kconfig, and it worked.  I think the framebuffer driver in use was vga16fb.c.
> It's odd because the same driver seems to be used in the QEMU case, and in both
> cases the virtual consoles were bound to the framebuffer console.
>
> I need to double-check all this though.
>
> And yes, probably many of the above bugs have the same cause.

Interesting. If you manage to reproduce it (or at least figure out
"the closest" video driver), it would be useful to mention at:
https://github.com/google/syzkaller/blob/master/docs/syzbot.md#crash-does-not-reproduce
Currently we don't specify any -vga flag at all.
