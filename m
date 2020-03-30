Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E70C2D0ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A0C3208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 02:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="VI/qIKph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgC3CeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 22:34:09 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44082 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729172AbgC3Cdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 22:33:47 -0400
Received: by mail-qt1-f196.google.com with SMTP id x16so13920678qts.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 19:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b0k3soKURyDBh9v099L9R8zvO5sOH/jeMANg/8/7Rzk=;
        b=VI/qIKphu5cG5RcFKyvsw3jMUdxJoZtgoDsGaptYl1UYTimCaWzYL9uhYPDg//wONL
         j9zq93V+5DBwWreZj901i//u1yxPIc8rSnuWwcdNbo5eKT7SZpcjCpou5Xtv81k7qB4B
         po3VX9PxBTGTPCmy4N8gkdA6AFQrXHt7/UOg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b0k3soKURyDBh9v099L9R8zvO5sOH/jeMANg/8/7Rzk=;
        b=dmg2FAqWpJXEytPRWZs2t1OJkk/ygixbKIxT09d/l5TrgvPMcIgHB4mf7jdQCdTxr9
         sdOZTVuJ0HCJ7djXh90oCw1u35LBX2zyrPp4CQitDhHQhqf+SIZW1HEJrn2LwTrQ6Vd2
         /Y2GXinHQDbxfYLmUbubMP3p6/qerFkoZTFMeE3PSl27Ae9LvSlsnzKlNh+D07dCDIgO
         UOCCNdgTbcqYqWYQXoq1aQP8ltqQbtF4rPLuRzerR11YTaJj371T8EaX4G4qZe/2Z4TO
         /5pbA7peAm9BGYdbiIR6G6DN8o4WyTF2puykA6epGHlYKP6NudylFpbnvg/ureGFWQGl
         JQDg==
X-Gm-Message-State: ANhLgQ0kpK/n04Wiplz1u+Z/5GjgtqdldLOiiVMSZcmC78++nHgZ5oNk
        BTKc0FRri+QSz0dwhllEMMe2CGgWZYg=
X-Google-Smtp-Source: ADFU+vtXYlMnNTXa8HH2h/iQhtZELpahx663+F4vLVBBsB/DDJ77YfhvA5Xkfej8EvFPpXiZ+guw3A==
X-Received: by 2002:aed:24c2:: with SMTP id u2mr9893436qtc.269.1585535624468;
        Sun, 29 Mar 2020 19:33:44 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q15sm10030625qtj.83.2020.03.29.19.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 19:33:44 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 13/18] rcu/tiny: Move kvfree_call_rcu() out of header
Date:   Sun, 29 Mar 2020 22:32:43 -0400
Message-Id: <20200330023248.164994-14-joel@joelfernandes.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200330023248.164994-1-joel@joelfernandes.org>
References: <20200330023248.164994-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>

Move inlined kvfree_call_rcu() function out of the
header file. This step is a preparation for head-lees
support.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/rcutiny.h | 6 +-----
 kernel/rcu/tiny.c       | 6 ++++++
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 5ba0bcb231976..19a780afa444a 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -34,11 +34,7 @@ static inline void synchronize_rcu_expedited(void)
 	synchronize_rcu();
 }
 
-static inline void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
-{
-	call_rcu(head, func);
-}
-
+void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
 void rcu_qs(void);
 
 static inline void rcu_softirq_qs(void)
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index aa897c3f2e92c..508c82faa45c3 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -177,6 +177,12 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
+void kvfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
+{
+	call_rcu(head, func);
+}
+EXPORT_SYMBOL_GPL(kvfree_call_rcu);
+
 void __init rcu_init(void)
 {
 	open_softirq(RCU_SOFTIRQ, rcu_process_callbacks);
-- 
2.26.0.rc2.310.g2932bb562d-goog

