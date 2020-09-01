Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F50C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 376B8204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598976502;
	bh=v9gQOf2yho3wnn66sqsWT+5Vz7QPb2gaJkVZZU4Booc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=REpEmK1dEXM+kmqFt5iNxNMrrmwk7I1ma7OkLF/RscbJDTS4QhGB6zvN4yPMDNqyD
	 GtS9zNs02iK27A+gw1AoAXYChNFBcr4ebe7AjFq17PqeOMIhcQS5BKkyH0bWEodvAL
	 9shHAgEF7hDpzcxvdQQJ+/X2Xob1wJwflUp2szGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbgIAQIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:08:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728811AbgIAPj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:39:29 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3DEF205F4;
        Tue,  1 Sep 2020 15:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974768;
        bh=v9gQOf2yho3wnn66sqsWT+5Vz7QPb2gaJkVZZU4Booc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tQm4QJsgYeIRT2cO4XCAgg0Ljk2bCXFqNyCD2d2fMWxo1esIHuTOyytGzoEOQ9bn4
         z10JMUKeI6uFmORTSFF8tynLb3cppVXYxAP3jYz1S9gXN8smIc0hHfZ6PIpD44c1uW
         DZ92S4XqMUOHr/Wpo8h+nwPoPi4RPWuMChsZF9ag=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 053/255] locking/lockdep: Fix overflow in presentation of average lock-time
Date:   Tue,  1 Sep 2020 17:08:29 +0200
Message-Id: <20200901151003.268731935@linuxfoundation.org>
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

From: Chris Wilson <chris@chris-wilson.co.uk>

[ Upstream commit a7ef9b28aa8d72a1656fa6f0a01bbd1493886317 ]

Though the number of lock-acquisitions is tracked as unsigned long, this
is passed as the divisor to div_s64() which interprets it as a s32,
giving nonsense values with more than 2 billion acquisitons. E.g.

  acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
  -------------------------------------------------------------------------
    2350439395           0.07         353.38   649647067.36          0.-32

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20200725185110.11588-1-chris@chris-wilson.co.uk
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/locking/lockdep_proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index 5525cd3ba0c83..02ef87f50df29 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -423,7 +423,7 @@ static void seq_lock_time(struct seq_file *m, struct lock_time *lt)
 	seq_time(m, lt->min);
 	seq_time(m, lt->max);
 	seq_time(m, lt->total);
-	seq_time(m, lt->nr ? div_s64(lt->total, lt->nr) : 0);
+	seq_time(m, lt->nr ? div64_u64(lt->total, lt->nr) : 0);
 }
 
 static void seq_stats(struct seq_file *m, struct lock_stat_data *data)
-- 
2.25.1



