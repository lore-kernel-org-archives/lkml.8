Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1C8CC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 734D124649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845289;
	bh=uE2tZ0cXXEfqiy3UNn8FOMrI+JRdn0gH0gv8NGuJsVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YU3oCxlyprb6TnKRwRmoXdi+w8vwolVtlBvTbRjv5+4yGsaoWEOkDbuIA/9fNp7bn
	 SsErvGE5YmMZreLJ+DQY8G1JBs7NpZ67stibghgdmMtyyLBba9Y+NDunfqpI4pumMR
	 YOEAVpeWS9Yh6yzAuptQrWVxzllz9zZgeqbXOgXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbgCJNB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:01:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730262AbgCJNBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:01:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B200B208E4;
        Tue, 10 Mar 2020 13:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845284;
        bh=uE2tZ0cXXEfqiy3UNn8FOMrI+JRdn0gH0gv8NGuJsVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xOqx37Yo9k0+d3Yee/+I5tryhBHAoikGIKE2+h8K+CsL05YUPGPoBLlLhFGbneyzU
         ZuYlJU5C+DNgsnBs5835Wjk+nd9pLkbxBc7UZ1I8xLOKM8Al/39VQpeL9d+YBPItxW
         FzM4EkNL84sGtRGrfnGeAMhq2f0KNuYrUh9WgMhU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Bates <jbates@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 5.5 129/189] drm/virtio: fix resource id creation race
Date:   Tue, 10 Mar 2020 13:39:26 +0100
Message-Id: <20200310123652.826628465@linuxfoundation.org>
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

From: John Bates <jbates@chromium.org>

commit fbb30168c7395b9cfeb9e6f7b0c0bca854a6552d upstream.

The previous code was not thread safe and caused
undefined behavior from spurious duplicate resource IDs.
In this patch, an atomic_t is used instead. We no longer
see any duplicate IDs in tests with this change.

Fixes: 16065fcdd19d ("drm/virtio: do NOT reuse resource ids")
Signed-off-by: John Bates <jbates@chromium.org>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
Link: http://patchwork.freedesktop.org/patch/msgid/20200220225319.45621-1-jbates@chromium.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/virtio/virtgpu_object.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -42,8 +42,8 @@ static int virtio_gpu_resource_id_get(st
 		 * "f91a9dd35715 Fix unlinking resources from hash
 		 * table." (Feb 2019) fixes the bug.
 		 */
-		static int handle;
-		handle++;
+		static atomic_t seqno = ATOMIC_INIT(0);
+		int handle = atomic_inc_return(&seqno);
 		*resid = handle + 1;
 	} else {
 		int handle = ida_alloc(&vgdev->resource_ida, GFP_KERNEL);


