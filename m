Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6ADC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:24:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327082072F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 21:24:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TW4b0hIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgC0VYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 17:24:31 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38006 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgC0VY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 17:24:27 -0400
Received: by mail-wr1-f68.google.com with SMTP id s1so13244938wrv.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 14:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H9z2b1vzlSf/N58DfrTHYz48txgfb47zhTeyBqYfVXc=;
        b=TW4b0hIGqEvGNtQ0U621TCRq+L09r6ti47QwaD8kglgKGG3/D3EHw+YwXn95H3G7Cv
         SYelRuedFoqpas5BTTqu7G2LjpntZNLUnhZ488FXj38A0mNXltfijN/zRYEeBVdltKN2
         LzFVMek43lyF06Pg4RqNsxlGJdulf7HGQ9lpuzL85aOFc1WhFJH0yrM1xiAHF13n7AFA
         Ppcy49w3lgICD9EyIVl67SmE9kuHHWgrwQnXwKBE5tzJ7ILSZbj7o15yf1Y0e408Jl7T
         tAu3HPTuH6tEigAuaGRXNgBpq1oERCkspzQLfMs0CuEsGIF6CeZiMZWAGaYp3BZNo53A
         vJOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H9z2b1vzlSf/N58DfrTHYz48txgfb47zhTeyBqYfVXc=;
        b=So6JNmOfJNipttKVsI3esg+9YysWg18K767P5IdRMA/fYd4u+silfY4nu8SwqDrNdG
         hzz0g9L10/GIds6U1+8WxByMd/tweCB1/aChkKpcEN9PFVxihg59K58M2/OIQAqDVvI6
         tm3bReII1EfjZUdsxx3pwDwlAm+4NUii6AOycsy2Bn750hkI/QAOYLr1xG+mslZEwuZ7
         t21BI5lvdplRIf/QSAW3avifpgNgi2+CTPeTRq0zJRUIasP8ZtgrlOLpk4tmnQJP3zch
         EY174KwgysFP37OtVCe4Q5Aqxt/7adi2HWgFG6s8eJBIDXtJN5Vl8Oz8zxwp4FYsKiZt
         Q5SA==
X-Gm-Message-State: ANhLgQ3tlnVk9HEOYA+V4ChAWV0dZx3Rrl5+BmKBugj7Vzea/PDCbvRg
        2b3Q1vwGKFSS0Sl5e/q8jA==
X-Google-Smtp-Source: ADFU+vstSDLTxkQfwj4puHkAAIq6CyCdvMwUoCJFPD0cCrdCCKOES5iVn0cejQh881321Jkea0f8vw==
X-Received: by 2002:a5d:4e03:: with SMTP id p3mr1476977wrt.408.1585344264601;
        Fri, 27 Mar 2020 14:24:24 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-82-35.as13285.net. [92.23.82.35])
        by smtp.gmail.com with ESMTPSA id h132sm10215141wmf.18.2020.03.27.14.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 14:24:24 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     julia.lawall@lip6.fr
Cc:     boqun.feng@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
        Armijn Hemel <armijn@tjaldur.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Muchun Song <smuchun@gmail.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 05/10] softirq: Replace BUG() after if statement with BUG_ON
Date:   Fri, 27 Mar 2020 21:23:52 +0000
Message-Id: <20200327212358.5752-6-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327212358.5752-1-jbi.octave@gmail.com>
References: <0/10>
 <20200327212358.5752-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccinelle reports a warning tasklet_action_common()

WARNING: Use BUG_ON instead of if condition followed by BUG

To fix this, BUG() is replaced by BUG_ON() with the recommended suggestion

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/softirq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 0427a86743a4..8a8f6ea0ff0a 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -517,9 +517,8 @@ static void tasklet_action_common(struct softirq_action *a,
 
 		if (tasklet_trylock(t)) {
 			if (!atomic_read(&t->count)) {
-				if (!test_and_clear_bit(TASKLET_STATE_SCHED,
-							&t->state))
-					BUG();
+				BUG_ON(!test_and_clear_bit(TASKLET_STATE_SCHED,
+							   &t->state));
 				t->func(t->data);
 				tasklet_unlock(t);
 				continue;
-- 
2.25.1

