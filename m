Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A30DC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB002082F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581700954;
	bh=H+HW9LdC+gGzgBI2knQjxdHksSbqipHsIqlIEKwTmKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hBd8ZLlaqaG1BhcsHDvyORug/JrIVxib7nyb/UOZsHJCX33Nnbjfx+3Yoit7cwrQl
	 sKN1ILMX4Q1QslkXofvoAFeoeFLJKBcTUUVcX/n0FEBmkpkD6aTUx8LFugRB5JoyBa
	 h1XruM7iRswh/ZuI6+gJGA3NG8SlwZuKE/Lpbq8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390642AbgBNRWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:22:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:34890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390624AbgBNQJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:09:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6A7424685;
        Fri, 14 Feb 2020 16:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696592;
        bh=H+HW9LdC+gGzgBI2knQjxdHksSbqipHsIqlIEKwTmKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qdyv+tF4qoRcpRLmMncmM+gNikK5gIm9zysjiCWVij9KCGEyLvEphw1NqxeTydvzw
         wvTRVZtMdU/sO70gRuJJ1Vq9nPvV6xytIx0q2QeINmSE6lQ4hvc6LExUU9XKfIOsV5
         Yjc4BJoTejOjOcmHdmQ9DlQcyK5wa7WiPv/VNknk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 379/459] drm/nouveau/mmu: fix comptag memory leak
Date:   Fri, 14 Feb 2020 11:00:29 -0500
Message-Id: <20200214160149.11681-379-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
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

