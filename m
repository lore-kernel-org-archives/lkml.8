Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B114C28E83
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0911720709
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgIDIkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:40:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:5910 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728118AbgIDIkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:40:39 -0400
IronPort-SDR: lQf5MVWK4EBZUf7xpP3leE7/8raUYPSHDAo01sk/N/xhDFXq7JJNKkr6IYF4yqUAogSNihzhop
 ySQqWSxBt8Qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="137763268"
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="137763268"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 01:40:39 -0700
IronPort-SDR: 50nrgL/5igyKZdf4Mkjq06CHEwygX49SYgPoXEadfUSnhVQ8//e63PjAdPFQH3xjsA6qGhXJyX
 SDI9X/Po3KqQ==
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="478402092"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 01:40:35 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2 1/3] ASoC: soc-dai: clarify return value for get_sdw_stream()
Date:   Fri,  4 Sep 2020 04:46:48 +0800
Message-Id: <20200903204650.31098-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903204650.31098-1-yung-chuan.liao@linux.intel.com>
References: <20200903204650.31098-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Previous changes move to use ERR_PTR(-ENOTSUPP), but it's not clear
what implementations can return in case of errors. Explicitly document
that NULL is not a possible return value, only ERR_PTR with a negative
error code is valid.

Fixes: 308811a327c38 ('ASoC: soc-dai: return proper error for get_sdw_stream()')
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reported-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/sound/soc-dai.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 776a60529e70..8b693dade9c6 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -471,7 +471,8 @@ static inline int snd_soc_dai_set_sdw_stream(struct snd_soc_dai *dai,
  * This routine only retrieves that was previously configured
  * with snd_soc_dai_get_sdw_stream()
  *
- * Returns pointer to stream or -ENOTSUPP if callback is not supported;
+ * Returns pointer to stream or an ERR_PTR value, e.g.
+ * ERR_PTR(-ENOTSUPP) if callback is not supported;
  */
 static inline void *snd_soc_dai_get_sdw_stream(struct snd_soc_dai *dai,
 					       int direction)
-- 
2.17.1

