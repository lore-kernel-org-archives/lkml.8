Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E2FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BE92071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 18:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ds5ZrD9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391181AbgAXSSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 13:18:25 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45324 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387407AbgAXSSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 13:18:24 -0500
Received: by mail-pg1-f194.google.com with SMTP id b9so1508113pgk.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 10:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DBEb0PGQ8rkprqzYuthrkHqrDnmF+gnYXnsoY61wfI8=;
        b=Ds5ZrD9g+A+yQianbqzd9622ABXWWBTWdNrTwPhQxf+QCupBQSTA0cXV/L9BaSKNh/
         UxvfFxIJmEZt8iL0AEFdTIPbSVcCQYcouEblBlZFsYHrKnBm8FzzWSRLIF31j+G+0Azd
         CrzVwhUsiObuUI28RTP8nS0tarLSSpamB6P26EUsZCf6GXZdLgX+jtCz5WxIZGFFzZmR
         +f/ewqlyrcRNloQsXoqrR9OoL4ZfIKIE8QsU4Fsf2vg/rRfVo7fTC4zuMgNJ0UiUy2VV
         Jr6gaPBjKkkdtYfSECoWZl3BurEvyWYeF+jFp0SNuhSXXqsOFWRH+0WuUZd/Hialgvu4
         /Jig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DBEb0PGQ8rkprqzYuthrkHqrDnmF+gnYXnsoY61wfI8=;
        b=lmvqfVu/8DASkmIR6Taz/KnmPqF3fwqWkvwVWj+uwSMNg/sAiJGYjp6lo2WTSf0JWc
         lq37AqUut3lDxwhXcGrvoHe1jbcoZ691GMVA/OVfKXyDscZhStUee6oruxuesoYS/3e9
         lx82VPf7m+nR7kBBQKTxM4OKzmfrCG8rK2r5Zcpl2myPR59uM0Gf9CV4oZx8mAuDk7OF
         cYpDtln1tvEyPe3s3VKd3VYtgUJevwHnOwDQn/Nn2ojt/Nk9HpG31Z/GNr1OffJulrK7
         y88gkic8QKyYIm59ANbSBdcK5L+WakXp46TwkqfbbNWrt5BLznS+2PF/SIx6PgatjzM6
         AYpQ==
X-Gm-Message-State: APjAAAVjhDOBWplvLZFHYeoCIQeTDUL49RA+MiBRjWYWAXZ+0c2GQJSU
        4AoKSdYsxHnMM/hfSZf4kKs=
X-Google-Smtp-Source: APXvYqwMDoDhsg5l4YfQxjQIzNo3s004MSDA+puBxj3+oWgcjOeT5GcvgvBnHalX+N8VYHvRfczYig==
X-Received: by 2002:a05:6a00:45:: with SMTP id i5mr4353509pfk.252.1579889903358;
        Fri, 24 Jan 2020 10:18:23 -0800 (PST)
Received: from gnu-efi-2.localdomain ([2607:fb90:276d:92e7:da4f:90b0:c395:2435])
        by smtp.gmail.com with ESMTPSA id m128sm7022264pfm.183.2020.01.24.10.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 10:18:22 -0800 (PST)
Received: from gnu-efi-2.localdomain (localhost [IPv6:::1])
        by gnu-efi-2.localdomain (Postfix) with ESMTP id 93E5D100AB8;
        Fri, 24 Jan 2020 10:18:21 -0800 (PST)
From:   "H.J. Lu" <hjl.tools@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH 0/2] x86: Discard .note.gnu.property sections
Date:   Fri, 24 Jan 2020 10:18:17 -0800
Message-Id: <20200124181819.4840-1-hjl.tools@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the command-line option, -mx86-used-note=yes, the x86 assembler
in binutils 2.32 and above generates a program property note in a note
section, .note.gnu.property, to encode used x86 ISAs and features.  But
x86 kernel vmlinux and vDSO linker scripts only contain a signle NOTE
segment which may not be incompatible with note.gnu.property sections.
Since note.gnu.property section from kernel are unused, they should be
discarded by adding

/DISCARD/ : {
 *(.note.gnu.property)
}

before .notes sections.

H.J. Lu (2):
  x86: Discard .note.gnu.property sections in vDSO
  x86: Discard .note.gnu.property sections in vmlinux

 arch/x86/entry/vdso/vdso-layout.lds.S |  4 ++++
 arch/x86/kernel/vmlinux.lds.S         | 11 +++++++++++
 2 files changed, 15 insertions(+)

-- 
2.24.1

