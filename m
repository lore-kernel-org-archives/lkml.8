Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2060BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 20:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC9AF207CB
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 20:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EM8o2YVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387965AbgEWUfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 16:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387883AbgEWUfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 16:35:18 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC35C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 13:35:18 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id x27so8458092lfg.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 13:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wEmUEirF5tfAd7Gq1m77iRwi3DBT03ajwm/+Kim4iFg=;
        b=EM8o2YVyEwUqzdJ+R97QdRyWik29nXrHHi1lSu3IWudNr6YhRjDeYEqE1PGfsOTj2I
         9j7+PO+0hkKWWaN4XLgb6UqHEVFqud2NqlkV6EnExAdOEtBjmiEv1BYrmomCptcIYKAY
         n8QU2rzLgSp42zNfG9cgvQ9G/TfrGAoWrEQQBXpjvIxcHcN6rMsRXCZrRGml7GnuaXq1
         XjwcwxmCzzg06PPf7rV3Cw/TwvGFzhJ161B5qnm41M8RPNlnB84OUXUPBtxqI/+NgKe5
         RALeoVV1qdXz8Wef9U8WMCe16bGYIg1f+rG+BNJM0eQxj8OFiL8gUjLmK8WvEwebATwr
         Pa8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wEmUEirF5tfAd7Gq1m77iRwi3DBT03ajwm/+Kim4iFg=;
        b=HZZPjMFU905lRct+prreZv3BGijOcxZp0JH4dfDPMdQYUNcSND+jEExln/RKcnEBxA
         MxoqfVDSQXQFlJLIaKmurig12rrAlNMC7HgF2zdQ4uOzbvP9VHN3+7ZMoeDx2YPjI8Zv
         jqYfW1XYyP8cvrDrCnzaLncaXO7KjmTVOc568oLD4JvGTtd/3uEZ9DcoyVJzhelOPQI6
         J8akqZUAEHnZutqtaoUFYhbjVgwum+Lm2NtawVOnFTJyF6hzOIw0f1aOcXVE+53+WK4E
         qrK2PtGknRzKefyPfn4zjGjikvI6AqzVLRFrqn/CS47BtTRVnpgw/l402DngFY5BNttd
         v1Bw==
X-Gm-Message-State: AOAM531HLlWXZrrsGOWkZH2i4VoVQfm+pK8TEKAbI6pI3lBV9rVG/F4X
        NPIjXRIcuw9LgF1rmdc8Uuc=
X-Google-Smtp-Source: ABdhPJw8beiOY5GbQG+UAI+K9m6fW/bBhsr/irDhjKPMhW7JYgDHzKqg9gxgNaTpOtyM0DcTBMxN+w==
X-Received: by 2002:a19:c187:: with SMTP id r129mr10765647lff.35.1590266116799;
        Sat, 23 May 2020 13:35:16 -0700 (PDT)
Received: from localhost.localdomain ([85.249.97.232])
        by smtp.googlemail.com with ESMTPSA id l20sm3342354lfj.10.2020.05.23.13.35.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 May 2020 13:35:16 -0700 (PDT)
From:   Artur Barsegyan <a.barsegyan96@gmail.com>
Cc:     a.barsegyan96@gmail.com, skutepov@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Lu Shuaibing <shuaibinglu@126.com>,
        Manfred Spraul <manfred@colorfullife.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ipc/msg.c: wake up senders until there is a queue empty capacity
Date:   Sat, 23 May 2020 23:34:44 +0300
Message-Id: <20200523203448.84235-1-a.barsegyan96@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take into account the total size of the already enqueued messages of
previously handled senders before another one.

Otherwise, we have serious degradation of receiver throughput for
case with multiple senders because another sender wakes up,
checks the queue capacity and falls into sleep again.

Each round-trip wastes CPU time a lot and leads to perceptible
throughput degradation.

Source code of:
	- sender/receiver
	- benchmark script
	- ready graphics of before/after results

is located here: https://github.com/artur-barsegyan/systemv_queue_research

Signed-off-by: Artur Barsegyan <a.barsegyan96@gmail.com>
---
 ipc/msg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/ipc/msg.c b/ipc/msg.c
index caca67368cb5..52d634b0a65a 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -214,6 +214,7 @@ static void ss_wakeup(struct msg_queue *msq,
 	struct msg_sender *mss, *t;
 	struct task_struct *stop_tsk = NULL;
 	struct list_head *h = &msq->q_senders;
+	size_t msq_quota_used = 0;
 
 	list_for_each_entry_safe(mss, t, h, list) {
 		if (kill)
@@ -233,7 +234,7 @@ static void ss_wakeup(struct msg_queue *msq,
 		 * move the sender to the tail on behalf of the
 		 * blocked task.
 		 */
-		else if (!msg_fits_inqueue(msq, mss->msgsz)) {
+		else if (!msg_fits_inqueue(msq, msq_quota_used + mss->msgsz)) {
 			if (!stop_tsk)
 				stop_tsk = mss->tsk;
 
@@ -241,6 +242,7 @@ static void ss_wakeup(struct msg_queue *msq,
 			continue;
 		}
 
+		msq_quota_used += mss->msgsz;
 		wake_q_add(wake_q, mss->tsk);
 	}
 }
-- 
2.19.1

