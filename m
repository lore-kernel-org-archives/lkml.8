Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD00EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B42C7206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:46:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgG0Jq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:46:58 -0400
Received: from mga03.intel.com ([134.134.136.65]:51087 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgG0Jq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:46:58 -0400
IronPort-SDR: zLuQcfHG7dxlJUe+oWNgXVNope4meG/EleZ3y0ZC6qeHY4KJp0ZwIeYT3n5Zce3o93G5/vrFxI
 aOVlqh5AtZRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="150965124"
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="150965124"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 02:46:57 -0700
IronPort-SDR: fRkHLPfUUkyR6dt2pbNxODGrXRQRuiCwYTLin+oxchTEZo79pQIzCEwlReQ5yptAW4owmsGbcy
 fFLzmTULJNJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="scan'208";a="312154320"
Received: from pg-nxl3.altera.com ([10.142.129.93])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jul 2020 02:46:54 -0700
From:   "Ooi, Joyce" <joyce.ooi@intel.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Joyce Ooi <joyce.ooi@intel.com>,
        Tan Ley Foon <ley.foon.tan@intel.com>,
        See Chin Liang <chin.liang.see@intel.com>
Subject: [PATCH] MAINTAINERS: Replace Thor Thayer as Altera Triple Speed Ethernet maintainer
Date:   Mon, 27 Jul 2020 17:46:41 +0800
Message-Id: <20200727094641.174870-1-joyce.ooi@intel.com>
X-Mailer: git-send-email 2.13.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joyce Ooi <joyce.ooi@intel.com>

This patch is to replace Thor Thayer as Altera Triple Speed Ethernet
maintainer as he is moving to a different role.

Signed-off-by: Joyce Ooi <joyce.ooi@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e64cdde81851..9e6789e1d168 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -782,7 +782,7 @@ F:	include/dt-bindings/reset/altr,rst-mgr-a10sr.h
 F:	include/linux/mfd/altera-a10sr.h
 
 ALTERA TRIPLE SPEED ETHERNET DRIVER
-M:	Thor Thayer <thor.thayer@linux.intel.com>
+M:	Joyce Ooi <joyce.ooi@intel.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/altera/
-- 
2.13.0

