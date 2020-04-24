Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29F1C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 00:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B72B620704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 00:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgDXAy5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 20:54:57 -0400
Received: from mga04.intel.com ([192.55.52.120]:25188 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728156AbgDXAy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 20:54:57 -0400
IronPort-SDR: EzTOSaEPySnl5lQy4+erP7Fwg7R2LwJgx9lC+GU3UqFTlZ+az0DGa72Thaa3UsqvE9zTnJaTjB
 ogQkyx0oXz+A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 17:54:57 -0700
IronPort-SDR: lB41GEDhV85GA7tfq07v2fLk/Bk/F3oxHXYNJBfZ9JuS3a6hGj+RLPWgZ+cPHICGpaVd7xG6hR
 BdqHtn1O30Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,309,1583222400"; 
   d="scan'208";a="430560009"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by orsmga005.jf.intel.com with ESMTP; 23 Apr 2020 17:54:54 -0700
From:   Rong Chen <rong.a.chen@intel.com>
To:     Vinod Koul <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Rong Chen <rong.a.chen@intel.com>,
        kbuild test robot <lkp@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2] ASoC: soc-compress: avoid false-positive Wuninitialized warning
Date:   Fri, 24 Apr 2020 08:54:37 +0800
Message-Id: <20200424005437.3941-1-rong.a.chen@intel.com>
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
index ceaf976db0bb..8431ff72be63 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -72,7 +72,7 @@ static int soc_compr_components_free(struct snd_compr_stream *cstream,
 static int soc_compr_open(struct snd_compr_stream *cstream)
 {
 	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
-	struct snd_soc_component *component, *save = NULL;
+	struct snd_soc_component *component = NULL, *save = NULL;
 	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
 	int ret, i;
 
-- 
2.20.1

