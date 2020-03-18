Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487C6C4332B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED2E20409
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584565796;
	bh=nTxRlZrbXFqAbJBx9TxjT33/QaswKJOnZ4Fdd6jn2Cw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iCWRkBIXocZ02mJJCu+GuCgfykCv9OjBx5lskgDNUvXyHL6KZA+jIJvrss7mLmSIS
	 cnCDhOIfI8byRzxQZ/24OWNNZtg7pE7zCuWwbn5vy+bVseU40B4INcDAsRBV50jeT4
	 j5hBQ96gq371Lct8KowXC23I2cse3MZwURFd9DHA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgCRVJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:09:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbgCRUxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:53:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 692C020775;
        Wed, 18 Mar 2020 20:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584564819;
        bh=nTxRlZrbXFqAbJBx9TxjT33/QaswKJOnZ4Fdd6jn2Cw=;
        h=From:To:Cc:Subject:Date:From;
        b=ZRf0vLdRsfc+vodoQwpt5T6Q8D73zorn/PgnD3D98F4EQ2imeqAAvmxJI6U0TftoS
         1ebHbCJyc0vLDsgOWfPYxeK3pwbaNvOnzpPeAQHqUrNb4ZEEcdmvlC7ErYlyJvIHBH
         AmIZs714QAymr7k9LF7XPcT6aZbNvaf0Jnh6c03o=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Averin <vvs@virtuozzo.com>, Tejun Heo <tj@kernel.org>,
        Sasha Levin <sashal@kernel.org>, cgroups@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 01/73] cgroup-v1: cgroup_pidlist_next should update position index
Date:   Wed, 18 Mar 2020 16:52:25 -0400
Message-Id: <20200318205337.16279-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

[ Upstream commit db8dd9697238be70a6b4f9d0284cd89f59c0e070 ]

if seq_file .next fuction does not change position index,
read after some lseek can generate unexpected output.

 # mount | grep cgroup
 # dd if=/mnt/cgroup.procs bs=1  # normal output
...
1294
1295
1296
1304
1382
584+0 records in
584+0 records out
584 bytes copied

dd: /mnt/cgroup.procs: cannot skip to specified offset
83  <<< generates end of last line
1383  <<< ... and whole last line once again
0+1 records in
0+1 records out
8 bytes copied

dd: /mnt/cgroup.procs: cannot skip to specified offset
1386  <<< generates last line anyway
0+1 records in
0+1 records out
5 bytes copied

https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cgroup-v1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
index 7f83f4121d8d0..2db582706ec5c 100644
--- a/kernel/cgroup/cgroup-v1.c
+++ b/kernel/cgroup/cgroup-v1.c
@@ -473,6 +473,7 @@ static void *cgroup_pidlist_next(struct seq_file *s, void *v, loff_t *pos)
 	 */
 	p++;
 	if (p >= end) {
+		(*pos)++;
 		return NULL;
 	} else {
 		*pos = *p;
-- 
2.20.1

