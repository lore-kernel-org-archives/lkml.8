Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C18C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D67820714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="osBvUAaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgBLI6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:58:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41335 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbgBLI6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:58:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so1182310wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P+oTW1oqdZZpvbExNtN6cEjZVuY6rtlPN76BdLxBHrg=;
        b=osBvUAaRLXIEwRLMbGoLedaXv4Ac/y455olJmGTpqe5ljva0Yw+gPcmSx9YkiwtDGU
         GPRWNmQBjq5v5mhfRD4J5XGkpXLUyr90q1fg8Xbb0foc6EknCKctaBhVSX3jt+o4xSyd
         VzKq6dfq6nLYtXQVPRoH6L+VBz/uZAzdnQ40OhQDfXbMR6fbOeYuwfrit1E2rznbAkt5
         akFkP2JxhxkckgNK9xIu29XLqdBKrsdaiffg+nuHIbnDLkwxeOBsKWXN6hwJTqq/fFRf
         fN7CrLm6zXITFjeZHT/96E/viQudh5o+DfbSMWh036vS8Lw/cl1GA3202YNpykH/btDO
         YLKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=P+oTW1oqdZZpvbExNtN6cEjZVuY6rtlPN76BdLxBHrg=;
        b=S51e8VQGAbo06PE7xJmNKYtjI7zjmX0Me5JdQK6sG9kCuC83YHwguNsuw8mHk5r7Lj
         yz4LDaN/cDS0TtzgMnx4SLVwFVR3lnotjLuzj7uTFF4glm/34hoQUBc1k+co3OUJqkDd
         ggBbpHPp5nehbTI0W6V10JI3+TLPRKyQtNz3Ke9e2ymnVOg/mYhLFXAFEGOeBbvcrMkC
         j7vZhEeDaXrJtv2AC7M7qloVlr7U03gZ2vlbz/PXJcTyLVun0IMAxXnNCPdC5M7chQVm
         iNHjBr5fnYyFIlXyjrHrPgKmERiodZmKFtBOWxslrjNscckASyQ5J/ncdwuSgGJhc1Yk
         d6dg==
X-Gm-Message-State: APjAAAVRZLnq3UZSZS8CeQMJrkkv8XmQmo7dvYKlo0ngvQ7efuJmvB4P
        +W7UTT/IaOEEMwdhv1ep9zXwZNvZMPPiZw==
X-Google-Smtp-Source: APXvYqxy+QfVMd4+1vZhPJKba77efLsRGHXlJCHu4Ro6lxGOfIRXmptsY7EVm8UfLvjKuITEfALCMA==
X-Received: by 2002:adf:f3d1:: with SMTP id g17mr13443885wrp.378.1581497896214;
        Wed, 12 Feb 2020 00:58:16 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id n13sm7497505wmd.21.2020.02.12.00.58.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:58:15 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, arnd@arndb.de
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 04/10] microblaze: Remove empty headers
Date:   Wed, 12 Feb 2020 09:58:01 +0100
Message-Id: <9cca0a17b62cfa548a9cac7a58d516f967163f4d.1581497860.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1581497860.git.michal.simek@xilinx.com>
References: <cover.1581497860.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to keep empty headers if asm-generic one can be used
instead. That's why remove empty file and use asm-generic equivalent.
cputable.h is completely unused that's why remove it.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
---

 arch/microblaze/include/asm/Kbuild     | 2 ++
 arch/microblaze/include/asm/cputable.h | 1 -
 arch/microblaze/include/asm/hw_irq.h   | 1 -
 arch/microblaze/include/asm/user.h     | 1 -
 4 files changed, 2 insertions(+), 3 deletions(-)
 delete mode 100644 arch/microblaze/include/asm/cputable.h
 delete mode 100644 arch/microblaze/include/asm/hw_irq.h
 delete mode 100644 arch/microblaze/include/asm/user.h

diff --git a/arch/microblaze/include/asm/Kbuild b/arch/microblaze/include/asm/Kbuild
index 7ae427f73105..a11407112e9a 100644
--- a/arch/microblaze/include/asm/Kbuild
+++ b/arch/microblaze/include/asm/Kbuild
@@ -13,6 +13,7 @@ generic-y += exec.h
 generic-y += extable.h
 generic-y += fb.h
 generic-y += hardirq.h
+generic-y += hw_irq.h
 generic-y += irq_regs.h
 generic-y += irq_work.h
 generic-y += kdebug.h
@@ -34,6 +35,7 @@ generic-y += syscalls.h
 generic-y += tlb.h
 generic-y += topology.h
 generic-y += trace_clock.h
+generic-y += user.h
 generic-y += vga.h
 generic-y += word-at-a-time.h
 generic-y += xor.h
diff --git a/arch/microblaze/include/asm/cputable.h b/arch/microblaze/include/asm/cputable.h
deleted file mode 100644
index 8b137891791f..000000000000
--- a/arch/microblaze/include/asm/cputable.h
+++ /dev/null
@@ -1 +0,0 @@
-
diff --git a/arch/microblaze/include/asm/hw_irq.h b/arch/microblaze/include/asm/hw_irq.h
deleted file mode 100644
index 8b137891791f..000000000000
--- a/arch/microblaze/include/asm/hw_irq.h
+++ /dev/null
@@ -1 +0,0 @@
-
diff --git a/arch/microblaze/include/asm/user.h b/arch/microblaze/include/asm/user.h
deleted file mode 100644
index 8b137891791f..000000000000
--- a/arch/microblaze/include/asm/user.h
+++ /dev/null
@@ -1 +0,0 @@
-
-- 
2.25.0

