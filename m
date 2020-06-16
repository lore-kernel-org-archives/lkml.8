Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E1ADC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FEB520786
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgFPWZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 18:25:51 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42397 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgFPWZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 18:25:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id l17so203475qki.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 15:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VcKfZlE4WkUhVaivLHqicBLfv47GDp8cYmEaB3V/yXI=;
        b=rLUoZOZ8JStWVgPsHXFSVdi320jWCV4Ds7VR5rrRt/QsR4iWrUUAbnnTZxOJqUAlv9
         K6v8KHmt7jSPub5mX+0VdcviG47+K+YpN7I1KhH6KURl++xrs6wIHamEFCQJfyCX+xEl
         I2Zm1VI6+X8ULHt3+KJSboK1TLC3Pg40bRU9cCETlFf9keGSq6g6NR0HUbHiHWqHKu/E
         kSn+CQBu40Ka+KDq3CI++5w/ayhBeCxBcApXJMIRvuO0U8QB8OVf1cfY001dHFwhgdck
         ba6+Jw5NJiVUXn2ydZ0Y6GOQDcbgH2JA0xKnddG2EZRrQbhMB3XGaubB06bQ2AVCXMNL
         hxYg==
X-Gm-Message-State: AOAM5334bOpdYk8cpc98h4oXqBHXs34P421zuaBjvx3Z8WwKL+EA06YG
        CvQGMUNy//RMj72r3QrILGQ=
X-Google-Smtp-Source: ABdhPJzFBcXfx4S8pNUEkIHwipaB95eGAuUAwTxzAUh2H7g200UUY9Jq7+mPMqFlgP6VAR8d66371Q==
X-Received: by 2002:a37:4753:: with SMTP id u80mr22286270qka.178.1592346350157;
        Tue, 16 Jun 2020 15:25:50 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p13sm15290473qke.135.2020.06.16.15.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 15:25:49 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, kexec@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Gabriel C <nix.or.die@googlemail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH] x86/purgatory: Add -fno-stack-protector
Date:   Tue, 16 Jun 2020 18:25:47 -0400
Message-Id: <20200616222547.1979233-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CAEJqkggDJEC4W9V6ijmPoE0-soKE7zBUWUiDLdCZArEsDo9vrQ@mail.gmail.com>
References: <CAEJqkggDJEC4W9V6ijmPoE0-soKE7zBUWUiDLdCZArEsDo9vrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purgatory Makefile removes -fstack-protector options if they were
configured in, but does not currently add -fno-stack-protector.

If gcc was configured with the --enable-default-ssp configure option,
this results in the stack protector still being enabled for the
purgatory (absent distro-specific specs files that might disable it
again for freestanding compilations), if the main kernel is being
compiled with stack protection enabled (if it's disabled for the main
kernel, the top-level Makefile will add -fno-stack-protector).

This will break the build since commit
  e4160b2e4b02 ("x86/purgatory: Fail the build if purgatory.ro has missing symbols")
and prior to that would have caused runtime failure when trying to use
kexec.

Explicitly add -fno-stack-protector to avoid this, as done in other
Makefiles that need to disable the stack protector.

Reported-by: Gabriel C <nix.or.die@googlemail.com>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/purgatory/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index b04e6e72a592..088bd764e0b7 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -34,6 +34,7 @@ KCOV_INSTRUMENT := n
 PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
 PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
+PURGATORY_CFLAGS += $(call cc-option,-fno-stack-protector)
 
 # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
 # in turn leaves some undefined symbols like __fentry__ in purgatory and not
-- 
2.26.2

