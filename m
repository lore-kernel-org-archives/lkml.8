Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB1FC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E8120720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JcZ2ieOu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgEKKLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 06:11:55 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56913 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728574AbgEKKLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 06:11:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589191912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=8rIJ/HCKqeDNuhBVCnARIXHuevQW0iI68fcfjw4hurk=;
        b=JcZ2ieOur6lia07C2xkB1A7EnGgLerve1/EsOfS8ZslQpBAUGOL38SRTbw1w9fGFPnJLfN
        4C69nj74+7dM4/kgvEcOsU/YOfLr14R9AeXsCLYmgpcKKwl++LHUgladsrA6EjOyJLvHTJ
        +m7U0652pu2HsNq7zsZX+ulXr2GhaY0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-Tn97hWBtP1iFU2lMNZDHUA-1; Mon, 11 May 2020 06:11:51 -0400
X-MC-Unique: Tn97hWBtP1iFU2lMNZDHUA-1
Received: by mail-pl1-f200.google.com with SMTP id q7so7026466plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 03:11:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8rIJ/HCKqeDNuhBVCnARIXHuevQW0iI68fcfjw4hurk=;
        b=Bn5WtqQNMLWg0X2X28kDah1G61x8uQ4kRicGqm7nNmcEKSSA9AZRVC9zFvSOuzXLYM
         hP9h0RpJoUnSD3rICMi9R7IdUzFtLmFbYvSLZrXDaw3T7N1RUAEdeAzguChX+9Cu5WG1
         wF0KpHlYApvDYsFV3h8Cj3aGoNWvPaoYJVr/e+VYa4Kj8gUwt6z2hX2Yn3y5lK7OD8tX
         oFliRKwUSFFzs7gqpwI3CrxExQAQyWmcuORkDr6g3ctqPEnRe69hxZNtWxLL3JpbHAyj
         6JPEyUYLjiCjfbNviAyOVA0lmNlX5VTas5wFp7RUn7fOWgnSavxjZDNsisV0n9PXbSm2
         g7Hg==
X-Gm-Message-State: AGi0PuZRt5IBgdN+QorftlYGPNcP1DVXbJjB5yPfPb0jH8gSlkDiEJWA
        Ya4VKm5YTFlu+P3U8dVnGcgp2nBp13b+5bZ6zhZMFF5ls7A9bImJgnjP0uRCVE+1wJgSPEtddgj
        /pQCHPUpqKwXHCRhbWin9pvf9
X-Received: by 2002:a63:1a16:: with SMTP id a22mr14247242pga.264.1589191909948;
        Mon, 11 May 2020 03:11:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypIrWZlVCElZ4EiLMyjUtvtYVoLvegFRsAleXJFufyVTBZQHo6zM2eSohv7NXejuepQZbH+sDQ==
X-Received: by 2002:a63:1a16:: with SMTP id a22mr14247218pga.264.1589191909658;
        Mon, 11 May 2020 03:11:49 -0700 (PDT)
Received: from localhost ([223.235.87.110])
        by smtp.gmail.com with ESMTPSA id q72sm9712037pjb.53.2020.05.11.03.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2020 03:11:49 -0700 (PDT)
From:   Bhupesh Sharma <bhsharma@redhat.com>
To:     netdev@vger.kernel.org
Cc:     bhsharma@redhat.com, bhupesh.linux@gmail.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        aelior@marvell.com, GR-everest-linux-l2@marvell.com,
        manishc@marvell.com, davem@davemloft.net, irusskikh@marvell.com
Subject: [PATCH v2 1/2] net: qed*: Reduce RX and TX default ring count when running inside kdump kernel
Date:   Mon, 11 May 2020 15:41:41 +0530
Message-Id: <1589191902-958-2-git-send-email-bhsharma@redhat.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1589191902-958-1-git-send-email-bhsharma@redhat.com>
References: <1589191902-958-1-git-send-email-bhsharma@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally kdump kernel(s) run under severe memory constraint with the
basic idea being to save the crashdump vmcore reliably when the primary
kernel panics/hangs.

Currently the qed* ethernet driver ends up consuming a lot of memory in
the kdump kernel, leading to kdump kernel panic when one tries to save
the vmcore via ssh/nfs (thus utilizing the services of the underlying
qed* network interfaces).

An example OOM message log seen in the kdump kernel can be seen here
[1], with crashkernel size reservation of 512M.

Using tools like memstrack (see [2]), we can track the modules taking up
the bulk of memory in the kdump kernel and organize the memory usage
output as per 'highest allocator first'. An example log for the OOM case
indicates that the qed* modules end up allocating approximately 216M
memory, which is a large part of the total crashkernel size:

 dracut-pre-pivot[676]: ======== Report format module_summary: ========
 dracut-pre-pivot[676]: Module qed using 149.6MB (2394 pages), peak allocation 149.6MB (2394 pages)
 dracut-pre-pivot[676]: Module qede using 65.3MB (1045 pages), peak allocation 65.3MB (1045 pages)

This patch reduces the default RX and TX ring count from 1024 to 64
when running inside kdump kernel, which leads to a significant memory
saving.

An example log with the patch applied shows the reduced memory
allocation in the kdump kernel:
 dracut-pre-pivot[674]: ======== Report format module_summary: ========
 dracut-pre-pivot[674]: Module qed using 141.8MB (2268 pages), peak allocation 141.8MB (2268 pages)
 <..snip..>
[dracut-pre-pivot[674]: Module qede using 4.8MB (76 pages), peak allocation 4.9MB (78 pages)

Tested crashdump vmcore save via ssh/nfs protocol using underlying qed*
network interface after applying this patch.

[1] OOM log:
------------

 kworker/0:6: page allocation failure: order:6,
 mode:0x60c0c0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO), nodemask=(null)
 kworker/0:6 cpuset=/ mems_allowed=0
 CPU: 0 PID: 145 Comm: kworker/0:6 Not tainted 4.18.0-109.el8.aarch64 #1
 Hardware name: To be filled by O.E.M. Saber/Saber, BIOS 0ACKL025
 01/18/2019
 Workqueue: events work_for_cpu_fn
 Call trace:
  dump_backtrace+0x0/0x188
  show_stack+0x24/0x30
  dump_stack+0x90/0xb4
  warn_alloc+0xf4/0x178
  __alloc_pages_nodemask+0xcac/0xd58
  alloc_pages_current+0x8c/0xf8
  kmalloc_order_trace+0x38/0x108
  qed_iov_alloc+0x40/0x248 [qed]
  qed_resc_alloc+0x224/0x518 [qed]
  qed_slowpath_start+0x254/0x928 [qed]
   __qede_probe+0xf8/0x5e0 [qede]
  qede_probe+0x68/0xd8 [qede]
  local_pci_probe+0x44/0xa8
  work_for_cpu_fn+0x20/0x30
  process_one_work+0x1ac/0x3e8
  worker_thread+0x44/0x448
  kthread+0x130/0x138
  ret_from_fork+0x10/0x18
  Cannot start slowpath
  qede: probe of 0000:05:00.1 failed with error -12

[2]. Memstrack tool: https://github.com/ryncsn/memstrack

Cc: kexec@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: Ariel Elior <aelior@marvell.com>
Cc: GR-everest-linux-l2@marvell.com
Cc: Manish Chopra <manishc@marvell.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 drivers/net/ethernet/qlogic/qede/qede.h      |  2 ++
 drivers/net/ethernet/qlogic/qede/qede_main.c | 11 +++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qede/qede.h b/drivers/net/ethernet/qlogic/qede/qede.h
index 234c6f30effb..234c7e35ee1e 100644
--- a/drivers/net/ethernet/qlogic/qede/qede.h
+++ b/drivers/net/ethernet/qlogic/qede/qede.h
@@ -574,12 +574,14 @@ int qede_add_tc_flower_fltr(struct qede_dev *edev, __be16 proto,
 #define RX_RING_SIZE		((u16)BIT(RX_RING_SIZE_POW))
 #define NUM_RX_BDS_MAX		(RX_RING_SIZE - 1)
 #define NUM_RX_BDS_MIN		128
+#define NUM_RX_BDS_KDUMP_MIN	63
 #define NUM_RX_BDS_DEF		((u16)BIT(10) - 1)
 
 #define TX_RING_SIZE_POW	13
 #define TX_RING_SIZE		((u16)BIT(TX_RING_SIZE_POW))
 #define NUM_TX_BDS_MAX		(TX_RING_SIZE - 1)
 #define NUM_TX_BDS_MIN		128
+#define NUM_TX_BDS_KDUMP_MIN	63
 #define NUM_TX_BDS_DEF		NUM_TX_BDS_MAX
 
 #define QEDE_MIN_PKT_LEN		64
diff --git a/drivers/net/ethernet/qlogic/qede/qede_main.c b/drivers/net/ethernet/qlogic/qede/qede_main.c
index 34fa3917eb33..1a83d1fd8ccd 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_main.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_main.c
@@ -29,6 +29,7 @@
  * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  * SOFTWARE.
  */
+#include <linux/crash_dump.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/version.h>
@@ -707,8 +708,14 @@ static struct qede_dev *qede_alloc_etherdev(struct qed_dev *cdev,
 	edev->dp_module = dp_module;
 	edev->dp_level = dp_level;
 	edev->ops = qed_ops;
-	edev->q_num_rx_buffers = NUM_RX_BDS_DEF;
-	edev->q_num_tx_buffers = NUM_TX_BDS_DEF;
+
+	if (is_kdump_kernel()) {
+		edev->q_num_rx_buffers = NUM_RX_BDS_KDUMP_MIN;
+		edev->q_num_tx_buffers = NUM_TX_BDS_KDUMP_MIN;
+	} else {
+		edev->q_num_rx_buffers = NUM_RX_BDS_DEF;
+		edev->q_num_tx_buffers = NUM_TX_BDS_DEF;
+	}
 
 	DP_INFO(edev, "Allocated netdev with %d tx queues and %d rx queues\n",
 		info->num_queues, info->num_queues);
-- 
2.7.4

