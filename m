Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384D7C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 192F82222D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587050083;
	bh=d9pFvTfnO44VU4f05RrOD3sJL8UbpjbwLQHFV2pQFuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nBuaveU4XpvuP6GTia62h0W7PvNeZMxXdPGvXV80h9vgSI3B2KXFL0afSvbwRVpkh
	 F0tghO+x6nXb6jkAWI9i99djCKtDYrblxGKjeGrgdMiX558KdUYNL8wDZIK9zEhjHD
	 53hVdtS3NwYOlJX86Xegdkaxv2ghwd+TVtE1fFZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394896AbgDPPOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:14:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:35836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441663AbgDPNuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:50:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5316F22247;
        Thu, 16 Apr 2020 13:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044994;
        bh=d9pFvTfnO44VU4f05RrOD3sJL8UbpjbwLQHFV2pQFuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IwgXW7xHP0uRTHdSXQhsStBZ5O0ha/a8ExBTeBc9/C1LMzZu+fhBtuFEbaeAu1nG8
         MBOSkIIwTFq5XXxN5azTka72p3h/EasnCJhAXSxcL8A4z+fBXzv06ewu14hKlvd3/e
         BwJUO0JrEjvPkkR+EHVcnQN3ouMJ41pT/yLqbnRk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aaron Liu <aaron.liu@amd.com>,
        Yuxian Dai <Yuxian.Dai@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Huang Rui <ray.huang@amd.com>
Subject: [PATCH 5.4 187/232] drm/amdgpu: unify fw_write_wait for new gfx9 asics
Date:   Thu, 16 Apr 2020 15:24:41 +0200
Message-Id: <20200416131338.514465096@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
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
@@ -1026,6 +1026,8 @@ static void gfx_v9_0_check_fw_write_wait
 			adev->gfx.mec_fw_write_wait = true;
 		break;
 	default:
+		adev->gfx.me_fw_write_wait = true;
+		adev->gfx.mec_fw_write_wait = true;
 		break;
 	}
 }


