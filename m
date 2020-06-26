Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED1FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9981F206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oYwgaxdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgFZR4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgFZRz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:55:57 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638B9C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 10:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=XskWF0QTIZ4lHntPQXw8xyJv+6dEiZPhmaSvqFHmsJ8=; b=oYwgaxdX520yV4DRVW03qLb5Tp
        IuHgeXq+cUrwuqTOZT9qiWybJ+YfEpj1GtpYRp3W+lsNeV0b0MhauWzY9VNlTrFDyG0E8LCJTbnFS
        1CGQl/ZfZ5fHBLmNlhbpEr25hJ5f6LTzEYCKJP4FXIhDBQS0OlMRpw0C/l9GolbFL3/9/FhMun4AG
        XP8ygGUzXlP0G+vY+G/aVliXOQ61SEAPYe2c9mjpe1ra8x9u5ZD4l/wUiTRYO444SXY1L7Fj3Rnkp
        mwPa49OBfshThe8rvsRYdaADroCDIA3m2CB/1QtmUwqDovJgfN5KUDZKeM+e/CoUrCROhqKAYfUpW
        wB+yTy8g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1josZb-0002Yp-7D; Fri, 26 Jun 2020 17:55:36 +0000
Subject: Re: [PATCH v0 5/5] Add Documentation for console mouse reporting
To:     Tammo Block <tammo.block@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
References: <cover.1593155911.git.tammo.block@gmail.com>
 <1eb8c1220ad8315a05ed55a54c54e163029467f1.1593155911.git.tammo.block@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <85150f59-b69e-cc5d-9efb-6ba60f4cf504@infradead.org>
Date:   Fri, 26 Jun 2020 10:55:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1eb8c1220ad8315a05ed55a54c54e163029467f1.1593155911.git.tammo.block@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/20 12:23 AM, Tammo Block wrote:
> This patch adds a description of the kernel interface(s) used for mouse
> reporting and compares the old and new bitmask layout.
> 
> Signed-off-by: Tammo Block <tammo.block@gmail.com>
> ---
>  .../admin-guide/console-mouse-reporting.rst   | 82 +++++++++++++++++++
>  Documentation/admin-guide/index.rst           |  1 +
>  2 files changed, 83 insertions(+)
>  create mode 100644 Documentation/admin-guide/console-mouse-reporting.rst
> 
> diff --git a/Documentation/admin-guide/console-mouse-reporting.rst b/Documentation/admin-guide/console-mouse-reporting.rst
> new file mode 100644
> index 000000000000..799288295655
> --- /dev/null
> +++ b/Documentation/admin-guide/console-mouse-reporting.rst
> @@ -0,0 +1,82 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=======================
> +Console Mouse Reporting
> +=======================
> +
> +A terminal may send escape sequences to enable applications to react on mouse
> +input. As the kernel does not know when to emit these events a mouse daemon
> +is needed to react on mouse movements and signal the kernel accordingly. The

preferable:
                react to

> +kernel will then send an escape sequence to the application. This is called
> +mouse reporting and several types and protocols have been developed over time.
> +
> +See tiocl.h, the :manpage:`ioctl_console(2)` and :manpage:`console_codes(4)`
> +man pages and the xterm [1]_ or terminalguide [2]_ home pages for a detailed
> +list and description of the various protocols, their bit layout as well as
> +their limitations.
> +
> +You can check which mouse events are requested *clients* via the TIOCLINUX

                                    ^^^^^^^^^^^^^^^^^^^^^^^
I don't understand what that means.

> +ioctl, using the TIOCL_GETMOUSEREPORTING subcall. The values of these event
> +classes (9, 1000, 1002, 1003, 1005) are described in tiocl.h.
> +
> +Report layout
> +-------------
> +
> +A report is send by a mouse *daemon* to the kernel via the TIOCLINUX ioctl,

               sent (as Jiri said)

> +using the TIOCL_SETSEL subcall. The coordinates are encoded zero based in
> +xs and ys, with 0,0 as upper left corner, but see note below.
> +
> +The bits of the sel_mode are used the following way:
> +
> +X10/X11 like protocol
> ++++++++++++++++++++++
> +
> +For the X10/X11 like protocol (if DECSET 1005 is *not* set), the lower 5 bits
> +of the sel_mode are used like this:
> +
> +- 1,2  : Encode Buttons (see notes below) / TIOCL_SELBUTTONMASK
> +- 3,4  : Modifier keys (Shift, Alt) / TIOCL_SELBUTTONMASK
> +- 5    : Always 1, identifies X10 protocol / TIOCL_SELMOUSEREPORT
> +
> +SRG protocol
> +++++++++++++
> +
> +For the SRG style protocol (xterm style, DECSET 1005 *is* set) the upper 11
> +bits of sel_mode are used like this:
> +
> +- 6    : Always 1, identifies SRG protocol / TIOCL_SELSRGREPORT
> +- 7    : Unused, should be 0. Ignored by kernel (future extensions)
> +- 8    : Set on button release events / TIOCL_SELSRGRELEASE
> +- 9-16 : The SRG byte, send to userspace as is / TIOCL_SELSRGMASK

                          sent

> +
> +The SRG (upper) byte
> +++++++++++++++++++++
> +
> +The layout of the *upper byte* ("SRG") is identical to the SRG data layout,
> +for protocol "1005", as described in detail in the xterm [1]_ or
> +terminalguide [2]_ home pages. Short summary:
> +
> + - 1,2 : Buttons, lower bits (see notes below)
> + - 3-5 : Modifier keys (Shift, Alt and Ctrl)
> + - 6   : Mouse movement only, no button status change
> + - 7-8 : Buttons, upper bits (for buttons 4-15)
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
> +syscall but one based for the escape sequences send by the kernel, so the

                                                  sent

> +kernel will increase all coordinates by one.
> +
> +.. [1] https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h2-Mouse-Tracking
> +.. [2] https://terminalguide.namepad.de/mouse/
> +
> +


-- 
~Randy

