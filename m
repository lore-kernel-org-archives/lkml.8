Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493DAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:56:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28A38206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 13:56:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DUtxQ+F3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgFLN4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 09:56:30 -0400
Received: from m12-15.163.com ([220.181.12.15]:37007 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726474AbgFLN4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 09:56:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=L2UPa91bTaGr2nGxt5
        46epMlCxYbdwpTFHQ6idsU4S4=; b=DUtxQ+F39DdxT4/o5nwzw+dQRvWV6hXvsh
        cT+dsbwpbNQIrxYtZhf+JsJu7IGssukccNGHHleJPkYGyQmcDBM2Ki6cKLuwhgmj
        3BnWVewvWWhTvxJCDgX4EC9NL3hZe9qdxJRUAIio2uII9TsLxK1Yv4hVpxl291HM
        4Ye2IkZNA=
Received: from localhost.localdomain (unknown [111.202.190.28])
        by smtp11 (Coremail) with SMTP id D8CowABnbn5xieNeLmwJGg--.23390S2;
        Fri, 12 Jun 2020 21:56:02 +0800 (CST)
From:   zzuedu2000@163.com
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        weifenghai <zzuedu2000@163.com>
Subject: [PATCH] Fix code style same in one function
Date:   Fri, 12 Jun 2020 21:54:59 +0800
Message-Id: <20200612135459.28537-1-zzuedu2000@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: D8CowABnbn5xieNeLmwJGg--.23390S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFW8JryrtFW5GrWfXFWfAFb_yoWxCrb_Z3
        s3Xw1xKryIyw1qyrZ8ZwsaqaykKayrKrWv9r17trW7AF1UJrs8JwnxKFn8JFsruwn3Cr98
        Ar93KF93tFsrWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUjRVbtUUUUU==
X-Originating-IP: [111.202.190.28]
X-CM-SenderInfo: p22xvvbxsqiii6rwjhhfrp/1tbiJRJBQlUMYHoY5gAAsJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: weifenghai <zzuedu2000@163.com>

One line similar code before in this function

Signed-off-by: weifenghai <zzuedu2000@163.com>
---
 kernel/cgroup/cgroup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1ea181a58465..c3e6db6e44d8 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4352,8 +4352,7 @@ static struct css_set *css_task_iter_next_css_set(struct css_task_iter *it)
 	}
 
 	/* find the next cset */
-	l = it->cset_pos;
-	l = l->next;
+	l = it->cset_pos->next;
 	if (l == it->cset_head) {
 		it->cset_pos = NULL;
 		return NULL;
-- 
2.17.1


