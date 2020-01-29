Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F1BC35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 16:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC4D2070E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 16:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c7W8xJl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgA2QJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 11:09:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36447 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgA2QJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:09:16 -0500
Received: by mail-pl1-f194.google.com with SMTP id a6so112742plm.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 08:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2w+XND7PBGeesb5X+LaSnTAVC7q/SmsQ7bhG7hGGu3k=;
        b=c7W8xJl31owTz1Yx+RJ0t0lJeWMHmojPOvI9FTa0hToQ9rjk61F9cJpECaP8EbV9jV
         WRZWrG5hZ7ErbuZZDvb4Z2ar70aqpQH+u6FO0iuWYBi7MWWnFPiRRLuaAnpssV+DyGNN
         MisbUq3yuk+p3LM/1fKZ+8GjZEWkz7BLcGV8HFs/oPmu3w8rA+kTmif0eg8BeaZU0AuK
         cEO1sVF3TrYI7hjmzlHWu4qdxcwtEn6XUo4TH+0B33NSGwu2HBe9wer6Pfz1830NTLdq
         erOkBytkQCIlCU8kECVoDaG7m+JHQrcGcj1Tgu21IsrQnesl0MMlbNHzSs20osvTKgHn
         Ahqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2w+XND7PBGeesb5X+LaSnTAVC7q/SmsQ7bhG7hGGu3k=;
        b=B6oWT3x/5lTTjzuHs8PEIBpJCPo/8oiL36K2UsHpjTzg7G6y1eZC5HnQU9nPi+9vww
         +fqSlDjeCTzr/s65D0sKNoGF6icUFgcPEkjtQCk8yfZBhwcNw3f8cyqY55BmSJlwUtZQ
         jp8+gEWj8CnyIBOITKXxqNSRhSi4HE2vE7eX1knhue0lA3w3gyJsQn3+sXXB/frV1KDW
         YHPKjFcu3i5hBhL+SBFLBozdBQVs0M8q6TmxdQl/1JgYUobQIq7HW6BQsHedO/OEQdue
         Uh7zfDQZkF3kCciA2wL8C/o+J6BtIsYY7vdpRAWwNRWsszHkfH1NnjwiScAWHcuBC+3D
         qu9A==
X-Gm-Message-State: APjAAAUS/9IFmAMh1zh1KFW5CGfPWIIJW5DpDE+S7xpLn0R+qN4TmyKe
        e6RL7l4aWMNstAERqJtzkRw=
X-Google-Smtp-Source: APXvYqyecajgm+oWpK3P0WbUAVW3ldWDqy8/QBKpagphreZeSIqivw+c88aMbpIHn528OveKK7/n2g==
X-Received: by 2002:a17:90a:9f04:: with SMTP id n4mr363732pjp.76.1580314155804;
        Wed, 29 Jan 2020 08:09:15 -0800 (PST)
Received: from localhost.localdomain ([146.196.37.139])
        by smtp.googlemail.com with ESMTPSA id 73sm3258801pgc.13.2020.01.29.08.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 08:09:15 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH 2/2] events: callchain: Use RCU API to access RCU pointer
Date:   Wed, 29 Jan 2020 21:38:13 +0530
Message-Id: <20200129160813.14263-2-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129160813.14263-1-frextrite@gmail.com>
References: <20200129160813.14263-1-frextrite@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

callchain_cpus_entries is annotated as an RCU pointer.
Hence rcu_dereference_protected or similar RCU API is
required to dereference the pointer.

This fixes the following sparse warning
kernel/events/callchain.c:65:17: warning: incorrect type in assignment

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 kernel/events/callchain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index f91e1f41d25d..a672d02a1b3a 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -62,7 +62,8 @@ static void release_callchain_buffers(void)
 {
 	struct callchain_cpus_entries *entries;
 
-	entries = callchain_cpus_entries;
+	entries = rcu_dereference_protected(callchain_cpus_entries,
+					    lockdep_is_held(&callchain_mutex));
 	RCU_INIT_POINTER(callchain_cpus_entries, NULL);
 	call_rcu(&entries->rcu_head, release_callchain_buffers_rcu);
 }
-- 
2.24.1

