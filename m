Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE2DC5518A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 839842077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550036;
	bh=OifP4P5hXxTkzT+ICeJO7lVltwiShd+rSRZd7Y6s+aI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0V+IqlzkXuiXBuG8ewZC+LvO6qTwHUwOStj42QpBf3X1CSqf9npyZOfrLBS7Id+pg
	 GXzRQ3q3+NWXDGY356wdc1m9FN0FyTqgABMsHiSOlSskS1U9KfujlBwYw7mRPBtL5e
	 JjuvCvZoisQOXj/KvDBPVybbHcsSypA+OHj3ycmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbgDVKHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:07:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728472AbgDVKHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:07:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 139D820774;
        Wed, 22 Apr 2020 10:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550030;
        bh=OifP4P5hXxTkzT+ICeJO7lVltwiShd+rSRZd7Y6s+aI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tKrpPvh6xTwD9fhM+f/rdCiRvrWW/gwQFxY/U+OZWBEycr3epoEHldbETvS9kiSjm
         4WVh3S/nO5UEM5eSCBEJgdh2qrF3z/WloL9pO3j1imjRIAouk5Jh2POMJ9KQze5Lzi
         ZwBDZLD3OqWMSVqOe4CCafMK5lsHNcK4hX3R0HUA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 107/125] s390/cpuinfo: fix wrong output when CPU0 is offline
Date:   Wed, 22 Apr 2020 11:57:04 +0200
Message-Id: <20200422095050.149825962@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095032.909124119@linuxfoundation.org>
References: <20200422095032.909124119@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Gordeev <agordeev@linux.ibm.com>

[ Upstream commit 872f27103874a73783aeff2aac2b41a489f67d7c ]

/proc/cpuinfo should not print information about CPU 0 when it is offline.

Fixes: 281eaa8cb67c ("s390/cpuinfo: simplify locking and skip offline cpus early")
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Reviewed-by: Heiko Carstens <heiko.carstens@de.ibm.com>
[heiko.carstens@de.ibm.com: shortened commit message]
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/processor.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index d856263fd7687..737e22cf09728 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -139,8 +139,9 @@ static void show_cpu_mhz(struct seq_file *m, unsigned long n)
 static int show_cpuinfo(struct seq_file *m, void *v)
 {
 	unsigned long n = (unsigned long) v - 1;
+	unsigned long first = cpumask_first(cpu_online_mask);
 
-	if (!n)
+	if (n == first)
 		show_cpu_summary(m, v);
 	if (!machine_has_cpu_mhz)
 		return 0;
@@ -153,6 +154,8 @@ static inline void *c_update(loff_t *pos)
 {
 	if (*pos)
 		*pos = cpumask_next(*pos - 1, cpu_online_mask);
+	else
+		*pos = cpumask_first(cpu_online_mask);
 	return *pos < nr_cpu_ids ? (void *)*pos + 1 : NULL;
 }
 
-- 
2.20.1



