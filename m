Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14243C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAEDD207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597882266;
	bh=WUu1nmeECqgBkkf62NEGmJ1dhLGsP5wMDFpd2EjOBCk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lXHD+QpevUEQmpPSMamEB5y2m/DvSdnql/KaUi4hpmgWuC/jnOax8c9I/3UZFaB7K
	 np/wZmTsCQKTcEwVKjJIMMyvvo2G/kT1qD92M4QdRsc4Y6NH++G4m5NVUvVYUpZUNS
	 5qVY69/JIHIS0Qn0eUJ84l7huo3AHJXqKa0r18nA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHTACP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:02:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgHTACC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:02:02 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3192B208C7;
        Thu, 20 Aug 2020 00:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597881721;
        bh=WUu1nmeECqgBkkf62NEGmJ1dhLGsP5wMDFpd2EjOBCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pGlZ1vJcNQFLIPl+qzrULbv5xC/eBwGefve5kdVy+13dHedkuG3CFFXLQ7/BCpC9N
         RvuxZc+IvfpweCMX20NVlgnAT1J9WHXoCJeGtB/C2y6QRh8peYmT6QXrEyB1MMJh9U
         wjSGW5u9uxlJ59WB1XJV7vEcVrwic0bi+0uzNc80=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.7 04/24] f2fs: fix to check page dirty status before writeback
Date:   Wed, 19 Aug 2020 20:01:35 -0400
Message-Id: <20200820000155.215089-4-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200820000155.215089-1-sashal@kernel.org>
References: <20200820000155.215089-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

[ Upstream commit eb1353cfa9c1e9415b03dc117f8399969fa02102 ]

In f2fs_write_raw_pages(), we need to check page dirty status before
writeback, because there could be a racer (e.g. reclaimer) helps
writebacking the dirty page.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/compress.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index a5b2e72174bb1..a1504a7aecb19 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1207,6 +1207,12 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 				congestion_wait(BLK_RW_ASYNC,
 						DEFAULT_IO_TIMEOUT);
 				lock_page(cc->rpages[i]);
+
+				if (!PageDirty(cc->rpages[i])) {
+					unlock_page(cc->rpages[i]);
+					continue;
+				}
+
 				clear_page_dirty_for_io(cc->rpages[i]);
 				goto retry_write;
 			}
-- 
2.25.1

