Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4135FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0531A20716
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMfV/cqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgHNLrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgHNLrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:47:31 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD89C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:47:31 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v22so6661352qtq.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 04:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IMIPBlv3aDvlQTux/3mYRoi4ImY2wIcaiD0853r0XO0=;
        b=cMfV/cqLQ+GOOSEmgHNnRlrXGy9A+AO0vRKHoCWP3TqUcLwGqLj/u/7diBPteCCLmv
         7HE/l7k9/pAsp0QfTJCeXWTeJdKuU1EtX/MJ9XuRUtavvDOlkFvNuWqYUHOgCqFK6Ltl
         OITiCytp94FaiPABukF4UdDMC0aWqzJcuJi83pq2376h1hcOaCc36FsSeegxiJJbRxty
         KGP1BTzj6cRYPOVrbPn7hUl8if+feFotnTtpzT6nGWJkWySqznEviZl7cRN8AEmCqvU+
         iEMdUSUhTBQKz6SElFKV15Y0UAhVpZ1S2oh90hjC9zjL/WuvNVxS4ecoBqKnhoCN2F6Y
         PH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IMIPBlv3aDvlQTux/3mYRoi4ImY2wIcaiD0853r0XO0=;
        b=Yghf3ZrIV8TeNXlLDKKg4D1U/sfcD5YKQBwOJXZX/07SEcoBjtkfLZG2AM136dSPcd
         9u1YqQgvEd4pFBTuWd4MFRTVo6bop267Rvcjqi1iS2OX6wYLDLwZ/Iz/QIgweohkbP0g
         S4ZbYRFmpKcMTKWXlXbirbRtKBgsps3ar1S30zaZG+0a6kEmaYjZWYSN9LDYMaLKVh7H
         5F8MkuKOMlxvp+w8tAUag1A1WhdH8cHYCsSeJdYBrb60exvYv4GvH6MrXnc5z+lk0xp4
         C+C5oB4Xg/z457KhgBHZlePZ91NAHVjQZhCavTXmoBnIkn/MO1PxUqH/CSGTDI/6ulrs
         pPUA==
X-Gm-Message-State: AOAM532894lkdMPzc2evnJ6E13ftxlUn0XkpEeU0Ho1+4LxSj4a+KmTP
        AKt0/jNWWp63l2RHgAbgdWqABzhjwuGDKcfa
X-Google-Smtp-Source: ABdhPJwMEYvhFV2izqj8f0aPhTev1ayZlzIlL5sbUDYzZz3wdR20iAlakXaHGGDk0PKQ085CctBhog==
X-Received: by 2002:aed:3587:: with SMTP id c7mr1635807qte.136.1597405648366;
        Fri, 14 Aug 2020 04:47:28 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c100:b9d:d19a:2bb:fec9:a79])
        by smtp.googlemail.com with ESMTPSA id d124sm8089268qkg.65.2020.08.14.04.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 04:47:27 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org
Cc:     ztong0001@gmail.com
Subject: [PATCH v2] nvme-pci: cancel nvme device request before disabling
Date:   Fri, 14 Aug 2020 07:46:02 -0400
Message-Id: <20200814114602.3934-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814071431.201400-1-ztong0001@gmail.com>
References: <20200814071431.201400-1-ztong0001@gmail.com>
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

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ba725ae47305..c4f1ce0ee1e3 100644
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
-- 
2.25.1

