Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0378C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94409208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322268;
	bh=Fmt7OWxQ8GzI+MHevMs0ZHnD1FSVTqDy9UHdzRcOWMQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZXZMHyaxF57od+ukw3z9mmcLcTxs2B4nluz6FTPALzPoi7+5+V33dRNWtqyiZ7ZwD
	 PcAEPkwbEFmRtGzu4WhbiB/2yIPuhdFjNLrXSm8UpIygkD05cpORM9hurvYtIVxvyO
	 A16HV0CYch3ABmkPq3NCrfWdXZKOAP3BLhuEUjRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731968AbgFPPo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:44:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730565AbgFPPoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:44:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F2D921475;
        Tue, 16 Jun 2020 15:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322262;
        bh=Fmt7OWxQ8GzI+MHevMs0ZHnD1FSVTqDy9UHdzRcOWMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eHRusZA+UE2cZTMDj8lRlz8jZJx9vAQMXB/QOYn8hfb8PsoS+zrS1kR4A/3lgIhs8
         beLX64iEzum004e7eRvmskQbN2UfVR3en5Ozw07FheDBL/cKcRyFm3UDjLdMhZvarF
         ke2gg4cwr8No2hjyRvVXCas0d7U6OdEGoy/8yrDQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hersen Wu <hersenxs.wu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.7 064/163] ALSA: hda: add sienna_cichlid audio asic id for sienna_cichlid up
Date:   Tue, 16 Jun 2020 17:33:58 +0200
Message-Id: <20200616153109.910710034@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hersen Wu <hersenxs.wu@amd.com>

commit 27a7c67012cfa6d79f87fbb51afa13c6c0e24e34 upstream.

dp/hdmi ati hda is not shown in audio settings

[ rearranged to a more appropriate place per device number order
  -- tiwai ]

Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200603013137.1849404-1-alexander.deucher@amd.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/hda_intel.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2662,6 +2662,9 @@ static const struct pci_device_id azx_id
 	{ PCI_DEVICE(0x1002, 0xab20),
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
 	  AZX_DCAPS_PM_RUNTIME },
+	{ PCI_DEVICE(0x1002, 0xab28),
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
+	  AZX_DCAPS_PM_RUNTIME },
 	{ PCI_DEVICE(0x1002, 0xab38),
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
 	  AZX_DCAPS_PM_RUNTIME },


