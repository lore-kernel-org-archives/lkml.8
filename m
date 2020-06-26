Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90391C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A001207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbgFZH2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:28:35 -0400
Received: from mailout2n.rrzn.uni-hannover.de ([130.75.2.113]:37597 "EHLO
        mailout2n.rrzn.uni-hannover.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728341AbgFZH2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 03:28:35 -0400
Received: from ytterbium.maphy.uni-hannover.de (ytterbium.maphy.uni-hannover.de [130.75.75.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailout2n.rrzn.uni-hannover.de (Postfix) with ESMTPSA id D3FB21F56A;
        Fri, 26 Jun 2020 09:23:18 +0200 (CEST)
Received: by ytterbium.maphy.uni-hannover.de (sSMTP sendmail emulation); Fri, 26 Jun 2020 09:23:18 +0200
Date:   Fri, 26 Jun 2020 09:23:18 +0200
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v0 5/5] Add Documentation for console mouse reporting
Message-ID: <1eb8c1220ad8315a05ed55a54c54e163029467f1.1593155911.git.tammo.block@gmail.com>
References: <cover.1593155911.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1593155911.git.tammo.block@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a description of the kernel interface(s) used for mouse
reporting and compares the old and new bitmask layout.

Signed-off-by: Tammo Block <tammo.block@gmail.com>
---
 .../admin-guide/console-mouse-reporting.rst   | 82 +++++++++++++++++++
 Documentation/admin-guide/index.rst           |  1 +
 2 files changed, 83 insertions(+)
 create mode 100644 Documentation/admin-guide/console-mouse-reporting.rst

diff --git a/Documentation/admin-guide/console-mouse-reporting.rst b/Documentation/admin-guide/console-mouse-reporting.rst
new file mode 100644
index 000000000000..799288295655
--- /dev/null
+++ b/Documentation/admin-guide/console-mouse-reporting.rst
@@ -0,0 +1,82 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+Console Mouse Reporting
+=======================
+
+A terminal may send escape sequences to enable applications to react on mouse
+input. As the kernel does not know when to emit these events a mouse daemon
+is needed to react on mouse movements and signal the kernel accordingly. The
+kernel will then send an escape sequence to the application. This is called
+mouse reporting and several types and protocols have been developed over time.
+
+See tiocl.h, the :manpage:`ioctl_console(2)` and :manpage:`console_codes(4)`
+man pages and the xterm [1]_ or terminalguide [2]_ home pages for a detailed
+list and description of the various protocols, their bit layout as well as
+their limitations.
+
+You can check which mouse events are requested *clients* via the TIOCLINUX
+ioctl, using the TIOCL_GETMOUSEREPORTING subcall. The values of these event
+classes (9, 1000, 1002, 1003, 1005) are described in tiocl.h.
+
+Report layout
+-------------
+
+A report is send by a mouse *daemon* to the kernel via the TIOCLINUX ioctl,
+using the TIOCL_SETSEL subcall. The coordinates are encoded zero based in
+xs and ys, with 0,0 as upper left corner, but see note below.
+
+The bits of the sel_mode are used the following way:
+
+X10/X11 like protocol
++++++++++++++++++++++
+
+For the X10/X11 like protocol (if DECSET 1005 is *not* set), the lower 5 bits
+of the sel_mode are used like this:
+
+- 1,2  : Encode Buttons (see notes below) / TIOCL_SELBUTTONMASK
+- 3,4  : Modifier keys (Shift, Alt) / TIOCL_SELBUTTONMASK
+- 5    : Always 1, identifies X10 protocol / TIOCL_SELMOUSEREPORT
+
+SRG protocol
+++++++++++++
+
+For the SRG style protocol (xterm style, DECSET 1005 *is* set) the upper 11
+bits of sel_mode are used like this:
+
+- 6    : Always 1, identifies SRG protocol / TIOCL_SELSRGREPORT
+- 7    : Unused, should be 0. Ignored by kernel (future extensions)
+- 8    : Set on button release events / TIOCL_SELSRGRELEASE
+- 9-16 : The SRG byte, send to userspace as is / TIOCL_SELSRGMASK
+
+The SRG (upper) byte
+++++++++++++++++++++
+
+The layout of the *upper byte* ("SRG") is identical to the SRG data layout,
+for protocol "1005", as described in detail in the xterm [1]_ or
+terminalguide [2]_ home pages. Short summary:
+
+ - 1,2 : Buttons, lower bits (see notes below)
+ - 3-5 : Modifier keys (Shift, Alt and Ctrl)
+ - 6   : Mouse movement only, no button status change
+ - 7-8 : Buttons, upper bits (for buttons 4-15)
+
+Notes
++++++
+
+Button numbers are encoded like this:
+
+- 0-2  : Left, middle and right button
+- 3    : No button pressed / Button release
+- 4-15 : More buttons, e.g. 4 and 5 are scroll wheel
+
+Please note that button releases should only be reported for buttons 0-2.
+
+Also note that coordinates (xs,ys,xe,ye) are zero based for the TIOCL_SETSEL
+syscall but one based for the escape sequences send by the kernel, so the
+kernel will increase all coordinates by one.
+
+.. [1] https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h2-Mouse-Tracking
+.. [2] https://terminalguide.namepad.de/mouse/
+
+
diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 58c7f9fc2396..c535902f3851 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -71,6 +71,7 @@ configure specific aspects of kernel behavior to your liking.
    cgroup-v2
    cifs/index
    clearing-warn-once
+   console-mouse-reporting
    cpu-load
    cputopology
    dell_rbu
-- 
2.27.0

