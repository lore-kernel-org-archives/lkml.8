Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94262C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 05:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 740842065C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 05:50:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaHenN3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgHCFuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 01:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgHCFuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 01:50:11 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E24C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 22:50:11 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bh1so7069237plb.12
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 22:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iVhQkFEgxDVVa1k/NmDMYKiPLDUD4ULVTRaA7/u4IlM=;
        b=OaHenN3YVA9KfZ2utjtSn+pK8YSMuWpxd1lwT6nfh+/qr4a2cdl9ninmyekQf7ix9H
         m63at5+JvoLK6yB7V1YE4wgc6bc4aqEMiG5cs/4i9WA5rbcdsxRJKDsK3Yms+1oTqjhZ
         40l0GDIH6qleEuL4cKyW78crhy87f4PeKTpEqT+JTquYGLkun/8W9q0+fWbi+cCrccD3
         T+ut6CYhiJ6Zxnx1jGAKzc4fHBZ2bRXZ/t9t553F5bkFH8F2HPryY2OrUkVlHjz4lKZR
         i4wZOeG+xaQNPoCeJjelaVz248B/MECUCCaCNMaYNisSYnGG+mpxV54CjbutGehYXxfH
         MH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iVhQkFEgxDVVa1k/NmDMYKiPLDUD4ULVTRaA7/u4IlM=;
        b=jWod+3cb6fYGx/RZ7VaxISqqYNfVlxxIBWO+Ghj9ldtHOoSdLOFUoR9uAEwLXm3WfI
         A5j+y4LX+Zr9uev64Ig1dCyLAWBZ4WeOeAk4nvABgTnwe56BY33whWE+JhG47MxgHOqk
         qAidC6U6wHcX11wTiSQdmUCwY2ufH2HU8ed0ssJ3ROC/6wFp4RBM5tmXLf5bHeaNhMF8
         5Vjr9tbIf+/bxhizIw0iCNPivoqsWkpQ6JF/zESQwL8F0scLFWM5AnYEbhQ2xbBrwpUM
         bt1JCveTQucCbSr/o9ioNMbuOZRVNEFRcQgC/3TJ2Yv/pH0UZuI0EiRbTPzcbFvN/zV6
         g5Fg==
X-Gm-Message-State: AOAM532bhZ+sB1YpStkUOFn9Wl/dsCq0gqZO7QSXgnlrEUWjC+8hyt3c
        IAcL9mbls0Op9hMTyQ367Q==
X-Google-Smtp-Source: ABdhPJyCt1EBTK6p/VlfpDw4I0dQ7ggxX38XXm1dn6OvcxPKgezYMyFyXupUaFV03mzb34XPxCmKIQ==
X-Received: by 2002:a17:90a:bf04:: with SMTP id c4mr14636664pjs.149.1596433810763;
        Sun, 02 Aug 2020 22:50:10 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s68sm17522651pfb.103.2020.08.02.22.50.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Aug 2020 22:50:10 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Steve Wahl <steve.wahl@hpe.com>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org
Subject: [PATCHv2] x86/purgatory: don't generate debug info for purgatory.ro
Date:   Mon,  3 Aug 2020 13:49:48 +0800
Message-Id: <1596433788-3784-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Purgatory.ro is a standalone binary that is not linked against the rest of
the kernel.  Its image is copied into an array that is linked to the
kernel, and from there kexec relocates it wherever it desires.

Unlike the debug info for vmlinux, which can be used for analyzing crash
such info is useless in purgatory.ro. And discarding them can save about
200K space.

Original:
  259080  kexec-purgatory.o
Stripped debug info:
   29152  kexec-purgatory.o

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org
To: x86@kernel.org
---
 arch/x86/purgatory/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 088bd76..d24b43a 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -32,7 +32,7 @@ KCOV_INSTRUMENT := n
 # make up the standalone purgatory.ro
 
 PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
-PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
+PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += $(call cc-option,-fno-stack-protector)
 
@@ -64,6 +64,9 @@ CFLAGS_sha256.o			+= $(PURGATORY_CFLAGS)
 CFLAGS_REMOVE_string.o		+= $(PURGATORY_CFLAGS_REMOVE)
 CFLAGS_string.o			+= $(PURGATORY_CFLAGS)
 
+AFLAGS_REMOVE_setup-x86_$(BITS).o	+= -Wa,-gdwarf-2
+AFLAGS_REMOVE_entry64.o			+= -Wa,-gdwarf-2
+
 $(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)
 
-- 
2.7.5

