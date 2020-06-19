Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54A0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:36:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 823A2207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="MNCqe6WD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730490AbgFSBgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 21:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgFSBgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 21:36:49 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394E0C0613EF
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 18:36:49 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id g11so3754534qvs.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 18:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ILh8pXdwwkspY2rtatfl7bOAa7tRdkNG/ybhL3LfCEw=;
        b=MNCqe6WDs6hqVevKhLr65JJFpohkYO64QOEoOs66C466QTc3u/2d2TGmhYZUy4rMbx
         ao6sobWJTBfmifm0NGW+X1qpCPvEYB/qGUeuI7s9vM+j3JnlGP/UPEuerUsFGQZYDXWQ
         5yto/AIVPwdTsuFxEI5npzayD9VBfE2ebrw5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ILh8pXdwwkspY2rtatfl7bOAa7tRdkNG/ybhL3LfCEw=;
        b=ltawJxr1sFPtRaNE1HYaaXNVgwzedCNj0Zni9Xh8F/1TNul+PKjmNSfAtcaP0wPl2t
         ugF2urTMZ/v+Bs4vCgqxbVUPGJKytOFLAv5oTkwC3S5OBk509uJ1MjQ2nrZJAURxuyIF
         P51/MOjqDG/m5pEH6Pj/V3TKFH/Kcrmu7NzgRM3V0icWmwPES1MlpUhFdiLvwMiMrtfn
         WK+re63OpOGsHUcrkk7UvaA8P/snLOw7wVBGIR71KTCdWv/AcwhWIBQ0PxGbOJXED4Sz
         ZbJ3LuC19ZdacvbJfP1s3qIqIWMv4XU4UQeKezRq8pY6Vhtc6t7NK2AcdmxkfoGfl8pY
         EeMg==
X-Gm-Message-State: AOAM531yE+VlyPaVA+rTXuko9zZxAT6GUcHug8EU8gt3gAIxXo9rbxXu
        AjwsfgM6eRhpS/EGqRUtUhyv4v2cBm4=
X-Google-Smtp-Source: ABdhPJyL5oV0nisqpEMa7x4yK6mlKgt+tr8VxTyV4nQ2v0py/S44mbukzukRo2Ay4yWJSyF+jrpz6A==
X-Received: by 2002:a05:6214:13e6:: with SMTP id ch6mr6559466qvb.29.1592530608139;
        Thu, 18 Jun 2020 18:36:48 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id s15sm5379570qtc.95.2020.06.18.18.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 18:36:47 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: [PATCH 2/3] rcu/trace: Use gp_seq_req in acceleration's rcu_grace_period tracepoint
Date:   Thu, 18 Jun 2020 21:36:40 -0400
Message-Id: <20200619013641.63453-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
In-Reply-To: <20200619013641.63453-1-joel@joelfernandes.org>
References: <20200619013641.63453-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During acceleration of CB, the rsp's gp_seq is rcu_seq_snap'd. This is
the value used for acceleration - it is the value of gp_seq at which it
is safe the execute all callbacks in the callback list.

The rdp's gp_seq is not very useful for this scenario. Make
rcu_grace_period report the gp_seq_req instead as it allows one to
reason about how the acceleration works.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/tree.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9ef68dd249e1d..d0988a1c1079d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1464,9 +1464,10 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 
 	/* Trace depending on how much we were able to accelerate. */
 	if (rcu_segcblist_restempty(&rdp->cblist, RCU_WAIT_TAIL))
-		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("AccWaitCB"));
+		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccWaitCB"));
 	else
-		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("AccReadyCB"));
+		trace_rcu_grace_period(rcu_state.name, gp_seq_req, TPS("AccReadyCB"));
+
 	return ret;
 }
 
-- 
2.27.0.111.gc72c7da667-goog

