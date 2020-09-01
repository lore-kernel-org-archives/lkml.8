Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C2EC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A22B7206EF
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598975140;
	bh=X2DGoTfYqQ05LHE37QFTcsOpw/4x131sy9zxpFv050A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MMh/hTFj6i/8D/TrWMjtumZSZaRB2veXfg1BLbL+y/Fh/n00VKYrRBboHwYAc/m6x
	 rsNPFNe2Ia9Wkw+vbRXZfmzjji1NyLpsdKazjm1THQJKrDzADP2jWp2uHIvFiArZBw
	 lXPIbuKG7oyG2hjae/nhG09Ct28+6Ac7JhEeZK3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731888AbgIAPpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:45:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731508AbgIAPmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:42:50 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2EFE2064B;
        Tue,  1 Sep 2020 15:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974970;
        bh=X2DGoTfYqQ05LHE37QFTcsOpw/4x131sy9zxpFv050A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nv58xKhOzEytl/jthtk43WzV5KPlcSm2LpTaahmsIe5WfDDqD2Ekgd6NYi9JCKY9e
         JH8L0GY/glEKBoHAgUdV9Elxl36dQ3Yfs58mTAjxIhNpuK7jQn+0WYHFxAL+nWPSfW
         vcuig86ll4Xr429vo0PQsJU6ULjKE+I3lHvxlA7c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 160/255] bpf: Avoid visit same object multiple times
Date:   Tue,  1 Sep 2020 17:10:16 +0200
Message-Id: <20200901151008.357190893@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901151000.800754757@linuxfoundation.org>
References: <20200901151000.800754757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

[ Upstream commit e60572b8d4c39572be6857d1ec91fdf979f8775f ]

Currently when traversing all tasks, the next tid
is always increased by one. This may result in
visiting the same task multiple times in a
pid namespace.

This patch fixed the issue by seting the next
tid as pid_nr_ns(pid, ns) + 1, similar to
funciton next_tgid().

Signed-off-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Link: https://lore.kernel.org/bpf/20200818222310.2181500-1-yhs@fb.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/task_iter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index a4a0fb4f94cc1..323def936be24 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -28,8 +28,9 @@ static struct task_struct *task_seq_get_next(struct pid_namespace *ns,
 
 	rcu_read_lock();
 retry:
-	pid = idr_get_next(&ns->idr, tid);
+	pid = find_ge_pid(*tid, ns);
 	if (pid) {
+		*tid = pid_nr_ns(pid, ns);
 		task = get_pid_task(pid, PIDTYPE_PID);
 		if (!task) {
 			++*tid;
-- 
2.25.1



