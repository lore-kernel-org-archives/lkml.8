Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD018C52D56
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D6A20801
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812145;
	bh=Z3pvmBN7mNjqmSDn5pdU0b5YHXmvF7MhrUa1o1JzbtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WQD2oFpdy0AzW6bjjJPEeC8GC0U53JXwkXt9C9GYlBrB5JE8etJHeTp3hfG1HnU8M
	 hoLRdF/W1by2M+o13LuYXnzUfE8h8Zg6rPRW9sPVGLSDc9sJRobKg4eK2DuOyz/oCJ
	 lDy/N+l9nHL5bDvSejx/UsfcK45YrbmUthgoKbYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732863AbgB0OCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:02:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:36986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733021AbgB0OCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:02:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C01A20801;
        Thu, 27 Feb 2020 14:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812141;
        bh=Z3pvmBN7mNjqmSDn5pdU0b5YHXmvF7MhrUa1o1JzbtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SPvDLbkZKyj0Z/t0yHd7pvbI+lSdR8mATbhbXgOZcRWaZfel/+V7PfpPV098lFhj9
         4meIBqjKngYdA1l2DXVTXpuMwdNeB/KLTB0y8NULjDPRhkQbSDAROIPhPagtsfCYI+
         XYUucC9Ai05HldaS1cDZY3lOiVY+9AJztaXZ0u/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4.14 199/237] drm/amdgpu/soc15: fix xclk for raven
Date:   Thu, 27 Feb 2020 14:36:53 +0100
Message-Id: <20200227132310.929274709@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit c657b936ea98630ef5ba4f130ab1ad5c534d0165 upstream.

It's 25 Mhz (refclk / 4).  This fixes the interpretation
of the rlc clock counter.

Acked-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/soc15.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -279,7 +279,12 @@ static void soc15_init_golden_registers(
 }
 static u32 soc15_get_xclk(struct amdgpu_device *adev)
 {
-	return adev->clock.spll.reference_freq;
+	u32 reference_clock = adev->clock.spll.reference_freq;
+
+	if (adev->asic_type == CHIP_RAVEN)
+		return reference_clock / 4;
+
+	return reference_clock;
 }
 
 


