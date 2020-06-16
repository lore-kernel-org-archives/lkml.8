Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E33C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE65621527
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322783;
	bh=86yjS12F00M5iig67fj51Gnv/ZGEDqWAQwXYxrrlrT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u8X3g4poWd/2FmY9fNI0W7S7hKTRmMaKSt9abICsywly0pfq03Lr94JtS/CTGe3a9
	 NNfihfAf0tTh3DsWfktawfOSJ4ZLMWhYUM6GhcmAPD1lGKYy+bRY3ySnR/xdHwq2sV
	 vtDsjzfzZIV5iP0O3hRPBDV748b5d7pMWRVYBZdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732770AbgFPPxB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:53:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732823AbgFPPw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:52:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFC19208D5;
        Tue, 16 Jun 2020 15:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322776;
        bh=86yjS12F00M5iig67fj51Gnv/ZGEDqWAQwXYxrrlrT4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P73qXm/InUft5rSj29kET6TLhhJRwa/+Lx55Lj+3pY5/lCp99+rHGKpF/lWee4GN7
         W3/9YGjTfKq3fC/EJCcNZFQp/m9w9qJt/+UqKuTy0le55KuC2AxukSQbBKXDkDG7Dz
         LmtU/ca0D+Jpi8WuLujkeIOhu1GR4am0d6DP41i0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hersen Wu <hersenxs.wu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.6 069/161] ALSA: hda: add sienna_cichlid audio asic id for sienna_cichlid up
Date:   Tue, 16 Jun 2020 17:34:19 +0200
Message-Id: <20200616153109.666586911@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.402291280@linuxfoundation.org>
References: <20200616153106.402291280@linuxfoundation.org>
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
@@ -2659,6 +2659,9 @@ static const struct pci_device_id azx_id
 	{ PCI_DEVICE(0x1002, 0xab20),
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
 	  AZX_DCAPS_PM_RUNTIME },
+	{ PCI_DEVICE(0x1002, 0xab28),
+	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
+	  AZX_DCAPS_PM_RUNTIME },
 	{ PCI_DEVICE(0x1002, 0xab38),
 	  .driver_data = AZX_DRIVER_ATIHDMI_NS | AZX_DCAPS_PRESET_ATI_HDMI_NS |
 	  AZX_DCAPS_PM_RUNTIME },


