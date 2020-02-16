Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E694C3B1BF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 07:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BD1620857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 07:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUR/n/eo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgBPHng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 02:43:36 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40771 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgBPHng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 02:43:36 -0500
Received: by mail-pj1-f68.google.com with SMTP id 12so5845566pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2020 23:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=mV1qixM+hRHgqOUWXlliAy9s0rAvz7UfT2PUrmz0Bbg=;
        b=mUR/n/eo7hViVFepH9tBOF/4d1CJP8nF9GlkVeBEkVqnXhxjxvJnJwh0iuPO7Yw9Pq
         ic68Yo9yDUpiX3Bcizh1bbCkeOfelr4g3Hy7ErKX5zIYMyf9rJxqse6a/q2cyfS8OQv9
         yoxhiGISRhvTM4pk5UU8qzFaey69bWTxWSLwjfta1y19Hug1pn8nxtWV1qFrKCLZwrDG
         SF7Wc0/LnNpYjACve6jb6VqQRnZ6P8AkZENSI6iCEGUNPm67GWp/vwaH1RJ8Iip7MYKi
         lU6JEthhHG/OvxrnAGQJREBdExrfsXSd+3MzSHwQzSehGGbVDkNWiq6x5Q/ofvVN3Z0B
         igGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=mV1qixM+hRHgqOUWXlliAy9s0rAvz7UfT2PUrmz0Bbg=;
        b=ClwK0F2SjpaHxWUjFUELyn43t5lMqjbdwv2rs0hmNfmVrOrMsRrowvWG7gxWx5HTWR
         3gdboIBz6HxKOirmy5r+emIAEUmGREVtAsg72ZAcWHr2CBoYdxs6I3qyVl0z4mnSvNNV
         8t8zufpR3I2y0hikaYRylkXlBZx2d1lx1lzxqZoBNlR79G/UeAGVIDlQL1KIytCerAgA
         v2JEILoUwCcH892czLIJ+k+BLuI+xYdK8SF7k8r1SBo0+XXMg2FnZCnh6ZIzDUPyQ++B
         VdRQJbey6eALeH0/xou0bI4AfaG2PkM4KaHIQDMOCjhj2NwdF+oC7Po71lFgXEu7AEDX
         KA5w==
X-Gm-Message-State: APjAAAXh6OlKtno3iixOLyXRV8ooloxymoUNevF21eJbJvyFF2T62d0M
        rm6LCVli2UlIm2mImsQjm6g=
X-Google-Smtp-Source: APXvYqzsqrs4KzGyTV7cuCbvzAVRqRkATFzF6Sh9VtOVBsQyT5MYbXW0QCTaF3SFN81jzDCWkw8tmQ==
X-Received: by 2002:a17:90a:a48a:: with SMTP id z10mr13288587pjp.52.1581839015446;
        Sat, 15 Feb 2020 23:43:35 -0800 (PST)
Received: from workstation-portable ([103.211.17.250])
        by smtp.gmail.com with ESMTPSA id 199sm12896682pfu.71.2020.02.15.23.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2020 23:43:34 -0800 (PST)
Date:   Sun, 16 Feb 2020 13:13:30 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH RESEND] kernel: time: posix-timers: Pass lockdep expression
 to RCU lists
Message-ID: <20200216074330.GA14025@workstation-portable>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

head is traversed using hlist_for_each_entry_rcu outside an
RCU read-side critical section but under the protection
of hash_lock.

Hence, add corresponding lockdep expression to silence false-positive
lockdep warnings, and harden RCU lists.

Add macro for the corresponding lockdep expression.

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 kernel/time/posix-timers.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 0ec5b7a1d769..2ccce00af177 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -50,6 +50,8 @@ static struct kmem_cache *posix_timers_cache;
 
 static DEFINE_HASHTABLE(posix_timers_hashtable, 9);
 static DEFINE_SPINLOCK(hash_lock);
+#define hash_lock_held() \
+	lockdep_is_held(&hash_lock)
 
 static const struct k_clock * const posix_clocks[];
 static const struct k_clock *clockid_to_kclock(const clockid_t id);
@@ -120,7 +122,7 @@ static struct k_itimer *__posix_timers_find(struct hlist_head *head,
 {
 	struct k_itimer *timer;
 
-	hlist_for_each_entry_rcu(timer, head, t_hash) {
+	hlist_for_each_entry_rcu(timer, head, t_hash, hash_lock_held()) {
 		if ((timer->it_signal == sig) && (timer->it_id == id))
 			return timer;
 	}
-- 
2.24.1

