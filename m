Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C923C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 17:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A42C206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 17:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgBVRTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 12:19:02 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:45426 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgBVRTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 12:19:01 -0500
Received: by mail-qv1-f67.google.com with SMTP id l14so2396172qvu.12
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 09:19:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=usc74mrAn4ovUQS3g/Tme8E1bBKJwqNVRzgsDrqLwAk=;
        b=MRpbE0hV4BpFcEVA7PHJwYHuWfG7kX1+dynoqCp83RY7rJrknrlg+yjNoIJyFB6lJG
         PgtKVBqeqL7Lug/Ndc2C60zkV1/Hfnlbnxc0uE1ZUaHxSA8wkrmTQRXEbZXBwxUU65ad
         Sdi/UQJ074fI+jBRH9OnYG291VYBAP+4V8xF5EpUq2uxe9yL5OvwUbSl6JrxMuUKhX1D
         65n8fqPGhULgy49lQeHAmpDz/2ivFsTO4vxG68z0+H1H3VRlUOhI8y1oL9JvXvT3htFc
         Vqi9qyt0L6aot9leBSQNXYgHXkxw/8JBsYPH35pc+seBWT/mjBTkle60+b9f6lWC8xmb
         WLag==
X-Gm-Message-State: APjAAAUgF8aqzAF2RnKF/qTUDQWFIRQH1X18ACnQKm+ZyxsI7+LVpFSh
        xJVR/uLXhtJLX9bjFxHTBWs=
X-Google-Smtp-Source: APXvYqyjo22fCEpPgJXDvzmoF63w+ePNIE+1PZuioIm+gfS4Kd2yIGeMHEgM7vMcRPAJwsuM4RpGqA==
X-Received: by 2002:a05:6214:1933:: with SMTP id es19mr35351103qvb.14.1582391940880;
        Sat, 22 Feb 2020 09:19:00 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a128sm1169350qkc.44.2020.02.22.09.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Feb 2020 09:19:00 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Michael Matz <matz@suse.de>
Subject: [PATCH] x86/boot/compressed: Fix compressed kernel linking with lld
Date:   Sat, 22 Feb 2020 12:18:59 -0500
Message-Id: <20200222171859.3594058-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200222164419.GB3326744@rani.riverdale.lan>
References: <20200222164419.GB3326744@rani.riverdale.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit TBD ("x86/boot/compressed: Remove unnecessary sections from
bzImage") discarded unnecessary sections with *(*). While this works
fine with the bfd linker, lld tries to also discard essential sections
like .shstrtab, .symtab and .strtab, which results in the link failing
since .shstrtab is required by the ELF specification. .symtab and
.strtab are also necessary to generate the zoffset.h file for the
bzImage header.

Since the only sizeable section that can be discarded is .eh_frame,
restrict the discard to only .eh_frame to be safe.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
Sending as a fix on top of tip/x86/boot.

 arch/x86/boot/compressed/vmlinux.lds.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 12a20603d92e..469dcf800a2c 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -74,8 +74,8 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
 	_end = .;
 
-	/* Discard all remaining sections */
+	/* Discard .eh_frame to save some space */
 	/DISCARD/ : {
-		*(*)
+		*(.eh_frame)
 	}
 }
-- 
2.24.1

