Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE08C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF43320781
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551589;
	bh=Lw5BH7pmk+9cni4ByfUZ7qQ8QaNhnIgwh6zVSoOuQGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jBWH6BIz1X3LnYb/XopeTJhvNbfr/SS8OLl86Ct3/qpmMwF/pE6bqF+3ZXn+XHIrY
	 tmWHCd7q9xsRBR/opV+kL9BeIisp022NhtbbQUKYoy4D8UDp9Am9ovs6cHeW25PAds
	 IvQjBK5Gw+m5Oa8R8ekA6uT/E7WXg9c3UjZzgUhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbgDVKdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:33:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730495AbgDVKZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:25:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D239720780;
        Wed, 22 Apr 2020 10:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587551106;
        bh=Lw5BH7pmk+9cni4ByfUZ7qQ8QaNhnIgwh6zVSoOuQGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BjrDrWqNXvdqiIPxT0ZXDU6y32Eka8tBn209I4YvaF+zTN6cgXB1bSJ1RiUN/CptJ
         Cf7uL6WofRI6+GFhqBorS1NIxSyewdxCeu9mTt9iGIF4x0XxexY3k5/z1V0Jj8YrAP
         RAatVwg/ozPGBSa5rM3m7NS5RqixCfM0uS0sjHSI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ralph Campbell <rcampbell@nvidia.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 102/166] drm/nouveau/svm: check for SVM initialized before migrating
Date:   Wed, 22 Apr 2020 11:57:09 +0200
Message-Id: <20200422095059.864165328@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralph Campbell <rcampbell@nvidia.com>

[ Upstream commit 822cab6150d3002952407a8297ff5a0d32bb7b54 ]

When migrating system memory to GPU memory, check that SVM has been
enabled. Even though most errors can be ignored since migration is
a performance optimization, return an error because this is a violation
of the API.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index df9bf1fd1bc0b..3ec5da025bea7 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -171,6 +171,11 @@ nouveau_svmm_bind(struct drm_device *dev, void *data,
 	mm = get_task_mm(current);
 	down_read(&mm->mmap_sem);
 
+	if (!cli->svm.svmm) {
+		up_read(&mm->mmap_sem);
+		return -EINVAL;
+	}
+
 	for (addr = args->va_start, end = args->va_start + size; addr < end;) {
 		struct vm_area_struct *vma;
 		unsigned long next;
-- 
2.20.1



