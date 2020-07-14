Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99D3C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDBDE20658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLvThvo4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgGNV3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgGNV27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:28:59 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C79DC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:28:59 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k6so276124wrn.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PKU5uergA0Aa1mhqo6EMw5cD+1UW22BLT1dbrl2IsxA=;
        b=lLvThvo4B331bayf7/2UW/PMnmk32xtN+AvUwEC3DxxqKKvgNziNafJzo9DEoIK0QG
         QKzBqXuBmcpralubgX51+CUBI4c0b46M9Ab1xI2BIHwMtO/otjajXJRIIx+txB5bTezH
         B9ODKxO/tX+X0KC1G81RMh04/C8nJ1AFRV2l3DDQOXKPrdD87xWKVoO6E6a708A9Fm8J
         RiGwBvNR45fgSkPjgHAhjrwzGIBkuUmJRfdJgV4s1C1mnH7z5nTGkl4y2CboFC0VRsU7
         lym13gI8bIQ4BX5ttI0t32u4r9GpBJl5jCo5Vb53DvR7Ib8lscUatlxLiBbQvQ63Yzdc
         doPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=PKU5uergA0Aa1mhqo6EMw5cD+1UW22BLT1dbrl2IsxA=;
        b=lS4B487y4mBmnGafF75eJAM9N3I/UxfaMOwzTgjPMDoFuF9w/cqeAd/U0qgevLYrxu
         zKU0mEOPJIN8PpDwIOIQMBHH6+c9jhUHL/HHw+QE+HjjeqpTmU63NTZ8jh66mDsdGe/B
         5rJGMzgFDnlEOVqr5jvgD/EKQ+hGgYQbEpAd/1AhYNjkH3ElO6rcCjZjwIlxBeHBO7S0
         +hrVz0f8FEIojoK1CoXTXtr6xse0PGn7G7UYorJjUTRv8Fb8QEiDfUt0OgtJ+MJnRC6z
         ij8em1+BfhdLD4HVaiSUJpmQ/CVTrpWtV/FLu+hfEkILgsOgLoZYiMwcqnseEx+y3rN8
         KxUQ==
X-Gm-Message-State: AOAM531OJAlV4N/hLLJS0KK1HHiIhZ9NRRc38skUXzkV8F45Hd17HYaL
        NAbuLKR+JGPp0v6zwl7sl3U=
X-Google-Smtp-Source: ABdhPJx/YmiJpiV9bcRcVFcElAJEvBJY+hvPpl6tbRljDQF0airtIeNgs192Zz5AkAazHZVyNC8OSA==
X-Received: by 2002:adf:e801:: with SMTP id o1mr8186529wrm.54.1594762137484;
        Tue, 14 Jul 2020 14:28:57 -0700 (PDT)
Received: from localhost.localdomain ([80.71.140.73])
        by smtp.gmail.com with ESMTPSA id s8sm345wru.38.2020.07.14.14.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:28:56 -0700 (PDT)
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-riscv@lists.infradead.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Select ARCH_HAS_DEBUG_VM_PGTABLE
Date:   Tue, 14 Jul 2020 23:26:11 +0200
Message-Id: <20200714212611.19692-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows the pgtable tests to be built.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---

The tests seem to succeed both in Qemu and on the HiFive Unleashed

Both with and without the recent additions in
https://lore.kernel.org/linux-riscv/1594610587-4172-1-git-send-email-anshuman.khandual@arm.com/

 Documentation/features/debug/debug-vm-pgtable/arch-support.txt | 2 +-
 arch/riscv/Kconfig                                             | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
index c527d05c0459..c9a764c3c795 100644
--- a/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
+++ b/Documentation/features/debug/debug-vm-pgtable/arch-support.txt
@@ -23,7 +23,7 @@
     |    openrisc: | TODO |
     |      parisc: | TODO |
     |     powerpc: |  ok  |
-    |       riscv: | TODO |
+    |       riscv: |  ok  |
     |        s390: |  ok  |
     |          sh: | TODO |
     |       sparc: | TODO |
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 3230c1d48562..b4e674b1e857 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -15,6 +15,7 @@ config RISCV
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
+	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
-- 
2.27.0

