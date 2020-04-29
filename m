Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2333C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 04:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90D1420731
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 04:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMXJknaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgD2EEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 00:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726669AbgD2EEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 00:04:20 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1ED3C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 21:04:20 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id r4so411101pgg.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 21:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N+HyAPL9cDPoNwkcJep2JsuLSlmzp1VJiq0Za7OP/Lo=;
        b=OMXJknaUvTlSXDqH0WAp2063IWMkOc08eK4KaFP3n3aXebilFIkSj4Zw/uQvRU5sNj
         1wjSQ7B0LAfDkkv+bpqUMwsM5cv/CBUGFHUSwlPbW30qQz3G5QB6CChFOAw1zKd8vdhv
         jtSZA7EBvBE9JotG5+nArIvXZ+ycb8Hm1MCXrvEWcTYHN1t0wJMmhbPcRp5q5Ea+TDbU
         m0FpaoJ9kxoDDFTLvBK3RIIO0PWQn3AZFCQn2qRVjnlNrQ6sesy4VGwurJgYxg5G3fr1
         LaHlMBTBvDs1NwpxHYJQyPOvlJkQLZtQinJJXCeaPukF/N9uuNYgAEuA0uHYdKicRJ9b
         40TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N+HyAPL9cDPoNwkcJep2JsuLSlmzp1VJiq0Za7OP/Lo=;
        b=TUsSh8KZAq4EOAkHGrlOSlOqHBC4xoe9/H2pzTvDwzOx6bE09b0e7ZDfMebX5XlBpB
         YN66yR7ShxfMn8/KGVFUA/Jlp3nNkkKJdpEWxWGRDOzB8ZB/11cvIcmrWlTU7JsF/mmQ
         NdDAQ0p+OV7WVcGvbDsoGZxYPdfPX/7Cm+awXi2/MfFFHkIJjCC/SxCuTZuE2KUpLPTI
         /LIKS9H/sO7oL1xvo4tySfFYOOtuidUVObaEQbjSepHKMuc1GgZmMGr6E3NLOjjva46B
         Kf4UvSgxhb5KaYnN/lSpqv37VDWwmQ26Xz2/o+ADKtgHmIzXH2Y+S5kY3xf+MHItFaSx
         Ho7g==
X-Gm-Message-State: AGi0PuakfhpXzfG6nEiuywPnZ7a+koMnEKvzVv6QlpzZXibcDeUldXf6
        4Ed8KmfVZ3PvlDp9uKn++SY=
X-Google-Smtp-Source: APiQypKxqccun1mvVNIZeFsqz3c/mXBYS1+QrqtW5LKbJb0DRvRwlDS9fWvQJ4V1azBbW7dXrUkAcw==
X-Received: by 2002:a63:bd42:: with SMTP id d2mr11590630pgp.214.1588133060127;
        Tue, 28 Apr 2020 21:04:20 -0700 (PDT)
Received: from localhost ([159.203.232.101])
        by smtp.gmail.com with ESMTPSA id t103sm3366621pjb.46.2020.04.28.21.04.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Apr 2020 21:04:19 -0700 (PDT)
From:   Sean Fu <fxinrong@gmail.com>
To:     tj@kernel.org
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        Sean Fu <fxinrong@gmail.com>
Subject: [PATCH v2] workqueue: Use IS_ERR and PTR_ERR instead of PTR_ERR_OR_ZERO.
Date:   Wed, 29 Apr 2020 12:04:13 +0800
Message-Id: <20200429040413.13942-1-fxinrong@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200429021905.10639-1-fxinrong@gmail.com>
References: <20200429021905.10639-1-fxinrong@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace inline function PTR_ERR_OR_ZERO with IS_ERR and PTR_ERR to
remove redundant parameter definitions and checks.
Reduce code size.
Before:
   text	   data	    bss	    dec	    hex	filename
  47510	   5979	    840	  54329	   d439	kernel/workqueue.o
After:
   text	   data	    bss	    dec	    hex	filename
  47474	   5979	    840	  54293	   d415	kernel/workqueue.o

Signed-off-by: Sean Fu <fxinrong@gmail.com>
---
Changes in v2:
    - make commit message more clear.

 kernel/workqueue.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 891ccad5f271..ddf0537dce14 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4197,7 +4197,6 @@ static int wq_clamp_max_active(int max_active, unsigned int flags,
 static int init_rescuer(struct workqueue_struct *wq)
 {
 	struct worker *rescuer;
-	int ret;

 	if (!(wq->flags & WQ_MEM_RECLAIM))
 		return 0;
@@ -4208,10 +4207,9 @@ static int init_rescuer(struct workqueue_struct *wq)

 	rescuer->rescue_wq = wq;
 	rescuer->task = kthread_create(rescuer_thread, rescuer, "%s", wq->name);
-	ret = PTR_ERR_OR_ZERO(rescuer->task);
-	if (ret) {
+	if (IS_ERR(rescuer->task)) {
 		kfree(rescuer);
-		return ret;
+		return PTR_ERR(rescuer->task);
 	}

 	wq->rescuer = rescuer;
--
2.16.4

