Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958BBC2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6177F206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vBlULqKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgDHOrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 10:47:01 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39636 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728716AbgDHOrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 10:47:00 -0400
Received: by mail-qk1-f196.google.com with SMTP id b62so265977qkf.6;
        Wed, 08 Apr 2020 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=siVBmthAdHFgLF9uhM5UakhjcNDqrzY58cEVl3kJ2Nc=;
        b=vBlULqKhI0EaYo7sydrnU5HqXR3aL1f+kq5OLCb2Lj1cHOMEgrrgyQIXph3wM1/moQ
         bWQXZw7fNg3h2SFeUftpzgREJHR6Pdr+PidkooC8667S7xmtpE2SYCrnwaO9BUsTo1Cu
         DVsv3Xs+zigpaiqUljyo/gCHFkjjNn6cWnjT0556ERKF+uPb8XKOF++xL89DGigAbQaT
         F5M2aTkMTrxxvGWlZjKtvmtK1xCtFZIdF49cDSiRv/7U4Y1cJcYwdfeJ9PP4RgWpvc2K
         bMFyMth2IFL0raT6Yz+Ut7l3krZngRCZQCJgn+rTwtqVWcbTTmInbwvGRfQ2kwXJOvWl
         bqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=siVBmthAdHFgLF9uhM5UakhjcNDqrzY58cEVl3kJ2Nc=;
        b=fv5h+hHPTINV6YA0rsQKH9GGrlyn0KgDla8hf6lVdVXBT0uJeUyFRJ8JU1ZtGkzMTt
         IuO5dVLrRVpNrR1NWO7lwnbdTtxtenW9rmpgtzVTyC7uyT9a3d8dfec/Qw96RMtPUDpA
         wKjzojfOZqY6Ieqi5/Lq4L+1I6y9pZejzsF+gnb7keV6mKIRPqeHpkgdly4hO81jID58
         bFXnPm1IWcx31+ARZM+AgGECXFtcbgXt6LmX+xrvFCEJqywAxIjb8e1PpGq3CXjQwX1j
         X9pLLy9TXggwVrM8YXhO58PZqtnrNpo5IX+u+6vtY7eluY15VTXaBpL8OV8YNh+yQuJ3
         bWcg==
X-Gm-Message-State: AGi0PuaWIr4VDrcZ+ZQnKTk3MkhoYRgNSv9K0AeaKMBrYyX2fdcZS8VW
        oDdxCSTWFivzxqfgCf0Vg0HN8BB7EhP+Qw==
X-Google-Smtp-Source: APiQypL/wSbX97KPtQPP+kbxWU8QDFrfXkx+WsbSyOgDYc9o3OsQ3pp+LYebwokSvcvqZj2PwzwIfw==
X-Received: by 2002:a37:6616:: with SMTP id a22mr7706216qkc.391.1586357218692;
        Wed, 08 Apr 2020 07:46:58 -0700 (PDT)
Received: from darkstar ([177.89.165.183])
        by smtp.gmail.com with ESMTPSA id m92sm19200936qtd.94.2020.04.08.07.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 07:46:58 -0700 (PDT)
Date:   Wed, 8 Apr 2020 11:46:53 -0300
From:   Cristian Souza <cristianmsbr@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, corbet@lwn.net
Subject: [PATCH v2] docs: admin-guide: Clarify sentences
Message-ID: <20200408144653.GA123268@darkstar>
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
 Documentation/admin-guide/init.rst | 35 ++++++++++++++----------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/init.rst b/Documentation/admin-guide/init.rst
index 68f2f6cf456b..0c2c9138f268 100644
--- a/Documentation/admin-guide/init.rst
+++ b/Documentation/admin-guide/init.rst
@@ -1,34 +1,30 @@
-Explaining the dreaded "No working init found." boot hang message
-=================================================================
+Explaining the "No working init found." boot hang message
+=========================================================

-OK, so you have got this pretty unintuitive message (currently located
-in init/main.c) and are wondering what went wrong.
-Some high-level reasons for failure (listed roughly in order of execution)
-to load the init binary are:
+Message location: ``init/main.c``

-A) Unable to mount root FS
-B) init binary doesn't exist on rootfs
-C) Broken console device
-D) Binary exists but dependencies not available
-E) Binary cannot be loaded
+This document provides some high-level reasons for failure
+(listed roughly in order of execution) to load the init binary.

-Detailed explanations:
-
-A) Set "debug" kernel parameter (in bootloader config file or CONFIG_CMDLINE)
+1) **Unable to mount root FS**: Set "debug" kernel parameter (in bootloader config file or CONFIG_CMDLINE)
    to get more detailed kernel messages.
-B) Make sure you have the correct root FS type
+
+2) **init binary doesn't exist on rootfs**: Make sure you have the correct root FS type
    (and ``root=`` kernel parameter points to the correct partition),
    required drivers such as storage hardware (such as SCSI or USB!)
    and filesystem (ext3, jffs2, etc.) are builtin (alternatively as modules,
-   to be pre-loaded by an initrd)
-C) Possibly a conflict in ``console= setup`` --> initial console unavailable.
+   to be pre-loaded by an initrd).
+
+3) **Broken console device**: Possibly a conflict in ``console= setup`` --> initial console unavailable.
    E.g. some serial consoles are unreliable due to serial IRQ issues (e.g.
    missing interrupt-based configuration).
    Try using a different ``console= device`` or e.g. ``netconsole=``.
-D) E.g. required library dependencies of the init binary such as
+
+4) **Binary exists but dependencies not available**: E.g. required library dependencies of the init binary such as
    ``/lib/ld-linux.so.2`` missing or broken. Use
    ``readelf -d <INIT>|grep NEEDED`` to find out which libraries are required.
-E) Make sure the binary's architecture matches your hardware.
+
+5) **Binary cannot be loaded**: Make sure the binary's architecture matches your hardware.
    E.g. i386 vs. x86_64 mismatch, or trying to load x86 on ARM hardware.
    In case you tried loading a non-binary file here (shell script?),
    you should make sure that the script specifies an interpreter in its shebang
@@ -50,3 +46,4 @@ Further TODOs:
   e.g. by providing additional error messages at affected places.

 Andreas Mohr <andi at lisas period de>
+Cristian Souza <cristianmsbr at gmail period com>
--
2.25.1
