Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7D1C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B648320722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272812;
	bh=H+HW9LdC+gGzgBI2knQjxdHksSbqipHsIqlIEKwTmKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w9VC31BSM+11hnc97myzWjlBTxJbD6cBprVHgawFC9dMYS15DuXF3Wy4o0wWWteje
	 MzOdfkeKJfGX1v+9DZ9579ElOUxWXtHwiPW3LlEQkXH9egnMuMjsKgud4k/EFmJRqx
	 6YVsEGBXRuPdezvaSTuVsLaTLRPdeauonuKlsAZ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733012AbgBUINa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:13:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:49560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733005AbgBUIN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:13:28 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 443D320722;
        Fri, 21 Feb 2020 08:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272807;
        bh=H+HW9LdC+gGzgBI2knQjxdHksSbqipHsIqlIEKwTmKU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fi5/Sm4EyA8DjWIqx4D8U7BGvGgUhXV+n24O/fUxJw7qtwaV5yZ1qSVNqSZ5u9Iv8
         TOSlBoZ5Xj8vMsaDGrhs+Y92DzxLR572+6WLIA1mWVIK9rw6aN+p7mnU7fHPlgS6xx
         7trFu7X14e0LkP0mUbRIdI2XHYpvAUdhMd48/KXA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 282/344] drm/nouveau/mmu: fix comptag memory leak
Date:   Fri, 21 Feb 2020 08:41:21 +0100
Message-Id: <20200221072415.386457732@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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



