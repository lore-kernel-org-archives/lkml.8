Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D027BC33CB7
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 00:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5F9920722
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 00:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHXcl61o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgBAAEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 19:04:50 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34742 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgBAAEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 19:04:48 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so10670622wrr.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 16:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uimvgFyuSg7nYK2tM2GQSI3r7Vr6x3Dc1/TzlyQxk6c=;
        b=pHXcl61oWq7Slj1voBT1khcXEP3B1GVaiTF4lOBFsMSI19tvut3+mIkS+Lx9QVtA+0
         Omase25Rh4eqqNPYi+KAS2eiiF1aOwuLB7wWrGEftkOpNbdnQAnRt2Uo9mGGKnWkNWvz
         nvTY6eJUX5Wf64WpGMziVkju/IYdOwF/DBWuFNXhtuyEXwUfF5v57I2oU8fMhvdjbPQD
         MR8wKLBlvARwdFpBZ816xXmECGzfl8bXe6giKZq+4LADTSb7y49rwEfOhe7DaJ9LS5Ho
         k5A6vzawPL+YaM35GT8qPG6paZCcwjskWe8DVjlct2p7if/+453uz9y133KFgQGpxqxu
         +OzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uimvgFyuSg7nYK2tM2GQSI3r7Vr6x3Dc1/TzlyQxk6c=;
        b=FS7zuTFydfjBCEmYnRkbsKZpvcen4+ms7q2QKyvQW1C7te8Q5klOsQeMXn3LbYUu3w
         S6FWT1vINHgu0gbnMSReYLeIa40RanBtqR3GyCiUkgzsYSpc2Y1mKsdVaC0aigRvn/re
         qvjEw57V5aA6XKUi5igsrF+nGTNn02FndiUU/oXk9aprSuT09NklHZvrnuNj/Pc+1uSj
         HDfoJYhAb7gLdVxfTx/QB9HCJslLsJ7ByaagymnFY3khUt/2Pt0fGWKXagt2MxEne/wD
         nweWAb4HEnjnaz+ZaXACgQ1wq7RcJs4nYiYMvPUXeBblI+iSezyyOMBQVLIPR2IbBmdF
         3DFg==
X-Gm-Message-State: APjAAAXMfLwjeEkjozO3hkf9Esn5rFz3knhH8Dty+Ar6kLYwR5wYPrTA
        vAYPC+ZmvbMwDbHf4yTkTw==
X-Google-Smtp-Source: APXvYqwsEdVsOhh4G33KS+Pjafwc/DDTIYt0nLNuG26vK6vx3kYhqT3npsgCsVvKnLo6gkUSmSYbpA==
X-Received: by 2002:adf:ec41:: with SMTP id w1mr849724wrn.212.1580515486276;
        Fri, 31 Jan 2020 16:04:46 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id n10sm13694048wrt.14.2020.01.31.16.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 16:04:45 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        dvhart@infradead.org, peterz@infradead.org, mingo@redhat.com,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 2/3] futex: Add missing annotation for wake_futex_pi()
Date:   Sat,  1 Feb 2020 00:04:15 +0000
Message-Id: <20200201000416.91900-3-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200201000416.91900-1-jbi.octave@gmail.com>
References: <0/3>
 <20200201000416.91900-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at wake_futex_pi()

warning: context imbalance in wake_futex_pi() - unexpected unlock

The root cause is amissing annotation of wake_futex_pi().

Add the missing __releases(&pi_state->pi_mutex.wait_lock) annotation

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/futex.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/futex.c b/kernel/futex.c
index 0cf84c8664f2..93e7510a5b36 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1550,6 +1550,7 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
  * Caller must hold a reference on @pi_state.
  */
 static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_state)
+	__releases(&pi_state->pi_mutex.wait_lock)
 {
 	u32 uninitialized_var(curval), newval;
 	struct task_struct *new_owner;
-- 
2.24.1

