Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB7EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 267B1206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 15:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="p4hMlBB0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729598AbgEZPig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 11:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728166AbgEZPif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 11:38:35 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13328C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:38:35 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id v63so10321005pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 08:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=cBqLiNjEy/ndkkWAzP7wodRHpLsltvVBRQYb+tSQCo0=;
        b=p4hMlBB0H7JmlDM03HCCMv+Cuzzv1QOYRz9S5LqAMjewzZqYRioAjQZFApZweJYITN
         pn8tOI2xBvC8QrzWJPQOkrpFhfJgDnRad/xCaJlN5Jo2PXNLnl987tffXDuoygRjA0ff
         aC9a0hn8DJULoaGvm9YIGD2cqF8FSvOb3vNTNY5pipvDz1GS+IMwaLpq3Ingyt4cunc/
         e60na6ewW70iWtyXouwaksqwipObz2mHaQI76T3dQSRTNL8yoc89/4Ild2XCMFjj4CDL
         utDuKt3U78HBIS53Rr8uBiZ1HGvJ2zomC1xg6Hzl/nmjA4Es8Z0Crcy08Xxt7fWDcgxk
         Rdog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=cBqLiNjEy/ndkkWAzP7wodRHpLsltvVBRQYb+tSQCo0=;
        b=L0nqdkXk7VL+9N3dikDYbvxSiUn8+74JrqsVALAzi2fMt+OESq3oh4d/cedR5LIk28
         BzvI6rl0t/cHPEXJ4ekTaaVBW0J3Rk7elD3ldxDwKxKSsVoIqS5kWKj3yrpFhVQg4Jiz
         60LMY4CBA3Vko0BZ20LpAQzXKYCOd3/Ryxhgu+unIR34YEftHjAJ17hS7CwYZ+hDzX8j
         4WEY6CaIFob9Kj7tAl9KMRCg0arSyEJpsU2DRgoTq/e40ubvwaZIilY1wpDkYEYq2Ej+
         Xd3k5XJQl6/UEpQ2GDuPNzSmffYm/Nc+Mu70bBoNac2KavdeTKxR9+BFTgYCreTS0wUi
         n44A==
X-Gm-Message-State: AOAM531tbBFiqmf8LERbrgL/rPIABMY71fFlX13bjhwESrj/+/kC7ehm
        ojfYIeSGQLoOvQIXna6ya9gK8Q==
X-Google-Smtp-Source: ABdhPJyDV0bp8kPx5+PI22yaoTjJ4D2uPUYqtIeyoyOOBo+kcjefiwlWpGTvEU/oAsONPYisH0ebJA==
X-Received: by 2002:a63:5024:: with SMTP id e36mr1548018pgb.438.1590507514387;
        Tue, 26 May 2020 08:38:34 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:8c61:6089:741f:7021:9aaf? ([2605:e000:100e:8c61:6089:741f:7021:9aaf])
        by smtp.gmail.com with ESMTPSA id r34sm93744pgl.38.2020.05.26.08.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 08:38:33 -0700 (PDT)
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefano Garzarella <sgarzare@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] sched/fair: don't NUMA balance for kthreads
Message-ID: <865de121-8190-5d30-ece5-3b097dc74431@kernel.dk>
Date:   Tue, 26 May 2020 09:38:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stefano reported a crash with using SQPOLL with io_uring:

BUG: kernel NULL pointer dereference, address: 00000000000003b0
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 800000046c042067 P4D 800000046c042067 PUD 461fcf067 PMD 0 
Oops: 0000 [#1] SMP PTI
CPU: 2 PID: 1307 Comm: io_uring-sq Not tainted 5.7.0-rc7 #11
Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS 1.2.6 06/08/2015
RIP: 0010:task_numa_work+0x4f/0x2c0
Code: 18 4c 8b 25 e3 f0 8e 01 49 8b 9f 00 08 00 00 4d 8b af c8 00 00 00 49 39 c7 0f 85 e8 01 00 00 48 89 6d 00 41 f6 47 24 04 75 67 <48> 8b ab b0 03 00 00 48 85 ed 75 16 8b 3d 6f 68 94 01 e8 aa fb 04
RSP: 0018:ffffaaa98415be10 EFLAGS: 00010246
RAX: ffff953ee36b8000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000001 RSI: ffff953ee36b8000 RDI: ffff953ee36b8dc8
RBP: ffff953ee36b8dc8 R08: 00000000001200db R09: ffff9542e3ad2e08
R10: ffff9542ecd20070 R11: 0000000000000000 R12: 00000000fffca35b
R13: 000000012a06a949 R14: ffff9542e3ad2c00 R15: ffff953ee36b8000
FS:  0000000000000000(0000) GS:ffff953eefc40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000000003b0 CR3: 000000046bbd0002 CR4: 00000000001606e0
Call Trace:
 task_work_run+0x68/0xa0
 io_sq_thread+0x252/0x3d0
 ? finish_wait+0x80/0x80
 kthread+0xf9/0x130
 ? __ia32_sys_io_uring_enter+0x370/0x370
 ? kthread_park+0x90/0x90
 ret_from_fork+0x35/0x40

which is task_numa_work() oopsing on current->mm being NULL. The task
work is queued by task_tick_numa(), which checks if current->mm is NULL
at the time of the call. But this state isn't necessarily persistent,
if the kthread is using use_mm() to temporarily adopt the mm of a task.

Change the task_tick_numa() check to exclude kernel threads in general,
as it doesn't make sense to attempt ot balance for kthreads anyway.

Reported-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

This should go into 5.7 imho

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 02f323b85b6d..403556fc16d4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2908,7 +2908,7 @@ static void task_tick_numa(struct rq *rq, struct task_struct *curr)
 	/*
 	 * We don't care about NUMA placement if we don't have memory.
 	 */
-	if (!curr->mm || (curr->flags & PF_EXITING) || work->next != work)
+	if ((curr->flags & (PF_EXITING | PF_KTHREAD)) || work->next != work)
 		return;
 
 	/*

-- 
Jens Axboe

