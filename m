Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCABC4BA06
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF07C21927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="p1b6DIB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgBZB6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:58:25 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38763 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbgBZB6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:58:25 -0500
Received: by mail-qt1-f194.google.com with SMTP id i23so1164591qtr.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 17:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3W6dUjneFw3Iq5j0LRHddz/04ra8gT9SV1GqromcUcA=;
        b=p1b6DIB/zaPCoKDbRHx56Ttn3E//aAfWWDn5ysoYfvW9M17pCbsmV09+Z/c1eYrgYT
         RLTBR6fyj9srVTEglPmT6kRF5IjSO/9MH40LH7aL2K5L0ywykQNdGuGmcBoh7+g20L/S
         4Hz0X55LGUiN8wlKC5ak0ibUvEkrv71+M1Ue6SrYDgJEVxuPB10/Dvy3waU+0NZTGszW
         afkV03q05woG9KXAuYUXZPHO9kcMr2Wf0wussfbM34enqv7vS26F6o//x03jcLx9zOXc
         QpBHg9A0nAt62FEphlR4ouYHAs0nsgfx0P/SuHe5AWaKE/CuSIpB55fBGtOCmOfS7LCj
         ha0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3W6dUjneFw3Iq5j0LRHddz/04ra8gT9SV1GqromcUcA=;
        b=X3DJ4pJT0fuxT7d/vF6tQta75cHHRY6hfxKeUSBBO6XZs91qt2Qw4pKsf5VtfyNsqV
         V97rIddOB8UzqSzRx66L3LAheS8H6aEP5QdYNYHhwu5DW+B4FwRO27e7kHRjWa4IsVWe
         lFZkE3TLwWiuNQcmvFEIu0hXu37xVMCKOrApqsZJfr9BrF5PEGLbKT4Xs49m2TUT0bKg
         zCg3e1ZJfRcVQF7Mch+W+5qLCGx28dzNNLKOVoz5UH81Y/0IuB/W+lq8EX5SKS9PUKfL
         FIZMxPt1w4KfL8W5XkAP8Lh/POcrX52KhEjvM16aWZgp0xKDc4Ubw0DhvETpbFnQ5NVB
         g8Fg==
X-Gm-Message-State: APjAAAV6SS0X1KWH7pmHjWyUULlnAaPMU5ESlS+XGdgYEEfOOKgVOPL4
        LZpj4VMp4SLC0pytGxE5JTn03A==
X-Google-Smtp-Source: APXvYqzceBcyktKssUogh3JQAjPXAwym222xlUpuJoB/bKA9+80nAwe3RJB1ejMlWvXgtr7v8/21HA==
X-Received: by 2002:ac8:1b18:: with SMTP id y24mr2071113qtj.158.1582682304323;
        Tue, 25 Feb 2020 17:58:24 -0800 (PST)
Received: from ovpn-121-122.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v80sm283450qka.15.2020.02.25.17.58.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 17:58:23 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     rafael@kernel.org
Cc:     elver@google.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH -next v2] power/qos: annotate data races in pm_qos_*_value
Date:   Tue, 25 Feb 2020 20:58:13 -0500
Message-Id: <20200226015813.987-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The target_value field in struct pm_qos_constraints is used for lockless
access to the effective constraint value of a given QoS list, so the
readers of it cannot expect it to always reflect the most recent
effective constraint value.  However, they can and do expect it to be
equal to a valid effective constraint value computed at a certain time
in the past (event though it may not be the most recent one), so add
READ|WRITE_ONCE() annotations around the target_value accesses to
prevent the compiler from possibly causing that expectation to be unmet
by generating code in an exceptionally convoluted way.

Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: borrow the commit log from Rafael.

 kernel/power/qos.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 32927682bcc4..db0bed2cae26 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -52,7 +52,7 @@ static DEFINE_SPINLOCK(pm_qos_lock);
  */
 s32 pm_qos_read_value(struct pm_qos_constraints *c)
 {
-	return c->target_value;
+	return READ_ONCE(c->target_value);
 }
 
 static int pm_qos_get_value(struct pm_qos_constraints *c)
@@ -75,7 +75,7 @@ static int pm_qos_get_value(struct pm_qos_constraints *c)
 
 static void pm_qos_set_value(struct pm_qos_constraints *c, s32 value)
 {
-	c->target_value = value;
+	WRITE_ONCE(c->target_value, value);
 }
 
 /**
-- 
2.21.0 (Apple Git-122.2)

