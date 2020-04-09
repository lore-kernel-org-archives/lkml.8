Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02177C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C34222074F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:46:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3z7QB/j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgDITqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:46:45 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33968 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgDITqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:46:44 -0400
Received: by mail-qk1-f194.google.com with SMTP id i186so5378844qke.1;
        Thu, 09 Apr 2020 12:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vcnNkYD65cZvHPdMFn+PkHSwRz/TrLDpN2V4DWblgRE=;
        b=e3z7QB/jwEcj721jqewkO7fb5y+Gs1Vr1HTN3GPOwIQJRcyp54MX8a/Xqj4gvEO08i
         YpkrvIBTs3mw20tpILgmBV5i8O1lsV0NkD0vqSoJbDU1RuY5YPhPRfKHRGB+htmBRT9F
         6GZSydJJ86nphbJIMDNZBRpzEjNEefIzfYuitxJdYXS4l103lHCrhh3fKdri8gK/LiDT
         sOra30ylymtvld9WFiI4xF3WjKFMq0hnxOnQbBa+9O30H9GU36qSmNdRYvvjey/93UqZ
         MVCCAiRK2s3/MMJ9oKC7fFV/ycD6EytT5xZm2yy47zHinjyjAwov5lBYoli3hUS7H8tR
         BELQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vcnNkYD65cZvHPdMFn+PkHSwRz/TrLDpN2V4DWblgRE=;
        b=sqUSBBrR+OiPUmU5MraaGTUjUxD3hI1OW1MTsbdWP7OMzsvzwBMxBoBOsKhSaIfd1o
         KN8pOnuHPHhBPxoyoB/Ri19SdVa/3TfYHgDLUes0q89IwOOpC5sVeFpoRhrwBDasDqxb
         ysLr2Qh7iDoo5KanA1O3zY/FQRbijXpgi1L9WJ5HmcIZ2wut7rzUfSiWV7ogDH0RAAHZ
         dQO3p72jHKCNNgyhfOSn9cZby02K37+MBFGg4WRj7ETuFziuOU8cpXiv/rTLrgIp+Ehz
         r4qeKZnEkxORajeSTvj0zF3A1xm/I7p9qdM26zma488hJu6kdDy5VRxF1qQ/rW9BbHXE
         dETA==
X-Gm-Message-State: AGi0PuZwdFUCR/6DnvKp3EKOEb8dHFBv5ALGyevlaZpz4+zw6C1oqxL1
        lknTR3txds4s1wVsYc9aZbk=
X-Google-Smtp-Source: APiQypIt6LelOTKkqavBPWscgik8cCZv/c1vfkxoes5ZNKr1W1wfqnB7S8lROVaWSbvvXF62OaReQg==
X-Received: by 2002:a37:c246:: with SMTP id j6mr562717qkm.298.1586461602477;
        Thu, 09 Apr 2020 12:46:42 -0700 (PDT)
Received: from darkstar ([177.89.165.183])
        by smtp.gmail.com with ESMTPSA id l3sm10710912qkl.85.2020.04.09.12.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 12:46:41 -0700 (PDT)
Date:   Thu, 9 Apr 2020 16:46:37 -0300
From:   Cristian Souza <cristianmsbr@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH v2] docs: admin-guide: Clarify sentences
Message-ID: <20200409194637.GA141700@darkstar>
References: <20200408144653.GA123268@darkstar>
 <20200409181311.GW21484@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409181311.GW21484@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removal of unnecessary sentences, identification of authors at the top of the file,
and correction of the number of characters per line.

Signed-off-by: Cristian Souza <cristianmsbr@gmail.com>
---
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

