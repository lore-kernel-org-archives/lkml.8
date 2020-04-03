Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5745FC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A8D92073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Giy9dKRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403953AbgDCQGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:06:00 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55572 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728126AbgDCQF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:05:59 -0400
Received: by mail-wm1-f66.google.com with SMTP id r16so7672177wmg.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 09:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yWVsg2O9zhGalvGX+nmw8V2YWRG8uH/vlzv7kbC1wXg=;
        b=Giy9dKRukI/k1MEXbyHBkt7Gtq+lTH8dlYv4wvBwQui9J39u2LalbRxTH/XL4IeuE1
         WusY3MrDEjrStmwsREWrUZh9y0Sm0mlP9KBbPQXdVmFafQgf570zp70UuwGaFnXiZw4M
         V1f8JZv4BVZuR/7AJqdDrauhs1Hyy2RGGYKjcniJ1bmEDx3NhK1KBhXf2m8Sr2CqQs1R
         ZYElnSag05ex/GJ3wlbwI5CH9pOeB1ZaVMYo3/WJxqC3VhHFc6WNgWKdH3mvKGj+rmoW
         jOokU9C2kt9iA/p6SQvbemNnH4VWMWFPIMUKQPEmRh3jyWfdFNiAQhT6zvbEpXtdfPRK
         ZjIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yWVsg2O9zhGalvGX+nmw8V2YWRG8uH/vlzv7kbC1wXg=;
        b=BF7Vgx9m0VMOWgnAbpFkYn0na73f7DIS4xc/zG9XsHMqFO4uBX1CgNjraT04MYl1Rq
         VrjLhxakVemFAMj/+kuGTIr008vPT81QMDou1oiyEWBVEb5x/2hcs+uc0OoTyO9GT0UW
         XNs9cB6SJdsaei5rUVjHfHPbupidxU45xQU+T6+TtKMrM4bH23BDPD+l0HXQmm9k6y4r
         zKsYjLvS1SM1cTbirGmgZm1wGa3K8LSb9XBq/a0aD44G77aXKCuRNrf+dC1KJRnxl19Z
         7rZKoGFbyO1wKsqZA5Umu4PX67DqGq4M+VOUIUe6Bcbh+76ZQf+uytwh54lfy0WG4IVa
         bQgw==
X-Gm-Message-State: AGi0Pub9Ovl0JC3eqXr65fYQDFtKh8BqAshwTY4mGxeG0k5BinH4rJQT
        oSm7PvwecaUFBwTowFLskEt2rC/6Vw==
X-Google-Smtp-Source: APiQypK+pHUBNHU1g6vdAifk/O+7Vo+AWOtwaxvsmWs4IEVOrdresmT7yXhlPAmgJpOokXO+pyceRA==
X-Received: by 2002:a05:600c:2206:: with SMTP id z6mr9440647wml.188.1585929957222;
        Fri, 03 Apr 2020 09:05:57 -0700 (PDT)
Received: from ninjahost.lan (host-92-23-85-227.as13285.net. [92.23.85.227])
        by smtp.gmail.com with ESMTPSA id l12sm12351426wrt.73.2020.04.03.09.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 09:05:56 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        Lu Shuaibing <shuaibinglu@126.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 1/5] ipc/msg: Add missing annotation for freeque()
Date:   Fri,  3 Apr 2020 17:05:01 +0100
Message-Id: <20200403160505.2832-2-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403160505.2832-1-jbi.octave@gmail.com>
References: <0/5>
 <20200403160505.2832-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at freeque()

warning: context imbalance in freeque() - unexpected unlock

The root cause is the missing annotation at freeque()

Add the missing __releases(RCU) annotation
Add the missing __releases(&msq->q_perm) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 ipc/msg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ipc/msg.c b/ipc/msg.c
index caca67368cb5..acd1bc7af55a 100644
--- a/ipc/msg.c
+++ b/ipc/msg.c
@@ -268,6 +268,8 @@ static void expunge_all(struct msg_queue *msq, int res,
  * before freeque() is called. msg_ids.rwsem remains locked on exit.
  */
 static void freeque(struct ipc_namespace *ns, struct kern_ipc_perm *ipcp)
+	__releases(RCU)
+	__releases(&msq->q_perm)
 {
 	struct msg_msg *msg, *t;
 	struct msg_queue *msq = container_of(ipcp, struct msg_queue, q_perm);
-- 
2.24.1

