Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52A9C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8347A20674
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844890;
	bh=uE2tZ0cXXEfqiy3UNn8FOMrI+JRdn0gH0gv8NGuJsVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pI0o420DhqsyZPi6pVux0atiIkdcYh+4Ed4Lqskwvc34XbqoFdspOOChH2tc1VRDP
	 5NROZUaeq7nZU8snrHMYt+uQqbKd6l8O3oCl3b9dn1rM5FL6MctVvIv9eOqkNI6tnm
	 YEg47WU84mc4luDo8cszE0pM97yNsOe+ZoQpNbzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgCJMyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:33332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729406AbgCJMyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:54:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A72722468F;
        Tue, 10 Mar 2020 12:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844885;
        bh=uE2tZ0cXXEfqiy3UNn8FOMrI+JRdn0gH0gv8NGuJsVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wt2/7OS+iM9svd2ZY9Q2UMfNtJXyyv+n9fDSNm+JnOF9D2G9ZuPMMfVMR8KkGKL/G
         sqacA95UWWHIbgp6pd0WeycNzBKh1Tm+DBIOSt/5bUY7MC8itmW9Rtu9PQC2OBEdyv
         dhl1XtJZN1q9SJ6Ch8sPWR2lUEdlOYu2/RsMkDdc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Bates <jbates@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>,
        Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 5.4 116/168] drm/virtio: fix resource id creation race
Date:   Tue, 10 Mar 2020 13:39:22 +0100
Message-Id: <20200310123647.154455955@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
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


