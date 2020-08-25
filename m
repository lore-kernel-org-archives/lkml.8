Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCE8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AB96204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MVMfwOZV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgHYCs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgHYCsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:48:51 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD9DC0613ED
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 19:48:51 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id z3so5436977qkz.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 19:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZysaSI5yV1FqGvE2KQYGBQnhBGkYceVPyQn+o+Qr/5I=;
        b=MVMfwOZVJRqlGMMh58yzJyBWm78A8XbSB1PnLgjpi6Uv+IuvP5FjtWbuhI2F+5wsAw
         RvwY+GPvSannr0L3tJ9zPnHqzagYfT6EdR5SgqPRSy1DUHgl3I6D5IRyhxWI9/FAS5KN
         0+vSF/cF+91qLlqySeDrydVFY91sPlnwivK10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZysaSI5yV1FqGvE2KQYGBQnhBGkYceVPyQn+o+Qr/5I=;
        b=IifNZBbt7klAaA3r204Xqwx+1dNsYKI6pxOWCAgRUVoFsBcjqG8BEBTCsMA1uxNRuE
         DtIrCdcZfjwE5HT4F/F9WLb1vJ7sV5WUPNL0YRBtNw6ieFV8H04NJiaOWywMp3Rck9DM
         IIkhby0IAfaqxk9DcJbwg8pxsyMr9IaHGc8EWYPTOSYi0RJKLS1OfcZPjVB4UlXQuq9l
         KX3O10nSKOqx8/c68Ryu10L/ePl5fHQzH7h/NdGd/7l46ZMkU2ZFxgsRnCGRBs4kLxOe
         F6ueoEGJ3aCsSYYs4lktcF2N3InqMAUs9v+RD5QS4hbBbTUjkzBL6rPeheotup/SLht5
         dHFg==
X-Gm-Message-State: AOAM532q7RHc+8RjDqTvcsmflipv+FDG0qAXMQOU/+Ns4u9CBq0Oi7W7
        4jeu2z0j/DHNeSCbo4B6yOoBA7BE0N18Ag==
X-Google-Smtp-Source: ABdhPJwfWA7ZYbRJz/2t6AMGiMRL04UCzNl4aWt1ng8pH8/SsOtQNWt5k8Hhj03GrNJCWp5+fdmj+g==
X-Received: by 2002:a37:afc4:: with SMTP id y187mr7762698qke.285.1598323730619;
        Mon, 24 Aug 2020 19:48:50 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id n14sm2159188qtk.50.2020.08.24.19.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 19:48:50 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        boqun.feng@gmail.com, dave@stgolabs.net,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        neeraj.iitr10@gmail.com, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, vineethrp@gmail.com
Subject: [PATCH v4 -rcu 1/4] rcu/segcblist: Do not depend on rcl->len to store the segcb len during merge
Date:   Mon, 24 Aug 2020 22:48:39 -0400
Message-Id: <20200825024842.3408659-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
In-Reply-To: <20200825024842.3408659-1-joel@joelfernandes.org>
References: <20200825024842.3408659-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The donecbs's ->len field is used to store the total count of the segmented
callback list's length. This ->len field is then added to the destination segcb
list.

However, this presents a problem for per-segment length counting which is added
in a future patch. This future patch sets the rcl->len field as we move
segments of callbacks between source and destination lists, thus becoming
incompatible with the donecb's ->len field.

This commit therefore avoids depending on the ->len field in this way. IMHO,
this is also less error-prone and is more accurate - the donecb's ->len field
should be the length of the done segment and not just used as a temporarily
variable.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcu_segcblist.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 2d2a6b6b9dfb..b70d4154433c 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -513,14 +513,18 @@ void rcu_segcblist_merge(struct rcu_segcblist *dst_rsclp,
 {
 	struct rcu_cblist donecbs;
 	struct rcu_cblist pendcbs;
+	long src_len;
 
 	rcu_cblist_init(&donecbs);
 	rcu_cblist_init(&pendcbs);
-	rcu_segcblist_extract_count(src_rsclp, &donecbs);
+
+	src_len = rcu_segcblist_xchg_len(src_rsclp, 0);
 	rcu_segcblist_extract_done_cbs(src_rsclp, &donecbs);
 	rcu_segcblist_extract_pend_cbs(src_rsclp, &pendcbs);
-	rcu_segcblist_insert_count(dst_rsclp, &donecbs);
+
+	rcu_segcblist_add_len(dst_rsclp, src_len);
 	rcu_segcblist_insert_done_cbs(dst_rsclp, &donecbs);
 	rcu_segcblist_insert_pend_cbs(dst_rsclp, &pendcbs);
+
 	rcu_segcblist_init(src_rsclp);
 }
-- 
2.28.0.297.g1956fa8f8d-goog

