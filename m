Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B78C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B0424650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272745;
	bh=7AOqokVREmq51fFdwM3EZKsgEKghH5r7iEePC9Yg5p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BXyUUxPgOueJGs+ssKJemqmrVZA4AfBzQPit02m5/OyZobYWT+DSOpjtK2XsDIPGD
	 t7W8zlQeDmrsU7KPSYgs7ejfMSyWJaGU8Vsz9kgkWp3vblTZCcaFvt3i3ctT3+21BI
	 /jR4lY8vrtpwxI2B883t0ZZU4qGrZZ+KC6t29sRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732632AbgBUIMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:12:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:48090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732812AbgBUIMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:12:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8385720722;
        Fri, 21 Feb 2020 08:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272741;
        bh=7AOqokVREmq51fFdwM3EZKsgEKghH5r7iEePC9Yg5p8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b3vgw5R0Fn/6Vspra8kjiyhvb52uCiKg1F13ZBrDIen5LtR+edxgHrRJegUNqSa1s
         18oNeNx0MV5BrGisQm5at5AxuBM/VwN+UKKP0KChm+SqDt1WxWknCwyBNy6kchcDPe
         jwBN2ZWrrUrfrVe4StFC1xvgb+LbL8jgb+Y6FveM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 256/344] ASoC: SOF: Intel: hda: Fix SKL dai count
Date:   Fri, 21 Feb 2020 08:40:55 +0100
Message-Id: <20200221072412.819540646@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cezary Rojewski <cezary.rojewski@intel.com>

[ Upstream commit a6947c9d86bcfd61b758b5693eba58defe7fd2ae ]

With fourth pin added for iDisp for skl_dai, update SOF_SKL_DAI_NUM to
account for the change. Without this, dais from the bottom of the list
are skipped. In current state that's the case for 'Alt Analog CPU DAI'.

Fixes: ac42b142cd76 ("ASoC: SOF: Intel: hda: Add iDisp4 DAI")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200113114054.9716-1-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 23e430d3e0568..4be53ef2eab6e 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -336,7 +336,7 @@
 
 /* Number of DAIs */
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
-#define SOF_SKL_NUM_DAIS		14
+#define SOF_SKL_NUM_DAIS		15
 #else
 #define SOF_SKL_NUM_DAIS		8
 #endif
-- 
2.20.1



