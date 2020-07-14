Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3136C43446
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7674C22B4E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753309;
	bh=Cu3BvAfYn5LTqrRnIppM+ink8n0nkxKYVSqNHITujiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sk+6qcJggmEQXZWl1mM4LKVtKe2vc95TuNEtCPTOjzjDMYjR2oTtxE7Qqfo4ecN+c
	 nAm26zXOm/7WTE5Smn2CVwzgT80f67qs4n8Z06iSLJkowO3jpHVHI0xMK3KRiXeZqU
	 nG6qFPjICdl3/uhpjzF2bLf08on1C5GNlwc6xMao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbgGNTBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731124AbgGNS7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:59:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0E8122507;
        Tue, 14 Jul 2020 18:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594753162;
        bh=Cu3BvAfYn5LTqrRnIppM+ink8n0nkxKYVSqNHITujiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AXnB/ocpExMJAa/IsdVmp1ImuXAkFAMndTreZcDBIVzsJiMqHtHZmVkGwaifmKoG1
         mIHwd8aswo5rmjWu80HgGAsx6JxgnZ8Yec4eNr5uAFO6RckNUCbsdHGDJYwmRda/B8
         0Ly/KJ6NoKLKCN+iyXvXfIT4IIQUpxi27E4EmL4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.7 143/166] drm/amdgpu: asd function needs to be unloaded in suspend phase
Date:   Tue, 14 Jul 2020 20:45:08 +0200
Message-Id: <20200714184122.672952668@linuxfoundation.org>
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

From: Huang Rui <ray.huang@amd.com>

commit 20303ec5d2165ee6344190274bc59118921f71d9 upstream.

Unload ASD function in suspend phase.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1685,6 +1685,12 @@ static int psp_suspend(void *handle)
 		return ret;
 	}
 
+	ret = psp_asd_unload(psp);
+	if (ret) {
+		DRM_ERROR("Failed to unload asd\n");
+		return ret;
+	}
+
 	ret = psp_ring_stop(psp, PSP_RING_TYPE__KM);
 	if (ret) {
 		DRM_ERROR("PSP ring stop failed\n");


