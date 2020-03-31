Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB5AC2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD4D20675
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646393;
	bh=52XgwWwovb/P9VUKpfTnNO8+PHWAFRtCqha/7sMsf1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kctENQ5vMA5qANbNIB+9OdomsGeT1LU0EtWnJzbDvYNGa5W+rFpQvSGGtS8Q5XAhN
	 dTo/V3yXecmRZZUAq5P+XZx++RGXjun3PCMTnB+mAIqItdedxUGTD9o4r9Fp+eA5j4
	 6MMiPEQ/XbmGc5HAYFtVaLshj07DRfGtwqShB2ow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbgCaJQl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:16:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:37460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731975AbgCaJQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:16:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08A4720772;
        Tue, 31 Mar 2020 09:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585646197;
        bh=52XgwWwovb/P9VUKpfTnNO8+PHWAFRtCqha/7sMsf1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m5biKIMMMntd25pRn1L+EO7uVw+h4eYdaIf5xUVZUZS40sLspVMGp0F6D+xBW4HZZ
         pslqd849oG26+ptX9BkFKJoqDV+336zrmjLvNvPZFdoxNLdlWmznshjTvM31dSYLbk
         qqnHMJ+aXaWfxq8bWOJb2RogsCets9b6Kv3MJJ8w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Zhang <markz@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.4 113/155] RDMA/mlx5: Fix the number of hwcounters of a dynamic counter
Date:   Tue, 31 Mar 2020 10:59:13 +0200
Message-Id: <20200331085431.230022718@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

commit ec16b6bbdab1ce2b03f46271460efc7f450658cd upstream.

When we read the global counter and there's any dynamic counter allocated,
the value of a hwcounter is the sum of the default counter and all dynamic
counters. So the number of hwcounters of a dynamically allocated counter
must be same as of the default counter, otherwise there will be read
violations.

This fixes the KASAN slab-out-of-bounds bug:

  BUG: KASAN: slab-out-of-bounds in rdma_counter_get_hwstat_value+0x36d/0x390 [ib_core]
  Read of size 8 at addr ffff8884192a5778 by task rdma/10138

  CPU: 7 PID: 10138 Comm: rdma Not tainted 5.5.0-for-upstream-dbg-2020-02-06_18-30-19-27 #1
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
  Call Trace:
   dump_stack+0xb7/0x10b
   print_address_description.constprop.4+0x1e2/0x400
   ? rdma_counter_get_hwstat_value+0x36d/0x390 [ib_core]
   __kasan_report+0x15c/0x1e0
   ? mlx5_ib_query_q_counters+0x13f/0x270 [mlx5_ib]
   ? rdma_counter_get_hwstat_value+0x36d/0x390 [ib_core]
   kasan_report+0xe/0x20
   rdma_counter_get_hwstat_value+0x36d/0x390 [ib_core]
   ? rdma_counter_query_stats+0xd0/0xd0 [ib_core]
   ? memcpy+0x34/0x50
   ? nla_put+0xe2/0x170
   nldev_stat_get_doit+0x9c7/0x14f0 [ib_core]
   ...
   do_syscall_64+0x95/0x490
   entry_SYSCALL_64_after_hwframe+0x49/0xbe
  RIP: 0033:0x7fcc457fe65a
  Code: bb 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 8b 05 fa f1 2b 00 45 89 c9 4c 63 d1 48 63 ff 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 76 f3 c3 0f 1f 40 00 41 55 41 54 4d 89 c5 55
  RSP: 002b:00007ffc0586f868 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
  RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fcc457fe65a
  RDX: 0000000000000020 RSI: 00000000013db920 RDI: 0000000000000003
  RBP: 00007ffc0586fa90 R08: 00007fcc45ac10e0 R09: 000000000000000c
  R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004089c0
  R13: 0000000000000000 R14: 00007ffc0586fab0 R15: 00000000013dc9a0

  Allocated by task 9700:
   save_stack+0x19/0x80
   __kasan_kmalloc.constprop.7+0xa0/0xd0
   mlx5_ib_counter_alloc_stats+0xd1/0x1d0 [mlx5_ib]
   rdma_counter_alloc+0x16d/0x3f0 [ib_core]
   rdma_counter_bind_qpn_alloc+0x216/0x4e0 [ib_core]
   nldev_stat_set_doit+0x8c2/0xb10 [ib_core]
   rdma_nl_rcv_msg+0x3d2/0x730 [ib_core]
   rdma_nl_rcv+0x2a8/0x400 [ib_core]
   netlink_unicast+0x448/0x620
   netlink_sendmsg+0x731/0xd10
   sock_sendmsg+0xb1/0xf0
   __sys_sendto+0x25d/0x2c0
   __x64_sys_sendto+0xdd/0x1b0
   do_syscall_64+0x95/0x490
   entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fixes: 18d422ce8ccf ("IB/mlx5: Add counter_alloc_stats() and counter_update_stats() support")
Link: https://lore.kernel.org/r/20200305124052.196688-1-leon@kernel.org
Signed-off-by: Mark Zhang <markz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/main.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -5638,9 +5638,10 @@ mlx5_ib_counter_alloc_stats(struct rdma_
 	const struct mlx5_ib_counters *cnts =
 		get_counters(dev, counter->port - 1);
 
-	/* Q counters are in the beginning of all counters */
 	return rdma_alloc_hw_stats_struct(cnts->names,
-					  cnts->num_q_counters,
+					  cnts->num_q_counters +
+					  cnts->num_cong_counters +
+					  cnts->num_ext_ppcnt_counters,
 					  RDMA_HW_STATS_DEFAULT_LIFESPAN);
 }
 


