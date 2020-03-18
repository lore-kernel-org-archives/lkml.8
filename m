Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997CDC43332
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65C922137B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584564872;
	bh=eCI/k5w1qWNWYqRZaIz8Ti155zkqEQGAc3HnK40M09c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=14Q5gs7gi67ul78AEnOXjmGyQEAEPOuAXScAcMd69qQ1FJnAwWZWKcQ+CuMPd1KzQ
	 4OuExTjmGxg6jKPqxti92BN4pzoZNmenhh+hIIGwQhB5DO8qSDevsO7X19sXrcFMc/
	 nbwcb1p5Cxsg9xtRvL7Dl/zHII0w0qbuXus5ZPmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgCRUya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbgCRUy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:54:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0288820BED;
        Wed, 18 Mar 2020 20:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584564865;
        bh=eCI/k5w1qWNWYqRZaIz8Ti155zkqEQGAc3HnK40M09c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dSicSenbgPIVPN/Y32tRcAFh5TYsVn/L1azk8j9q+7zy/Q1NEEtejh+m//ePlKIer
         eVNznmvNCp6oL3s0WC/nN3GH0EKMwFNwEMC80UlBcZCiNPJAqElFOzX7mc9zMDVfeL
         cIMh1lU+QGek1WuMbgS6R7ytl6gJV7ODbxWnGfqQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        virtualization@lists.linux-foundation.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 5.4 38/73] virtio_balloon: Adjust label in virtballoon_probe
Date:   Wed, 18 Mar 2020 16:53:02 -0400
Message-Id: <20200318205337.16279-38-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318205337.16279-1-sashal@kernel.org>
References: <20200318205337.16279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 6ae4edab2fbf86ec92fbf0a8f0c60b857d90d50f ]

Clang warns when CONFIG_BALLOON_COMPACTION is unset:

../drivers/virtio/virtio_balloon.c:963:1: warning: unused label
'out_del_vqs' [-Wunused-label]
out_del_vqs:
^~~~~~~~~~~~
1 warning generated.

Move the label within the preprocessor block since it is only used when
CONFIG_BALLOON_COMPACTION is set.

Fixes: 1ad6f58ea936 ("virtio_balloon: Fix memory leaks on errors in virtballoon_probe()")
Link: https://github.com/ClangBuiltLinux/linux/issues/886
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Link: https://lore.kernel.org/r/20200216004039.23464-1-natechancellor@gmail.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index d2c4eb9efd70b..7aaf150f89ba0 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -958,8 +958,8 @@ static int virtballoon_probe(struct virtio_device *vdev)
 	iput(vb->vb_dev_info.inode);
 out_kern_unmount:
 	kern_unmount(balloon_mnt);
-#endif
 out_del_vqs:
+#endif
 	vdev->config->del_vqs(vdev);
 out_free_vb:
 	kfree(vb);
-- 
2.20.1

