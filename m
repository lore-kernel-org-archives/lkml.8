Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E715C433E3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 18:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CDC92072A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 18:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiffGE6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgHASql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 14:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgHASqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 14:46:39 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5887CC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 11:46:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r4so27736034wrx.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 11:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DoAzX0mPxKwifGhIAYoV8gWIU4fgddXvYUu1szasbME=;
        b=TiffGE6FOY11z2ZpFyKJWmRbhR+8VYGGHcuUJ2pDvXdKyRco3smaDAN7F/caupCQkc
         k0m9zesmoKK6rIZxl3Wb0XqfTX+PQsj659jowXgbnzebu+f8IsBf9k5L1UdJwQPeZxGu
         +ZCS42FWf+6muHgIkq6eqFNCs9DCLOPYyqeHoNk6eFXcu/qaWEGLPKZz6h/Gve16PF54
         n+g9l3zUSyLvOKoD6rDdpvCWylCe4ECJBVqIHOqM+u1I4/ik/JriIKDPI8yOh8ByrQeh
         8pgk6GZMuVYk0hh7I3y8XmcixdNLD9H0pmvdJcQ2TFip4b1QW5NJLipU9MN+gABvrTTn
         GaGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DoAzX0mPxKwifGhIAYoV8gWIU4fgddXvYUu1szasbME=;
        b=RRX+/DStpc4M/74hp4sZP6OyQYjsGbWMddLz5orfEcxrV8DsLaEnW+D93MKrdW9oZH
         Mtvvs2+Nvhrs9nXbO2fS4btTI3OXo1tN4p+6W+t6T81TDXVNOxt0IA/VfAI4F6YGOzln
         bz8RbBwnTH9TV+oWzxONEvCFjemFv2ovst+2U+E+6WhulD+ADrnAmxSz+VkyqDVssWP9
         4RInPlYZ0Lqd34vwoP/yTFt16FJDkB+wZahtBwCq+v0xIAB0poeyXkttU7EQ8oi0e/tv
         1IGIkfE7KX8aIpbZvmg6Q6DZkjPgpKUZV00UGF3Bs9rBgIDGlGV9tuQ6vO7jSQdOoSDd
         QERQ==
X-Gm-Message-State: AOAM53219I+x8DqSFFomVyM3demxr1KmcjhZoZ8TZLZlMq5jxQu8yviB
        X4ejak4rliFJOm2C5D0lp8kmPlSUd5De
X-Google-Smtp-Source: ABdhPJyftIU1s71JqoytPv8/QTAqp8h9/0euUzcWCNTNP34ycJ0FWWaTZ4liZzlyVwNckRuyLLlHrQ==
X-Received: by 2002:a5d:438c:: with SMTP id i12mr8998288wrq.210.1596307597696;
        Sat, 01 Aug 2020 11:46:37 -0700 (PDT)
Received: from localhost.lan (host-92-25-238-49.as13285.net. [92.25.238.49])
        by smtp.gmail.com with ESMTPSA id g7sm17468447wrv.82.2020.08.01.11.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 11:46:37 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Irenge <jbi.octave@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        linux-audit@redhat.com (moderated list:AUDIT SUBSYSTEM)
Subject: [PATCH 3/4] audit: uninitialize static variables
Date:   Sat,  1 Aug 2020 19:46:02 +0100
Message-Id: <20200801184603.310769-4-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200801184603.310769-1-jbi.octave@gmail.com>
References: <0/4>
 <20200801184603.310769-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch tool reports an error at variable declaration

"ERROR: do not initialise statics to 0"

This is due to the fact that these variables are stored in the buffer
In the .bss section, one can not set an initial value
Here we can trust the compiler to automatically set them to zero.
The variable has since been uninitialized.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/audit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 7b1a38a211a9..7d79ecb58b01 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -311,8 +311,8 @@ void audit_panic(const char *message)
 
 static inline int audit_rate_check(void)
 {
-	static unsigned long	last_check = 0;
-	static int		messages   = 0;
+	static unsigned long	last_check;
+	static int		messages;
 	static DEFINE_SPINLOCK(lock);
 	unsigned long		flags;
 	unsigned long		now;
@@ -348,7 +348,7 @@ static inline int audit_rate_check(void)
 */
 void audit_log_lost(const char *message)
 {
-	static unsigned long	last_msg = 0;
+	static unsigned long	last_msg;
 	static DEFINE_SPINLOCK(lock);
 	unsigned long		flags;
 	unsigned long		now;
@@ -713,7 +713,7 @@ static int kauditd_send_queue(struct sock *sk, u32 portid,
 {
 	int rc = 0;
 	struct sk_buff *skb;
-	static unsigned int failed = 0;
+	static unsigned int failed;
 
 	/* NOTE: kauditd_thread takes care of all our locking, we just use
 	 *       the netlink info passed to us (e.g. sk and portid) */
-- 
2.26.2

