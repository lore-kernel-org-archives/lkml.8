Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD001C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3ED20748
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 21:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVEu4Xou"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgDGVU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 17:20:57 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44173 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgDGVU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:20:57 -0400
Received: by mail-qt1-f193.google.com with SMTP id x16so3930266qts.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 14:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=eY5d6ZavaIVAvbx8NYtgXr1qanyD8WK2AjrNomfEZy0=;
        b=YVEu4Xouj0grHaPP+GEssOMfrIT0PgK/AJiLYhCagBO+4KhKOc/XWZLg/nDP5PCSxY
         wMiMbk4YK+de8T7Qv+vrrUG06CpE8ar/zd5UA06SNC8BJoOqZQ4JtfirItWlDI0CQlC2
         AH7s41HcTfR7GSU63ElWhx4IGSjMNMrpbTUIvXOkGvySHMkMPWXNHIaVHhy9GD8GWlLY
         sWfLDpvw4ftmBRNgnEuMnCi2xdRPptXjilqWJfXqdsPaF0PiZLIEahF/mUs17IseVlu+
         goS38Kxmo1e7Jhj8fNeq3SMXAXLCWuEu6PDTv+GnPr14+ascReBPYGdZ4q3NcWyWveYi
         UvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=eY5d6ZavaIVAvbx8NYtgXr1qanyD8WK2AjrNomfEZy0=;
        b=OjCn02ADirSrBJYSzownmxjzMshjWVScURfwEBaNWISyBxVCbfFSHspj0zStABIsj9
         kEyKJks8hjzN0nmI5PGxEPSTiV94s9jVt2USGFo6gB2vIMEnR//Whr5P0ITTcvR2Sle6
         y4G4I3jx8cmPB5cm5HQVvVEfWyNjPJufPy7HvRgR0uixswWa7Z+17BQm7PDeCsiUF/ni
         IWnTBbivH4zikbKn4X45QtOX3SsyVGoGhxXCkMiTnwSl0Wx+iGg+ievkgXn9tqo+NnwO
         H/7uGG4btpbiWGxo7p3U8aupgjJhmMl4+K9kX2CJy8TSkwucRHEOAbWYR9ynBD9i5Q4x
         wL/A==
X-Gm-Message-State: AGi0Pua4LHxOVz11DO7nlPR3Tk9LFGULUANt3gmwFTPtVjqZxtlMs0nz
        8cJFipYlrbRmLwcYEeKCwGPbNjwNaGU=
X-Google-Smtp-Source: APiQypKyKap0GnKvQbnYxuIDuzN9ySOXXPpVXSGMu4IDl5ZMUL2kLobqalRu68unaPRejcV6BOdPXA==
X-Received: by 2002:aed:2591:: with SMTP id x17mr4284846qtc.76.1586294455964;
        Tue, 07 Apr 2020 14:20:55 -0700 (PDT)
Received: from darkstar ([177.89.165.183])
        by smtp.gmail.com with ESMTPSA id l186sm6808089qke.16.2020.04.07.14.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 14:20:55 -0700 (PDT)
Date:   Tue, 7 Apr 2020 18:20:51 -0300
From:   Cristian Souza <cristianmsbr@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     corbet@lwn.net
Subject: [PATCH] docs: admin-guide: Clarify sentences
Message-ID: <20200407212051.GA22156@darkstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling mistakes corrected for easy reading.

Signed-off-by: Cristian Souza <cristianmsbr@gmail.com>
---
 Documentation/admin-guide/init.rst | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/init.rst b/Documentation/admin-guide/init.rst
index e89d97f31eaf..68f2f6cf456b 100644
--- a/Documentation/admin-guide/init.rst
+++ b/Documentation/admin-guide/init.rst
@@ -1,34 +1,34 @@
-Explaining the dreaded "No init found." boot hang message
-=========================================================
+Explaining the dreaded "No working init found." boot hang message
+=================================================================

-OK, so you've got this pretty unintuitive message (currently located
-in init/main.c) and are wondering what the H*** went wrong.
+OK, so you have got this pretty unintuitive message (currently located
+in init/main.c) and are wondering what went wrong.
 Some high-level reasons for failure (listed roughly in order of execution)
 to load the init binary are:

 A) Unable to mount root FS
 B) init binary doesn't exist on rootfs
-C) broken console device
-D) binary exists but dependencies not available
-E) binary cannot be loaded
+C) Broken console device
+D) Binary exists but dependencies not available
+E) Binary cannot be loaded

 Detailed explanations:

 A) Set "debug" kernel parameter (in bootloader config file or CONFIG_CMDLINE)
    to get more detailed kernel messages.
-B) make sure you have the correct root FS type
+B) Make sure you have the correct root FS type
    (and ``root=`` kernel parameter points to the correct partition),
    required drivers such as storage hardware (such as SCSI or USB!)
-   and filesystem (ext3, jffs2 etc.) are builtin (alternatively as modules,
+   and filesystem (ext3, jffs2, etc.) are builtin (alternatively as modules,
    to be pre-loaded by an initrd)
 C) Possibly a conflict in ``console= setup`` --> initial console unavailable.
    E.g. some serial consoles are unreliable due to serial IRQ issues (e.g.
    missing interrupt-based configuration).
    Try using a different ``console= device`` or e.g. ``netconsole=``.
-D) e.g. required library dependencies of the init binary such as
+D) E.g. required library dependencies of the init binary such as
    ``/lib/ld-linux.so.2`` missing or broken. Use
    ``readelf -d <INIT>|grep NEEDED`` to find out which libraries are required.
-E) make sure the binary's architecture matches your hardware.
+E) Make sure the binary's architecture matches your hardware.
    E.g. i386 vs. x86_64 mismatch, or trying to load x86 on ARM hardware.
    In case you tried loading a non-binary file here (shell script?),
    you should make sure that the script specifies an interpreter in its shebang
@@ -40,13 +40,13 @@ E) make sure the binary's architecture matches your hardware.

 Please extend this explanation whenever you find new failure causes
 (after all loading the init binary is a CRITICAL and hard transition step
-which needs to be made as painless as possible), then submit patch to LKML.
+which needs to be made as painless as possible), then submit a patch to LKML.
 Further TODOs:

 - Implement the various ``run_init_process()`` invocations via a struct array
   which can then store the ``kernel_execve()`` result value and on failure
   log it all by iterating over **all** results (very important usability fix).
-- try to make the implementation itself more helpful in general,
+- Try to make the implementation itself more helpful in general,
   e.g. by providing additional error messages at affected places.

 Andreas Mohr <andi at lisas period de>
--
2.25.1
