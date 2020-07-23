Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86B2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98B3A20792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9xG05XM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgGWQsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgGWQsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:48:00 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE88C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 09:48:00 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id y24so1645440wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 09:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wfF1MOO1eIe212zlvHoNqhCTnx4F2/9hLEtAwwz0Jk4=;
        b=e9xG05XMIbCd3yoNECxx58RWPFDwsGN78vxHpnefdBYd5BGTeTwmgrAtJSigMwenju
         PYC+zVYNr+chV2LlWA5K9eS09v6MfSWOnxAhZhtccnWACBCx1DnhzNqRQi52JVJI+GtP
         WaX7ZmVHAD0pUD7HR0roWWbbBHkiVaWw0UHIUYqkWB02pmSzDxqUOY3GT7qHCtyUUadW
         w6oat+cGbkuejcLAz4hEwrQbpD39ByM0xzsGWXJnoJeXk8ZIUNU7Lo0+rYzr4+Lzfu2O
         Elq5ncJC9M4jZLjf4iUVlm1Cxb/utNoi29G9lvag49Skl/y6qWhA1fj4o4MbLFXBtdqm
         N7/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wfF1MOO1eIe212zlvHoNqhCTnx4F2/9hLEtAwwz0Jk4=;
        b=d8lMA/g6LvCFN/knSUum90oti/W6LJicAz+s79t1MG4Zws7BA1fA+JXbLlYdQDyw15
         Kej2t9BypRxjpYpCjnPxdMKs4aH9fozr15okEJKJXUwePY6i+Jbg1xf9SCy72vW/KbvY
         KrAL/SJQx6T/uGCFtfOn4sXusJbt20fS3N3yLPsadnIHw+t+sLnJlmTT/Z9Einaj12Cu
         yB2HCGf4Z4FgmTcxowxU/GrII7KMRDXgRrZps8xDwQRqf/Vqv35XcwCyf2BeJQXAF6X3
         FRoD/1ffTaGLb1dbNisAp7OBX5uBDF0CrrZBWLWMLG4MwkY/EAaUR8pqhSD1MbNbQNJO
         zSlQ==
X-Gm-Message-State: AOAM5327txcYOt96W9Uwnk5OS7OsWHyunN5Yi+ct+G6E0M960ZBbn8DK
        eKl9Tm10NZk3yRG2QdUEeHg=
X-Google-Smtp-Source: ABdhPJxyNhYCGgNuLaTjqFv0yH8uoWTe1e/G2xMuFIbC+gm5yNZ+XH/lyuSKYNcgsuGooadr0WVveA==
X-Received: by 2002:a1c:6804:: with SMTP id d4mr2028048wmc.175.1595522878997;
        Thu, 23 Jul 2020 09:47:58 -0700 (PDT)
Received: from localhost.localdomain ([46.114.110.108])
        by smtp.gmail.com with ESMTPSA id b139sm4409523wmd.19.2020.07.23.09.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 09:47:58 -0700 (PDT)
From:   Sedat Dilek <sedat.dilek@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        =?UTF-8?q?Diego=20Elio=20Petten=C3=B2?= <flameeyes@flameeyes.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/configs: Remove CONFIG_CRYPTO_AES_586 from i386_defconfig
Date:   Thu, 23 Jul 2020 18:47:43 +0200
Message-Id: <20200723164746.5580-1-sedat.dilek@gmail.com>
X-Mailer: git-send-email 2.28.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initially CONFIG_CRYPTO_AES_586=y was added to i386_defconfig file by
commit c1b362e3b4d3 ("x86: update defconfigs").

The code and Kconfig for CONFIG_CRYPTO_AES_586 was removed in:

commit 1d2c3279311e4f03fcf164e1366f2fda9f4bfccf
("crypto: x86/aes - drop scalar assembler implementations")

Remove the Kconfig relict from i386_defconfig file.

Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 arch/x86/configs/i386_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 550904591e94..3a2a89882350 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -290,7 +290,6 @@ CONFIG_SECURITY_NETWORK=y
 CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
 CONFIG_SECURITY_SELINUX_DISABLE=y
-CONFIG_CRYPTO_AES_586=y
 # CONFIG_CRYPTO_ANSI_CPRNG is not set
 CONFIG_EFI_STUB=y
 CONFIG_ACPI_BGRT=y
-- 
2.28.0.rc2

