Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F88DC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E974207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbgG2ADv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:03:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:12906 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730203AbgG2ADu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 20:03:50 -0400
IronPort-SDR: UjBXySBTkyKvwXXqEyL9+3Bu1SL1TwoVn2vjdcmo2ElQI5ORoEz22WTHkLAPef5s0wTVcOZRJf
 CT8hPjFnLBFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="139355499"
X-IronPort-AV: E=Sophos;i="5.75,408,1589266800"; 
   d="scan'208";a="139355499"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 17:03:50 -0700
IronPort-SDR: HWByhIL8dhsYC9YtywZwN6Xjz/9Jegnru3PAqqACxrwnjWR7GB9EHHB/PdeQTqszECTRTtUdv3
 WK1OyxomiY9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,408,1589266800"; 
   d="scan'208";a="273722248"
Received: from lkp-server01.sh.intel.com (HELO d27eb53fc52b) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jul 2020 17:03:46 -0700
Received: from kbuild by d27eb53fc52b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k0ZZS-00018e-0S; Wed, 29 Jul 2020 00:03:46 +0000
Date:   Wed, 29 Jul 2020 08:03:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        Moti Haimovski <mhaimovski@habana.ai>,
        Ofir Bitton <obitton@habana.ai>,
        Ben Segal <bpsegal20@gmail.com>,
        Christine Gharzuzi <cgharzuzi@habana.ai>,
        Pawel Piskorski <ppiskorski@habana.ai>
Subject: [RFC PATCH] habanalabs: goya_ctx_init() can be static
Message-ID: <20200729000313.GA14680@e442e3f624c4>
References: <20200728171851.55842-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728171851.55842-1-gregkh@linuxfoundation.org>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: kernel test robot <lkp@intel.com>
---
 gaudi/gaudi.c |    2 +-
 goya/goya.c   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index d4b3b995f69d8..00a0a7238d814 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -6272,7 +6272,7 @@ static enum hl_device_hw_state gaudi_get_hw_state(struct hl_device *hdev)
 	return RREG32(mmHW_STATE);
 }
 
-int gaudi_ctx_init(struct hl_ctx *ctx)
+static int gaudi_ctx_init(struct hl_ctx *ctx)
 {
 	return 0;
 }
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index dedcd2211fb73..85030759b2afe 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -5225,7 +5225,7 @@ static enum hl_device_hw_state goya_get_hw_state(struct hl_device *hdev)
 	return RREG32(mmHW_STATE);
 }
 
-int goya_ctx_init(struct hl_ctx *ctx)
+static int goya_ctx_init(struct hl_ctx *ctx)
 {
 	return 0;
 }
