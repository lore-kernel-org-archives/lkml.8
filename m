Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A555C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0285D2072D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258131;
	bh=2/KUVOIHXpR6PaTRaKSVLZOJx88iqvjR1GFeETai+4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k8l3qbcVvYtK3/YbISK0BVrNm5JZWUUspn7dFgl13uD+1MXRak70J6XqzATOPPNBJ
	 ToxPpHiSGJyiCJZQvAPYYfQyou8V+f2ZK/+Q8uePePuYWRPrJKEO7/kgAWK0W1Icmb
	 9xYEg6XyISnxPgstw00ZxT/zcxWnqPuYH19JESLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732323AbgCCRz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:55:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:37024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732697AbgCCRzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:55:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36FB8206D5;
        Tue,  3 Mar 2020 17:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258123;
        bh=2/KUVOIHXpR6PaTRaKSVLZOJx88iqvjR1GFeETai+4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yYMclx6WQscBElvYTl3qhiJ/Sy46x0F1VfMhvh96CVTC+ZfYGjZrg6o9jhCN7bWTU
         tLWoUUjDX482xsC/hXVXbdFU76/x10IEVwdnZuatpy8hO22yYJk/jAvfVP1A303JzM
         y35nSRsnFDtvMKQaRhvnXPUKGcgwpcyg7/YMeYqM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Xiaojie Yuan <xiaojie.yuan@amd.com>,
        Evan Quan <evan.quan@amd.com>,
        "Tianci.Yin" <tianci.yin@amd.com>,
        =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <marek.olsak@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Emil Velikov <emil.velikov@collabora.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 5.4 079/152] drm/amdgpu: Drop DRIVER_USE_AGP
Date:   Tue,  3 Mar 2020 18:42:57 +0100
Message-Id: <20200303174311.499834820@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174302.523080016@linuxfoundation.org>
References: <20200303174302.523080016@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Vetter <daniel.vetter@ffwll.ch>

commit 8a3bddf67ce88b96531fb22c5a75d7f4dc41d155 upstream.

This doesn't do anything except auto-init drm_agp support when you
call drm_get_pci_dev(). Which amdgpu stopped doing with

commit b58c11314a1706bf094c489ef5cb28f76478c704
Author: Alex Deucher <alexander.deucher@amd.com>
Date:   Fri Jun 2 17:16:31 2017 -0400

    drm/amdgpu: drop deprecated drm_get_pci_dev and drm_put_dev

No idea whether this was intentional or accidental breakage, but I
guess anyone who manages to boot a this modern gpu behind an agp
bridge deserves a price. A price I never expect anyone to ever collect
:-)

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Hawking Zhang <Hawking.Zhang@amd.com>
Cc: Xiaojie Yuan <xiaojie.yuan@amd.com>
Cc: Evan Quan <evan.quan@amd.com>
Cc: "Tianci.Yin" <tianci.yin@amd.com>
Cc: "Marek Olšák" <marek.olsak@amd.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1421,7 +1421,7 @@ amdgpu_get_crtc_scanout_position(struct
 
 static struct drm_driver kms_driver = {
 	.driver_features =
-	    DRIVER_USE_AGP | DRIVER_ATOMIC |
+	    DRIVER_ATOMIC |
 	    DRIVER_GEM |
 	    DRIVER_RENDER | DRIVER_MODESET | DRIVER_SYNCOBJ,
 	.load = amdgpu_driver_load_kms,


