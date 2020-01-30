Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E5EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6052B205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580409904;
	bh=1CJUUDFCemZcrasaD10onhLEDNjLB5/mzrNSPYQzFng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gip06COh607AgRcQVyO3Djej4YHKRK+yy4k8M7YwUYK8GLHkho1gOMBHFf6+JNwJB
	 3CeM4iYeh2IGUEUwXl8WgDBvlQptXEehB6QNrJvHrpBwS0tmmytV+jD6SXdAC3YWN5
	 ZJovhxNKC8xTRnX3ABxFeFliyhakX4Mz4idpN8W4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730943AbgA3SpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:45:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730930AbgA3SpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:45:01 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1AA1205F4;
        Thu, 30 Jan 2020 18:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409900;
        bh=1CJUUDFCemZcrasaD10onhLEDNjLB5/mzrNSPYQzFng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lauwEwn1EQfcHg1x79eCe1jK3/hh1iDqyunv33LRYLTJckl9oBga8cpqNWbbQQLWm
         89Wa4HCeL2vf1+jiUKVjO+yNrR8DDggqa79ingrzrOdLVLPD4QGajQTis16uB7/tmP
         HRjhQ4JlYeavgBpKp+cRl1tMuJmDfL6689EstOVw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiange Zhao <Jiange.Zhao@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 077/110] drm/amdgpu/SRIOV: add navi12 pci id for SRIOV (v2)
Date:   Thu, 30 Jan 2020 19:38:53 +0100
Message-Id: <20200130183623.425577059@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183613.810054545@linuxfoundation.org>
References: <20200130183613.810054545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiange Zhao <Jiange.Zhao@amd.com>

[ Upstream commit 57d4f3b7fd65b56f98b62817f27c461142c0bc2a ]

Add Navi12 PCI id support.

v2: flag as experimental for now (Alex)

Signed-off-by: Jiange Zhao <Jiange.Zhao@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 33a1099e2f33e..bb9a2771a0f9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1023,6 +1023,7 @@ static const struct pci_device_id pciidlist[] = {
 
 	/* Navi12 */
 	{0x1002, 0x7360, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI12|AMD_EXP_HW_SUPPORT},
+	{0x1002, 0x7362, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_NAVI12|AMD_EXP_HW_SUPPORT},
 
 	{0, 0, 0}
 };
-- 
2.20.1



