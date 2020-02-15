Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A212C352A3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 03:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2715F2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 03:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uT0W1YyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgBODuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 22:50:39 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46425 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727642AbgBODuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 22:50:39 -0500
Received: by mail-pl1-f195.google.com with SMTP id y8so4473597pll.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 19:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sfJlJJwI1bxI5Zr2QmVRgw6cluqLBrhqOPcxIVa8hmk=;
        b=uT0W1YyJVofYAVNGMMKAzVLg/bwPszqUn5ZOEzTfUsKHt7HkkAoz/W4eCOvrrYyFMF
         jAHvwnuwuzQiRQpbKoljkuD88QBHo4YiW+ma+jux+JzKcBv+JGNubZ/7QzpZHQ8rVJAw
         7vt450akbhYK8IZ6b5RhLlejP5bVCzGkeoS5QqhxA4nHBDr5shHEATHVU3vHFPAwdDbc
         KLwgJhf/YAniF6hS89YLNIKO55WfNK22amqGLN7uR8P6t6X39rbfatpN8JXnXd4x9RUw
         o76N0p9zKBDnuJijW2PgxmGHR48/DUl9MILj6DOxLvl2XBSJwhVL/U27ViE+NKFK5BdC
         Z+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sfJlJJwI1bxI5Zr2QmVRgw6cluqLBrhqOPcxIVa8hmk=;
        b=NA+lbBpHQfhVZV0iwCAQje6hUVUj7rUljmyiFxIo/PS9dKDxSUAlR0uLVETFhosX8W
         ayO18HK2Cm37oSQ3/IuENuXVKqdPUlNevXQzvLwwOkKHkFXxOeH6smzG9m3L4Gyk0S99
         8PN1npJ+uz3ddjAuHe7O2XBcBJREo1MeWelFN26BlWdd95qckhoRInQnMkQ9EwHIfPTM
         oxJ91gl/RFAYywf/TpcCSrOnC3+PDugbpRjO7vpVHuyLI3fAz6WiKiFxwVfUwmBYUuKm
         qnMuPKNeqFVG0BK6BSnObtAQt5nbchJa4S7njLFd2NIPTAXei7H+Fdfwuxw6QgPq702v
         RnPA==
X-Gm-Message-State: APjAAAVHMPX/x+AJ3t7hWnZKx/H4jVjGHk6mhzVlCBCAU8o0hujVAOKy
        PsmzmYzh9dnGX+6GSYfJv7U=
X-Google-Smtp-Source: APXvYqyZGuZetBDODErSQUtfoVszKVteigeR9DNtDeH/xT3Ikx0w+NzBBVD8KljUGYhJYubNFZ+pxQ==
X-Received: by 2002:a17:902:d205:: with SMTP id t5mr6454527ply.138.1581738637706;
        Fri, 14 Feb 2020 19:50:37 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id f8sm8489612pfn.2.2020.02.14.19.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 19:50:37 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Qiang Yu <yuq825@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH] drm/lima: fix recovering from PLBU out of memory
Date:   Fri, 14 Feb 2020 19:50:26 -0800
Message-Id: <20200215035026.3180698-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like on PLBU_OUT_OF_MEM interrupt we need to resume from where we
stopped, i.e. new PLBU heap start is old end. Also update end address
in GP frame to grow heap on 2nd and subsequent out of memory interrupts.

Fixes: 2081e8dcf1ee ("drm/lima: recover task by enlarging heap buffer")
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/gpu/drm/lima/lima_gp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/lima/lima_gp.c b/drivers/gpu/drm/lima/lima_gp.c
index d1e7826c2d74..325604262def 100644
--- a/drivers/gpu/drm/lima/lima_gp.c
+++ b/drivers/gpu/drm/lima/lima_gp.c
@@ -224,8 +224,13 @@ static int lima_gp_task_recover(struct lima_sched_pipe *pipe)
 	}
 
 	gp_write(LIMA_GP_INT_MASK, LIMA_GP_IRQ_MASK_USED);
+	/* Resume from where we stopped, i.e. new start is old end */
+	gp_write(LIMA_GP_PLBU_ALLOC_START_ADDR,
+		 f[LIMA_GP_PLBU_ALLOC_END_ADDR >> 2]);
+	f[LIMA_GP_PLBU_ALLOC_END_ADDR >> 2] =
+		f[LIMA_GP_PLBU_ALLOC_START_ADDR >> 2] + task->heap->heap_size;
 	gp_write(LIMA_GP_PLBU_ALLOC_END_ADDR,
-		 f[LIMA_GP_PLBU_ALLOC_START_ADDR >> 2] + task->heap->heap_size);
+		 f[LIMA_GP_PLBU_ALLOC_END_ADDR >> 2]);
 	gp_write(LIMA_GP_CMD, LIMA_GP_CMD_UPDATE_PLBU_ALLOC);
 	return 0;
 }
-- 
2.25.0

