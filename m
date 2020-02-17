Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3700C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 20:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973DC20801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 20:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PECHai2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729764AbgBQUsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 15:48:09 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35177 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727300AbgBQUsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 15:48:08 -0500
Received: by mail-wr1-f68.google.com with SMTP id w12so21361295wrt.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 12:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=b1AIhMcP1KCe9+gTJebHWLZChVXuNqWcSJ6LImoJF60=;
        b=PECHai2jftiXH4Ct3muC6pR25gSon6pcfV7TAS2Z7pp9bCJwJT/5cG3PF3tSUZq8Zj
         sm+6dwwUV0NFw2JTCJGP/niNv7xahkKPgYvikoMcAcHQ1C7x1YVBmLUVai6gwhpnwnDb
         +3O1xpXlQ0Dhy6pS8f7LV3Se8QWuUo0HiMI/cEP8l39po6JTUPWZunOk4oMRyYjZ7H97
         /J7ZeDotVMP+1oyd3PX+rNTUwAVzB8JdiVO2Zo0k0KHG9WXLNGLkQlgh78EKZBMxbMA1
         JQdaQtQ8rnPa1C8EFST16v75A2sX2aMbhaey3W8b9U+SezGxsZNYlJcDGD1YENvkyJM2
         EVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=b1AIhMcP1KCe9+gTJebHWLZChVXuNqWcSJ6LImoJF60=;
        b=YtOVGJVyqPqZznb/EscZ9IF00+J0N0qwJy5kQ+NTpdQxYDX0wcb7VWc0bXhis8CAOV
         GkpxAnvxFIyhIW7BbuxEVc/3G8Jxrte4mYJ+gi5YIl4Crg2aD9dHMDUxkXZd/YhsonTd
         GEb0kmhBE6+9Md4ZaKEwKTPDm+5KJZOrsYWW2eF/W/GceDQ3bjVhBYCJE0M5RIqOO6VI
         ouNDJfa628iM+owk0LRzKIiL7/IhvvfFaZITpXkzH5ggNEKk34BzHQYxaW4+a5JQk/PY
         uhN8veSFB6w6HswbyDictJG7oQnp4LlDO1cAlvKQV+hkFcQmozW6YClTeRNNmgb++4yp
         4PWQ==
X-Gm-Message-State: APjAAAUCZJc1i3MGyHmhpTE06ZXP2lJf0DOALdCJCGR8j4myPY3jtJWg
        +JvrJrWOXwFNr97nY7mAFUQ/TKPz
X-Google-Smtp-Source: APXvYqxt/+Jle2DOUraVfOy8NH80vXlVV3sNuFL58eSY+iLJklK4wAvuTElg71TKCsmXIFms2YxNbA==
X-Received: by 2002:adf:f581:: with SMTP id f1mr24240727wro.264.1581972485597;
        Mon, 17 Feb 2020 12:48:05 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id e1sm2698377wrt.84.2020.02.17.12.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 12:48:05 -0800 (PST)
Date:   Mon, 17 Feb 2020 21:48:03 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     tj@kernel.org, jiangshanlai@gmail.com, will@kernel.org,
        mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: WARNING: at kernel/workqueue.c:1473 __queue_work+0x3b8/0x3d0
Message-ID: <20200217204803.GA13479@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

When running some CI test jobs (targeting crypto tests), I always get the following WARNING:
[    7.886361] ------------[ cut here ]------------
[    7.886388] WARNING: CPU: 2 PID: 147 at kernel/workqueue.c:1473 __queue_work+0x3b8/0x3d0
[    7.886394] Modules linked in: ghash_generic
[    7.886409] CPU: 2 PID: 147 Comm: modprobe Not tainted 5.6.0-rc1-next-20200214-00068-g166c9264f0b1-dirty #545
[    7.886414] Hardware name: Pine H64 model A (DT)
[    7.886422] pstate: a0000085 (NzCv daIf -PAN -UAO)
[    7.886429] pc : __queue_work+0x3b8/0x3d0
[    7.886436] lr : __queue_work+0x1dc/0x3d0
[    7.886440] sp : ffff800012073b50
[    7.886445] x29: ffff800012073b50 x28: ffff8000117bb590 
[    7.886452] x27: 0000000000000100 x26: ffff80001132d018 
[    7.886460] x25: ffff800011336d58 x24: ffff800011629920 
[    7.886467] x23: ffff80001132d018 x22: 000000000000000e 
[    7.886474] x21: 0000000000000002 x20: ffff0000b9c08000 
[    7.886481] x19: ffff0000bd9b8400 x18: 0000000000000000 
[    7.886488] x17: 0000000000000000 x16: 0000000000000000 
[    7.886495] x15: 0000af8c526b5c68 x14: 02be881212d8d480 
[    7.886503] x13: 0000000000000352 x12: 0000000000000001 
[    7.886510] x11: 0000000000000400 x10: 0000000000000040 
[    7.886517] x9 : ffff80001163f5e8 x8 : ffff80001163f5e0 
[    7.886524] x7 : ffff0000b9800028 x6 : 0000000000000000 
[    7.886531] x5 : ffff0000b9800000 x4 : 0000000000000000 
[    7.886538] x3 : ffff0000bd9b4800 x2 : 0000000000000001 
[    7.886545] x1 : 0000000000000000 x0 : ffff8000117bb598 
[    7.886552] Call trace:
[    7.886560]  __queue_work+0x3b8/0x3d0
[    7.886567]  queue_work_on+0x6c/0x90
[    7.886576]  do_init_module+0x188/0x1f0
[    7.886582]  load_module+0x1d00/0x22b0
[    7.886589]  __do_sys_finit_module+0xd0/0xe8
[    7.886595]  __arm64_sys_finit_module+0x1c/0x28
[    7.886605]  el0_svc_common.constprop.0+0x68/0x160
[    7.886613]  do_el0_svc+0x20/0x80
[    7.886621]  el0_sync_handler+0x10c/0x180
[    7.886627]  el0_sync+0x140/0x180
[    7.886638] ---[ end trace a44615ff285cb96c ]---
[    7.886643] WARN for events

For finding what was cause this, I have added the following debug:
@@ -1468,8 +1470,10 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
        /* pwq determined, queue */
        trace_workqueue_queue_work(req_cpu, pwq, work);
 
-       if (WARN_ON(!list_empty(&work->entry)))
+       if (WARN_ON(!list_empty(&work->entry))) {
+               pr_err("WARN for %s\n", wq->name);
                goto out;
+       }

So it seems that it is a "events" workqueue that hit this problem.

Note that classic defconfig do not hit this problem, since it appears with the following config change:
-CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
+# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
+CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y

I dont see any relation between crypto and this problem, but this problem with this config change is reproductible.

Regards
