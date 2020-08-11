Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABCCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7112E20768
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz+aoNkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgHKLS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbgHKLSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:18:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E9DC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 04:18:55 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k8so2463007wma.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 04:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WhMlMR0rWuSfJKIPPo9mAojnhHNWUY4zWDVzFeeHjaY=;
        b=Jz+aoNkIcFDY6nGZZsPqisGocV5D1HD4hNhlDzRzcadvtZ56+uD7mYRpbzlO1RgNuD
         UVvnCfwAGTtGwlnAE3kl2NJbWOoBS/+F9gGWz26ruptiARES3F6KsanO7nMWQ1iwT/jB
         TQkZIYgtxn3zms7KAb1qOqESycn3YzMQLHOQpeBtgnK/ynLY5wdtwTGMywNCsE/LL6GH
         QN9R2XV80pwRjRJ2RA2WP7mgP9ZJhq4CmrOxfyf7EZYZKIDlURJYWhsXcRv9cYqwcZ0Q
         PboD5Kf8J5hrbCxANqp/ZnV0lVcLRK0LPo5WcPcV2ISTe9JHfFQ/HTQHWVumtrw+s4HP
         aN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WhMlMR0rWuSfJKIPPo9mAojnhHNWUY4zWDVzFeeHjaY=;
        b=MvetusAOlTAArWjLZym63bJhqTEVxI/bpCPwYIt9yFaW+heTtwwZgprBoB300PLLmM
         1MyRWqcZ3YRm09JDjo+VYoDrRboO7U+aIULX+4aW/QTwtmRpFaj9VFdMF0LjuEo0VKBU
         SzdUK/1x50fa1EFM/SM8kaVMWIpXsnVrjAVb0N4TsAAd6Dt2Ww5EFa6cBKZIAb/lLs4Q
         tWbzxW0yLdo8BzE7paQusBSZh8amv/NFR0HHKOs+0OBNad4c8Y54QLP6Y5953MpM/UqB
         aQ3qQiMkjASXhs5m0Qg853AJCqpuyqgvtB3mgoCh6HllaK04mewMtsPqGABFsRzSTn7w
         Gvdw==
X-Gm-Message-State: AOAM53140fJDQXdnlKsyH8c7dUk65cMrowqClE86+tQa++8P8aeDvz9F
        fZfhJlygK3SEZWAmd8H9iBZvF3qK
X-Google-Smtp-Source: ABdhPJwBz0QXOIsjFl8fTDXDwU6V3q5VDdVsjTjA4lHmld5TpMebvTdgNMLcWqtfmJW6sn22ji8TbA==
X-Received: by 2002:a1c:750f:: with SMTP id o15mr3737321wmc.182.1597144734158;
        Tue, 11 Aug 2020 04:18:54 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id t14sm29172064wrg.38.2020.08.11.04.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 04:18:53 -0700 (PDT)
From:   "=?UTF-8?q?Christian=20K=C3=B6nig?=" 
        <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] locking/rwsem: remove redundant semicolon of down_write_nest_lock
Date:   Tue, 11 Aug 2020 13:18:52 +0200
Message-Id: <20200811111852.190209-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guchun Chen <guchun.chen@amd.com>

Otherwise, braces are needed when using it.

Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 include/linux/rwsem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 7e5b2a4eb560..7a5bf5d50489 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -179,7 +179,7 @@ extern void _down_write_nest_lock(struct rw_semaphore *sem, struct lockdep_map *
 do {								\
 	typecheck(struct lockdep_map *, &(nest_lock)->dep_map);	\
 	_down_write_nest_lock(sem, &(nest_lock)->dep_map);	\
-} while (0);
+} while (0)
 
 /*
  * Take/release a lock when not the owner will release it.
-- 
2.25.1

