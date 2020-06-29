Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0429C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEEDC20760
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593461652;
	bh=xJLQ0boay0Bf+EKvPVKaRb97JxMWn1YRifhIR045NQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2oFS+MF2a8vhZyA5nSl4JmcMym4TbQwUHCnKdhYAny42MJAq2cSNQJdVDlcu2JO1E
	 Qtq4TGBV1hGooKOXnv9L5kGySwNRh5xyxJkfw8nEqp2mITUxyXqqRRQYCb2RutNHt/
	 kg1Yjz9wL1trhNa+sqK8RkPLQ0GJz5OdzxGXfLjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbgF2UOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:14:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732849AbgF2TaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:30:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 204D9252BD;
        Mon, 29 Jun 2020 15:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445030;
        bh=xJLQ0boay0Bf+EKvPVKaRb97JxMWn1YRifhIR045NQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nA6foVKI2Q4Ub97PC3+qsReOgBe/XQ9cRNgzSQFBT0oHMYWnh8Co0MKcod3qXTJCt
         Pd/NRXHf0UYCrYGJDK6GCvt9ManbgvfxhL6ooAhJZGXTK51cxXTabAhHFow7NcRdab
         9pfbATfaSLcmKH31IioFcu1Wcq1MHv4n3Zh5P8cQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Huaisheng Ye <yehs1@lenovo.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.19 128/131] dm writecache: correct uncommitted_block when discarding uncommitted entry
Date:   Mon, 29 Jun 2020 11:34:59 -0400
Message-Id: <20200629153502.2494656-129-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629153502.2494656-1-sashal@kernel.org>
References: <20200629153502.2494656-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.131-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.131-rc1
X-KernelTest-Deadline: 2020-07-01T15:34+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

commit 39495b12ef1cf602e6abd350dce2ef4199906531 upstream.

When uncommitted entry has been discarded, correct wc->uncommitted_block
for getting the exact number.

Fixes: 48debafe4f2fe ("dm: add writecache target")
Cc: stable@vger.kernel.org
Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Acked-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-writecache.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 4321c48eba6b9..509552fc55fc7 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -811,6 +811,8 @@ static void writecache_discard(struct dm_writecache *wc, sector_t start, sector_
 				writecache_wait_for_ios(wc, WRITE);
 				discarded_something = true;
 			}
+			if (!writecache_entry_is_committed(wc, e))
+				wc->uncommitted_blocks--;
 			writecache_free_entry(wc, e);
 		}
 
-- 
2.25.1

