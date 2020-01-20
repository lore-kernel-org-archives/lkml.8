Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228EFC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 22:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E25352253D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 22:44:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIzeDpTI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgATWoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 17:44:04 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52431 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgATWoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 17:44:03 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so1002428wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 14:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LIr9v+lPF9m04aOL6YbMXajLYqQw2LLsXJkvfGL0mQk=;
        b=rIzeDpTIuB0fA3WkCVgeL/zTOL2ApKVRf6AsRWrDNXxctBI4iqUJqcUFkrvgSc66yr
         qkxwTkJvvaaMgJJnGYLM3PdOksWWrzKeqXMTBqE7LU7yWYuHcwWoFQKYuKl9PxGDidjH
         lCJOhi05qfrVM1PnkuhDCGgGrGR/+zFWGcyL0rrY/QWuxgygvn5UnFqIxIOMrRtDjeRF
         aQ08JidsuUjfPG2t4RaUusS9ohtqYepncEEeIOtlKZW0/4sqcJk5B8MCJYHvet/bHm9x
         EXkySVHsmI3raTarbl9H9Ae5hnxjmBylnvLhYc1JRDtoeyoDa2prdwftoyHdBEoTTHcM
         n2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LIr9v+lPF9m04aOL6YbMXajLYqQw2LLsXJkvfGL0mQk=;
        b=qqLOfqTOih+SUU7YHBLKjppzgRPZnYGkRWbVJwSmGIUK7sb0EIE8rX40GMpRlo3OzW
         saElohay3Qb5pZ+IWsOocF4C8F84f6NhqZTqxFa7zeIFJNZn3lWFv+QwhxCHeA4TNYvy
         VqJ6y0UPlelnY2ZdnOuJ8ruZ2b04WwP3oh/h8spPpC38LNzcS9OPZTBqGumkl/MApYfz
         omcFpx5Z8jaW2XVycNoKZrbnfj0be6esOll97iGSWPB6KWk4uoOgw7y3xUOM3/yAqfWN
         9u1oydgkFniyt89IcXPVy19eUtlZ5kACTZZDND6AVSouxEsomj1hAxh8BOd7cLyXLIMK
         MYAQ==
X-Gm-Message-State: APjAAAXa4FnQW1o1pItdskS4lm4F6ZcmCUG3/TwqgCJk1sRQLjgrum8i
        r9AlyU9Tbj4DU1+uHWibau4RSxFlCBR/
X-Google-Smtp-Source: APXvYqwxHUz6OKEv85tDO30YDy7S+E/IA1h7FluD25niQipE8rMNvoUajm52o/Y6z7U7hyux8kdoKA==
X-Received: by 2002:a05:600c:2290:: with SMTP id 16mr903542wmf.184.1579560241675;
        Mon, 20 Jan 2020 14:44:01 -0800 (PST)
Received: from ninjahost.lan (host-92-15-170-165.as43234.net. [92.15.170.165])
        by smtp.googlemail.com with ESMTPSA id o4sm47817626wrx.25.2020.01.20.14.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 14:44:01 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 5/5] time: Add missing annotation for __run_timer()
Date:   Mon, 20 Jan 2020 22:43:47 +0000
Message-Id: <20200120224347.51843-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at __run_hrtimer()

|warning: context imbalance in __run_hrtimer() - unexpected unlock

To fix this, a must_hold() annotation is added.
Given that __run_hrtimer() requires lock to be held
This  not only fixes the warning
but also improves on the readability of the code.

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 8de90ea31280..3e94ea58b18d 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1477,7 +1477,7 @@ EXPORT_SYMBOL_GPL(hrtimer_active);
 static void __run_hrtimer(struct hrtimer_cpu_base *cpu_base,
 			  struct hrtimer_clock_base *base,
 			  struct hrtimer *timer, ktime_t *now,
-			  unsigned long flags)
+			  unsigned long flags) __must_hold(&cpu_base->lock)
 {
 	enum hrtimer_restart (*fn)(struct hrtimer *);
 	int restart;
-- 
2.24.1

