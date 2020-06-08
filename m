Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FC2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC4E32086A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658300;
	bh=92v9pIWhiD1Q5RVPpKInmy4f4dVFrBCW0it7NySzVpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nvvkoA//tIVQdU8hOKK29JtDRVaK0Uzl83R+FLAurInT0t750cyJM/+Yf3giK9gtx
	 MHV966T3Hp059vqtm0lklPTWokd2vQUtGKe445KqIsw5JMX42JxszYsVH/iLmCbhe2
	 m+jjFLaMKoMGdXSgM88LYBR+zPeyDyzXdXgcNvRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbgFHXSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:18:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729852AbgFHXOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:14:38 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0068121548;
        Mon,  8 Jun 2020 23:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658078;
        bh=92v9pIWhiD1Q5RVPpKInmy4f4dVFrBCW0it7NySzVpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yeBkZ2gSGi/3RHmSG1GlUu4EpG406eSmkdcyepumgOwVgUM6Frw7hFfUsTmp4DkA9
         ef4meuLIH7SHKzqbT2hAegmBg84ifDJSuUSdSOcyrMwO93gpmZKBGCj4e4AuJgjNjO
         RamUOjZ8wNyijLz5GZPPi9PjDWOpYkc89MzoaOb0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wu Bo <wubo40@huawei.com>, "Yan, Zheng" <zyan@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, ceph-devel@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 123/606] ceph: fix double unlock in handle_cap_export()
Date:   Mon,  8 Jun 2020 19:04:08 -0400
Message-Id: <20200608231211.3363633-123-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wu Bo <wubo40@huawei.com>

[ Upstream commit 4d8e28ff3106b093d98bfd2eceb9b430c70a8758 ]

If the ceph_mdsc_open_export_target_session() return fails, it will
do a "goto retry", but the session mutex has already been unlocked.
Re-lock the mutex in that case to ensure that we don't unlock it
twice.

Signed-off-by: Wu Bo <wubo40@huawei.com>
Reviewed-by: "Yan, Zheng" <zyan@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/caps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index d050acc1fd5d..f50204380a65 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3707,6 +3707,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		WARN_ON(1);
 		tsession = NULL;
 		target = -1;
+		mutex_lock(&session->s_mutex);
 	}
 	goto retry;
 
-- 
2.25.1

