Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEF4C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 11:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3B03206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 11:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgEPLGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 07:06:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:26451 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbgEPLGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 07:06:18 -0400
IronPort-SDR: vCVPo9w43chX2DDBRA9Ydu9f/vb2jie9Ew8ORcMZKLa3arBp2vdc/reQ/cYyFOEXe2vyHDVRLE
 Rf24UxyNoMHg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2020 04:06:18 -0700
IronPort-SDR: m0wg51Tx6ROU4LHBKnUyWmWtm986e18Pn02u3VVeT/otnc2jS63zTmUulJGiV2aGz798VVoFNy
 vr9bFBYyv6tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,398,1583222400"; 
   d="scan'208";a="263457892"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.155])
  by orsmga003.jf.intel.com with ESMTP; 16 May 2020 04:06:16 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 2/2] mfd: mfd_cell: constify platform_data
Date:   Sat, 16 May 2020 14:06:09 +0300
Message-Id: <20200516110609.22013-3-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200516110609.22013-1-tomas.winkler@intel.com>
References: <20200516110609.22013-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_data is duplicated into platform_device platform_data
via platform_device_add_data() and is not modified.

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 include/linux/mfd/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 7e5ac3c00891..6919aaee33dc 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -66,7 +66,7 @@ struct mfd_cell {
 	int			(*resume)(struct platform_device *dev);
 
 	/* platform data passed to the sub devices drivers */
-	void			*platform_data;
+	const void		*platform_data;
 	size_t			pdata_size;
 
 	/* device properties passed to the sub devices drivers */
-- 
2.21.3

