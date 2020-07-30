Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07A0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8270C2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:54:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrrjsvcD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgG3Nyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 09:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgG3Nyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:54:35 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C82BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 06:54:35 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a9so4265617pjd.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 06:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tge8OIdcAuImjNZAecVhmu6eMDpyDyeIqIaLKa/p9WI=;
        b=MrrjsvcDuYwum8bwYmttmdNXOPwfYqaqZysQTAmgNzhGr97eP6mSDfGsE7yYAxxR95
         o0YK0Oj71dKbaOkgVd7etX4M/xzTgpzq4j3h/GilTxAr/KzrhP9o23/3vPyPkUASXkf7
         ed1a5S9U91jXZSJ2/NJh26AFTh5Bh3J6GAnN/rb/0fCIAjSDsC/ztmvQI/vQmiV4BSkc
         xiZIFou7wG7lbVQg2XJV5sQbcehBV/12c8r/J/50p6GXo6xPJhRvBS/SSgD27m/RxL8q
         GyBUtC1lpd4rgliincSyJ0hXLzNSby23DsK/SKFAmkbEpqFNI5K1lahgh3e0rKjkI7pN
         3F9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tge8OIdcAuImjNZAecVhmu6eMDpyDyeIqIaLKa/p9WI=;
        b=aXkmhkhCktsLoRcMtJUsUaVbMNM3IZytBt/qLE5jurVqsk+IV9cVS77L5V/K0mBQqt
         L9sO790UX97wjA47EJ5TH36qg+vmFFyGJ7VkHTbXgpq11b647eBUaltbRROWi0Bqlodo
         1h7Yc/LXlvKZ7cIC1iLyN53wi1cxGiRyWbrpFnPBWEKhZoEhAT/AnF0g0DTPIJ6Jq/20
         8QomU81PNgdzKiRuL3RXuRdORCNxvuSjZOlZ9P1a8sVcr8SIIRvclduHZaPbFuMBBZo5
         atnGBaSzeUdaK7sjQaem1pMBHG8Dp4doBhBkjvkqrSogBolbUeK7SXfyg2l/XNCr7M6S
         VJcQ==
X-Gm-Message-State: AOAM530qUOJXRIlbPjiDibcWW0vmCljeMcoDeev9lJY3TFyq6NjF3uci
        aNuJlUIdx/4PaVVIrXjwDW5cWmEAUQo=
X-Google-Smtp-Source: ABdhPJxayk8ENK9zCuGUMgiZ61LJsyc3uHFeJEXTbMbb02XV7Bwvui+l2Nb1JAY4hwLLIMQTJJFO3A==
X-Received: by 2002:a63:db18:: with SMTP id e24mr32961497pgg.192.1596117275006;
        Thu, 30 Jul 2020 06:54:35 -0700 (PDT)
Received: from localhost.localdomain ([101.32.41.8])
        by smtp.gmail.com with ESMTPSA id p10sm6347113pgn.6.2020.07.30.06.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 06:54:34 -0700 (PDT)
From:   Qi Zheng <arch0.zheng@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org, Qi Zheng <arch0.zheng@gmail.com>
Subject: [PATCH] sched/core: add unlikely in group_has_capacity()
Date:   Thu, 30 Jul 2020 21:54:23 +0800
Message-Id: <20200730135423.232776-1-arch0.zheng@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. The group_has_capacity() function is only called in
   group_classify().
2. Before calling the group_has_capacity() function,
   group_is_overloaded() will first judge the following
   formula, if it holds, the group_classify() will directly
   return the group_overloaded.

	(sgs->group_capacity * imbalance_pct) <
                        (sgs->group_runnable * 100)

Therefore, when the group_has_capacity() is called, the
probability that the above formalu holds is very small. Hint
compilers about that.

Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2ba8f230feb9..9074fd5e23b2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8234,8 +8234,8 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 	if (sgs->sum_nr_running < sgs->group_weight)
 		return true;
 
-	if ((sgs->group_capacity * imbalance_pct) <
-			(sgs->group_runnable * 100))
+	if (unlikely((sgs->group_capacity * imbalance_pct) <
+			(sgs->group_runnable * 100)))
 		return false;
 
 	if ((sgs->group_capacity * 100) >
-- 
2.25.1

