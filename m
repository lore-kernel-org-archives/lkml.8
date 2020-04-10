Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA655C2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 20:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A992078E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 20:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwIPwNyc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDJUDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 16:03:52 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:41294 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgDJUDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 16:03:52 -0400
Received: by mail-qv1-f67.google.com with SMTP id y16so1467001qvp.8;
        Fri, 10 Apr 2020 13:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=wlB9KQoEzyw2uD6EwYgr+3SPTA1uqMIIAHShVGWPQno=;
        b=MwIPwNycgFupo0shQhepifv9g41x8tss2kkSa11EGb1mxz0rQRWs69V5CRHOwn/GSm
         S0C0naUkylybXgfFSJxruwWHtzoYGIm8NUVzKhbXo00WcBoofdLFNGCUrWc9DmJZOJQK
         NCvzWZLqQbuudF5mUAlRK45ujT70DHYV62nAhwxI2GfxfIaSLC5KACVMhvputofzBck0
         C7x0w7JFLukXQ5M2zrGIV5k11WbqzxBtx2nxlCicyHly+xwdWatkHPutgBANoI3uVUPv
         N1N8d9XHCLeAha2n6hq5dy3sSKxSZAnVAl46puOJZ7rPibULBFqtklir+ym/IQKJRxhh
         2C0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=wlB9KQoEzyw2uD6EwYgr+3SPTA1uqMIIAHShVGWPQno=;
        b=ElhlHF+OGJbWEuYk6TtiC7jn5AgAejF2Fh86e4UFFrBti9guYnUkROJbD3u1kaosKM
         asSnHoNLoa7tLzH/Cmi7G7I8j2eO0xSdV94qxrl27kvMMc+ISy4m++xAogmpTA+ZjZiC
         s6Oz0pfYMRJOcOkM2vDb/ivmGkRoPiNq0bk7nQdZaimcFfLlwzyUQL0PrOoEC3KoCLlh
         2EtK+lYwYN0u/WfIeRdV2bU0bg7e+ISLYIVgK6XzCGbiqcIDf3tfPXM0+cGXcXKCUD6g
         Pzi976dfYE+abByybTbnyEozMU2IBojMvACX8Hds9KVfiGrNJyU7MgIgj1Rg3P6dCc9h
         D0JA==
X-Gm-Message-State: AGi0PuZvNFc2UgvJj7j9nqkUdgYYNteYIz8PnIx7MUMtJcBQ0SyAY7qV
        N/gGM4LbSuqVRxULpOj072F366t9/o6h9Q==
X-Google-Smtp-Source: APiQypLs26QKYqNz1tAwi7/rodeGouqlPOdxJqen56m07wzSjlTgWYPy6YXd8JVi/hgk/OKkUmW5JA==
X-Received: by 2002:ad4:498c:: with SMTP id t12mr6823037qvx.27.1586549030517;
        Fri, 10 Apr 2020 13:03:50 -0700 (PDT)
Received: from darkstar ([177.89.165.183])
        by smtp.gmail.com with ESMTPSA id 206sm2361151qkn.36.2020.04.10.13.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 13:03:50 -0700 (PDT)
Date:   Fri, 10 Apr 2020 17:03:45 -0300
From:   Cristian Souza <cristianmsbr@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, corbet@lwn.net, willy@infradead.org
Subject: [PATCH v3] docs: admin-guide: Clarify sentences
Message-ID: <20200410200345.GA36148@darkstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes to make the text more formal and organized. The reasons are now cited and described at the same time.
Minor grammatical problems have also been fixed.

Signed-off-by: Cristian Souza <cristianmsbr@gmail.com>
---
Changes in v2:
 - Text more formal and organized
Changes in v3:
 - Authors at the top of the file
 - Removal of the source file in which the message is located
 - All lines under 80 characters

 Documentation/admin-guide/init.rst | 57 +++++++++++++++---------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/Documentation/admin-guide/init.rst b/Documentation/admin-guide/init.rst
index 0c2c9138f268..41f06a09152e 100644
--- a/Documentation/admin-guide/init.rst
+++ b/Documentation/admin-guide/init.rst
@@ -1,38 +1,39 @@
 Explaining the "No working init found." boot hang message
 =========================================================
-
-Message location: ``init/main.c``
+:Authors: Andreas Mohr <andi at lisas period de>
+          Cristian Souza <cristianmsbr at gmail period com>

 This document provides some high-level reasons for failure
 (listed roughly in order of execution) to load the init binary.

-1) **Unable to mount root FS**: Set "debug" kernel parameter (in bootloader config file or CONFIG_CMDLINE)
-   to get more detailed kernel messages.
+1) **Unable to mount root FS**: Set "debug" kernel parameter (in bootloader
+   config file or CONFIG_CMDLINE) to get more detailed kernel messages.

-2) **init binary doesn't exist on rootfs**: Make sure you have the correct root FS type
-   (and ``root=`` kernel parameter points to the correct partition),
-   required drivers such as storage hardware (such as SCSI or USB!)
-   and filesystem (ext3, jffs2, etc.) are builtin (alternatively as modules,
-   to be pre-loaded by an initrd).
+2) **init binary doesn't exist on rootfs**: Make sure you have the correct
+   root FS type (and ``root=`` kernel parameter points to the correct
+   partition), required drivers such as storage hardware (such as SCSI or
+   USB!) and filesystem (ext3, jffs2, etc.) are builtin (alternatively as
+   modules, to be pre-loaded by an initrd).

-3) **Broken console device**: Possibly a conflict in ``console= setup`` --> initial console unavailable.
-   E.g. some serial consoles are unreliable due to serial IRQ issues (e.g.
-   missing interrupt-based configuration).
+3) **Broken console device**: Possibly a conflict in ``console= setup``
+   --> initial console unavailable. E.g. some serial consoles are unreliable
+   due to serial IRQ issues (e.g. missing interrupt-based configuration).
    Try using a different ``console= device`` or e.g. ``netconsole=``.

-4) **Binary exists but dependencies not available**: E.g. required library dependencies of the init binary such as
-   ``/lib/ld-linux.so.2`` missing or broken. Use
-   ``readelf -d <INIT>|grep NEEDED`` to find out which libraries are required.
-
-5) **Binary cannot be loaded**: Make sure the binary's architecture matches your hardware.
-   E.g. i386 vs. x86_64 mismatch, or trying to load x86 on ARM hardware.
-   In case you tried loading a non-binary file here (shell script?),
-   you should make sure that the script specifies an interpreter in its shebang
-   header line (``#!/...``) that is fully working (including its library
-   dependencies). And before tackling scripts, better first test a simple
-   non-script binary such as ``/bin/sh`` and confirm its successful execution.
-   To find out more, add code ``to init/main.c`` to display kernel_execve()s
-   return values.
+4) **Binary exists but dependencies not available**: E.g. required library
+   dependencies of the init binary such as ``/lib/ld-linux.so.2`` missing or
+   broken. Use ``readelf -d <INIT>|grep NEEDED`` to find out which libraries
+   are required.
+
+5) **Binary cannot be loaded**: Make sure the binary's architecture matches
+   your hardware. E.g. i386 vs. x86_64 mismatch, or trying to load x86 on ARM
+   hardware. In case you tried loading a non-binary file here (shell script?),
+   you should make sure that the script specifies an interpreter in its
+   shebang header line (``#!/...``) that is fully working (including its
+   library dependencies). And before tackling scripts, better first test a
+   simple non-script binary such as ``/bin/sh`` and confirm its successful
+   execution. To find out more, add code ``to init/main.c`` to display
+   kernel_execve()s return values.

 Please extend this explanation whenever you find new failure causes
 (after all loading the init binary is a CRITICAL and hard transition step
@@ -42,8 +43,6 @@ Further TODOs:
 - Implement the various ``run_init_process()`` invocations via a struct array
   which can then store the ``kernel_execve()`` result value and on failure
   log it all by iterating over **all** results (very important usability fix).
-- Try to make the implementation itself more helpful in general,
-  e.g. by providing additional error messages at affected places.
+- Try to make the implementation itself more helpful in general, e.g. by
+  providing additional error messages at affected places.

-Andreas Mohr <andi at lisas period de>
-Cristian Souza <cristianmsbr at gmail period com>
--
2.25.1
