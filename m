Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E60C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC6A217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581695364;
	bh=HDNfsmOpb9MK1yv2aN+/E97lXV9iDVXQh3D1EFAviJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=01iSnHll6X30RcrEjz79vtQgsf8Ku3s6hrM37ecq7qSdf9CQy2nr422r2Z5y3QbRs
	 5lnhvYUENuFmT0z3sdpEnYR9vVFRMHdCqipGu7hDQ01t7SYoSvyIBtInjll1h/TkrZ
	 V0U3sYN3S6V8aFbuzEvxSc5gGdDyorYlGVbYVpIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbgBNPtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:49:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:52082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729881AbgBNPtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:49:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E76E2467C;
        Fri, 14 Feb 2020 15:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695359;
        bh=HDNfsmOpb9MK1yv2aN+/E97lXV9iDVXQh3D1EFAviJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=whtoHfjZ/KMi2cLTlbjpP6gn9Z5A2nAAlwagihjgLVXcaZOwNzcUvvMTHnMafTnLw
         ojuPQgRIa5euTwh59o1YLtKs328hkVGQ0HYvsEJrPszaUqlJXXpUjWcXsNtcQRU6UN
         422ISCZYLk2PXFu0v865rmr4hB0PGDt7rMGzBaHQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 019/542] media: meson: add missing allocation failure check on new_buf
Date:   Fri, 14 Feb 2020 10:40:11 -0500
Message-Id: <20200214154854.6746-19-sashal@kernel.org>
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

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 11e0e167d071a28288a7a0a211d48c571d19b56f ]

Currently if the allocation of new_buf fails then a null pointer
dereference occurs when assiging new_buf->vb. Avoid this by returning
early on a memory allocation failure as there is not much more can
be done at this point.

Addresses-Coverity: ("Dereference null return")

Fixes: 3e7f51bd9607 ("media: meson: add v4l2 m2m video decoder driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/meson/vdec/vdec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index 0a1a04fd5d13d..8dd1396909d7e 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -133,6 +133,8 @@ vdec_queue_recycle(struct amvdec_session *sess, struct vb2_buffer *vb)
 	struct amvdec_buffer *new_buf;
 
 	new_buf = kmalloc(sizeof(*new_buf), GFP_KERNEL);
+	if (!new_buf)
+		return;
 	new_buf->vb = vb;
 
 	mutex_lock(&sess->bufs_recycle_lock);
-- 
2.20.1

