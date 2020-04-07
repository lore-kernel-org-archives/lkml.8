Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A21AC2BB85
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7110C2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:47:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="AHDDzmDi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgDGOrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:47:18 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43438 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729328AbgDGOrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:47:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id s4so1819396pgk.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 07:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Quhy5/QZPA8/P4q/9fnjufmjHKuWjkZaQYF9/wabbVw=;
        b=AHDDzmDiFHiECrdMx/1zHadC9VdetNvA12RpoCsdBdCEK14bBlGUUaj0dd2H3A+BCH
         L6TKBWsntI3ec6isKAfpwrdF8gp0hEaVoFmoYPb+coyfeDRwebMhUEHgh1ipHAiVF+Gt
         10VKtKonkggb5aWtTNpPY+j9eZcgqAFpLDjyDKnYkMUot/ajync8iCZ+8UgpSFPY7xSL
         gjON/Bei/AQgPSnbtG4wiHaMXKv+oyO1uxc/6HJCHDrs8EkA0debASne5ARpkVJ0R+FG
         OlfKbwiqhzHZt9pBeOyExXRS/dhnZB4yK/WSaSA6cpLorZk7MXsQvxmaE7X3t1hFGzjX
         5ORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Quhy5/QZPA8/P4q/9fnjufmjHKuWjkZaQYF9/wabbVw=;
        b=fiTPsOmVfU/1si3yn4Moj/qYnHqWWCpUKyxdDvjkqnC4PW6ZLHFKxFc0lAEbTnLkca
         x/L9DQtf3sV/YEAisQAMwREZIxFQSZ1PVxMqpvt8wDxyDtNaBh0ADaMhqwwcIlvoA9k4
         zyu8FsHcLH25zXWEG6YflHe8WoF4wlXw+m1hO5fIAOcNjfOCPyQ7tx21LkLmwOT9J9xa
         6rU6MCDbDXFKoutcUXpUnede3VWPpW7b7pCdJD0B+yBptH+iOU3u8jgrf52ynd2b/nEO
         PL+lvKR1pDEIzfUq2Co1FkGNxc2b0jpXl81jpV8O6vZsyKFv6QvE3/vr8fsqj/KTh/MK
         rZVw==
X-Gm-Message-State: AGi0PuZGjsG/UHln0300l2NfrGpzt2nqKHcZ2GYme8Pt/203n+UI7zxJ
        Y6Tt7AII0yV4UvqYFxo7APTQVA==
X-Google-Smtp-Source: APiQypIu7xZA7V1YhEkwC7XML1SD8uFsocdPfcN93OJKoMqGsb76XglFSxzjrLHKYnXDd+XsfzKmUg==
X-Received: by 2002:a62:154:: with SMTP id 81mr2864787pfb.228.1586270833015;
        Tue, 07 Apr 2020 07:47:13 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (220-132-236-182.HINET-IP.hinet.net. [220.132.236.182])
        by smtp.gmail.com with ESMTPSA id y15sm14190093pfc.206.2020.04.07.07.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 07:47:12 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, mhiramat@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v4 7/9] riscv: move exception table immediately after RO_DATA
Date:   Tue,  7 Apr 2020 22:46:52 +0800
Message-Id: <1d1d278ca3957db9103f40ddda008128365d6d72.1586265122.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <cover.1586265122.git.zong.li@sifive.com>
References: <cover.1586265122.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move EXCEPTION_TABLE immediately after RO_DATA. Make it easy to set the
attribution of the sections which should be read-only at a time.
Add _data to specify the start of data section with write permission.
This patch is prepared for STRICT_KERNEL_RWX support.

Signed-off-by: Zong Li <zong.li@sifive.com>
Suggested-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/kernel/vmlinux.lds.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index 1e0193ded420..02e948b620af 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -58,6 +58,10 @@ SECTIONS
 		*(.srodata*)
 	}
 
+	EXCEPTION_TABLE(0x10)
+
+	_data = .;
+
 	RW_DATA(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
 	.sdata : {
 		__global_pointer$ = . + 0x800;
@@ -69,8 +73,6 @@ SECTIONS
 
 	BSS_SECTION(PAGE_SIZE, PAGE_SIZE, 0)
 
-	EXCEPTION_TABLE(0x10)
-
 	.rel.dyn : {
 		*(.rel.dyn*)
 	}
-- 
2.26.0

