Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEB1C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA6720706
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgHRMKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:10:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:58739 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726792AbgHRMKX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:10:23 -0400
IronPort-SDR: mss5JKyw5bR37BTig66GpIaVZ7J11/Xx/yxgLG9Syh8ia8Hjnx6nqYIn+dmrNOcdWoiMj8DHHc
 p5wZ/x6+mArA==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="219200404"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="219200404"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 05:10:22 -0700
IronPort-SDR: zSuB06hyksvsmMMuIP6as8mjjlqkZ3hBWy5xVqaEyU84k1/Xie1+GafoiiGPM0liAP9IPuA/K9
 +4nwSTWMkFeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="326713055"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2020 05:10:20 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 10/13] mei: bus: unconditionally enable clients with vtag support
Date:   Tue, 18 Aug 2020 14:51:44 +0300
Message-Id: <20200818115147.2567012-11-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200818115147.2567012-1-tomas.winkler@intel.com>
References: <20200818115147.2567012-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

The list of clients is only visible via mei client bus.
Enabling vtag clients on the mei client bus allows user-space to
enumerate clients with vtag support by traversing the mei bus on sysfs.
This feature is required for ACRN device model service.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus-fixup.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 07ba16d46690..4e30fa98fe7d 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -463,6 +463,17 @@ static void mei_nfc(struct mei_cl_device *cldev)
 	dev_dbg(bus->dev, "end of fixup match = %d\n", cldev->do_match);
 }
 
+/**
+ * vt_support - enable on bus clients with vtag support
+ *
+ * @cldev: me clients device
+ */
+static void vt_support(struct mei_cl_device *cldev)
+{
+	if (cldev->me_cl->props.vt_supported == 1)
+		cldev->do_match = 1;
+}
+
 #define MEI_FIXUP(_uuid, _hook) { _uuid, _hook }
 
 static struct mei_fixup {
@@ -476,6 +487,7 @@ static struct mei_fixup {
 	MEI_FIXUP(MEI_UUID_WD, mei_wd),
 	MEI_FIXUP(MEI_UUID_MKHIF_FIX, mei_mkhi_fix),
 	MEI_FIXUP(MEI_UUID_HDCP, whitelist),
+	MEI_FIXUP(MEI_UUID_ANY, vt_support),
 };
 
 /**
-- 
2.25.4

