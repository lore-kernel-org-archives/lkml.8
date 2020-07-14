Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F3CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED66A2240B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753543;
	bh=Su7ILB/8TejBEFHJihSSLoVfxdzDuZnPTJVRyUPt8GI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dRaIpyQXw7pfl9Gov9E265LBRxyP1NpNwTnN+qf+mUSH1jXDcbd4iTSgtRIBWHg1T
	 Pmj+mKlmfIEXnF+Vnf2RfvLqODm28fv+ym8H2R3N5jsn+stcY7sUVt560407v4yxqO
	 rf5yc+5ouIHKhsfS2R29VQERzoIMoc2PFgtlPquY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbgGNTFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:05:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729821AbgGNSyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:54:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09F8B22BED;
        Tue, 14 Jul 2020 18:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752864;
        bh=Su7ILB/8TejBEFHJihSSLoVfxdzDuZnPTJVRyUPt8GI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0rRsUFECDOD92QLpF/Hp8z1FSTDI7rppHNxQbgIcBxfGuYi+zoNsGWYxpeeVcZbWg
         mYnb1AQ3yUlf9pctkNdbJV3AhIWxMeBkPDVIgtuO+mKwTNLX2a4PGpgpQ2mgj2m0go
         KPsEipv+7/o+cvyfNMabBh6bqXjQM8ZlxqfsgAWY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 015/166] ASoC: SOF: Intel: add PCI ID for CometLake-S
Date:   Tue, 14 Jul 2020 20:43:00 +0200
Message-Id: <20200714184116.627511977@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



