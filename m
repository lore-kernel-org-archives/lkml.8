Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D503BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE234204EA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aklJhmrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgG3I1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729002AbgG3I1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:27:08 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A64BC061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 01:27:08 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id o1so13394032plk.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 01:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ytlVe9sZxGP/GyzK5t16szL2Z6Kr4xJ+2Bn7kTuz0dI=;
        b=aklJhmrDNqJpPXrQLz8erspyzDFRr2txAah3NT49bYgkhhMKzFYO4EgfbucHmSCpBC
         mtjfmDBYhWH+iQdDCvVpUtqEyvhoc0RbAjNrQsRIScUNNMHZfATUyrre1xu138gkgugo
         OKuXf5+yjRiD4Q0C/QL0U809NjxV0XjEjUhKvkUoe4jn7iTOxbsKyugN5edwqa4OcWy7
         aFfyVbfXnDO8sRm32RYEOJyvaFcD7g72TTzncvS1+mdZVRxaKYoLA6psYuYFGU7d129N
         lSF2L2gqxLf+SnwRtPSjr8rp5MOyAAHRFbCVL5FLNsqUJeO0sFQM/vOP71me795CPOJh
         opAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ytlVe9sZxGP/GyzK5t16szL2Z6Kr4xJ+2Bn7kTuz0dI=;
        b=UiK0a7f7PdKiDQ8i9ll00qJjLdyGCUyQWTPMbhgYk7QoNVd3SW/y+Nb4R8tWFjTdmk
         0qNRnHXdxlrtzvWBg0kKbwDJBibmmSqo0vKXJB4NP+5FkEZqkIQQ8Vlk0E+WA5zDNc2P
         2UHL+mCLtj2TCD/IV3Cmmwqezlk/ODAkh87pXu/MFzX5lf6iYtFZLXKcngW4raq0vdoF
         +7b050LBM4HMqkG4ly41S8xQlnrs44sTv/oW/ThofXWuJIWTXdM5V8LUe9+UEXScf5++
         eegARsQI/Il37bWDlRoqZmtuZaJbJ4uh1g1h3g9D5y7FkKp/ujg4Imn0onHHJ9SzAS1O
         LHHw==
X-Gm-Message-State: AOAM532QAYaPbrKHbF2cY7K1m3FEnScaZBcyZcjsUI+nYppvShphuaci
        RyLWglTDcr+1prGa6cQ3CA==
X-Google-Smtp-Source: ABdhPJzg5uAiw9WYZREfbGe8Nmyc2zBfrzmvxoqDPF9+YWCQGN0vN+Xf5KblGrBnPnDfvwCtM+EPPg==
X-Received: by 2002:a17:90b:f09:: with SMTP id br9mr9916108pjb.11.1596097627997;
        Thu, 30 Jul 2020 01:27:07 -0700 (PDT)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h15sm5104315pjc.14.2020.07.30.01.27.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jul 2020 01:27:07 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Steve Wahl <steve.wahl@hpe.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/purgatory: strip debug info
Date:   Thu, 30 Jul 2020 16:26:49 +0800
Message-Id: <1596097609-14118-1-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is useless to keep debug info in purgatory. And discarding them saves
about 200K space.

Original:
  259080  kexec-purgatory.o
Stripped:
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
To: x86@kernel.org
---
 arch/x86/purgatory/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 088bd76..4340ae6 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -16,7 +16,7 @@ CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 
 # When linking purgatory.ro with -r unresolved symbols are not checked,
 # also link a purgatory.chk binary without -r to check for unresolved symbols.
-PURGATORY_LDFLAGS := -e purgatory_start -nostdlib -z nodefaultlib
+PURGATORY_LDFLAGS := -e purgatory_start -nostdlib -z nodefaultlib -S
 LDFLAGS_purgatory.ro := -r $(PURGATORY_LDFLAGS)
 LDFLAGS_purgatory.chk := $(PURGATORY_LDFLAGS)
 targets += purgatory.ro purgatory.chk
-- 
2.7.5

