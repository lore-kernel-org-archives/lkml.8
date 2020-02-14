Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828EEC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B3442468E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581695921;
	bh=H+HW9LdC+gGzgBI2knQjxdHksSbqipHsIqlIEKwTmKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E/ZT0quwI/Di2owCexz5P7JEU4NKS0LuVArSRbMQ+uF6dpZKHKOJjGGSZhPrfzC8Q
	 vTKN64+2l0ylWGuRVSl8ykPDmbznpTt1PfPJw/LU2dL5TWsTK0zNEvU9PHUDeb9zr6
	 ChDBaiiU6urJ/tFWRHCWP9mnZaaqnlkka0Nuo+Cg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388652AbgBNP6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:58:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:42074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388562AbgBNP6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:58:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 083D82086A;
        Fri, 14 Feb 2020 15:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695899;
        bh=H+HW9LdC+gGzgBI2knQjxdHksSbqipHsIqlIEKwTmKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BFldEh4Jtfu3EiUJ0lQZVLS1DIWfNcuCDbWKWHc7kymJ99pNhXzK8MJMPMQ7jp8/9
         221Q+rNfeQ66uDCCCWJzH/iBqZ35LE5vXJ3A7DjRZn+OsiBVo5K3D84qoQYihXeSjE
         hpKcaMoH9Dhhe+HNp6KuVXQx2I4IJhFzGlFv6xHI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.5 441/542] drm/nouveau/mmu: fix comptag memory leak
Date:   Fri, 14 Feb 2020 10:47:13 -0500
Message-Id: <20200214154854.6746-441-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Skeggs <bskeggs@redhat.com>

[ Upstream commit 35e4909b6a2b4005ced3c4238da60d926b78fdea ]

Signed-off-by: Ben Skeggs <bskeggs@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/core/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/core/memory.c b/drivers/gpu/drm/nouveau/nvkm/core/memory.c
index e85a08ecd9da5..4cc186262d344 100644
--- a/drivers/gpu/drm/nouveau/nvkm/core/memory.c
+++ b/drivers/gpu/drm/nouveau/nvkm/core/memory.c
@@ -91,8 +91,8 @@ nvkm_memory_tags_get(struct nvkm_memory *memory, struct nvkm_device *device,
 	}
 
 	refcount_set(&tags->refcount, 1);
+	*ptags = memory->tags = tags;
 	mutex_unlock(&fb->subdev.mutex);
-	*ptags = tags;
 	return 0;
 }
 
-- 
2.20.1

