Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C17BC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CF224676
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996235;
	bh=6gpxHRZvvxtXCc/sdKcp4tVqk49lNRrgqJ9R00qoDXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XqBe/sFgrYGrqIAWw+kxKxkKuCmQFl4XRbSQs7OD8s0p9q7jYaLk0NHc168Ci7QqN
	 6duQfxHBaoMt7VudwhEyGqNjY+1IHITqwBCkNgeiNYR0aFZ4y1LOI6U/HFy8wbR67X
	 NNJASWKv76MQFfjLKtAPS2XncvCAlE1sPCdN+AD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgANKDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:03:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:58984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbgANKDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:03:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 985D12465B;
        Tue, 14 Jan 2020 10:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996231;
        bh=6gpxHRZvvxtXCc/sdKcp4tVqk49lNRrgqJ9R00qoDXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bSI+6SHBOaXLT/p4RP1BRwz9FMaodd/gbh08DT8NjjR6vrhmthGC+4Nh0wwB9kJvc
         fFqJdEc5CsMH/lBKKlvPxZfW04hhI53zL7IL2+5Wk1D27CZhwJTA7VmPlpKcuf0olS
         mlIegNNvAq9yO+8B5Tbp8sP/agUJc+x2UGxZlF88=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.4 25/78] Revert "drm/amdgpu: Set no-retry as default."
Date:   Tue, 14 Jan 2020 11:00:59 +0100
Message-Id: <20200114094357.099118296@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094352.428808181@linuxfoundation.org>
References: <20200114094352.428808181@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit 7aec9ec1cf324d5c5a8d17b9c78a34c388e5f17b upstream.

This reverts commit 51bfac71cade386966791a8db87a5912781d249f.

This causes stability issues on some raven boards.  Revert
for now until a proper fix is completed.

Bug: https://gitlab.freedesktop.org/drm/amd/issues/934
Bug: https://bugzilla.kernel.org/show_bug.cgi?id=206017
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -145,7 +145,7 @@ int amdgpu_async_gfx_ring = 1;
 int amdgpu_mcbp = 0;
 int amdgpu_discovery = -1;
 int amdgpu_mes = 0;
-int amdgpu_noretry = 1;
+int amdgpu_noretry;
 
 struct amdgpu_mgpu_info mgpu_info = {
 	.mutex = __MUTEX_INITIALIZER(mgpu_info.mutex),
@@ -613,7 +613,7 @@ MODULE_PARM_DESC(mes,
 module_param_named(mes, amdgpu_mes, int, 0444);
 
 MODULE_PARM_DESC(noretry,
-	"Disable retry faults (0 = retry enabled, 1 = retry disabled (default))");
+	"Disable retry faults (0 = retry enabled (default), 1 = retry disabled)");
 module_param_named(noretry, amdgpu_noretry, int, 0644);
 
 #ifdef CONFIG_HSA_AMD


