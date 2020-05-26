Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3425EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E0C20849
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590519827;
	bh=ConqutJgbi4/Qis/DO2822iciViU/8gVeGfHmxkd1Do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ahU0jSE6FnINI2IzN3sEZSwNM6lyRXF7kpbPoQ6BDkjMgscF+Un/1CwGVZBsr6G7I
	 RzglqZnUi5zV9vxrygSPhNWILqctUjVhgWClMXpwneQyaiMao9FjGV31E4DDwpDhZS
	 URTXaF6aiqkj6ym0D4xzF4Of/vdMxKwqFW4pzoH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391267AbgEZTDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:03:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391252AbgEZTDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:03:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84C1620873;
        Tue, 26 May 2020 19:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519823;
        bh=ConqutJgbi4/Qis/DO2822iciViU/8gVeGfHmxkd1Do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kEq6qboQlgXnww5+i6yAiN82cLZFHYhhqWKo8b1R9ssAembLOJcQhtyQgFMJO1F0G
         sd/P6k4ghCvG2bY7yMqQJ6GBmraD+IbRrYFGm01Kw1UKiJjoiwOOfdBLl5ykm+zfxg
         zcB25bRS8iH4sKSlsh2ISWWHq2IM0/oIouWMZBYI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wu Bo <wubo40@huawei.com>,
        "Yan, Zheng" <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 30/81] ceph: fix double unlock in handle_cap_export()
Date:   Tue, 26 May 2020 20:53:05 +0200
Message-Id: <20200526183930.831806653@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183923.108515292@linuxfoundation.org>
References: <20200526183923.108515292@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 5241102b81a8..a2d4eed27f80 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3632,6 +3632,7 @@ retry:
 		WARN_ON(1);
 		tsession = NULL;
 		target = -1;
+		mutex_lock(&session->s_mutex);
 	}
 	goto retry;
 
-- 
2.25.1



