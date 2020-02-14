Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A0AC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40D8222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:48:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d25mbnej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbgBNUsb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:48:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45121 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727742AbgBNUsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:48:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id g3so12445335wrs.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=svWQH5bugH4rv9PdjMQlH3m1D3zp07Szx/MlMua2nmM=;
        b=d25mbnej0nI68r+3RO9No+cjoBx00ANfQLGScaYyj3YVWZ3F79gOMgGk08rVSC9fE7
         ESPUdTYdMEJNdvt61a44Y795P3LdRSyM/XykVD1Czy89+5mzPj7yN+ltcZLAw7bRWAq7
         hAuPGBkighdkT0lApuOkPh70R2SfBWagEyXGyE/AK85ycLlET1VLXU9sNKaSnhL8xCMU
         8MFrzULLv2IyMjuPlSGNDh5nwAYQN9FdQ6XKol89BH4AQdDVQNGiPWDiq9i6usmG0IEX
         +a5qFJdPOxBJ5qgW3b2MVp+jJAU48XgeEnsibzeEtoi8xdC5OLlpu+twoZGAOIRsa1EM
         z3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=svWQH5bugH4rv9PdjMQlH3m1D3zp07Szx/MlMua2nmM=;
        b=tHMtZes39WOlbUgBdHgrv3qc9WXJT3zPKW6/nNhrpGnMluOp5gEy39QUIU6yczr4iI
         Y8RjukiXfcPBJWTxlyH7qNT4Zs7vExWRzFwa5Qhq5vO49u4gKxNO+5gSI028ECTaYPkv
         PVf5rZQvN+3bZMX4C4taSL7moMOXn5PPKnpOKCqsiOAmgiz/NoBe4GfWFat3FeQUNPbK
         vOwt6GWvjx++zqvXXeekpt+kZJDJv5veBXwm+DdvLHQtoUTRIiMNYnsXA81I9ApUnrn7
         Vocw88BfHvvKS4SoktU5feDPf95Sl2ipLcws7iGInZAfpMvavOVUzG5+hPMXeYhK92RJ
         VXBw==
X-Gm-Message-State: APjAAAVkqxCqHvnxTOmXCWsfbzYdgBktL8x/43Kma8vElGeeVk71bAEi
        kzHT2yOASb3Cyke6rGTG+COF6/P7EvB+
X-Google-Smtp-Source: APXvYqxBqs8qKEgq3Rt0tCvQJo16SsSEXwYaNvfUGyPaNO2wnFlhm9gQA+K2IUz379yw6qOxfKSHaQ==
X-Received: by 2002:a05:6000:10c:: with SMTP id o12mr5918455wrx.106.1581713308959;
        Fri, 14 Feb 2020 12:48:28 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y12sm8660782wmj.6.2020.02.14.12.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:48:28 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Horman <nhorman@tuxdriver.com>
Subject: [PATCH 02/30] x86/apic/vector: Add missing annotation to lock_vector_lock(void)
Date:   Fri, 14 Feb 2020 20:47:13 +0000
Message-Id: <20200214204741.94112-3-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214204741.94112-1-jbi.octave@gmail.com>
References: <0/30>
 <20200214204741.94112-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at unlock_vector_lock()

warning: context imbalance in unlock_vector_lock() - unexpected unlock

The root cause is the missing annotation at unlock_vector_lock()
Add the missing  __releases(&vector_lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 arch/x86/kernel/apic/vector.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index d7556939c6cf..8ee7848a355b 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -55,7 +55,7 @@ void lock_vector_lock(void) __acquires(&vector_lock)
 	raw_spin_lock(&vector_lock);
 }
 
-void unlock_vector_lock(void)
+void unlock_vector_lock(void) __releases(&vector_lock)
 {
 	raw_spin_unlock(&vector_lock);
 }
-- 
2.24.1

