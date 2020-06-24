Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53C5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EDE720706
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AiRV5H39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404400AbgFXPod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404187AbgFXPoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:44:32 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926D5C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:44:32 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so2762227wrc.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=SE0p5yCntbHLxajveJ/3xidAqYZlUe0dqIonH/NYsTo=;
        b=AiRV5H39bO2eHiz1hKC7aI5kK4LSRqCTDajZ/KIz10GTnMeDYdSHF8d6Qlxk5ODYko
         p3xPOdRIHGbBFe7AwylFWgfZ766bMLhDZlkDPYHQRtjdsV4hF04HhNy6Ivi/BkfcNXnm
         mECmBHMX9HKrr+suhQvaRYWEVhUfyPbxicHxf8NHpOH9snlqF8WsVgNYB86A/BC1t9xh
         xZ7ceUQ0Tyxji3fxl3iGFc2lSFMZzu2xpcC6t2PWhBMnHuQOj4y2Z58PV3bwYBC6P7bu
         V9WOlfaXxPRZz+Yf2cUAyGEHRgnQKKI5IA6UwkjX2m6IDUDEF/093mkqPfryJbZukzOD
         jPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SE0p5yCntbHLxajveJ/3xidAqYZlUe0dqIonH/NYsTo=;
        b=KKT8bFXThNZ5f7tX8JT1tP0UFLd3WiMt2JlDhlWLETCVpHp1UAsn9U63PFjumXBJ1m
         xASZtZYstzhs9kqqD2CFOHm2YhogQZHHQUdrykomKH+LnE4VbIOZa9dL8sAD74ZjUVLi
         qFutPRqOUy0JjNCfTlljld4RkQQbSbaPvuwzDOJJ7i3c6NcFBToL2HUciWLYQILsQM3V
         KGExqnAAT/Lwy7HMDc/l/dDeBdPWSTMIPrJRKjnhnmtblJmaEYkf11zXvnHKA8hR5VDW
         CzHsRVkaX/t4q7D/UxDq/8kIgjDa/wgJ8BQWkeDlA1pvBSTjAE/wkR38Iqf1Fo5xTVLJ
         PC1w==
X-Gm-Message-State: AOAM532aOM4EVe/HSMYRvImhS54xR//HkPI00yBslfrxxvTFrxWpE0mc
        wf5i8OfD3qBAP9K66IUjwXw+Wg==
X-Google-Smtp-Source: ABdhPJw/07poY7dVOm3UC5HXMgoyhCu3QXc/QqotRwi+VYJMtlWq9BrwCzYenUIdL9yxrPoSxdtjoQ==
X-Received: by 2002:a5d:6986:: with SMTP id g6mr32525873wru.27.1593013471172;
        Wed, 24 Jun 2020 08:44:31 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:81b5:a82d:69e7:f32e])
        by smtp.gmail.com with ESMTPSA id v11sm9844301wmb.3.2020.06.24.08.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:44:30 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        rong.a.chen@intel.com
Cc:     valentin.schneider@arm.com, pauld@redhat.com, hdanton@sina.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/cfs: change initial value of runnable_avg
Date:   Wed, 24 Jun 2020 17:44:22 +0200
Message-Id: <20200624154422.29166-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some performance regression on reaim benchmark have been raised with
  commit 070f5e860ee2 ("sched/fair: Take into account runnable_avg to classify group")

The problem comes from the init value of runnable_avg which is initialized
with max value. This can be a problem if the newly forked task is finally
a short task because the group of CPUs is wrongly set to overloaded and
tasks are pulled less agressively.

Set initial value of runnable_avg equals to util_avg to reflect that there
is no waiting time so far.

Fixes: 070f5e860ee2 ("sched/fair: Take into account runnable_avg to classify group")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0424a0af5f87..45e467bf42fc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -806,7 +806,7 @@ void post_init_entity_util_avg(struct task_struct *p)
 		}
 	}
 
-	sa->runnable_avg = cpu_scale;
+	sa->runnable_avg = sa->util_avg;
 
 	if (p->sched_class != &fair_sched_class) {
 		/*
-- 
2.17.1

