Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88825C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5900B2076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="NRc8n7wi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgHKOZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgHKOZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:25:24 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CDBC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 07:25:24 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id kr4so1956239pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 07:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=itvwqamowYKSWXHmIO66m7ty93TbnAYlAALNwX1hIo0=;
        b=NRc8n7wiKqfGGpakRuEs2l72W8wBI/Wa4ogBcV1mjD7/7xtMFnrRqA/WRUXc0et7lM
         /TU9C75fLSVmSpsD9qVaYlOib7OBaDLyKhBr/8DcfFyX5zJucO8rXCvwE57HELuxMqd6
         gGOILwXnyXEGSzojqmAMVGjtE7SwtRjB5Sc5RP/XVpNy8M7qUmNF3FgaMqwOkn6eK6zj
         lbH3ts91HQ1c6Icr++7DJUDr+aUqwRfifZ/SNwIYO1Alys2TujxPlfCx2iQXE7DME82k
         zkNeeArQm/fBu6fpXZ5EesR+b41uLOKLITS5xi7AuLcc5hABddL3HJH4P6pDc5QXo1TJ
         GWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=itvwqamowYKSWXHmIO66m7ty93TbnAYlAALNwX1hIo0=;
        b=lwZvXiDteI1pxq4U+YkUlI686FufKviku+wjF+c62zMxAHJ4RsdjcFAgp3fyPuWsrg
         3C3E86ZeXzcRF/TeIzyX2QA/NqZuE9NX3+Kv5fSarOedQ2Z/B+ah/qwn3HjNfYE9epU8
         daaX5mjrhkNJ0T9Sm0iPuS0UrHui63vdgrVWA6tGm4nok/waB2Z1efXulGPkOmVkfgp+
         2MzXwVmr0YlUzuiEZTJVvVyiMVOLZM840x1K8lp4fAXUYSJxWL1sB7T9X6BzqDXcxDJW
         ataaik/+Ltky6zGagPJ62HoiyC7eCDOiCkp1PbFSWWd+eWIDHEjsTmqWCYD6U4Q1k1AS
         LZGQ==
X-Gm-Message-State: AOAM533BAxPlbDyLsxVEshsdBAwU/BhY8x1ZgtAKnS2Z7YIgMDujr8t3
        Ql6zDbcld+AWjj1kaSyBRMEh5g==
X-Google-Smtp-Source: ABdhPJzPNpLjfLwYEug1Fkr8vc7qD8wdOGvwnuUUEAL8Z+36OIDjms7IFfMwsOhmEpLGL/XaEDPmFg==
X-Received: by 2002:a17:90b:148b:: with SMTP id js11mr1422477pjb.234.1597155922658;
        Tue, 11 Aug 2020 07:25:22 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id a199sm22429346pfa.201.2020.08.11.07.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 07:25:22 -0700 (PDT)
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] task_work: only grab task signal lock when needed
Message-ID: <0028d3ea-4d05-405f-b457-75c83d381d89@kernel.dk>
Date:   Tue, 11 Aug 2020 08:25:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If JOBCTL_TASK_WORK is already set on the targeted task, then we need
not go through {lock,unlock}_task_sighand() to set it again and queue
a signal wakeup. This is safe as we're checking it _after adding the
new task_work with cmpxchg().

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

Tested this with an intensive task_work based io_uring workload, and
the benefits are quite large.

diff --git a/kernel/task_work.c b/kernel/task_work.c
index 5c0848ca1287..cbf8cab6e864 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -42,7 +42,8 @@ task_work_add(struct task_struct *task, struct callback_head *work, int notify)
 		set_notify_resume(task);
 		break;
 	case TWA_SIGNAL:
-		if (lock_task_sighand(task, &flags)) {
+		if (!(READ_ONCE(task->jobctl) & JOBCTL_TASK_WORK) &&
+		    lock_task_sighand(task, &flags)) {
 			task->jobctl |= JOBCTL_TASK_WORK;
 			signal_wake_up(task, 0);
 			unlock_task_sighand(task, &flags);
-- 
Jens Axboe

