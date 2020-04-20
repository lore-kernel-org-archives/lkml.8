Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0313EC54FD3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D505A21473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587386732;
	bh=sYjlDhEdzQB0hfAmY8IBX89GISvS3OByyChIfYmIFCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vr1Guih1MIW0otYZJRWbNxpVR3Lu25LqsIcuh4+uY2qFa7/KMkK/UgVdlRd4HM8Wp
	 MbfmZAB8Lhiz6pF8YM2bwzxtcJMtaVX9C6MQTTS7HBD1dpXYkv3js/+WBqrpQVffrW
	 Tu6eaYwr2uUOk3eIqnw1eT5rKEA0RrELSNS/U3fY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgDTMpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:45:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728013AbgDTMp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:45:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BBA420736;
        Mon, 20 Apr 2020 12:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587386728;
        bh=sYjlDhEdzQB0hfAmY8IBX89GISvS3OByyChIfYmIFCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ng6BUNCZ2NpkS/zh+QMQIcMVMo/3+GA/Rmh3FqHW4n6QJdf6qlmpGP0mRiPxkmQgT
         NzTGBm8zscyRgkupObc7mqgI5V1hMdMg8DfO9vMM/W/gsAQV1aHsaJNbaqVD2wu1sj
         0swgiukqdnmauIdVQZ93cfwg/O2u5KphWMg3tIRo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prike Liang <Prike.Liang@amd.com>,
        Mengbing Wang <Mengbing.Wang@amd.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.6 60/71] drm/amdgpu: fix the hw hang during perform system reboot and reset
Date:   Mon, 20 Apr 2020 14:39:14 +0200
Message-Id: <20200420121521.037452119@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420121508.491252919@linuxfoundation.org>
References: <20200420121508.491252919@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prike Liang <Prike.Liang@amd.com>

commit b2a7e9735ab2864330be9d00d7f38c961c28de5d upstream.

The system reboot failed as some IP blocks enter power gate before perform
hw resource destory. Meanwhile use unify interface to set device CGPG to ungate
state can simplify the amdgpu poweroff or reset ungate guard.

Fixes: 487eca11a321ef ("drm/amdgpu: fix gfx hang during suspend with video playback (v2)")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Tested-by: Mengbing Wang <Mengbing.Wang@amd.com>
Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2285,6 +2285,8 @@ static int amdgpu_device_ip_suspend_phas
 {
 	int i, r;
 
+	amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
+	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
 	for (i = adev->num_ip_blocks - 1; i >= 0; i--) {
 		if (!adev->ip_blocks[i].status.valid)


