Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E95C3B19F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE8E2187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rdWN8Lwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394105AbgBNQpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:45:12 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37774 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389082AbgBNQpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:45:09 -0500
Received: by mail-pj1-f68.google.com with SMTP id m13so4162708pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 08:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CPoNQ+Sf1fHspzF09NwteMM4WEWx0QsGsv6flTB39KM=;
        b=rdWN8LwnE+yDBw0Yxnm8NrLJssyO0EPhZNDWZzVwZO3XCtHtou5Zh6h6hWv9EeCVTm
         NpQHMImVRfOWB+7cIlNmX3PVT70LSzerCvNl2ceieb0MbKTzz5+oVv3w0AxQ149colJu
         j2bV8cnIygPKg25FmMzM7VE31g2FdG6sf+UcF9ZnDO0+O9TM3/BKCO+zYpkYh1EeTSf4
         kKruPVlp0XUX0WvUoMHQCtrahnz0rjYUMU6YIyMQcdY2aGcdIJb+CvwJqVLGYBIF4nCj
         U298WiHSPB/vWH9hYfwXSm8IIndleNTKsUe/kbwAeOWybMbhwe9z8ls91081fzWjMTVe
         1xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CPoNQ+Sf1fHspzF09NwteMM4WEWx0QsGsv6flTB39KM=;
        b=K21GSiM6/B0kGTGww6a449hCKmzFcHRyf5E1yXZToYDpyr964VNbNgKgHot7K55grW
         AeKUl5k5ZS4+3MO/dZ/qrbBAby3PbR8M4/0ZZqrndgvmKByd0POtJwNRoZEm2tr1RknN
         XnbonI2pMXGyYxylOxcT7Cu0xs23rMSX0lxYzYamtM4NAxE95NtuMzt9TTJgB7huVIQ+
         F3Cqnc3/Ku4mltAKP1emGZeCmyyvSlRx356R8KA0KJpV1jC4f+FKDWjO9GxkSY8eDSEP
         WEzNN3UZbIE7I+834FIHSeUWMFrn7ijRhuhiH7xbqAzaO5iRf+Oh0C0Sk5lFcLGLm8Fk
         gaNw==
X-Gm-Message-State: APjAAAUjLkqg1rhZi9f3dbLUcxTFPnrR/qBoXgTGdjowWwOJEny7k27i
        B07BlOHuq/+XKwVkm+2nzQ==
X-Google-Smtp-Source: APXvYqxge33YQRmBtTCmBNT7WE1SwgFIMCYS29+b4FN3wZu5vaLM1r03WPyC7m/WSeA+ON98qNlyjw==
X-Received: by 2002:a17:90a:102:: with SMTP id b2mr4673412pjb.64.1581698708825;
        Fri, 14 Feb 2020 08:45:08 -0800 (PST)
Received: from madhuparna-HP-Notebook.nitk.ac.in ([2409:4071:2305:77c6:fc5b:5bfd:1ab4:4848])
        by smtp.gmail.com with ESMTPSA id 200sm7474682pfz.121.2020.02.14.08.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 08:45:08 -0800 (PST)
From:   madhuparnabhowmik10@gmail.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, namhyung@kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        joel@joelfernandes.org, frextrite@gmail.com,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Subject: [PATCH RESEND] events:core.c: Use built-in RCU list checking
Date:   Fri, 14 Feb 2020 22:14:54 +0530
Message-Id: <20200214164454.19942-1-madhuparnabhowmik10@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

list_for_each_entry_rcu has built-in RCU and lock checking.

Pass cond argument to list_for_each_entry_rcu() to silence
false lockdep warning when CONFIG_PROVE_RCU_LIST is enabled
by default.

Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4ff86d57f9e5..04d28f3eb8df 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -3760,7 +3760,8 @@ static void perf_adjust_freq_unthr_context(struct perf_event_context *ctx,
 	raw_spin_lock(&ctx->lock);
 	perf_pmu_disable(ctx->pmu);
 
-	list_for_each_entry_rcu(event, &ctx->event_list, event_entry) {
+	list_for_each_entry_rcu(event, &ctx->event_list, event_entry,
+				lockdep_is_held(&ctx->lock)) {
 		if (event->state != PERF_EVENT_STATE_ACTIVE)
 			continue;
 
-- 
2.17.1

