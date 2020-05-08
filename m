Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD98FC47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A50D5206D6
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942765;
	bh=nYvNC5mp3p9E42LUYjMDSuncRs7p9od0b/nf87IZNn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mDD8z3k7qBzvHN+WGiffgpEd673rjBrUuhH+ENjVht0bw/q6Q2npri0AvPaRv5APA
	 ci60cZOPzG850JNy+VRH5P4EbHSmADA6mQSAn6kWJzB6NplW1Ubam9JRQk6uzfnCZZ
	 OG8DNcrkoOK446bjY2f4kKipEmE22IusoS/sSFnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730076AbgEHMxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:53:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730064AbgEHMxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:53:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C74ED24953;
        Fri,  8 May 2020 12:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942399;
        bh=nYvNC5mp3p9E42LUYjMDSuncRs7p9od0b/nf87IZNn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1AXzAubStcLuiGgtSsMDkY8k7mTiaL0hVQg8ZrWiFTFUpvKHZN9LGuq5509O8Hstk
         QFzzf+YYaR9w7Rflgz0cEZWQZau1WqV/oRJ5HoS+L+rq7JGQpR8zy6O44YCAoXHmiK
         TkTPB6EBwuHpgy2ZZOPGAQbjpQATUI735+SAsw5o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 07/50] ASoC: topology: Check return value of soc_tplg_dai_config
Date:   Fri,  8 May 2020 14:35:13 +0200
Message-Id: <20200508123044.352094803@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123043.085296641@linuxfoundation.org>
References: <20200508123043.085296641@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

[ Upstream commit dd8e871d4e560eeb8d22af82dde91457ad835a63 ]

Function soc_tplg_dai_config can fail, check for and handle possible
failure.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200327204729.397-7-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-topology.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 22960f5932c7f..2d4a5a3058c41 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2431,7 +2431,7 @@ static int soc_tplg_dai_elems_load(struct soc_tplg *tplg,
 {
 	struct snd_soc_tplg_dai *dai;
 	int count;
-	int i;
+	int i, ret;
 
 	count = le32_to_cpu(hdr->count);
 
@@ -2446,7 +2446,12 @@ static int soc_tplg_dai_elems_load(struct soc_tplg *tplg,
 			return -EINVAL;
 		}
 
-		soc_tplg_dai_config(tplg, dai);
+		ret = soc_tplg_dai_config(tplg, dai);
+		if (ret < 0) {
+			dev_err(tplg->dev, "ASoC: failed to configure DAI\n");
+			return ret;
+		}
+
 		tplg->pos += (sizeof(*dai) + le32_to_cpu(dai->priv.size));
 	}
 
-- 
2.20.1



