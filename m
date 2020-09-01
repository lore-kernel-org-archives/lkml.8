Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB30C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 02:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E2E3206CD
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 02:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgIBC4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 22:56:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:49594 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgIBC4c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 22:56:32 -0400
IronPort-SDR: YJ+19yKk0Q948+X6zeHeWT7e5blCEZSJVZEP0rxwxb+rEO0lH8NhpRYUdjMUDOKXgxnplIPUVl
 nay+jfhnnHDg==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="221528367"
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="221528367"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 19:56:31 -0700
IronPort-SDR: dBdYWAg0W5Eu+7VeYYI/bPQMqFd37s70fWLRa4KE01QtqXb/S2ViGvAlcPTYsUqcSqieOkE6uZ
 bMzgToiTgpZQ==
X-IronPort-AV: E=Sophos;i="5.76,381,1592895600"; 
   d="scan'208";a="477457257"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2020 19:56:27 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH 2/7] soundwire: stream: fix NULL/IS_ERR confusion
Date:   Tue,  1 Sep 2020 23:02:35 +0800
Message-Id: <20200901150240.19288-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901150240.19288-1-yung-chuan.liao@linux.intel.com>
References: <20200901150240.19288-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

snd_soc_dai_get_sdw_stream() can only return -ENOTSUPP or the stream,
NULL is not a possible value.

Fixes: 4550569bd779f ('soundwire: stream: add helper to startup/shutdown streams')
Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 37290a799023..3f54db259f45 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1911,7 +1911,7 @@ void sdw_shutdown_stream(void *sdw_substream)
 
 	sdw_stream = snd_soc_dai_get_sdw_stream(dai, substream->stream);
 
-	if (!sdw_stream) {
+	if (IS_ERR(sdw_stream)) {
 		dev_err(rtd->dev, "no stream found for DAI %s", dai->name);
 		return;
 	}
-- 
2.17.1

