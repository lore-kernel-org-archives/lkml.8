Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CE1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AC142074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgFEKbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:31:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:57119 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgFEKbE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:31:04 -0400
IronPort-SDR: IZw6TRNes93LzT2z9FKAiGiXoFSH5BxM6I3Mj8GuqoAbjyRRJx+/36gjuhPDkHz04kMJHH59WR
 FVdCJB5oyD3g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 03:31:04 -0700
IronPort-SDR: +zpebnjGfh6xj9sm4R3OIVRBs7GdDO/Rr2bEoYuCJTFva1PWcJal/MCFfuDziEwQL4hqgvCvef
 S6Od1Uf+9hxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,476,1583222400"; 
   d="scan'208";a="305024907"
Received: from unknown (HELO localhost.localdomain.bj.intel.com) ([10.240.192.131])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jun 2020 03:31:01 -0700
From:   Zhu Lingshan <lingshan.zhu@intel.com>
To:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        jasowang@redhat.com
Cc:     lulu@redhat.com, dan.daly@intel.com, cunming.liang@intel.com,
        Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH RESEND 2/5] ifcvf: ignore continuous setting same staus value
Date:   Fri,  5 Jun 2020 18:27:12 +0800
Message-Id: <1591352835-22441-3-git-send-email-lingshan.zhu@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1591352835-22441-1-git-send-email-lingshan.zhu@intel.com>
References: <1591352835-22441-1-git-send-email-lingshan.zhu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

User space may try to set status of same value for multiple times,
this patch can handle this case more efficiently by ignoring the
same value of status settings.

Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index d529ed6..63a6366 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -179,6 +179,9 @@ static void ifcvf_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 	adapter = dev_get_drvdata(vdpa_dev->dev.parent);
 	status_old = ifcvf_get_status(vf);
 
+	if (status_old == status)
+		return;
+
 	if ((status_old & VIRTIO_CONFIG_S_DRIVER_OK) &&
 	    !(status & VIRTIO_CONFIG_S_DRIVER_OK)) {
 		ifcvf_stop_datapath(adapter);
-- 
1.8.3.1

