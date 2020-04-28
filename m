Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF3CC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F09E321707
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588098397;
	bh=no3knKj15K/kqw5BYs/rcA1+Ow+Jsr8lPJT0094hSSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=STPv0bNnxK6yQNy3rb/ATEajb9g1YPpmoa1It/BfIsQt9ZJ7tr6nctCQC6DFJSyXM
	 nIaa5JDjN3UQ1fiJPw3fO5P9hcMWizXaIZwTapXnvTUKVAt1OeXhkC55MYOIQNXbqa
	 3Vm6PYSQs8aeI9W19X/4GfY7Fq1QHhXhGn1dW9TI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgD1S0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:26:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbgD1S0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:26:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7199520B1F;
        Tue, 28 Apr 2020 18:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098392;
        bh=no3knKj15K/kqw5BYs/rcA1+Ow+Jsr8lPJT0094hSSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PCyNrPNGQDUFSXqq8A4ARcX8W4/AuilgHbO4jjlrbtwu247nuNj7qStqcBM4u0kO2
         EmPGVm5QDMqxlb4swYYEtRNqM4J3naaj7XEZscM1AHX9kTKWqcg7d+3Xh02LlZli6h
         HW6sK6ARkc/Q1SB1vprW3NYw5EwZWpRjIZDqhUmQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        NeilBrown <neilb@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
        Waiman Long <longman@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 021/167] kernel/gcov/fs.c: gcov_seq_next() should increase position index
Date:   Tue, 28 Apr 2020 20:23:17 +0200
Message-Id: <20200428182227.835883934@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182225.451225420@linuxfoundation.org>
References: <20200428182225.451225420@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

[ Upstream commit f4d74ef6220c1eda0875da30457bef5c7111ab06 ]

If seq_file .next function does not change position index, read after
some lseek can generate unexpected output.

https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: NeilBrown <neilb@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Waiman Long <longman@redhat.com>
Link: http://lkml.kernel.org/r/f65c6ee7-bd00-f910-2f8a-37cc67e4ff88@virtuozzo.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/gcov/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/gcov/fs.c b/kernel/gcov/fs.c
index e5eb5ea7ea598..cc4ee482d3fba 100644
--- a/kernel/gcov/fs.c
+++ b/kernel/gcov/fs.c
@@ -108,9 +108,9 @@ static void *gcov_seq_next(struct seq_file *seq, void *data, loff_t *pos)
 {
 	struct gcov_iterator *iter = data;
 
+	(*pos)++;
 	if (gcov_iter_next(iter))
 		return NULL;
-	(*pos)++;
 
 	return iter;
 }
-- 
2.20.1



