Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27314C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82DB20737
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2FsSrJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgCYXNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:13:08 -0400
Received: from mail-pj1-f73.google.com ([209.85.216.73]:43239 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgCYXNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 19:13:08 -0400
Received: by mail-pj1-f73.google.com with SMTP id i3so2824966pjx.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 16:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vYzRHAXTkQE8ShgnDZUpxP00w9EinAhnVmiKvXd/foI=;
        b=q2FsSrJXDpqfuBS5dk6JPgdvo0wd0sVkpC7LXX+qsUsfnNJ31JRkXM2KcjWClSiSDV
         L3qSepNYPIqEMhy1N2aXKWeTXTbTiMYqZP15NN/ToHeMNdq/EGjGsDhoqViMxgiyE5m2
         xi+mX6gv+HaH28YiBTn59+rf4mF9HPFknk+hQ2nlozFrjj4dV8faD9Y/HnyUXszL+Ijr
         w9QkxblWDiMYzeAJwR18JvjgLcgsYhrtODqZTERNRgeAqwZwXEWE0e0uqoBBOeiK7BNy
         3zihojs5+alZtFAu2ly/VfSb3cl2FCljwn0rkQH+Ue445Z7kl922+aYK1iPlvqxsq+EL
         vNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vYzRHAXTkQE8ShgnDZUpxP00w9EinAhnVmiKvXd/foI=;
        b=o2iq++BA/FAKzCaQNZAuMR+ZE9+dsk5X+WhctfYXZJFi/ScYdY6BoDrNkW0jScGd85
         C7pU0dozsvLSCwfhZigAhdNaq4Ng3rcxjY5OxmDPZyDf/AWasLe7U1TZu4wdQOxoPLDj
         PWaZr2BobweuMYdpNljnquhrlvQC0lpnoMRKK4W9dk6evy31pv166Aa7Jbv2rPflVlKO
         gHmglOLByC2hAKe7W1GQ7zQFrmtedgFxt94lL9FfPDZG+N/6O32z4yQ20Vbjz2Efy51Q
         b7fkQq/yn4vuctZadyblnc0liQ918NaaKfu6gjqcV2U3H3kEch5UvrU+HTc5WuvWQPqu
         jhHw==
X-Gm-Message-State: ANhLgQ0CFl0iW3LZQQ+ItiDD0EPlKp/CO8zShPnUBNwuQnaIfI0JKXp1
        QVlARWkELfLKx7dUlgRXJ+atouiJ2NQSL+D7sFA=
X-Google-Smtp-Source: ADFU+vsTMhvlq2oHM5hrfkOjva2zCgqgnZoK8S009erVEMvYNOBoVA8tEYNNRGUKKRCLH3IYwCqYPxM5MIrZlXQ7Pcw=
X-Received: by 2002:a17:90b:124a:: with SMTP id gx10mr6250888pjb.117.1585177985586;
 Wed, 25 Mar 2020 16:13:05 -0700 (PDT)
Date:   Wed, 25 Mar 2020 16:12:49 -0700
Message-Id: <20200325231250.99205-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH] elfnote: mark all .note sections SHF_ALLOC
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jeremy Fitzhardinge <jeremy@xensource.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ELFNOTE_START allows callers to specify flags for .pushsection assembler
directives.  All callsites but ELF_NOTE use "a" for SHF_ALLOC. For
vdso's that explicitly use ELF_NOTE_START and BUILD_SALT, the same
section is specified twice after preprocessing, once with "a" flag, once
without. Example:

.pushsection .note.Linux, "a", @note ;
.pushsection .note.Linux, "", @note ;

While GNU as allows this ordering, it warns for the opposite ordering,
making these directives position dependent. We'd prefer not to precisely
match this behavior in Clang's integrated assembler.  Instead, the non
__ASSEMBLY__ definition of ELF_NOTE uses
__attribute__((section(".note.Linux"))) which is created with SHF_ALLOC,
so let's make the __ASSEMBLY__ definition of ELF_NOTE consistent with C
and just always use "a" flag.

This allows Clang to assemble a working mainline (5.6) kernel via:
$ make CC=clang AS=clang

Link: https://github.com/ClangBuiltLinux/linux/issues/913
Cc: Jeremy Fitzhardinge <jeremy@xensource.com>
Debugged-by: Ilie Halip <ilie.halip@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Ilie has further treewide cleanups:
https://github.com/ihalip/linux/commits/elfnote
This patch is the simplest to move us forwards.

 include/linux/elfnote.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/elfnote.h b/include/linux/elfnote.h
index 594d4e78654f..69b136e4dd2b 100644
--- a/include/linux/elfnote.h
+++ b/include/linux/elfnote.h
@@ -54,7 +54,7 @@
 .popsection				;
 
 #define ELFNOTE(name, type, desc)		\
-	ELFNOTE_START(name, type, "")		\
+	ELFNOTE_START(name, type, "a")		\
 		desc			;	\
 	ELFNOTE_END
 
-- 
2.26.0.rc2.310.g2932bb562d-goog

