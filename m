Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4B8C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DAEA24963
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942399;
	bh=GYpa3dN/ceeAIktMDNq9xvzagqdZCbUIdjlAwEWSv98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HyacQt+7hlv2CFmnEYzRYuGihyGYawwhJylCG17b5jPR3rgMlDAfbWQ5uvBAp8iM3
	 O0381Z3itqgVPDi7qX/3+6CyD+8Z6BeH6gk2YnOVzX/R4J32F+LKjuE+VU3xD+aFga
	 nxp9fz768hzBbivWTNlOJ7sblKXOlNSTq1PfEyO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgEHMxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:53:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729873AbgEHMxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:53:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6EEC0218AC;
        Fri,  8 May 2020 12:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942391;
        bh=GYpa3dN/ceeAIktMDNq9xvzagqdZCbUIdjlAwEWSv98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ud+nlE8hT1x2E10ULeHq+Zk5c2ycQyvXup5gbcpYKeKxQsT3jFzjd9j5kGjcS/Tz3
         imF8FQIJrP6RG0IyhYkdqPHouU6n8na40M4Xmu9QqTN0Eaq5j3t6OXyPV1ic1a/btv
         FrXREaaoGDtmRKGDc+iwf3Fxj2W0UFiAc9MMZSqE=
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
Subject: [PATCH 5.4 04/50] ASoC: topology: Check return value of soc_tplg_*_create
Date:   Fri,  8 May 2020 14:35:10 +0200
Message-Id: <20200508123043.868468052@linuxfoundation.org>
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

[ Upstream commit 2ae548f30d7f6973388fc3769bb3c2f6fd13652b ]

Functions soc_tplg_denum_create, soc_tplg_dmixer_create,
soc_tplg_dbytes_create can fail, so their return values should be
checked and error should be propagated.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200327204729.397-4-amadeuszx.slawinski@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/soc-topology.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index c2901652a6d04..efe6ad3bfcd9b 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -1123,6 +1123,7 @@ static int soc_tplg_kcontrol_elems_load(struct soc_tplg *tplg,
 	struct snd_soc_tplg_hdr *hdr)
 {
 	struct snd_soc_tplg_ctl_hdr *control_hdr;
+	int ret;
 	int i;
 
 	if (tplg->pass != SOC_TPLG_PASS_MIXER) {
@@ -1151,25 +1152,30 @@ static int soc_tplg_kcontrol_elems_load(struct soc_tplg *tplg,
 		case SND_SOC_TPLG_CTL_RANGE:
 		case SND_SOC_TPLG_DAPM_CTL_VOLSW:
 		case SND_SOC_TPLG_DAPM_CTL_PIN:
-			soc_tplg_dmixer_create(tplg, 1,
-					       le32_to_cpu(hdr->payload_size));
+			ret = soc_tplg_dmixer_create(tplg, 1,
+					le32_to_cpu(hdr->payload_size));
 			break;
 		case SND_SOC_TPLG_CTL_ENUM:
 		case SND_SOC_TPLG_CTL_ENUM_VALUE:
 		case SND_SOC_TPLG_DAPM_CTL_ENUM_DOUBLE:
 		case SND_SOC_TPLG_DAPM_CTL_ENUM_VIRT:
 		case SND_SOC_TPLG_DAPM_CTL_ENUM_VALUE:
-			soc_tplg_denum_create(tplg, 1,
-					      le32_to_cpu(hdr->payload_size));
+			ret = soc_tplg_denum_create(tplg, 1,
+					le32_to_cpu(hdr->payload_size));
 			break;
 		case SND_SOC_TPLG_CTL_BYTES:
-			soc_tplg_dbytes_create(tplg, 1,
-					       le32_to_cpu(hdr->payload_size));
+			ret = soc_tplg_dbytes_create(tplg, 1,
+					le32_to_cpu(hdr->payload_size));
 			break;
 		default:
 			soc_bind_err(tplg, control_hdr, i);
 			return -EINVAL;
 		}
+		if (ret < 0) {
+			dev_err(tplg->dev, "ASoC: invalid control\n");
+			return ret;
+		}
+
 	}
 
 	return 0;
-- 
2.20.1



