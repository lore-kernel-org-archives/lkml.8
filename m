Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87375C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594F924680
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgBNPpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:45:47 -0500
Received: from mga07.intel.com ([134.134.136.100]:1170 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbgBNPpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:45:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 07:45:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,441,1574150400"; 
   d="scan'208";a="433053711"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga005.fm.intel.com with ESMTP; 14 Feb 2020 07:45:45 -0800
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org, mdf@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org
Cc:     linux-fpga@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, richard.gong@linux.intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1 4/7] dt-bindings, firmware: add compatible value Intel Stratix10 service layer binding
Date:   Fri, 14 Feb 2020 10:00:49 -0600
Message-Id: <1581696052-11540-5-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
References: <1581696052-11540-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

A a compatible property value to Intel Stratix10 service layer binding

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
index 1fa6606..6eff1af 100644
--- a/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
+++ b/Documentation/devicetree/bindings/firmware/intel,stratix10-svc.txt
@@ -23,7 +23,7 @@ Required properties:
 The svc node has the following mandatory properties, must be located under
 the firmware node.
 
-- compatible: "intel,stratix10-svc"
+- compatible: "intel,stratix10-svc" or "intel,agilex-svc"
 - method: smc or hvc
         smc - Secure Monitor Call
         hvc - Hypervisor Call
-- 
2.7.4

