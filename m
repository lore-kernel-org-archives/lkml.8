Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB38C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13F2920781
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593653794;
	bh=Su7ILB/8TejBEFHJihSSLoVfxdzDuZnPTJVRyUPt8GI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ERjg6wJzXUflBgROjtUC2EH2/W5XsaJiyiAZkDFurGTUiJXCogJfxhFRmH7DoXS1t
	 Gg3aIP3WCB/0CADRpP1hnX/NRUJvwima4odDqd9zfFMG3gsoSnOCojxuNn2ir3v4hK
	 I7207vNjwFPOlFGSI7k91HP2M/u4L65eLM7HaHZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgGBBgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:36:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728233AbgGBBXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:23:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3ECE220884;
        Thu,  2 Jul 2020 01:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593652992;
        bh=Su7ILB/8TejBEFHJihSSLoVfxdzDuZnPTJVRyUPt8GI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y/ImAJUlSC+d/5oBzzTiIes4i0QnICPPsl3rwiE9tOFNaXq4HQ2CWl8dXGtrJ89pq
         ERrtwBoz/0/jPN0+UWMP7GeFLNt4t37BFDUEMvU/Y5WsDQbsIKBMFHDBqw2ty8of10
         MkPvCFtdJTj5zBiqYQ8Tr6dS8nqGKjYHnUq/YyL4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.7 14/53] ASoC: SOF: Intel: add PCI ID for CometLake-S
Date:   Wed,  1 Jul 2020 21:21:23 -0400
Message-Id: <20200702012202.2700645-14-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702012202.2700645-1-sashal@kernel.org>
References: <20200702012202.2700645-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 258fb4f4c34a0db9d3834aba6784d7b322176bb9 ]

Mirror ID added for legacy HDaudio

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://lore.kernel.org/r/20200617164755.18104-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/sof-pci-dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index cec631a1389b5..7b1846aeadd59 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -427,6 +427,8 @@ static const struct pci_device_id sof_pci_ids[] = {
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_COMETLAKE_H)
 	{ PCI_DEVICE(0x8086, 0x06c8),
 		.driver_data = (unsigned long)&cml_desc},
+	{ PCI_DEVICE(0x8086, 0xa3f0), /* CML-S */
+		.driver_data = (unsigned long)&cml_desc},
 #endif
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_TIGERLAKE)
 	{ PCI_DEVICE(0x8086, 0xa0c8),
-- 
2.25.1

