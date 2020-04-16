Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255C1C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F3C20786
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587045804;
	bh=+llwUcLtdnDf5ipAJ8Q607OsR1s6kLxbaQozCIUXY1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jz0fz+xoAgI+dcuBiqfoMHiJki2nGo7IRuvxcLHK38dmeEkASM1Wxem0SMMuEXR4p
	 eZ6VWmHnCMTotje+i76v27i2mDLf2eID6CDMNsh40ddhk3Ad3/IhHYaSHaXyDXqqjF
	 NJh2Rjq0Xq7o2090QFII77izK0scGS5LZYJtPJbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392808AbgDPODV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:03:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2898381AbgDPNmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:42:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9617214D8;
        Thu, 16 Apr 2020 13:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044520;
        bh=+llwUcLtdnDf5ipAJ8Q607OsR1s6kLxbaQozCIUXY1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mQhaNgh7B8CX+54m9yVC+xywwaFdeqoWW8xYa6Zy0J3V8VbmqO4Q943QBAMGbRAgB
         EIlFT97Ll1l25MPKVxEi1GTEp8mBLs1gp5dKobyeI/qcOHMXb3n/kH08X4eRgBnEMY
         OyvW3FIqGiV+v9VBNKQ8gmzpKY+W7kaiAw5Nkwv0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Liu <aaron.liu@amd.com>,
        Yuxian Dai <Yuxian.Dai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH 5.5 211/257] drm/amdgpu: unify fw_write_wait for new gfx9 asics
Date:   Thu, 16 Apr 2020 15:24:22 +0200
Message-Id: <20200416131352.431962090@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aaron Liu <aaron.liu@amd.com>

commit 2960758cce2310774de60bbbd8d6841d436c54d9 upstream.

Make the fw_write_wait default case true since presumably all new
gfx9 asics will have updated firmware. That is using unique WAIT_REG_MEM
packet with opration=1.

Signed-off-by: Aaron Liu <aaron.liu@amd.com>
Tested-by: Aaron Liu <aaron.liu@amd.com>
Tested-by: Yuxian Dai <Yuxian.Dai@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1040,6 +1040,8 @@ static void gfx_v9_0_check_fw_write_wait
 			adev->gfx.mec_fw_write_wait = true;
 		break;
 	default:
+		adev->gfx.me_fw_write_wait = true;
+		adev->gfx.mec_fw_write_wait = true;
 		break;
 	}
 }


