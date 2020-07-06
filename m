Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EECC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8224206E9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 11:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhsQDGS9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgGFLAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 07:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbgGFLAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 07:00:21 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE02FC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 04:00:20 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id q5so40303819wru.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 04:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DROFpnBFrE4AtjKVynyf3d8aaP4nTs4hoGNau1puBxU=;
        b=IhsQDGS9YQ/3aNt+HywQjsJPSy6KwEooCmzK+h9GGokiS/sS6Yq0Pjn/4DFqT65AdJ
         gVvOJtlb2mEtDmE2xgLkHVkaltXmZMrGGRMJpzomazmum6rqrGtYJiU7tOyJ4suRgznf
         cYIQVtRD/p17h2HGMHtglJI5a/DZGmy35Jl8p6fkigtHknxjmmWPf3hRDrTOF8yqzKj6
         M0t6pCTo0MYfFfTZVdwNlW/EHtUjM9FrNXUbOqyX9j1WccQxCoMsES8SfWsdNG9wluyd
         eJrOrUa5lRA603NIayCnD42yYJbxsUBHCE8E7rrCUZk1zN7QIaueCaNtCAUdDwOk0r0s
         96Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DROFpnBFrE4AtjKVynyf3d8aaP4nTs4hoGNau1puBxU=;
        b=iqfAB7uGbNoAD6FttjpXWMFSFDi+t9yN+OPJpuJwgPmn87gi8TyV0rtNpisgH2gYfW
         SnICOr7bGvUW1FhA0KWj72M0Rtb8byEtklG8r92KIiESapmCKeit/3j5eX8t4fkRfWu1
         2A9hABglMA7D1Y5JY9FoRxdy4csTn3BS5L6wqyJcJ/GhSyLaVS47ikCN+r5sbnTBUfrF
         KWSnZz5O+/cd4z0m+P5S2SKNuB+kr4f7Kx5T/CVQ6cCSrWRSMbAEBZvvbhp3SvrKMh9d
         yD3tnfOb4DAQlwi5Ln1ucefRhNDBxZWL77+9p/f3zMS9Sp9T2NpqmlWVt90SMLLfVsPJ
         PW8A==
X-Gm-Message-State: AOAM530iZ2+vMPYZEi9UH3V/Ub817q7q4AgOc7/MlM5xZPvlFMbx/XMS
        7jVGt4HHuvfrcKvVnjyvFB7iODF8Diw=
X-Google-Smtp-Source: ABdhPJzMYgg7aSGG3L5htMIEccPSN0wer6gpmayI8AFXcvfBOx0rrS6HrOLSpiYHQywz2WoXtI86Cw==
X-Received: by 2002:adf:9525:: with SMTP id 34mr50926244wrs.313.1594033219211;
        Mon, 06 Jul 2020 04:00:19 -0700 (PDT)
Received: from maphy.uni-hannover.de ([130.75.75.70])
        by smtp.gmail.com with ESMTPSA id k126sm23527764wmf.3.2020.07.06.04.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 04:00:18 -0700 (PDT)
Date:   Mon, 6 Jul 2020 13:00:17 +0200
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 6/6] Documentation: Describe console mouse reporting
Message-ID: <59a6057afa3b2310384f489b35e15eb624af2774.1594032517.git.tammo.block@gmail.com>
References: <cover.1594032517.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1594032517.git.tammo.block@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a description of the kernel interface(s) used for vt
console mouse reporting and describes the protocols and bitmasks.

Signed-off-by: Tammo Block <tammo.block@gmail.com>
---
 .../admin-guide/console-mouse-reporting.rst   | 88 +++++++++++++++++++
 Documentation/admin-guide/index.rst           |  1 +
 2 files changed, 89 insertions(+)
 create mode 100644 Documentation/admin-guide/console-mouse-reporting.rst

diff --git a/Documentation/admin-guide/console-mouse-reporting.rst b/Documentation/admin-guide/console-mouse-reporting.rst
new file mode 100644
index 000000000000..a05dfe251daf
--- /dev/null
+++ b/Documentation/admin-guide/console-mouse-reporting.rst
@@ -0,0 +1,88 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+Console Mouse Reporting
+=======================
+
+A terminal may send escape sequences to enable applications to react to mouse
+input. As the kernel does not know when to emit these events a mouse daemon
+is needed to react to mouse movements and signal the kernel accordingly. The
+kernel will then send an escape sequence to the application. This is called
+mouse reporting and several types and protocols have been developed over time.
+
+See tiocl.h, the :manpage:`ioctl_console(2)` and :manpage:`console_codes(4)`
+man pages and the xterm [1]_ or terminalguide [2]_ home pages for a detailed
+list and description of the various protocols, their bit layout as well as
+their limitations.
+
+Events and formats
+++++++++++++++++++
+
+A Linux console keeps state about two different aspects of mouse reporting,
+the kind of **events** to be reported and the **format** to send to userspace.
+
+A mouse daemon can check which kind of mouse events a client wants to be
+informed about via the TIOCLINUX ioctl, using the TIOCL_GETMOUSEREPORTING
+subcall. The values of the supported event classes (9, 1000, 1002, 1003) are
+described in tiocl.h. Based on this information the daemon is responsible
+for not sending data packages for unrequested events.
+
+A userspace client may request to be informed by the kernel about one of
+the event classes and choose one of the data formats URXVT (1005), SRG
+(1006) or X10/X11 (default) via console escape sequences. In general all
+of them encode similar information, only the escape sequences differ.
+
+See the xterm [1]_ or terminalguide [2]_ home pages for all details.
+
+Reports from kernel to userspace client
++++++++++++++++++++++++++++++++++++++++
+
+The requested events are sent by the kernel to userspace encoded in an
+escape sequence; details depend on the chosen format. All of them use one
+based pointer coordinates and a single byte to encode the button status.
+
+Short summary (we call this the SRG button format for the rest of this text):
+
+ - 1,2 : Buttons, lower bits (see notes below)
+ - 3-5 : Modifier keys (Shift, Alt and Ctrl)
+ - 6   : Mouse movement only, no button status change
+ - 7-8 : Buttons, upper bits (for buttons 4-15)
+
+Reports sent from daemon to kernel
+++++++++++++++++++++++++++++++++++
+
+A report is sent by a mouse daemon to the kernel via the TIOCLINUX ioctl,
+using the TIOCL_SETSEL subcall. The coordinates are encoded zero based in
+xs and ys, with 0,0 as the upper left corner, but see the note below.
+The format used by the userspace mouse daemon for button encoding is almost
+identical to the SRG button layout described above and is put into the sel_mode
+of the tiocl_selection struct. All bits masked in TIOCL_SELBUTTONMASK are
+unchanged compared to the SRG button format above; the remaining three are
+changed the following way:
+
+- 3,4  : Unused, must be zero. The kernel knows modifier key state anyway.
+- 5    : Always 1, identifies mouse report / TIOCL_SELMOUSEREPORT
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
+syscall but one based for the escape sequences sent by the kernel, so the
+kernel will increase all coordinates by one.
+
+Older kernels only used the lower 4 bits of sel_mode, effectively limiting
+the protocol to 3 buttons and button click only. The meaning of the 4 bits
+is equivalent to the SRG button layout. Note that newer kernels will ignore
+the upper two bits (modifier keys).
+
+.. [1] https://invisible-island.net/xterm/ctlseqs/ctlseqs.html#h2-Mouse-Tracking
+.. [2] https://terminalguide.namepad.de/mouse/
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

