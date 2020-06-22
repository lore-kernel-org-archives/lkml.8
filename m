Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972B3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C1452075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 23:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oCJRZhCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731023AbgFVXuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 19:50:08 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:41441 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbgFVXuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 19:50:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592869807; x=1624405807;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rZllEpf8ZszlyvJoAGgIfYMlPA/MYJ1fDs3XrZKxdZc=;
  b=oCJRZhCaB08569ZvGCGoPG0FqzY4lsh0JvZ5Ey4b6im1WHKfpxlKrLmL
   2Ybt5F+BxgjBGj8WpNJbtKVawvGs++kAdUHjTb7sy+XD/DIW4MLjOYmxy
   fzR94s2TEyrHUa8aOwuiQ6MPbGSctXz9oz/oT3dBqZm1EIsuoTbCZVJu9
   MwHau4FIAUJz7jyo78pHHuqBlcGH+JHd88Un2bbpA+LDBqIjBtKihNzLD
   i2vblqOcbxa2SxAkqC9zyLb27GByp/Detnf/0p4VMsAv49UQxFeVNnhni
   NGbb0ghHmhzsyRUcL5zA9oXe5LYhYkH5XHMiiSwWhXpX38bYmNnfQPM9e
   A==;
IronPort-SDR: w58p2vJDUuC1etz4K2HV9UCvQup0jV6RVz+pUc/SgCesYTZeX/yQFYDmkQmyDCu1uTqLY7f82S
 CuHfLzzBzsGHGNrMAXq0stAUCgQJsOvSZmhEHlopXz5T84UYx0zxPo3Bd7Apd0TBO8wHh8e7b2
 O/JNqBBqiXrgOivp5PeDar0xUSeF+vi4y7O8V1IrJzzS/AL4RGBaaOu7uxbJtKEf/oxTIUsZ6a
 dRivYXpc5DgZXS6E1flOCPiLmYoD+xCgaZfgytDpTlplVR/4zpi9cheqFz+rgwWpGU5UdSi4Nt
 L1w=
X-IronPort-AV: E=Sophos;i="5.75,268,1589212800"; 
   d="scan'208";a="140646385"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2020 07:50:06 +0800
IronPort-SDR: rR/kW+sJPyHkatnuX/t0dcIWK/1KvL7vSG0HOKOpVqImaTSYBgymY2KgAY/7bhDjTrPQrFLXoJ
 nZzxVedu3qBFYtm4/WWWhAaTm4wTla67g=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 16:39:12 -0700
IronPort-SDR: JiLUl4lWt6ijHyeGhTrIqNZmAwbOJ4TKFawtA72xtj+eWa4H8YRT6IHsXhbWWv1znpHQhmz8OU
 jEid+rR83mPg==
WDCIronportException: Internal
Received: from lpt-lee-f.ad.shared (HELO yoda.hgst.com) ([10.86.58.181])
  by uls-op-cesaip01.wdc.com with ESMTP; 22 Jun 2020 16:50:06 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greentime Hu <greentime.hu@sifive.com>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH] RISC-V: Use a local variable instead of smp_processor_id()
Date:   Mon, 22 Jun 2020 16:47:25 -0700
Message-Id: <20200622234725.92511-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greentime Hu <greentime.hu@sifive.com>

Store the smp_processor_id() in a local variable to save some
pointer chasing.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/kernel/smpboot.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 4e9922790f6e..3e033e97dd08 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -146,6 +146,7 @@ void __init smp_cpus_done(unsigned int max_cpus)
 asmlinkage __visible void smp_callin(void)
 {
 	struct mm_struct *mm = &init_mm;
+	unsigned int curr_cpuid = smp_processor_id();
 
 	if (!IS_ENABLED(CONFIG_RISCV_SBI))
 		clint_clear_ipi(cpuid_to_hartid_map(smp_processor_id()));
@@ -155,9 +156,9 @@ asmlinkage __visible void smp_callin(void)
 	current->active_mm = mm;
 
 	trap_init();
-	notify_cpu_starting(smp_processor_id());
-	update_siblings_masks(smp_processor_id());
-	set_cpu_online(smp_processor_id(), 1);
+	notify_cpu_starting(curr_cpuid);
+	update_siblings_masks(curr_cpuid);
+	set_cpu_online(curr_cpuid, 1);
 	/*
 	 * Remote TLB flushes are ignored while the CPU is offline, so emit
 	 * a local TLB flush right now just in case.
-- 
2.26.2

