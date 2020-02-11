Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D744C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 04:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 319A120661
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 04:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="oemCS7u3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgBKEHG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 23:07:06 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34447 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbgBKEHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 23:07:06 -0500
Received: by mail-qv1-f65.google.com with SMTP id o18so4385771qvf.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 20:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jP+KwizgAp4u1Hs+XLbuqhDNlKeTKCmKP2Xx0AvNis0=;
        b=oemCS7u3/gb5Lykz976wCFdzzFs9p6bvICWvD4l9Z660JbUncxEpdnnJGGgz1g8xw2
         n9NMBSkqV0AhsunxlxyV49c4r02SoM9t9phCEJEPYrdiWcaJ6Rtj2tpJPExeU2ZUeu8X
         /w1ISfQIfRm/F/2J73ZCCO/Oxw9MFfn3OymoiQTA6ykdj3dNwHhyIvls7+9u9nxleTdS
         7PvdTCcejTCUK55mLk5e6t3FQtYJf37mCt6p9eUqDLFG2tGiEAnRr4gGrTB6VTt9dFUH
         2PqqmYM3QzB6sKD8mxMlAKVLVcrLGydvaB0WBzCA4iAjtH5M+h3vDKxXqGLwb7f2smrG
         0E7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jP+KwizgAp4u1Hs+XLbuqhDNlKeTKCmKP2Xx0AvNis0=;
        b=JirkF+LP4ljFmpnMDkADPDNpy92DglLel4qox64odmG9IB7noTTjQTMWZ7G/P7Ah60
         sbJs8ZXum02mT7S+e95hThG7rCGyMSpeeABMym0XeeHpOvMIYC25afQBHYmU9gqZxp8x
         LpYZ6H85G0i6YOPUTb/4Z48bGFR7+gPrLyWjDIKnq2TkgZLXGrOLqGoPSxz1MQV2/37l
         eOQTjoMIwMW9cMtguqRHhk50Le7x5hQ+6qBbEkSjr59QxdcXWUhMIRLaFwKP+PPOp2+U
         i9p9WSO+sUzc5hZ0gkyg67zrj2iLoTH9YTY5tGgNXOvcuts1bRs6GF12CKUqpGybwzC6
         E8zA==
X-Gm-Message-State: APjAAAVN+wiijBrGiKfENSmN3CgTCTENjvX7nrp7j/9BF9cBLZrvYUU9
        E845Kkae5H7posJLK4PF6tiU8w==
X-Google-Smtp-Source: APXvYqzHMokwWB2NbnFjmTdaE2IQhdwywU5g0W0ofZn9mazfQBr/9nQBvIn8cfiLFeJK/J7LxN4YmQ==
X-Received: by 2002:a05:6214:11ac:: with SMTP id u12mr1241675qvv.85.1581394024919;
        Mon, 10 Feb 2020 20:07:04 -0800 (PST)
Received: from ovpn-120-145.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p135sm1315222qke.2.2020.02.10.20.07.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Feb 2020 20:07:04 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     peterz@infradead.org, mingo@redhat.com
Cc:     will@kernel.org, elver@google.com, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] locking/osq_lock: annotate a data race in osq_lock
Date:   Mon, 10 Feb 2020 23:06:51 -0500
Message-Id: <20200211040651.1993-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

prev->next could be accessed concurrently as noticed by KCSAN,

 write (marked) to 0xffff9d3370dbbe40 of 8 bytes by task 3294 on cpu 107:
  osq_lock+0x25f/0x350
  osq_wait_next at kernel/locking/osq_lock.c:79
  (inlined by) osq_lock at kernel/locking/osq_lock.c:185
  rwsem_optimistic_spin
  <snip>

 read to 0xffff9d3370dbbe40 of 8 bytes by task 3398 on cpu 100:
  osq_lock+0x196/0x350
  osq_lock at kernel/locking/osq_lock.c:157
  rwsem_optimistic_spin
  <snip>

Since the write only stores NULL to prev->next and the read tests if
prev->next equals to this_cpu_ptr(&osq_node). Even if the value is
shattered, the code is still working correctly. Thus, mark it as an
intentional data race using the data_race() macro.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/locking/osq_lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 1f7734949ac8..3c44ddbc11ce 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -154,7 +154,7 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 	 */
 
 	for (;;) {
-		if (prev->next == node &&
+		if (data_race(prev->next == node) &&
 		    cmpxchg(&prev->next, node, NULL) == node)
 			break;
 
-- 
2.21.0 (Apple Git-122.2)

