Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF6DC2BA83
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 22:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569F220820
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 22:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGCjK6Rd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgBIW3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 17:29:41 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54412 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgBIW3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 17:29:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id g1so7815727wmh.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 14:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uimvgFyuSg7nYK2tM2GQSI3r7Vr6x3Dc1/TzlyQxk6c=;
        b=VGCjK6Rd+fMIeQrRLtwiauOXBlFUwapuwF99BlUPE5Art9v4hqkoAgMSVC8e8hFCcx
         EgsKWEBA8JgsVB+fG6PgMWMicrm7G0y1XSsvsWHaPZyeg+snEu63+T4zbiAB/Jc6Kwr2
         StVx+mN2xT9+kyptSRJHzp6ttR9TudQcbgBzaRysEYTve/oePo+kHBRMOTgzRukeriqs
         /8nGMdQylwbI5x6ioMs+E/CmeLCW3VE7fuEk4JuHCxL8lfcr/AJ2CyfHm+xreKXI6tXm
         o5sG41ZvtVNe8qd5VPZAB4JJPPpmidco1CfK5Qs1Pz/gPHbIh201VAdoOidEbi1a62nc
         Av5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uimvgFyuSg7nYK2tM2GQSI3r7Vr6x3Dc1/TzlyQxk6c=;
        b=fJjDFjOd7UZYauvWEbkHtHqmEgU96D8mVU0Apm3GyiJlf8JBS/U3pqY0nr4dr3f74X
         F7rLgj9sl2jqqo4RoQcg+uoWOUPk1mF4spOlydOshGZPf/MhJ/3/l5QJN0itUBu11/Tv
         IbN2K5pcuvnfUHWe2zkVcAEyE+I4JFgtayW3sVYxMa/ZMfoBzVfNQiLuqrnjsw9qGg+S
         +gz0+7LhpLPVpRHKxawQupUxUFux3HbvbaxdJ/zrUPvm23xFNNxIDWc/fES1dNsL9QHL
         d8SN6wTeZk9Maee2OLH99rteZRMYT/Vgwk8yWBFpuui35Wro/cD5u8GbcX8dlHpp/eVm
         o9Iw==
X-Gm-Message-State: APjAAAUJcKD5WavJuNihjCQlIK5XmBGSOD9Kpr/poIOnvsWJJYFfmwP2
        6T8d/jUVTw/GwV0WW/QYEMDWAaWMTuCY
X-Google-Smtp-Source: APXvYqynPm/Kauf6thmBnzw2iQX2XLBZKTnnGFzz/ZKxFkMDUmfKJRGVZtHfLuCmygQcBjVkAbmF9g==
X-Received: by 2002:a1c:a796:: with SMTP id q144mr11572501wme.6.1581287377633;
        Sun, 09 Feb 2020 14:29:37 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id k13sm13448590wrx.59.2020.02.09.14.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 14:29:37 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     dvhart@infradead.org, peterz@infradead.org, mingo@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 02/11] futex: Add missing annotation for wake_futex_pi()
Date:   Sun,  9 Feb 2020 22:29:25 +0000
Message-Id: <0cfbbe1031005c37bf478c5a59d33cc83ef9a4a6.1581282103.git.jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581282103.git.jbi.octave@gmail.com>
References: <0/11> <cover.1581282103.git.jbi.octave@gmail.com>
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

