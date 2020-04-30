Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2146EC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0059820661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588254912;
	bh=zdG9+nXHyjiM/BTOaYaVPvawmq2B75M4V90iTlupPwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yV+603VxUs0EYf3M7IlzBe4Ar74b1SBYGbjDMafovG0Me05wlM0jEJRMKB4PcHZ1c
	 TIGvx3Yix7Vn9bKNEdCVwTkmHTxwOrOB3I9kREG1UnWID7Z2flVOUCzYViAxmIzwpJ
	 +zX8JMMLLhiKvMVM1tJRQJBHXJyxYLjPkBLLXOjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgD3NzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:36682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728951AbgD3NyT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:54:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD3952137B;
        Thu, 30 Apr 2020 13:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254859;
        bh=zdG9+nXHyjiM/BTOaYaVPvawmq2B75M4V90iTlupPwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ksRVdnXo8kr5M3eZ5nffX7AxNhKnOpLeOxbqfO0PNP/G/bITdprHOFijE9ZfFy3pu
         tnnc7My4LznWvvzN1nzY+pAIvOzDVs9mq2mkiqGRTlAgDZGcAkxW0YSBtWrwjCuq7S
         BsQ2MWRFP6HBCE8l58S/gES9qxkdrIZuClXqeW2Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Taehee Yoo <ap420073@gmail.com>, Jiri Pirko <jiri@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 15/27] team: fix hang in team_mode_get()
Date:   Thu, 30 Apr 2020 09:53:50 -0400
Message-Id: <20200430135402.20994-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135402.20994-1-sashal@kernel.org>
References: <20200430135402.20994-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit 1c30fbc76b8f0c07c92a8ca4cd7c456612e17eb5 ]

When team mode is changed or set, the team_mode_get() is called to check
whether the mode module is inserted or not. If the mode module is not
inserted, it calls the request_module().
In the request_module(), it creates a child process, which is
the "modprobe" process and waits for the done of the child process.
At this point, the following locks were used.
down_read(&cb_lock()); by genl_rcv()
    genl_lock(); by genl_rcv_msc()
        rtnl_lock(); by team_nl_cmd_options_set()
            mutex_lock(&team->lock); by team_nl_team_get()

Concurrently, the team module could be removed by rmmod or "modprobe -r"
The __exit function of team module is team_module_exit(), which calls
team_nl_fini() and it tries to acquire following locks.
down_write(&cb_lock);
    genl_lock();
Because of the genl_lock() and cb_lock, this process can't be finished
earlier than request_module() routine.

The problem secenario.
CPU0                                     CPU1
team_mode_get
    request_module()
                                         modprobe -r team_mode_roundrobin
                                                     team <--(B)
        modprobe team <--(A)
            team_mode_roundrobin

By request_module(), the "modprobe team_mode_roundrobin" command
will be executed. At this point, the modprobe process will decide
that the team module should be inserted before team_mode_roundrobin.
Because the team module is being removed.

By the module infrastructure, the same module insert/remove operations
can't be executed concurrently.
So, (A) waits for (B) but (B) also waits for (A) because of locks.
So that the hang occurs at this point.

Test commands:
    while :
    do
        teamd -d &
	killall teamd &
	modprobe -rv team_mode_roundrobin &
    done

The approach of this patch is to hold the reference count of the team
module if the team module is compiled as a module. If the reference count
of the team module is not zero while request_module() is being called,
the team module will not be removed at that moment.
So that the above scenario could not occur.

Fixes: 3d249d4ca7d0 ("net: introduce ethernet teaming device")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Reviewed-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/team/team.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 3dba58fa34339..396a8c6cb9992 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -480,6 +480,9 @@ static const struct team_mode *team_mode_get(const char *kind)
 	struct team_mode_item *mitem;
 	const struct team_mode *mode = NULL;
 
+	if (!try_module_get(THIS_MODULE))
+		return NULL;
+
 	spin_lock(&mode_list_lock);
 	mitem = __find_mode(kind);
 	if (!mitem) {
@@ -495,6 +498,7 @@ static const struct team_mode *team_mode_get(const char *kind)
 	}
 
 	spin_unlock(&mode_list_lock);
+	module_put(THIS_MODULE);
 	return mode;
 }
 
-- 
2.20.1

