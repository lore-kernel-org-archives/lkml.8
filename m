Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B3CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE0820760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b3oPVpuK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732043AbgGAPbP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731608AbgGAPbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:31:14 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E32CC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 08:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=RclAIIkZW3ZiXGcGlVoas281Hc1XxmdGe8QV2kbulsU=; b=b3oPVpuKnOK70sQ8PtkU3B/W9T
        Ib2kMj/r72OrROoaxbDMI5rASQC/j70EMitwdCKYE+Ya7zkkbgwbjTLB4Yf3C+kV0HyScWE8EFMo7
        5e0uUPc+cm594b8dCqGIBebLgLUDgjykt9JdO1iQj7WtqL0cGAFjFlQW5riDimJk0qi0oh0avZwrv
        pMpTWaKVzKxsBeRivyhlsIJj9HaLt0MAzffAcubhhe+XW7FJLELmpyxXpxKznxvWYUeh1E5D16OfW
        yUMj234NP6tMHQvQn7h20Rl5HP6tduRfJP0oI0wtp2eg+5ek10U6qUYzsjMxJazjB7kLyPUIUBtfj
        y2ezYntg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqeha-0001IS-Eu; Wed, 01 Jul 2020 15:31:10 +0000
Subject: Re: [PATCH v2 6/6] Documentation: Describe console mouse reporting
To:     Tammo Block <tammo.block@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
References: <cover.1593615440.git.tammo.block@gmail.com>
 <1a16072f2e8152e4cd3a9d733bf8bed84228e9de.1593615440.git.tammo.block@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8986005c-9d82-c958-c902-f77175d71012@infradead.org>
Date:   Wed, 1 Jul 2020 08:31:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1a16072f2e8152e4cd3a9d733bf8bed84228e9de.1593615440.git.tammo.block@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/20 8:14 AM, Tammo Block wrote:
> This patch adds a description of the kernel interface(s) used for vt
> console mouse reporting and describes the protocols and bitmasks.
> 
> Signed-off-by: Tammo Block <tammo.block@gmail.com>
> ---
>  .../admin-guide/console-mouse-reporting.rst   | 88 +++++++++++++++++++
>  Documentation/admin-guide/index.rst           |  1 +
>  2 files changed, 89 insertions(+)
>  create mode 100644 Documentation/admin-guide/console-mouse-reporting.rst
> 
> diff --git a/Documentation/admin-guide/console-mouse-reporting.rst b/Documentation/admin-guide/console-mouse-reporting.rst
> new file mode 100644
> index 000000000000..c75a627f27b8
> --- /dev/null
> +++ b/Documentation/admin-guide/console-mouse-reporting.rst
> @@ -0,0 +1,88 @@
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
> +A Linux console keeps state about two different aspects of mouse reporting,
> +the kind of **events** to be reported and the **format** to send to userspace.
> +
> +A mouse daemon can check which kind of mouse events a client wants to be
> +informed about via the TIOCLINUX ioctl, using the TIOCL_GETMOUSEREPORTING
> +subcall. The values of the supported event classes (9, 1000, 1002, 1003) are
> +described in tiocl.h. Based on this information the daemon is responsible
> +for not sending data packages for unrequested events.
> +
> +A userspace client may request to be informed by the kernel about one of
> +the event classes and choose one of the data formats URXVT (1005), SRG
> +(1006) or X10/X11 (default) via console escape sequences. In general all
> +of them encode similar information, only the escape sequences differ.
> +
> +See the xterm [1]_ or terminalguide [2]_ home pages for all details.
> +
> +Reports from kernel to userspace client
> ++++++++++++++++++++++++++++++++++++++++
> +
> +The requested events are sent by the kernel to userspace encoded in an
> +escape sequences; details depend on the chosen format. All of them use one

          sequence;

(this word was correct in v1)

> +based pointer coordinates and a single byte to encode the button status.
> +
> +Short summary (we call this the SRG button format for the rest of this text):
> +
> + - 1,2 : Buttons, lower bits (see notes below)
> + - 3-5 : Modifier keys (Shift, Alt and Ctrl)
> + - 6   : Mouse movement only, no button status change
> + - 7-8 : Buttons, upper bits (for buttons 4-15)
> +
> +Reports sent from daemon to kernel
> +++++++++++++++++++++++++++++++++++
> +
> +A report is sent by a mouse daemon to the kernel via the TIOCLINUX ioctl,
> +using the TIOCL_SETSEL subcall. The coordinates are encoded zero based in
> +xs and ys, with 0,0 as the upper left corner, but see the note below.
> +The format used by the userspace mouse daemon for button encoding is almost
> +identical to the SRG button layout described above and is put into the sel_mode
> +of the tiocl_selection struct. All bits masked in TIOCL_SELBUTTONMASK are
> +unchanged compared to the SRG button format above; the remaining three are
> +changed the following way:
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
> +is equivalent to the SRG button layout. Note that newer kernels will ignore
> +the upper two bits (modifier keys).
> +
> +.. [1] https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h2-Mouse-Tracking
> +.. [2] https://terminalguide.namepad.de/mouse/
> +

thanks.
-- 
~Randy

