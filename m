Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4546C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8470C20748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 17:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598030086;
	bh=v9gQOf2yho3wnn66sqsWT+5Vz7QPb2gaJkVZZU4Booc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TKVbCQ/SrfTbrgOlywvltzalxPP4jhID2pokJZP18KKiP5ggTaQcl8AqMCQaS546q
	 PX5ripaprX21yPxTaudOtv/lN3ODucZs8HpokLTohk2+IfI+1+CCgyMZqsCLOZvAIN
	 olz8bWWl3nkRENiPkOy6GtvtdhGqXLVgDOYXhLfk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgHUROm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:14:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728129AbgHUQQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:16:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE22A22CA0;
        Fri, 21 Aug 2020 16:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598026608;
        bh=v9gQOf2yho3wnn66sqsWT+5Vz7QPb2gaJkVZZU4Booc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t6D3aTBmEePwtmOI+lfu1La/vqgL2MKjqedylje9edO6Fa7lPKZvb6rHNTS9hUKqH
         33iJVCftU1poL7Nua7FfHZ3fcJYd3VtRHS2Yz1ubjy3gpPMUgMMxrQ+2poLF4ROx7X
         7XrKNwBzq0EwHl139+4xuW/25BvTscBDe5iVDwKs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chris Wilson <chris@chris-wilson.co.uk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.7 50/61] locking/lockdep: Fix overflow in presentation of average lock-time
Date:   Fri, 21 Aug 2020 12:15:34 -0400
Message-Id: <20200821161545.347622-50-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821161545.347622-1-sashal@kernel.org>
References: <20200821161545.347622-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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

