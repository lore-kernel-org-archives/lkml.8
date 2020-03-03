Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F86DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C012146E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGOGyoxs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgCCEvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 23:51:05 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:32955 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbgCCEvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 23:51:04 -0500
Received: by mail-qv1-f65.google.com with SMTP id p3so1131723qvq.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 20:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BVGVQnxZtKvu5WnCQWuc4A5xHojwRze8c7W911gPsz4=;
        b=eGOGyoxsK0Q234ZJr5UzB+z8DCoiAIt4CNNzce4tRt9F94JL9PHDpk6HQhNdwF54mH
         oodd1OliC4kv8x/QYhmTvkaUut5M8bSdBfdr5x1XB8/4JPVGOrkwgcNOOxhWmp9NTRBC
         9YSRFYJTF0RMPnow1M+vDetnbswzE5DVWeAiQ9gMB+WX6fl9LxW9/C+FMtAKBpTraD7M
         qOQj2AcrkKsSQ/mfoYI1omlYNJ3scDbzmwJpjx4k2BRiEc3fe/QtJpWPcJqNVDRFXRst
         mV3hTTfTnse0NVCoTD23+85bGyIXo8tcb9WBTzpNU24HRBKHOtkDsWAvdvbmmJ6K2puB
         FBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BVGVQnxZtKvu5WnCQWuc4A5xHojwRze8c7W911gPsz4=;
        b=AmoU3XjRuD8tIZjsYSujVVjfwmvXzKnPCDgyi9dt1iIsuQ4T8g61TANeB6b9uccmrt
         XikbP/jTHnkwSixwvRLNGRw6+v7P3tXZPN5kZ0GmNQxM6I3EJHlP+uW3dcUt4uv56hZ8
         G8OBDNBGO31Lmrv4Sge/XAvCd2sGnlGiwOvAplf1IQPu8il89x3OcPYXxdEHE2dbYLGJ
         EgkxazB8o9fjxRaChrHkM8jsTUazK1SOYy7vqQWWlSqc4COXCgYaxU8V6i5E/Wd84Eju
         5hUw3x0qrg6jupOdiF1qsocL3hgOvJ5Z3pB8KeLJpWh8p9YLNK99yWGov9kFdwCsiyvJ
         SPTA==
X-Gm-Message-State: ANhLgQ3lolqRsKk+IkH0DjCAhzgz8C6+He3Lkx//dLECyPWL9BShVX9l
        8imClFXbXAu1Ut4oAJfNalU=
X-Google-Smtp-Source: ADFU+vv0/u6cM/i1pkRIiCJ7tMOSpGeYcYsL9BsxkiOsCSwmakKlq+XFF01jwpLjeqRjl2khWyxp0Q==
X-Received: by 2002:ad4:4861:: with SMTP id u1mr2498626qvy.233.1583211062210;
        Mon, 02 Mar 2020 20:51:02 -0800 (PST)
Received: from localhost.localdomain ([128.6.37.0])
        by smtp.googlemail.com with ESMTPSA id z26sm4790469qki.36.2020.03.02.20.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 20:51:01 -0800 (PST)
From:   Mingbo Zhang <whensungoes@gmail.com>
To:     x86@kernel.org
Cc:     Mingbo Zhang <whensungoes@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86: perf: insn: Tweak opcode map for Intel CET instructions
Date:   Mon,  2 Mar 2020 23:50:30 -0500
Message-Id: <20200303045033.6137-1-whensungoes@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Intel CET instructions are not described in the Intel SDM. When trying to
get the instruction length, the following instructions get wrong (missing
ModR/M byte).

RDSSPD r32
RSDDPQ r64
ENDBR32
ENDBR64
WRSSD r/m32, r32
WRSSQ r/m64, r64

RDSSPD/Q and ENDBR32/64 use the same opcode (f3 0f 1e) slot, which is
described in SDM as Reserved-NOP with no encoding characters, and got an
empty slot in the opcode map. WRSSD/Q (0f 38 f6) also got an empty slot.

Signed-off-by: Mingbo Zhang <whensungoes@gmail.com>
---
 arch/x86/lib/x86-opcode-map.txt       | 4 ++--
 tools/arch/x86/lib/x86-opcode-map.txt | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 53adc1762ec0..0e3434c882d4 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -366,7 +366,7 @@ AVXcode: 1
 1b: BNDCN Gv,Ev (F2) | BNDMOV Ev,Gv (66) | BNDMK Gv,Ev (F3) | BNDSTX Ev,Gv
 1c: Grp20 (1A),(1C)
 1d:
-1e:
+1e: NOP Gy,Gy
 1f: NOP Ev
 # 0x0f 0x20-0x2f
 20: MOV Rd,Cd
@@ -804,7 +804,7 @@ f1: MOVBE My,Gy | MOVBE Mw,Gw (66) | CRC32 Gd,Ey (F2) | CRC32 Gd,Ew (66&F2)
 f2: ANDN Gy,By,Ey (v)
 f3: Grp17 (1A)
 f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey (F2),(v)
-f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v)
+f6: NOP Ey,Gy | ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v)
 f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
 f8: MOVDIR64B Gv,Mdqq (66) | ENQCMD Gv,Mdqq (F2) | ENQCMDS Gv,Mdqq (F3)
 f9: MOVDIRI My,Gy
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index 53adc1762ec0..0e3434c882d4 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -366,7 +366,7 @@ AVXcode: 1
 1b: BNDCN Gv,Ev (F2) | BNDMOV Ev,Gv (66) | BNDMK Gv,Ev (F3) | BNDSTX Ev,Gv
 1c: Grp20 (1A),(1C)
 1d:
-1e:
+1e: NOP Gy,Gy
 1f: NOP Ev
 # 0x0f 0x20-0x2f
 20: MOV Rd,Cd
@@ -804,7 +804,7 @@ f1: MOVBE My,Gy | MOVBE Mw,Gw (66) | CRC32 Gd,Ey (F2) | CRC32 Gd,Ew (66&F2)
 f2: ANDN Gy,By,Ey (v)
 f3: Grp17 (1A)
 f5: BZHI Gy,Ey,By (v) | PEXT Gy,By,Ey (F3),(v) | PDEP Gy,By,Ey (F2),(v)
-f6: ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v)
+f6: NOP Ey,Gy | ADCX Gy,Ey (66) | ADOX Gy,Ey (F3) | MULX By,Gy,rDX,Ey (F2),(v)
 f7: BEXTR Gy,Ey,By (v) | SHLX Gy,Ey,By (66),(v) | SARX Gy,Ey,By (F3),(v) | SHRX Gy,Ey,By (F2),(v)
 f8: MOVDIR64B Gv,Mdqq (66) | ENQCMD Gv,Mdqq (F2) | ENQCMDS Gv,Mdqq (F3)
 f9: MOVDIRI My,Gy
-- 
2.25.1

