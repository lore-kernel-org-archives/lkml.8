Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C901C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F7D020781
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:38:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgHLIiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 04:38:19 -0400
Received: from mail1.windriver.com ([147.11.146.13]:55514 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgHLIiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 04:38:18 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.2) with ESMTPS id 07C8bw4R004857
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Wed, 12 Aug 2020 01:37:58 -0700 (PDT)
Received: from pek-qzhang2-d1.wrs.com (128.224.162.183) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Wed, 12 Aug 2020 01:37:58 -0700
From:   <qiang.zhang@windriver.com>
To:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>
CC:     <linux-nvdimm@lists.01.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] libnvdimm: KASAN: global-out-of-bounds Read in internal_create_group
Date:   Wed, 12 Aug 2020 16:37:55 +0800
Message-ID: <20200812083755.30220-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

Because the last member of the "nvdimm_firmware_attributes" array
was not assigned a null ptr, when traversal of "group" array is out of
bounds in "internal_create_groups" func.

internal_create_groups:
	->for (i = 0; groups[i]; i++)
		->...

BUG: KASAN: global-out-of-bounds in create_files fs/sysfs/group.c:43 [inline]
BUG: KASAN: global-out-of-bounds in internal_create_group+0x9d8/0xb20
fs/sysfs/group.c:149
Read of size 8 at addr ffffffff8a2e4cf0 by task kworker/u17:10/959

CPU: 2 PID: 959 Comm: kworker/u17:10 Not tainted 5.8.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: events_unbound async_run_entry_fn
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 create_files fs/sysfs/group.c:43 [inline]
 internal_create_group+0x9d8/0xb20 fs/sysfs/group.c:149
 internal_create_groups.part.0+0x90/0x140 fs/sysfs/group.c:189
 internal_create_groups fs/sysfs/group.c:185 [inline]
 sysfs_create_groups+0x25/0x50 fs/sysfs/group.c:215
 device_add_groups drivers/base/core.c:2024 [inline]
 device_add_attrs drivers/base/core.c:2178 [inline]
 device_add+0x7fd/0x1c40 drivers/base/core.c:2881
 nd_async_device_register+0x12/0x80 drivers/nvdimm/bus.c:506
 async_run_entry_fn+0x121/0x530 kernel/async.c:123
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

The buggy address belongs to the variable:
 nvdimm_firmware_attributes+0x10/0x40

Reported-by: syzbot+1cf0ffe61aecf46f588f@syzkaller.appspotmail.com
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 drivers/nvdimm/dimm_devs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 61374def5155..b59032e0859b 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -529,6 +529,7 @@ static DEVICE_ATTR_ADMIN_RW(activate);
 static struct attribute *nvdimm_firmware_attributes[] = {
 	&dev_attr_activate.attr,
 	&dev_attr_result.attr,
+	NULL,
 };
 
 static umode_t nvdimm_firmware_visible(struct kobject *kobj, struct attribute *a, int n)
-- 
2.17.1

