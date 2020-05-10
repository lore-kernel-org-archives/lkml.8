Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8972C35280
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 05:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9265220735
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 05:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="HL7AJgTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgEJFOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 01:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgEJFOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 01:14:12 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86DAC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 22:14:11 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id f83so6314666qke.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 22:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b+gfzmKn75xZVao9M5VVI/l01MvP0LO2u2zGlstYALs=;
        b=HL7AJgTJdvCZts1tIX9IGGn3KtYcMg9tkA1NZ7BwqKRT/7bBb/NNSACm/S0i8V9iQ4
         VERDX+1KVy2X6DEXjxOOX7kPYFPbRRkHeQhyVjIUPsRqymHHJ805hCx2+hhApLZaxDKa
         cFu8FVfs3vu8QCc/DLXTIYC2JCMeuHXGXOJt7PCH6MhEe6d0yVB/PumQw2uvEUaMN6Ik
         iotklanOiwdStFRf5qI4SOiFpOrJAOYFiPB5Ao5LeBVa2EGodSIY+cTwYjBcQhRNw29d
         o/EqJ30QXj9jM6XBlJ2HYlbVVlnOeyzv4E6SClaNZQRh+EzOBqubB/JFh3Bd/CqChf/V
         0+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=b+gfzmKn75xZVao9M5VVI/l01MvP0LO2u2zGlstYALs=;
        b=UTsDa/GKpuxzKt+xiiifH9b/TA7Z7VtfqnlaKud+GsGfzlaLOCgq9lZEM8fnVM2PER
         8JY5QK6OpH9IlX5asxQKOc2NSLIh1WkBHLQdug7eBO2f+gBnx5y+imUhGQHHyVxDiWt1
         O1xZSI3HhyAumCQwpvaeCDrZULa9+XBPhyKHqY6QLArxqkWVt9OAyNFGK7WaYOURXpp3
         nAVLh6UPaBCiKS35/eKla9VEmC7GUUkD1g4CQ5aBjF88Lh0Ph33/AEj5ClUkq1jeShlp
         lgn/tzKDdzJaK1zineCLfZ1GgnOagW/6kt1WHz1twEJMMUtBRXn46wzvGc0p6Vmc7zqB
         je6A==
X-Gm-Message-State: AGi0PuYhxP7kKk44kXv3KMA9Rl2MDH/dkVTM2eC0aOqN+AIXqO3/5RQY
        5cwy7XAO5l9Krjm/tqg29ddEEg==
X-Google-Smtp-Source: APiQypJh4YYuN8boueA234dTZu1p5/7eCxYm6HOeG6TAlMAYpYnUQaSoIHfnA5GUkhCUbnD9Hm3TDA==
X-Received: by 2002:a05:620a:556:: with SMTP id o22mr10148196qko.434.1589087650989;
        Sat, 09 May 2020 22:14:10 -0700 (PDT)
Received: from ovpn-112-80.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id n206sm5169417qke.20.2020.05.09.22.14.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 May 2020 22:14:10 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, aik@ozlabs.ru,
        paulmck@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] powerpc/powernv/pci: fix a RCU-list lock
Date:   Sun, 10 May 2020 01:13:47 -0400
Message-Id: <20200510051347.1906-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is unsafe to traverse tbl->it_group_list without the RCU read lock.

 WARNING: suspicious RCU usage
 5.7.0-rc4-next-20200508 #1 Not tainted
 -----------------------------
 arch/powerpc/platforms/powernv/pci-ioda-tce.c:355 RCU-list traversed in non-reader section!!

 other info that might help us debug this:

 rcu_scheduler_active = 2, debug_locks = 1
 3 locks held by qemu-kvm/4305:
  #0: c000000bc3fe6988 (&container->group_lock){++++}-{3:3}, at: vfio_fops_unl_ioctl+0x108/0x410 [vfio]
  #1: c00800000fcc7400 (&vfio.iommu_drivers_lock){+.+.}-{3:3}, at: vfio_fops_unl_ioctl+0x148/0x410 [vfio]
  #2: c000000bc3fe4d68 (&container->lock){+.+.}-{3:3}, at: tce_iommu_attach_group+0x3c/0x4f0 [vfio_iommu_spapr_tce]

 stack backtrace:
 CPU: 4 PID: 4305 Comm: qemu-kvm Not tainted 5.7.0-rc4-next-20200508 #1
 Call Trace:
 [c0000010f29afa60] [c0000000007154c8] dump_stack+0xfc/0x174 (unreliable)
 [c0000010f29afab0] [c0000000001d8ff0] lockdep_rcu_suspicious+0x140/0x164
 [c0000010f29afb30] [c0000000000dae2c] pnv_pci_unlink_table_and_group+0x11c/0x200
 [c0000010f29afb70] [c0000000000d4a34] pnv_pci_ioda2_unset_window+0xc4/0x190
 [c0000010f29afbf0] [c0000000000d4b4c] pnv_ioda2_take_ownership+0x4c/0xd0
 [c0000010f29afc30] [c00800000fd60ee0] tce_iommu_attach_group+0x2c8/0x4f0 [vfio_iommu_spapr_tce]
 [c0000010f29afcd0] [c00800000fcc11a0] vfio_fops_unl_ioctl+0x238/0x410 [vfio]
 [c0000010f29afd50] [c0000000005430a8] ksys_ioctl+0xd8/0x130
 [c0000010f29afda0] [c000000000543128] sys_ioctl+0x28/0x40
 [c0000010f29afdc0] [c000000000038af4] system_call_exception+0x114/0x1e0
 [c0000010f29afe20] [c00000000000c8f0] system_call_common+0xf0/0x278

Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/powerpc/platforms/powernv/pci-ioda-tce.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda-tce.c b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
index 5dc6847d5f4c..6be9cf292b4e 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda-tce.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
@@ -352,6 +352,8 @@ void pnv_pci_unlink_table_and_group(struct iommu_table *tbl,
 
 	/* Remove link to a group from table's list of attached groups */
 	found = false;
+
+	rcu_read_lock();
 	list_for_each_entry_rcu(tgl, &tbl->it_group_list, next) {
 		if (tgl->table_group == table_group) {
 			list_del_rcu(&tgl->next);
@@ -360,6 +362,8 @@ void pnv_pci_unlink_table_and_group(struct iommu_table *tbl,
 			break;
 		}
 	}
+	rcu_read_unlock();
+
 	if (WARN_ON(!found))
 		return;
 
-- 
2.21.0 (Apple Git-122.2)

