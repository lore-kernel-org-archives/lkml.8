Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19C6C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B87B720746
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="GgqI2nXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgEDIQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 04:16:38 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:6427 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgEDIQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 04:16:37 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eafcee50001>; Mon, 04 May 2020 01:14:30 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 04 May 2020 01:16:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 04 May 2020 01:16:37 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May
 2020 08:16:36 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 4 May 2020 08:16:36 +0000
Received: from audio.nvidia.com (Not Verified[10.24.34.185]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5eafcf600002>; Mon, 04 May 2020 01:16:35 -0700
From:   Sameer Pujar <spujar@nvidia.com>
To:     <perex@perex.cz>, <tiwai@suse.com>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <sharadg@nvidia.com>,
        <mkumard@nvidia.com>, <viswanathl@nvidia.com>,
        <rlokhande@nvidia.com>, <dramesh@nvidia.com>,
        <atalambedu@nvidia.com>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH 0/3] Tegra194 HW Fixes
Date:   Mon, 4 May 2020 13:46:13 +0530
Message-ID: <1588580176-2801-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588580070; bh=zUEiA6/N+ok9bG2zchOM1YIm2uvHGbS/o7XvZezsxfM=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Type;
        b=GgqI2nXcuC6ccVS6bieRn5Iw7/KjOyCod8MRs9TCbQcNxbiOTQV8sblj3cBiNIjGf
         p6hU0CwveBHLEgKfzNUS1XKAPKV7ONCxWbbnUMzRX3ymljjqibisdZUJDcWbamKKXu
         BJF9XpoTAOtIvI5BciTZAJUsyL5Nc68G+JqIMGy/uwxKuXc4+f6E250YoRFpaTzDA0
         IpdXP6xBP+elHtR5gyh4BQ7EgKdrl9W9So2zPWh2XyZPPMobiFlKVHUj8w845iUlkx
         bZj/YSV+HRfogPSl1+2Z8MX8rCtow1e6oj5QLvH2+YfYVwCXUO6X4Z4Wt9hjr71IgB
         voxUOYky7/L+w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series proposes SW workarounds for Tegra194 HDA HW bugs.
Following are the two issues seen:
 1. GCAP register does not reflect true capability.
    The actual number of SDO lines is "4", where as it reflects "2".
 2. With 4 SDO line configuration playback fails for,
    44.1K/48K, 2-channel, 16-bps audio stream.

After fixing [1], issue [2] is uncovered.
As per recommendation by Tegra HW team the workarounds are pushed.

Testing done
============
 * Verify GCAP register after registering HDA sound card
 * Verify audio playback for 44.1K/48K, 2-channel, 16-bps.

Sameer Pujar (3):
  ALSA: hda/tegra: correct number of SDO lines for Tegra194
  ALSA: hda: add member to store ratio for stripe control
  ALSA: hda/tegra: workaround playback failure on Tegra194

 include/sound/hdaudio.h     |  3 +++
 sound/hda/hdac_controller.c | 11 ++++++++++
 sound/hda/hdac_stream.c     |  2 +-
 sound/pci/hda/hda_tegra.c   | 50 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 65 insertions(+), 1 deletion(-)

-- 
2.7.4

