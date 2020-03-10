Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD5BCC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B1B724694
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845243;
	bh=j4rbuNto2WRhNGN8Rhb71bMLkxbanm1XnNP+wsBtRi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bAPNCzaxSxAFFLY1G90Y0/KSggJCtpSKRpluykcM1ntOs80Jwv7x6eePMrvUv0WO/
	 2c/VXt8trxIIWtNSaIPKgzKsINZ7f7CnG4nnMlDd7M8Pg7yGwilfu11elExH7FxdCr
	 sq7g83gmorm6RLq4vlrjKHoETevetglhioNNI8WU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbgCJNAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:00:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:41464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729924AbgCJNAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:00:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4ABCA2468D;
        Tue, 10 Mar 2020 13:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845237;
        bh=j4rbuNto2WRhNGN8Rhb71bMLkxbanm1XnNP+wsBtRi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gj65FWbgwwNDeDzfyWl7dmz0RaHGycL/5g3oHiUqRBws//t+HU+Ut3WXv3rGHWZyw
         5sQdTEQkxlhKuYWlTMB5hRF/WNOgHkhZihbEO8Y6Wy7v6RJFoLQicjSpDoKNfboQpO
         2F+agPdcSxfRA52mXEr4arH4+gKfqAW/qm6jqXDs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Guillaume Gardet <Guillaume.Gardet@arm.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 5.5 110/189] drm/virtio: fix mmap page attributes
Date:   Tue, 10 Mar 2020 13:39:07 +0100
Message-Id: <20200310123650.814203614@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerd Hoffmann <kraxel@redhat.com>

commit 6be7e07335486f5731cab748d80c68f20896581f upstream.

virtio-gpu uses cached mappings, set
drm_gem_shmem_object.map_cached accordingly.

Cc: stable@vger.kernel.org
Fixes: c66df701e783 ("drm/virtio: switch from ttm to gem shmem helpers")
Reported-by: Gurchetan Singh <gurchetansingh@chromium.org>
Reported-by: Guillaume Gardet <Guillaume.Gardet@arm.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Gurchetan Singh <gurchetansingh@chromium.org>
Tested-by: Guillaume Gardet <Guillaume.Gardet@arm.com>
Link: http://patchwork.freedesktop.org/patch/msgid/20200226154752.24328-3-kraxel@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/virtio/virtgpu_object.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -99,6 +99,7 @@ struct drm_gem_object *virtio_gpu_create
 		return NULL;
 
 	bo->base.base.funcs = &virtio_gpu_gem_funcs;
+	bo->base.map_cached = true;
 	return &bo->base.base;
 }
 


