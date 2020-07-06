Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2736FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D822053B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgGFBUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 21:20:14 -0400
Received: from foss.arm.com ([217.140.110.172]:45850 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728509AbgGFBUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 21:20:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58B1F101E;
        Sun,  5 Jul 2020 18:20:11 -0700 (PDT)
Received: from localhost.localdomain (entos-thunderx2-02.shanghai.arm.com [10.169.212.213])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F1BFB3F718;
        Sun,  5 Jul 2020 18:20:07 -0700 (PDT)
From:   Jia He <justin.he@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Kaly Xin <Kaly.Xin@arm.com>,
        Jia He <justin.he@arm.com>
Subject: [PATCH 2/3] mm/memory_hotplug: harden try_offline_node against bogus nid
Date:   Mon,  6 Jul 2020 09:19:46 +0800
Message-Id: <20200706011947.184166-3-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706011947.184166-1-justin.he@arm.com>
References: <20200706011947.184166-1-justin.he@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When testing the remove_memory path of dax pmem, there will be a panic with
call trace:
  try_remove_memory+0x84/0x170
  remove_memory+0x38/0x58
  dev_dax_kmem_remove+0x3c/0x84 [kmem]
  device_release_driver_internal+0xfc/0x1c8
  device_release_driver+0x28/0x38
  bus_remove_device+0xd4/0x158
  device_del+0x160/0x3a0
  unregister_dev_dax+0x30/0x68
  devm_action_release+0x20/0x30
  release_nodes+0x150/0x240
  devres_release_all+0x6c/0x1d0
  device_release_driver_internal+0x10c/0x1c8
  driver_detach+0xac/0x170
  bus_remove_driver+0x64/0x130
  driver_unregister+0x34/0x60
  dax_pmem_exit+0x14/0xffc4 [dax_pmem]
  __arm64_sys_delete_module+0x18c/0x2d0
  el0_svc_common.constprop.2+0x78/0x168
  do_el0_svc+0x34/0xa0
  el0_sync_handler+0xe0/0x188
  el0_sync+0x164/0x180

It is caused by the bogus nid (-1). Although the root cause is pmem dax
translates from pxm to node_id incorrectly due to numa_off, it is worth
hardening the codes in try_offline_node(), quiting if !pgdat.

Signed-off-by: Jia He <justin.he@arm.com>
---
 mm/memory_hotplug.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index da374cd3d45b..e1e290577b45 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1680,6 +1680,9 @@ void try_offline_node(int nid)
 	pg_data_t *pgdat = NODE_DATA(nid);
 	int rc;
 
+	if (WARN_ON(!pgdat))
+		return;
+
 	/*
 	 * If the node still spans pages (especially ZONE_DEVICE), don't
 	 * offline it. A node spans memory after move_pfn_range_to_zone(),
-- 
2.17.1

