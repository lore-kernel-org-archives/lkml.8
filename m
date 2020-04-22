Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A61AC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E3C3206A1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgDVHgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:36:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:53133 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbgDVHgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:36:37 -0400
IronPort-SDR: vImTca02YxtXN3YuKH3kNHxXDXMpxM4oV/aPVadU6J0m/s9NbU8GVDI4xgbZHKyKCDNhHvYdQS
 QDZvO91OCcLw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 00:36:37 -0700
IronPort-SDR: +Df1GZqIX6BzgTnln2lNtwlmSbZGLpqIynJLSUWBSCXlbUf0gTW+Fsivufie4VbI/TnnDhQkhw
 WCmBL7Ull+1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,412,1580803200"; 
   d="scan'208";a="456407390"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by fmsmga005.fm.intel.com with ESMTP; 22 Apr 2020 00:36:34 -0700
From:   Rong Chen <rong.a.chen@intel.com>
To:     Vinod Koul <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Rong Chen <rong.a.chen@intel.com>,
        kbuild test robot <lkp@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH] ASoC: soc-compress: avoid false-positive Wuninitialized warning
Date:   Wed, 22 Apr 2020 15:35:43 +0800
Message-Id: <20200422073543.1671-1-rong.a.chen@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <202004201540.vYPhhYMs%lkp@intel.com>
References: <202004201540.vYPhhYMs%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-6.5 and earlier show a new warning:

sound/soc/soc-compress.c: In function ‘soc_compr_open’:
sound/soc/soc-compress.c:75:28: warning: ‘component’ is used uninitialized in this function [-Wuninitialized]
  struct snd_soc_component *component, *save = NULL;
                              ^~~~~~~~~

Simplest fix is to initialize it to avoid the warning.

Reported-by: kbuild test robot <lkp@intel.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/lkml/202004201540.vYPhhYMs%25lkp@intel.com
Signed-off-by: Rong Chen <rong.a.chen@intel.com>
---
 sound/soc/soc-compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 50062eb79adb..e7bd80ed7f2e 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -72,7 +72,7 @@ static int soc_compr_components_free(struct snd_compr_stream *cstream,
 static int soc_compr_open(struct snd_compr_stream *cstream)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
-	struct snd_soc_component *component, *save = NULL;
+	struct snd_soc_component *component = NULL, *save = NULL;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret, i;
 
-- 
2.20.1

