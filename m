Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6FFC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EA9120848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyx7hHza"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgH1ORw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgH1ORj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:17:39 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A01C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:17:36 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id p65so217644qtd.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 07:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AY0AyQHe0H4aLpd5O1f5q6yOLbf+gMdRxlwBykfuLqM=;
        b=gyx7hHzabhnb3NOoenQKNQfJ0sJDfwG8cz34kPqqZUTPLzDyTaR9KU1oaE045SmKkE
         IDUrHQxiC+TH+r2s7248YUO+iEpszvB7t1VVmIoBbBvsUo/ujttAZIgg2XMi4koOIOlc
         m215CyBdM666qAJbB3WqpDOZo+ZTSdM35v7VCEMye4KlXmkkFptTmd6o46uubn63qMXm
         jmymereHIJo9QBoOhHIKjIt/BqxCR9rX2ZX4101ksGJGt8svOBk+wnISy6fHqXXOVFG9
         68WwQswWcAdExoSdv+/cTSgiH/nraxTTdXToRaQUJvx1Ruak95Atz73zQy6r57AywkvB
         WUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AY0AyQHe0H4aLpd5O1f5q6yOLbf+gMdRxlwBykfuLqM=;
        b=hzo4ufEdUnbJP47VCWla2K3xK1IBIeCdPUW7wcq14r4ySES6EkDjGQMP4/04/qzRSW
         fw8JBsZd5QpvRDhX8B5QXpzkK7PmeNTkT7UVZSLn+IVZ5JdJGZ4USKz19AXp2TnWlVWk
         oMCHx8zg8Kt9fnd40Hqn0B+sJm+ZN3RCVkPGJynSXFw+hHgXAtN2oWAThfx4HG0Ntbuk
         WF0ORf6RPU9XvRv0F19JjpWpFRWvAvRMi9LXomZgUYHVV0hpyYLsJzKwv3vY5TrC6Rvg
         4JoVpEapW+66a8hMcIIEqjQHlZ9YQnVleX8xY3lrcxF1NHYLk8hM1HPCMedNSLSuFef/
         M8uQ==
X-Gm-Message-State: AOAM531yD5YNd+whwEf6yLDHzCE11zfgcuYYNAPGwsx8VtoKKR2joaEE
        dU2O8KpgZevkyhbnHDnL2Ko=
X-Google-Smtp-Source: ABdhPJyUlxMEoAvW8FaJdkBw87TbgVGZvFaU8S5sokQdP8xZgQJseHb8YliUrTHJ2BukFcE+aqhGQA==
X-Received: by 2002:ac8:2a30:: with SMTP id k45mr1572731qtk.290.1598624255751;
        Fri, 28 Aug 2020 07:17:35 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c100:b9d:8cbc:4931:e171:e7fa])
        by smtp.googlemail.com with ESMTPSA id 7sm831641qkp.57.2020.08.28.07.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 07:17:35 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     ztong0001@gmail.com
Subject: [PATCH v2] nvme-pci: cancel nvme device request before disabling
Date:   Fri, 28 Aug 2020 10:17:08 -0400
Message-Id: <20200828141707.4124-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200827150103.GA2613662@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200827150103.GA2613662@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addresses an irq free warning and null pointer dereference
error problem when nvme devices got timeout error during initialization.
This problem happens when nvme_timeout() function is called while
nvme_reset_work() is still in execution. This patch fixed the problem by
setting flag of the problematic request to NVME_REQ_CANCELLED before
calling nvme_dev_disable() to make sure __nvme_submit_sync_cmd() returns
an error code and let nvme_submit_sync_cmd() fail gracefully.
The following is console output.

[   62.472097] nvme nvme0: I/O 13 QID 0 timeout, disable controller
[   62.488796] nvme nvme0: could not set timestamp (881)
[   62.494888] ------------[ cut here ]------------
[   62.495142] Trying to free already-free IRQ 11
[   62.495366] WARNING: CPU: 0 PID: 7 at kernel/irq/manage.c:1751 free_irq+0x1f7/0x370
[   62.495742] Modules linked in:
[   62.495902] CPU: 0 PID: 7 Comm: kworker/u4:0 Not tainted 5.8.0+ #8
[   62.496206] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-48-gd9c812dda519-p4
[   62.496772] Workqueue: nvme-reset-wq nvme_reset_work
[   62.497019] RIP: 0010:free_irq+0x1f7/0x370
[   62.497223] Code: e8 ce 49 11 00 48 83 c4 08 4c 89 e0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 44 89 f6 48 c70
[   62.498133] RSP: 0000:ffffa96800043d40 EFLAGS: 00010086
[   62.498391] RAX: 0000000000000000 RBX: ffff9b87fc458400 RCX: 0000000000000000
[   62.498741] RDX: 0000000000000001 RSI: 0000000000000096 RDI: ffffffff9693d72c
[   62.499091] RBP: ffff9b87fd4c8f60 R08: ffffa96800043bfd R09: 0000000000000163
[   62.499440] R10: ffffa96800043bf8 R11: ffffa96800043bfd R12: ffff9b87fd4c8e00
[   62.499790] R13: ffff9b87fd4c8ea4 R14: 000000000000000b R15: ffff9b87fd76b000
[   62.500140] FS:  0000000000000000(0000) GS:ffff9b87fdc00000(0000) knlGS:0000000000000000
[   62.500534] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   62.500816] CR2: 0000000000000000 CR3: 000000003aa0a000 CR4: 00000000000006f0
[   62.501165] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   62.501515] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   62.501864] Call Trace:
[   62.501993]  pci_free_irq+0x13/0x20
[   62.502167]  nvme_reset_work+0x5d0/0x12a0
[   62.502369]  ? update_load_avg+0x59/0x580
[   62.502569]  ? ttwu_queue_wakelist+0xa8/0xc0
[   62.502780]  ? try_to_wake_up+0x1a2/0x450
[   62.502979]  process_one_work+0x1d2/0x390
[   62.503179]  worker_thread+0x45/0x3b0
[   62.503361]  ? process_one_work+0x390/0x390
[   62.503568]  kthread+0xf9/0x130
[   62.503726]  ? kthread_park+0x80/0x80
[   62.503911]  ret_from_fork+0x22/0x30
[   62.504090] ---[ end trace de9ed4a70f8d71e2 ]---
[  123.912275] nvme nvme0: I/O 12 QID 0 timeout, disable controller
[  123.914670] nvme nvme0: 1/0/0 default/read/poll queues
[  123.916310] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  123.917469] #PF: supervisor write access in kernel mode
[  123.917725] #PF: error_code(0x0002) - not-present page
[  123.917976] PGD 0 P4D 0
[  123.918109] Oops: 0002 [#1] SMP PTI
[  123.918283] CPU: 0 PID: 7 Comm: kworker/u4:0 Tainted: G        W         5.8.0+ #8
[  123.918650] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-48-gd9c812dda519-p4
[  123.919219] Workqueue: nvme-reset-wq nvme_reset_work
[  123.919469] RIP: 0010:__blk_mq_alloc_map_and_request+0x21/0x80
[  123.919757] Code: 66 0f 1f 84 00 00 00 00 00 41 55 41 54 55 48 63 ee 53 48 8b 47 68 89 ee 48 89 fb 8b4
[  123.920657] RSP: 0000:ffffa96800043d40 EFLAGS: 00010286
[  123.920912] RAX: ffff9b87fc4fee40 RBX: ffff9b87fc8cb008 RCX: 0000000000000000
[  123.921258] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9b87fc618000
[  123.921602] RBP: 0000000000000000 R08: ffff9b87fdc2c4a0 R09: ffff9b87fc616000
[  123.921949] R10: 0000000000000000 R11: ffff9b87fffd1500 R12: 0000000000000000
[  123.922295] R13: 0000000000000000 R14: ffff9b87fc8cb200 R15: ffff9b87fc8cb000
[  123.922641] FS:  0000000000000000(0000) GS:ffff9b87fdc00000(0000) knlGS:0000000000000000
[  123.923032] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  123.923312] CR2: 0000000000000000 CR3: 000000003aa0a000 CR4: 00000000000006f0
[  123.923660] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  123.924007] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  123.924353] Call Trace:
[  123.924479]  blk_mq_alloc_tag_set+0x137/0x2a0
[  123.924694]  nvme_reset_work+0xed6/0x12a0
[  123.924898]  process_one_work+0x1d2/0x390
[  123.925099]  worker_thread+0x45/0x3b0
[  123.925280]  ? process_one_work+0x390/0x390
[  123.925486]  kthread+0xf9/0x130
[  123.925642]  ? kthread_park+0x80/0x80
[  123.925825]  ret_from_fork+0x22/0x30
[  123.926004] Modules linked in:
[  123.926158] CR2: 0000000000000000
[  123.926322] ---[ end trace de9ed4a70f8d71e3 ]---
[  123.926549] RIP: 0010:__blk_mq_alloc_map_and_request+0x21/0x80
[  123.926832] Code: 66 0f 1f 84 00 00 00 00 00 41 55 41 54 55 48 63 ee 53 48 8b 47 68 89 ee 48 89 fb 8b4
[  123.927734] RSP: 0000:ffffa96800043d40 EFLAGS: 00010286
[  123.927989] RAX: ffff9b87fc4fee40 RBX: ffff9b87fc8cb008 RCX: 0000000000000000
[  123.928336] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9b87fc618000
[  123.928679] RBP: 0000000000000000 R08: ffff9b87fdc2c4a0 R09: ffff9b87fc616000
[  123.929025] R10: 0000000000000000 R11: ffff9b87fffd1500 R12: 0000000000000000
[  123.929370] R13: 0000000000000000 R14: ffff9b87fc8cb200 R15: ffff9b87fc8cb000
[  123.929715] FS:  0000000000000000(0000) GS:ffff9b87fdc00000(0000) knlGS:0000000000000000
[  123.930106] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  123.930384] CR2: 0000000000000000 CR3: 000000003aa0a000 CR4: 00000000000006f0
[  123.930731] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  123.931077] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

Co-developed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---

v2: also fix other places where NVME_REQ_CANCELLED should be set before
calling nvme_dev_disable according to Keith Busch's comment

 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ba725ae47305..0d51f1210444 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1249,8 +1249,8 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		dev_warn_ratelimited(dev->ctrl.device,
 			 "I/O %d QID %d timeout, disable controller\n",
 			 req->tag, nvmeq->qid);
-		nvme_dev_disable(dev, true);
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
+		nvme_dev_disable(dev, true);
 		return BLK_EH_DONE;
 	case NVME_CTRL_RESETTING:
 		return BLK_EH_RESET_TIMER;
@@ -1267,10 +1267,10 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		dev_warn(dev->ctrl.device,
 			 "I/O %d QID %d timeout, reset controller\n",
 			 req->tag, nvmeq->qid);
+		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 		nvme_dev_disable(dev, false);
 		nvme_reset_ctrl(&dev->ctrl);
 
-		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
 		return BLK_EH_DONE;
 	}
 
-- 
2.25.1

