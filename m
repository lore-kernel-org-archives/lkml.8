Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BDAC2BB1D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE74206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 01:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4wIcfT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgDKBCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 21:02:08 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38737 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgDKBCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 21:02:08 -0400
Received: by mail-qk1-f194.google.com with SMTP id h14so3944747qke.5;
        Fri, 10 Apr 2020 18:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=uCHZQqzsLUSZfwsYBU0j4Lk4ekCfYpHpyDR1Ei7qxqo=;
        b=G4wIcfT8Z/Y1ZgJCtGYPuYhSlZLb1wrNJjTWWGR45FGFVdtNXDf694qgDwG2EvyElL
         WOHEKt2sDQ13H5pYgJh94jg67eIQx2VyBimNt4TdmPyMggb0VtHPjqOwJ5t0RTNLFfhh
         LrE3F/IFtiJt7jEFheaOQQfNmeXIvg51orHRUN+VhwHGPhhQKIT1fEVFKp0/92osVCiA
         8TF7PaYY39ScC4V9fl6ZSDQZRCDxaFF94bzW6bquOWWdcJBxUgw4iYD3g2X9iw416Lpc
         yMXU9iPTMbvf8qhT+hfF48vPz/HrJkBrPZVUiis85Exntlaa6qboiWwLw4FqXOlsTsSL
         S2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=uCHZQqzsLUSZfwsYBU0j4Lk4ekCfYpHpyDR1Ei7qxqo=;
        b=QvAzXsYz5gIyho6lxZAzBoYWyk+ERPIfMNjA+YlDwSItUeHeiJzcZ6luE0yL+IhKDG
         /2T2Q1KJvIxoeFC9j4Ntr8n5hvKkd3L0tZfZiTb1iDSZtTOhgBeSajRrUbZAE5nNHBSe
         48zuhGtUGjqg5HTRCfACT7DCiYXv5DnIyq4YIWwl2vYu1dj27/P3TmdGs+Q5/XCsDqaf
         DI2Q1VuFf89zqiEpgVD7BicSss0Et0V0HmFtkCrOGBZeldxTnI0z2AfUVxcmSqYI0zy/
         XKEpWBiN5yaljm4gbv2aRkxMA3LU02pjTiHxsgzNwbS/hsvK3zw/crI/3cSbJIrElo2y
         utKg==
X-Gm-Message-State: AGi0PuYqhsaFscmVUTvbDPha8fqlw6nNK19B2ujnlSkm/aPTWfsvFEJO
        Gzvwj3OrlngwF82YS/Ei6gIbGzo+hC985A==
X-Google-Smtp-Source: APiQypLy/o8e2yqRpsVXjOUFdLb6fmuFf4eiE2mr3OLlRD8EXOunNa1Djc3NiAa4fPjPpHdOHzunTw==
X-Received: by 2002:a05:620a:c0b:: with SMTP id l11mr6513457qki.270.1586566926628;
        Fri, 10 Apr 2020 18:02:06 -0700 (PDT)
Received: from darkstar ([177.89.165.183])
        by smtp.gmail.com with ESMTPSA id y9sm2504142qkb.41.2020.04.10.18.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 18:02:06 -0700 (PDT)
Date:   Fri, 10 Apr 2020 22:02:01 -0300
From:   Cristian Souza <cristianmsbr@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, corbet@lwn.net, willy@infradead.org
Subject: [PATCH v4] docs: admin-guide: Clarify sentences
Message-ID: <20200411010201.GA22706@darkstar>
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
Changes in v4:
 - Diff against mainline

 Documentation/admin-guide/init.rst | 76 ++++++++++++++----------------
 1 file changed, 36 insertions(+), 40 deletions(-)

diff --git a/Documentation/admin-guide/init.rst b/Documentation/admin-guide/init.rst
index e89d97f31eaf..41f06a09152e 100644
--- a/Documentation/admin-guide/init.rst
+++ b/Documentation/admin-guide/init.rst
@@ -1,52 +1,48 @@
-Explaining the dreaded "No init found." boot hang message
+Explaining the "No working init found." boot hang message
 =========================================================
+:Authors: Andreas Mohr <andi at lisas period de>
+          Cristian Souza <cristianmsbr at gmail period com>

-OK, so you've got this pretty unintuitive message (currently located
-in init/main.c) and are wondering what the H*** went wrong.
-Some high-level reasons for failure (listed roughly in order of execution)
-to load the init binary are:
-
-A) Unable to mount root FS
-B) init binary doesn't exist on rootfs
-C) broken console device
-D) binary exists but dependencies not available
-E) binary cannot be loaded
-
-Detailed explanations:
-
-A) Set "debug" kernel parameter (in bootloader config file or CONFIG_CMDLINE)
-   to get more detailed kernel messages.
-B) make sure you have the correct root FS type
-   (and ``root=`` kernel parameter points to the correct partition),
-   required drivers such as storage hardware (such as SCSI or USB!)
-   and filesystem (ext3, jffs2 etc.) are builtin (alternatively as modules,
-   to be pre-loaded by an initrd)
-C) Possibly a conflict in ``console= setup`` --> initial console unavailable.
-   E.g. some serial consoles are unreliable due to serial IRQ issues (e.g.
-   missing interrupt-based configuration).
+This document provides some high-level reasons for failure
+(listed roughly in order of execution) to load the init binary.
+
+1) **Unable to mount root FS**: Set "debug" kernel parameter (in bootloader
+   config file or CONFIG_CMDLINE) to get more detailed kernel messages.
+
+2) **init binary doesn't exist on rootfs**: Make sure you have the correct
+   root FS type (and ``root=`` kernel parameter points to the correct
+   partition), required drivers such as storage hardware (such as SCSI or
+   USB!) and filesystem (ext3, jffs2, etc.) are builtin (alternatively as
+   modules, to be pre-loaded by an initrd).
+
+3) **Broken console device**: Possibly a conflict in ``console= setup``
+   --> initial console unavailable. E.g. some serial consoles are unreliable
+   due to serial IRQ issues (e.g. missing interrupt-based configuration).
    Try using a different ``console= device`` or e.g. ``netconsole=``.
-D) e.g. required library dependencies of the init binary such as
-   ``/lib/ld-linux.so.2`` missing or broken. Use
-   ``readelf -d <INIT>|grep NEEDED`` to find out which libraries are required.
-E) make sure the binary's architecture matches your hardware.
-   E.g. i386 vs. x86_64 mismatch, or trying to load x86 on ARM hardware.
-   In case you tried loading a non-binary file here (shell script?),
-   you should make sure that the script specifies an interpreter in its shebang
-   header line (``#!/...``) that is fully working (including its library
-   dependencies). And before tackling scripts, better first test a simple
-   non-script binary such as ``/bin/sh`` and confirm its successful execution.
-   To find out more, add code ``to init/main.c`` to display kernel_execve()s
-   return values.
+
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
-which needs to be made as painless as possible), then submit patch to LKML.
+which needs to be made as painless as possible), then submit a patch to LKML.
 Further TODOs:

 - Implement the various ``run_init_process()`` invocations via a struct array
   which can then store the ``kernel_execve()`` result value and on failure
   log it all by iterating over **all** results (very important usability fix).
-- try to make the implementation itself more helpful in general,
-  e.g. by providing additional error messages at affected places.
+- Try to make the implementation itself more helpful in general, e.g. by
+  providing additional error messages at affected places.

-Andreas Mohr <andi at lisas period de>
--
2.25.1
