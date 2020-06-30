Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82505C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A75206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 16:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iIxfCrLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732081AbgF3QOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 12:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728998AbgF3QOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:14:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AF8C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 09:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=lJv9Fg6198JSOBnpEYJynEhd5rfWcSCyiHXswrTAmUU=; b=iIxfCrLhbId6WNuBpoz82q6QtR
        RE4T4cgyTaYkcM6naLWesekFkzEfKqkNAAhk076XkGBuL0vzCO5Nv5VfZakUr3d6fReG9b2hBqlkJ
        weRSAMUgJdiiQ4x52G28fnxu52Y/hKasDtg5hZhhJ0lx84dsuxW2Yk/j3v9gJ2bxnVpoDPe4U9a9i
        bDO4+fZO5DvqDNH4wIgWZmnlyrsBovv9+FIwVMX+Bigk3qJqV30tTbxlklAJaRFdKlTQb1tNFakP9
        JdR6zpU47pVQJ3uzjrNtRdfmnt2RhWZlIPQ4HUnNXcc0cZYIU0VYhg95TM6RW86Nup0u8PjP9parf
        yOdkAPMQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqItb-0000XT-IJ; Tue, 30 Jun 2020 16:14:08 +0000
Subject: Re: [PATCH v1 6/6] Documentation: Describe console mouse reporting
To:     Tammo Block <tammo.block@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
References: <cover.1593499846.git.tammo.block@gmail.com>
 <ae41a64c682a2af6c8c0fbaa8d94c7b63a6f2450.1593499846.git.tammo.block@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <9b1ec821-61d5-d1ca-d569-ef4c5a9a638d@infradead.org>
Date:   Tue, 30 Jun 2020 09:14:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ae41a64c682a2af6c8c0fbaa8d94c7b63a6f2450.1593499846.git.tammo.block@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

(duplicating some of Juri's comments)

On 6/30/20 12:12 AM, Tammo Block wrote:
> This patch adds a description of the kernel interface(s) used for vt
> console mouse reporting and describes the protocols and bitmasks.
> 
> Signed-off-by: Tammo Block <tammo.block@gmail.com>
> ---
>  .../admin-guide/console-mouse-reporting.rst   | 92 +++++++++++++++++++
>  Documentation/admin-guide/index.rst           |  1 +
>  2 files changed, 93 insertions(+)
>  create mode 100644 Documentation/admin-guide/console-mouse-reporting.rst
> 
> diff --git a/Documentation/admin-guide/console-mouse-reporting.rst b/Documentation/admin-guide/console-mouse-reporting.rst
> new file mode 100644
> index 000000000000..11287cb233ba
> --- /dev/null
> +++ b/Documentation/admin-guide/console-mouse-reporting.rst
> @@ -0,0 +1,92 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======================
> +Console Mouse Reporting
> +=======================
> +
> +A terminal may send escape sequences to enable applications to react to mouse
> +input. As the kernel does not know when to emit these events a mouse daemon
> +is needed to react to mouse movements and signal the kernel accordingly. The
> +kernel will then send an escape sequence to the application. This is called
> +mouse reporting and several types and protocols have been developed over time.
> +
> +See tiocl.h, the :manpage:`ioctl_console(2)` and :manpage:`console_codes(4)`
> +man pages and the xterm [1]_ or terminalguide [2]_ home pages for a detailed
> +list and description of the various protocols, their bit layout as well as
> +their limitations.
> +
> +Events and formats
> +++++++++++++++++++
> +
> +A linux console keeps state about two different aspects of mouse reporting,

     Linux

> +the kind of **events** to be reported and the **format** to send to userspace.
> +
> +A mouse daemon can check which kind of mouse events a clients wants to be

                                                         client

> +informed about via the TIOCLINUX ioctl, using the TIOCL_GETMOUSEREPORTING
> +subcall. The values of the supported event classes (9, 1000, 1002, 1003) are
> +described in tiocl.h. Based on this information the daemon is responsible
> +for not sending data packages for unrequested events.
> +
> +A userspace client may request to be informed by the kernel about one of
> +the event classes and chose one of the data formats URXVT (1005), SRG

                         choose

> +(1006) or X10/X11 (default) via console escape sequences. In general all
> +of them encode similar information, only the escape sequences differ.
> +
> +See the xterm [1]_ or terminalguide [2]_ home pages for all details.
> +
> +Reports from kernel to userspace client
> ++++++++++++++++++++++++++++++++++++++++
> +
> +The requested events are sent by the kernel to userspace encoded in a

                                                                       an

> +escape sequence, details depend on the chosen format. All of them use one

          sequence; details

> +based pointer coordinates and a single byte to encode the button status.
> +
> +Short summary (we call this the SRG button format for the rest of this text):
> +
> + - 1,2 : Buttons, lower bits (see notes below)
> + - 3-5 : Modifier keys (Shift, Alt and Ctrl)
> + - 6   : Mouse movement only, no button status change
> + - 7-8 : Buttons, upper bits (for buttons 4-15)
> +
> +Reports send from daemon to kernel

           sent

> +++++++++++++++++++++++++++++++++++
> +
> +A report is send by a mouse daemon to the kernel via the TIOCLINUX ioctl,

               sent

> +using the TIOCL_SETSEL subcall. The coordinates are encoded zero based in
> +xs and ys, with 0,0 as upper left corner, but see note below.
> +The format used by the userspace mouse daemon for button encoding is almost
> +identical to the SRG button layout decribed above and is put into the sel_mode

                                      described

> +of the tiocl_selection struct. All bits masked in TIOCL_SELBUTTONMASK are
> +unchanged compared to the SRG button format above, the remaining three are

                                               above; the

> +changed the following way :
> +
> +- 3,4  : Unused, must be zero. The kernel knows modifier key state anyway.
> +- 5    : Always 1, identifies mouse report / TIOCL_SELMOUSEREPORT
> +
> +Notes
> ++++++
> +
> +Button numbers are encoded like this:
> +
> +- 0-2  : Left, middle and right button
> +- 3    : No button pressed / Button release
> +- 4-15 : More buttons, e.g. 4 and 5 are scroll wheel
> +
> +Please note that button releases should only be reported for buttons 0-2.
> +
> +Also note that coordinates (xs,ys,xe,ye) are zero based for the TIOCL_SETSEL
> +syscall but one based for the escape sequences sent by the kernel, so the
> +kernel will increase all coordinates by one.
> +
> +Older kernels only used the lower 4 bits of sel_mode, effectively limiting
> +the protocol to 3 buttons and button click only. The meaning of the 4 bits
> +is equivalent to the SRG button layout. Note that newer kernel will ignore

                                                           kernels

> +the upper two bits (modifier keys).
> +
> +.. [1] https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h2-Mouse-Tracking
> +.. [2] https://terminalguide.namepad.de/mouse/
> +
> +
> +
> +
> +

Drop all those ending blank lines.


thanks.
-- 
~Randy

