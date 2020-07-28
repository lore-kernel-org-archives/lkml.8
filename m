Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC7DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5067120714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:02:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgG1CCc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:02:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:7279 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgG1CCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:02:31 -0400
IronPort-SDR: dE+EoLQFYU28T4rtALJiwGhWTPQLkwCjPYZu/IMfb3nzsf95/3Fagq8O59QdEv0kBwn0SncWyv
 InJrS8YkMI0Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9695"; a="139172220"
X-IronPort-AV: E=Sophos;i="5.75,404,1589266800"; 
   d="scan'208";a="139172220"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 19:02:30 -0700
IronPort-SDR: z+bb1G64rsSarO3BomzCJm0/wbGN2TZwe4ZC/HjZYvZoNIlm2LQw/2gc4Y5ILiZjUjLwwWkRFT
 QZA1EcGJwOTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,404,1589266800"; 
   d="scan'208";a="312432655"
Received: from ipu5-build.bj.intel.com ([10.238.232.196])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jul 2020 19:02:18 -0700
From:   Bingbu Cao <bingbu.cao@intel.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        helgaas@kernel.org
Cc:     sakari.ailus@linux.intel.com, tian.shu.qiu@intel.com,
        bingbu.cao@intel.com, bingbu.cao@linux.intel.com
Subject: [PATCH v2] MAINTAINERS: Fix email typo and correct name of Tianshu
Date:   Tue, 28 Jul 2020 10:01:05 +0800
Message-Id: <1595901665-17624-1-git-send-email-bingbu.cao@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the typo in email address of Tianshu Qiu and correct the name.

Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Tianshu Qiu <tian.shu.qiu@intel.com>
Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5392f00cec46..638dfa99751b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8765,7 +8765,7 @@ INTEL IPU3 CSI-2 CIO2 DRIVER
 M:	Yong Zhi <yong.zhi@intel.com>
 M:	Sakari Ailus <sakari.ailus@linux.intel.com>
 M:	Bingbu Cao <bingbu.cao@intel.com>
-R:	Tian Shu Qiu <tian.shu.qiu@intel.com>
+R:	Tianshu Qiu <tian.shu.qiu@intel.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/userspace-api/media/v4l/pixfmt-srggb10-ipu3.rst
@@ -8774,7 +8774,7 @@ F:	drivers/media/pci/intel/ipu3/
 INTEL IPU3 CSI-2 IMGU DRIVER
 M:	Sakari Ailus <sakari.ailus@linux.intel.com>
 R:	Bingbu Cao <bingbu.cao@intel.com>
-R:	Tian Shu Qiu <tian.shu.qiu@intel.com>
+R:	Tianshu Qiu <tian.shu.qiu@intel.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/admin-guide/media/ipu3.rst
@@ -12609,7 +12609,7 @@ T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/i2c/ov2685.c
 
 OMNIVISION OV2740 SENSOR DRIVER
-M:	Tianshu Qiu <tian.shu.qiua@intel.com>
+M:	Tianshu Qiu <tian.shu.qiu@intel.com>
 R:	Shawn Tu <shawnx.tu@intel.com>
 R:	Bingbu Cao <bingbu.cao@intel.com>
 L:	linux-media@vger.kernel.org
-- 
2.7.4

