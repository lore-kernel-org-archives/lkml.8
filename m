Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FD3C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 13:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA7C421569
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 13:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z8J8xUgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgAUNM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 08:12:28 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54590 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgAUNM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 08:12:27 -0500
Received: by mail-pj1-f66.google.com with SMTP id kx11so1347618pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 05:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mV1qixM+hRHgqOUWXlliAy9s0rAvz7UfT2PUrmz0Bbg=;
        b=Z8J8xUgv8y94kuhtX71q1/CgB8A/sNC1KYd1fA4XQ8dsGsaiP8ZgINBuCPnzRg4jHV
         CderUAy51B78k5hydIFo8YC5g4HekpmRgr3HyEQaYAgvf6qtS8Aji3Xgdw3dAdkh7Lu9
         rbyrLtr0sphBHAJXTzNAIU/PPtgvQu1s9enlYvGdqLY7A+118uke39A8zjn1l+gy0Csu
         u1H7QAonjdPZPsxVEQjA9Cq5C0irlKLA3lGcMYyt7ZKo4oSVRQtsag//IGj7nJHYLaXg
         C5a0GPYzOBtZkQzlXuV2WhmR17axvDCbDCM8N3tX/9uSQmdOy+L85hYnf/5L1kItG67Y
         FSEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mV1qixM+hRHgqOUWXlliAy9s0rAvz7UfT2PUrmz0Bbg=;
        b=S7TZl+bSRqBCDdkD3T8Whu9ZJ4Jodhn766uy5uVlBSA03AdnJh9sgcx0iXozc+3AZZ
         W6FjJbhUZoxjLMV4RDJ+qlZyXi3iNSCS3A2wlBPEd/b2mRrerJLGF6l1t9b+4YAmH/Ks
         TxjXTd8SyuFZdGbD+kSldNjhTYT8jXoLZoCEd1U9jAK2ZXiHCZ+rxOegJ+w//oUCxiqM
         yTOotlQ+7wVPnEyhVNaQoQrssYI4sjfCj1H+pS56z0EIijDMbfCu+jLYm8xyJB4N6Daa
         1z1rkaRuYFltcHQ7H8nbSx/MezyUL9O0mtbIou9gfSwyhuBJbN4+ldoNv6p9boSEsquy
         6/hA==
X-Gm-Message-State: APjAAAWmSSiGPMkLHd/bSONqQs+r6HZpmrOZ2zXxwvW8/CGWCPRIRXFQ
        fE9jqEBf1THdj9U9QjYwkI8=
X-Google-Smtp-Source: APXvYqyEZrfngkxRMK2d39FAOYp9BghixyVDEshJdO27mt1aBls2Y29kbpl7VvmR8iQqVYQg2VnG/Q==
X-Received: by 2002:a17:90a:1697:: with SMTP id o23mr5418876pja.62.1579612347118;
        Tue, 21 Jan 2020 05:12:27 -0800 (PST)
Received: from localhost.localdomain ([146.196.37.201])
        by smtp.googlemail.com with ESMTPSA id i8sm44027333pfa.109.2020.01.21.05.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 05:12:26 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH] kernel: time: posix-timers: Pass lockdep expression to RCU lists
Date:   Tue, 21 Jan 2020 18:41:33 +0530
Message-Id: <20200121131132.15830-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

