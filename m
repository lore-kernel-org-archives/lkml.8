Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEC0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 20:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82AC42081E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 20:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6nEs34L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404219AbgAXUMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 15:12:36 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33841 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387535AbgAXUMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 15:12:36 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so3519283wrr.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 12:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rwO60z18tzr7WQ1TP+fRraEsg7xwuQbgnqSnqaMw5hc=;
        b=b6nEs34Lez22ZBBp+RU/DKcDzy+B2KZikc59VGSL95cIqqFk5U4LW92rw3xrF/nYXA
         A5Ig334+JLGJ6V298+KsUZthCMGiVqFYAipxMuMjyKBg+xXRR96a7Hfussm6OO2TBwic
         tLyxTsl3XfBym5roX2ilHicefHn21awM/CUH2JChGjVfE0jb1smZcc6ImkvJbtyo2g/h
         mAxRJ4AZUpMrU1PjdNg0nnfWR4bjNXLnStv5pdmuyexwyV92kqnofx+fLWDDptJKpZZ3
         e38F3Yd8QuGS8HtuNQK1pbm7OzqzA6JX0nC7uRfEOw3r01gHhSm4bb5y5hfAt/4txkJG
         aabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rwO60z18tzr7WQ1TP+fRraEsg7xwuQbgnqSnqaMw5hc=;
        b=LgAFQIYoIvuQpY1LKDZVr0toiul3oC9N6qhfTK6VULq9A7K+Kbkc0gsFFn9GcScs5P
         cwcmDiWq45h2r3yniOXXclchGCNoFxiSh9raCS6SPV50N7r/pJ9vBKz3etwOWIFYC74i
         qkESNk3QKgIUkeFcx9YDR2Zw2OTA6gUz2RWyF8AcJPnJ3qrf0TWmEJClRqC7Qnvqu3FW
         cwgJFFLmQ+ZO4Ba1uqWh53ZyVyLHlqY8hM6GxiSbHuLYf/Tjz7T/Aj45aakkACGWerJD
         d4ExQETk5DXOf0AMhiVY7pogOfAkve2qMBoRXg8GbQHrAOMj+7VWI29dPSAT6oLmiIdR
         EoOA==
X-Gm-Message-State: APjAAAXXvxxg9aP3rYeJ/rbjGG9O+O5OuLdnBVt44nLpYFZSWD+oeB9O
        TergvluSvJcsHp/wb+Y0AH3DH82d7g==
X-Google-Smtp-Source: APXvYqz1EKFYVnl5kf+N2sLKycLiAepUZcXUxPrVeHgff0oVBCNvs7vQ/jaV/lybZkvIfeEfeyE8eA==
X-Received: by 2002:adf:f58a:: with SMTP id f10mr6573895wro.105.1579896754091;
        Fri, 24 Jan 2020 12:12:34 -0800 (PST)
Received: from ninjahub.lan (host-92-15-174-87.as43234.net. [92.15.174.87])
        by smtp.googlemail.com with ESMTPSA id i204sm6897654wma.44.2020.01.24.12.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 12:12:33 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] futex: Add missing annotation for wake_futex_pi()
Date:   Fri, 24 Jan 2020 20:12:19 +0000
Message-Id: <a3868cdf0328e5953d6c12fe1e94fb2d8932044b.1579893447.git.jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1579893447.git.jbi.octave@gmail.com>
References: <0/3> <cover.1579893447.git.jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at wake_futex_pi()

|warning: context imbalance in wake_futex_pi() - unexpected unlock
To fix this,
a __releases(&pi_state->pi_mutex.wait_lock) annotation is added
Given that wake_futex_pi() does actually call
raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock)
This not only fixes the warning
but also improves on the readability of the code.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/futex.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/futex.c b/kernel/futex.c
index 03c518e9747e..8bc288a7187f 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1549,6 +1549,7 @@ static void mark_wake_futex(struct wake_q_head *wake_q, struct futex_q *q)
  * Caller must hold a reference on @pi_state.
  */
 static int wake_futex_pi(u32 __user *uaddr, u32 uval, struct futex_pi_state *pi_state)
+	__releases(&pi_state->pi_mutex.wait_lock)
 {
 	u32 uninitialized_var(curval), newval;
 	struct task_struct *new_owner;
-- 
2.24.1

