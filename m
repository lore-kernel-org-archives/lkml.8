Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E94BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0967A208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579859106;
	bh=+eFq1Vi9Mp4gWPRSaTrPqaP333Ytd51PTucRNr71yOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RHLfniMl3xk/MKWbaXWQ8C14aWVG92kl2xCDaRM0/zDJyowVXc5d03TX5h+32kxp8
	 LFH8tjpEpNWcIJ2GkEP+Qh+QYp37Vjt6T7M8QNsb7jhpV7zcnEYwz0NZrBJJUNA30I
	 B+93ec9+8NxzmLfrMO6lTvPvA4FUjERBbK4kLZ1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387440AbgAXJpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:45:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:43754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732257AbgAXJpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:45:03 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 814E420718;
        Fri, 24 Jan 2020 09:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579859102;
        bh=+eFq1Vi9Mp4gWPRSaTrPqaP333Ytd51PTucRNr71yOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ntfVh2AxEUWw1so0YHOe1myeoBXSOEB0Qi9ILCUO4Pz+ytqMNIrhgHPZFX2CE3H6p
         7+eDy1cPiocY9Ub9tMMN+BZbyrTKc3QXeNdNAmP+BO+gWbMutrkfwNcBzK7OZfiY72
         lCT+oJDRfLaL1jil9pl9JnzChPlli9jaKINNfHWs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 029/343] staging: bcm2835-camera: Abort probe if there is no camera
Date:   Fri, 24 Jan 2020 10:27:27 +0100
Message-Id: <20200124092923.664049032@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Wahren <stefan.wahren@i2se.com>

[ Upstream commit 7566f39dfdc11f8a97d5810c6e6295a88f97ef91 ]

Abort the probing of the camera driver in case there isn't a camera
actually connected to the Raspberry Pi. This solution also avoids a
NULL ptr dereference of mmal instance on driver unload.

Fixes: 7b3ad5abf027 ("staging: Import the BCM2835 MMAL-based V4L2 camera driver.")
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../vc04_services/bcm2835-camera/bcm2835-camera.c        | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
index 377da037f31c3..b521752d9aa01 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/bcm2835-camera.c
@@ -1849,6 +1849,12 @@ static int __init bm2835_mmal_init(void)
 	num_cameras = get_num_cameras(instance,
 				      resolutions,
 				      MAX_BCM2835_CAMERAS);
+
+	if (num_cameras < 1) {
+		ret = -ENODEV;
+		goto cleanup_mmal;
+	}
+
 	if (num_cameras > MAX_BCM2835_CAMERAS)
 		num_cameras = MAX_BCM2835_CAMERAS;
 
@@ -1948,6 +1954,9 @@ cleanup_gdev:
 	pr_info("%s: error %d while loading driver\n",
 		BM2835_MMAL_MODULE_NAME, ret);
 
+cleanup_mmal:
+	vchiq_mmal_finalise(instance);
+
 	return ret;
 }
 
-- 
2.20.1



