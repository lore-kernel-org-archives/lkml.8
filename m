Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47811C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0322051A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747740;
	bh=2dCeTe+htp6bYLj6TEvc7v6Uv3nrYBGHsJ2ytgCOJwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CTCMK7WLzy27rEOfXFkQTt5zSEFajqO5h0XV2PVsThIDh207fdPPOyMijqWHhpGEZ
	 laGN589XTx9f7h0SloinndvtINL7OMuJcRa8TXoEDmsIQPH2cZkr3WiruLIIee6RYo
	 1foLd5eF3hEIq2uPa1Pf0xzNcAhuKObLn2393KQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731018AbgBCQfi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:35:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:50446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730974AbgBCQfe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:35:34 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD29A2051A;
        Mon,  3 Feb 2020 16:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747734;
        bh=2dCeTe+htp6bYLj6TEvc7v6Uv3nrYBGHsJ2ytgCOJwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S7x8RZCuj+2mg1GpYwwG5cTAfCGNRSvfBD4oB9nR/lyGd/nwu2UU+nN9seHRWkKEs
         Yld1kmrnHD/IL/ZuzC091t8m0Lq8ZYSo3u1vAHv+mbIimnINJfd/izpv144ElWO9BI
         UWMkWSI+ni2moaDXtF0mAgtlIDmuHvxciaNuEC7k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 46/90] ASoC: hdac_hda: Fix error in driver removal after failed probe
Date:   Mon,  3 Feb 2020 16:19:49 +0000
Message-Id: <20200203161923.638680544@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161917.612554987@linuxfoundation.org>
References: <20200203161917.612554987@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

[ Upstream commit 552b1a85da9f63856e7e341b81c16e0e078204f1 ]

In case system has multiple HDA codecs, and codec probe fails for
at least one but not all codecs, driver will end up cancelling
a non-initialized timer context upon driver removal.

Call trace of typical case:

[   60.593646] WARNING: CPU: 1 PID: 1147 at kernel/workqueue.c:3032
__flush_work+0x18b/0x1a0
[...]
[   60.593670]  __cancel_work_timer+0x11f/0x1a0
[   60.593673]  hdac_hda_dev_remove+0x25/0x30 [snd_soc_hdac_hda]
[   60.593674]  device_release_driver_internal+0xe0/0x1c0
[   60.593675]  bus_remove_device+0xd6/0x140
[   60.593677]  device_del+0x175/0x3e0
[   60.593679]  ? widget_tree_free.isra.7+0x90/0xb0 [snd_hda_core]
[   60.593680]  snd_hdac_device_unregister+0x34/0x50 [snd_hda_core]
[   60.593682]  snd_hdac_ext_bus_device_remove+0x2a/0x60 [snd_hda_ext_core]
[   60.593684]  hda_dsp_remove+0x26/0x100 [snd_sof_intel_hda_common]
[   60.593686]  snd_sof_device_remove+0x84/0xa0 [snd_sof]
[   60.593687]  sof_pci_remove+0x10/0x30 [snd_sof_pci]
[   60.593689]  pci_device_remove+0x36/0xb0

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20200110235751.3404-9-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/hdac_hda.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/hdac_hda.c b/sound/soc/codecs/hdac_hda.c
index 4570f662fb48b..d78f4d856aaff 100644
--- a/sound/soc/codecs/hdac_hda.c
+++ b/sound/soc/codecs/hdac_hda.c
@@ -498,7 +498,9 @@ static int hdac_hda_dev_remove(struct hdac_device *hdev)
 	struct hdac_hda_priv *hda_pvt;
 
 	hda_pvt = dev_get_drvdata(&hdev->dev);
-	cancel_delayed_work_sync(&hda_pvt->codec.jackpoll_work);
+	if (hda_pvt && hda_pvt->codec.registered)
+		cancel_delayed_work_sync(&hda_pvt->codec.jackpoll_work);
+
 	return 0;
 }
 
-- 
2.20.1



