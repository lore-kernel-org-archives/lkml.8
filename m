Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B69FC33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 16:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0260D205F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 16:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580575822;
	bh=cz2jaRYgs63UkaIzhYF0qCRKMvYvKyiGNaEhnLQYLCE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=s/L3L0eDOaBLbOrihZDK3wDszaUtYxWdiqIqMb4+0eM8sT0UdQKMBoSImcip6YpvG
	 vdy9l6dw7mGJxeq+iZ1xFuVfvPnWuxr02ctNPnoMeVumiux/o0mWG3vbXeTrZA27SI
	 38/4i3q32ccoXaQsXtLn4cqE24vxk4SIdigVB5zc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgBAQuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 11:50:21 -0500
Received: from conuserg-09.nifty.com ([210.131.2.76]:63393 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgBAQuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 11:50:20 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 011GnQ2n014749;
        Sun, 2 Feb 2020 01:49:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 011GnQ2n014749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1580575766;
        bh=+liGyO13j1pVITn3Gx2mtqaSG3y9ETg34rlRB39rH/4=;
        h=From:To:Cc:Subject:Date:From;
        b=yN+UtQYH3VaMnqtFmbuUWxHCoT1TMBb7zCM7XwH5xMhWTI1rvZtM/3HfHsvzGTniN
         HzuvvdBp3u6iYhRtGYxiVsAtFl0migbH9wvHB8AJjr4VTsBW0rhuYu8YJWzzQ3usCS
         0AHMe2ooUS830XWTqP5D75Y7n24VMcsiBUdT23Y1SmZHq0VRuP22wOHUDIS028KrLN
         X8xx8dp9dmwkr5d2UdO+aeOOBS3svYn+K4uL0uNWXumgD3sU/CG8UliwQ7SF+St9QT
         YI0SQ9HPvYPO366k9UBagl0T7aEwRkZ7OYX1bne9qqI6c/ETNRii3WxvOtH+aY2cIW
         epXEu6E5EPeUQ==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/2] kbuild: fix the document to use extra-y for vmlinux.lds
Date:   Sun,  2 Feb 2020 01:49:23 +0900
Message-Id: <20200201164924.5487-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The difference between "always" and "extra-y" is that the targets
listed in $(always) are always built, whereas the ones in $(extra-y)
are built only when KBUILD_BUILTIN is set.

So, "make modules" does not build the targets in $(extra-y).

vmlinux.lds is only needed for linking vmlinux. So, adding it to extra-y
is more correct. In fact, arch/x86/kernel/Makefile does this.

Fix the example code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Documentation/kbuild/makefiles.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index d7e6534a8505..b1733b877025 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -1269,12 +1269,12 @@ When kbuild executes, the following steps are followed (roughly):
 	Example::
 
 		#arch/x86/kernel/Makefile
-		always := vmlinux.lds
+		extra-y := vmlinux.lds
 
 		#Makefile
 		export CPPFLAGS_vmlinux.lds += -P -C -U$(ARCH)
 
-	The assignment to $(always) is used to tell kbuild to build the
+	The assignment to extra-y is used to tell kbuild to build the
 	target vmlinux.lds.
 	The assignment to $(CPPFLAGS_vmlinux.lds) tells kbuild to use the
 	specified options when building the target vmlinux.lds.
-- 
2.17.1

