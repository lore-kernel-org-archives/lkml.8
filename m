Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC43C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D5521527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:39:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgFQQjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:39:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:1547 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgFQQjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:39:31 -0400
IronPort-SDR: m31+KGyYT+fvY6MgVB9KgwjqI+6tb3LR9o/OZ7NnA5a6EPAXc08Xlk76m3KnV8UBE0zs7vFNvv
 fSKTvPYs6Ebw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 09:39:30 -0700
IronPort-SDR: IwJt8IVIlsSKjZf5pZBRSBYupg3zeibMExm2K4AEJ+eEuqx4P9HJDgRLj75QksXcIwKf52kiKD
 Cr3kMPhz4mpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,523,1583222400"; 
   d="scan'208";a="309531624"
Received: from zdsmith-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.255.229.128])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jun 2020 09:39:29 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        gregkh@linuxfoundation.org,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: [PATCH] regmap: fix memory leak with map->patch
Date:   Wed, 17 Jun 2020 11:39:00 -0500
Message-Id: <20200617163900.17674-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemleak throws the following error on devices using
regmap_register_patch().  map->patch is allocated dynamically with
krealloc() but never freed.

root@Zotac:~/kmod# cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff8880641c4e08 (size 96):
  comm "systemd-udevd", pid 266, jiffies 4294736541 (age 414.914s)
  hex dump (first 32 bytes):
    3d 01 00 00 00 36 00 00 00 00 00 00 12 01 00 00  =....6..........
    a8 0a 00 00 00 00 00 00 14 01 00 00 aa 0a 00 00  ................
  backtrace:
    [<00000000f2841faf>] krealloc+0x63/0xc0
    [<00000000ed643fb3>] regmap_register_patch+0x68/0x1d0
    [<000000001806a5c3>] 0xffffffffc088a5f9
    [<00000000f4781e26>] i2c_device_probe+0x462/0x4b0
    [<000000009dd7f5f4>] really_probe+0x17f/0x520
    [<00000000be42920d>] driver_probe_device+0x114/0x170
    [<00000000e5840d3f>] device_driver_attach+0x82/0x90
    [<0000000027828801>] __driver_attach+0xa9/0x190
    [<0000000085195e73>] bus_for_each_dev+0xe1/0x140
    [<0000000070edb38c>] bus_add_driver+0x224/0x2e0
    [<000000002d41b24a>] driver_register+0xd3/0x150
    [<0000000055dbb3fb>] i2c_register_driver+0x6b/0xd0
    [<00000000bf84b954>] do_one_initcall+0x86/0x2a0
    [<000000001d939871>] do_init_module+0xf8/0x350
    [<00000000267b474f>] load_module+0x41a9/0x44c0
    [<000000007d8014dc>] __do_sys_finit_module+0x121/0x1b0

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/base/regmap/regmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index c472f624382d..46f4b6322e47 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1357,6 +1357,7 @@ void regmap_exit(struct regmap *map)
 	if (map->hwlock)
 		hwspin_lock_free(map->hwlock);
 	kfree_const(map->name);
+	kfree(map->patch);
 	kfree(map);
 }
 EXPORT_SYMBOL_GPL(regmap_exit);
-- 
2.20.1

