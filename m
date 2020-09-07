Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC34CC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682A9206B5
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 18:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E4pUSDNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgIGSFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 14:05:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49866 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729741AbgIGSEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 14:04:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599501890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=wEV7c2hoejQ1ixum50rA5xwKvNmSW5uoo1V8Pac1bKo=;
        b=E4pUSDNFVNkGaVDsM5mr5Og+r+k6Zt2TFwU6Jgk2I2ArPo6I89LVTSdSzSvzASzwe8CUCw
        4qmd0Slo+xq/4K5OZmavcX45yVn8kk+Ohvl8t63w6ImEteogqjqtNxvozBpFRq2OIDx0Ot
        6LPSkLu9FopmPqoi52/5lqRYgAFfhnw=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-x2w9Zp_zMP-hOuqQoDF3KA-1; Mon, 07 Sep 2020 14:04:48 -0400
X-MC-Unique: x2w9Zp_zMP-hOuqQoDF3KA-1
Received: by mail-qk1-f197.google.com with SMTP id v16so7854891qka.18
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 11:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wEV7c2hoejQ1ixum50rA5xwKvNmSW5uoo1V8Pac1bKo=;
        b=EH0uaJ9l4/NbqylLKyNYxcWC9dDMV/L6ZT7VLlPiv2vSPoeTfxdjlK6+EmoUE8ZWwj
         ZZ8dAy26Dzg0ZOZ9+FXgFXTgqNDMrwIbmdWIDdowtMTUJydtB0Q9eE32CrPiCLVjklIn
         eRBuvRsG++AV4Lf+m/sgL0uvf6qJ9lTQAKF4UOH+ch2nXiXQZPw84evnxGa9hNOLLCuZ
         OMPwLarGeIvvZwre2SUhZW+rA2bqDI+5Zjh/cLwOX/0s3jdkA1zyzvCZ6ckMaPPUBJCM
         3xYxzlPCzFk1bensyS5PiWokbo61s8dMBxcJWUfL2zE980h0SdW3UcYXR2JC9qS14DSN
         +PCg==
X-Gm-Message-State: AOAM532mDtqRwzbpqRY0u/qgh23HRoQ3be+BtwM4Ua1FAgB+o53AXQ8P
        wKQnm/Iuy2suP3ZkLrYIt8G9QjrVp/L5Y6/Mdwf++BKtzMvzxZ+UFmDzbQ8M/HPYc2ZaYKLU/JZ
        1ecSARnCoAGSkgLRqJQ9bwoFN
X-Received: by 2002:a37:8c02:: with SMTP id o2mr18932750qkd.461.1599501888005;
        Mon, 07 Sep 2020 11:04:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzc9bmRu1RY4kwHcHrlv9A879aAJwVxMmr05CDWzHdIf5f9kZB3pGIWJMKzUyS2DL1f0/pOQg==
X-Received: by 2002:a37:8c02:: with SMTP id o2mr18932729qkd.461.1599501887741;
        Mon, 07 Sep 2020 11:04:47 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id e24sm11088555qka.76.2020.09.07.11.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 11:04:47 -0700 (PDT)
From:   trix@redhat.com
To:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        davem@davemloft.net, kuba@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] net: sched: skip an unnecessay check
Date:   Mon,  7 Sep 2020 11:04:38 -0700
Message-Id: <20200907180438.11983-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Reviewing the error handling in tcf_action_init_1()
most of the early handling uses

err_out:
	if (cookie) {
		kfree(cookie->data);
		kfree(cookie);
	}

before cookie could ever be set.

So skip the unnecessay check.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/sched/act_api.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 063d8aaf2900..f64af9d9dfee 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -976,7 +976,7 @@ struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
 #endif
 		NL_SET_ERR_MSG(extack, "Failed to load TC action module");
 		err = -ENOENT;
-		goto err_out;
+		goto err_free;
 	}
 
 	/* backward compatibility for policer */
@@ -1013,11 +1013,12 @@ struct tc_action *tcf_action_init_1(struct net *net, struct tcf_proto *tp,
 
 err_mod:
 	module_put(a_o->owner);
-err_out:
+err_free:
 	if (cookie) {
 		kfree(cookie->data);
 		kfree(cookie);
 	}
+err_out:
 	return ERR_PTR(err);
 }
 
-- 
2.18.1

