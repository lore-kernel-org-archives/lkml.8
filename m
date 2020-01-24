Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFC3C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEA7B22464
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579828859;
	bh=1CJUUDFCemZcrasaD10onhLEDNjLB5/mzrNSPYQzFng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=He3WnwtSHGlY8O6dFR/6lJ3YWamz54iOY8YD9ede9eB7DZgWtutUNHpbfbWCvE58z
	 SzruW+CIagUvk2bDAqnbHyyRWqihcwfTJhPnhAGz7yigsgNICpxmavv1qKveseeG2u
	 z+OaBVB9b+S3l9Ib/BvQds79fjCBzK1nmKtXMQsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbgAXBU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 20:20:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:60020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730312AbgAXBRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 20:17:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2891F2071E;
        Fri, 24 Jan 2020 01:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579828632;
        bh=1CJUUDFCemZcrasaD10onhLEDNjLB5/mzrNSPYQzFng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mDRyc0UN4oOdc4IAh5SxLexhxvj7PjImy8AdXcTMCYVnX9bFWsRgWHhDg8539kv3n
         Sfpory52RTxJE9ziDcUt8vjBDk4ncuKfTNvQ0oKsVjMSxGPPbxmPoo2pDjfBzKeWOM
         BMMNut7CANqz2qcg7KeXOgji8oFNAjNoUBEITH24=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jiange Zhao <Jiange.Zhao@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 03/33] drm/amdgpu/SRIOV: add navi12 pci id for SRIOV (v2)
Date:   Thu, 23 Jan 2020 20:16:38 -0500
Message-Id: <20200124011708.18232-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124011708.18232-1-sashal@kernel.org>
References: <20200124011708.18232-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

