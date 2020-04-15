Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85124C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58C9920737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586955940;
	bh=Lw5BH7pmk+9cni4ByfUZ7qQ8QaNhnIgwh6zVSoOuQGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i8/VEdUNS6t7EwklfnSr9YAk9HzbT9tDOojFV8tk1pRzt/vgXkhONfhH6s1vWstct
	 IGenFVggGlHhMiJfcgVbVLJNquNrnIbQvoHbuWrUke30xiF5ogu4FAJQc7iQs9EA8I
	 Qvv5uXgxSl41TsBBqtGlqS0FGlKKVkR2BQ30Yv3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505921AbgDONFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897130AbgDOLgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:36:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C825820737;
        Wed, 15 Apr 2020 11:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950576;
        bh=Lw5BH7pmk+9cni4ByfUZ7qQ8QaNhnIgwh6zVSoOuQGM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cJzzyOIzl1vFC0JQlLjrDHOMuHVQ2iamfFifRqS6vsIQDQTmulgWKtylE75NvSaON
         JK9mtefBnG8plgc+v5WEt+8sa01PQWezdcmiWzk6AxAsnbVHKjBZF/HXLgI9HEd7EL
         7yD8Vcw8CA8XLyk5a9lPMxG6mxkhHwUVcejwLQJc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.6 077/129] drm/nouveau/svm: check for SVM initialized before migrating
Date:   Wed, 15 Apr 2020 07:33:52 -0400
Message-Id: <20200415113445.11881-77-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

