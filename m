Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B06C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2884921835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="c8G5/cQU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgAVQjG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:39:06 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42598 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgAVQjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:39:06 -0500
Received: by mail-qt1-f194.google.com with SMTP id j5so8936qtq.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 08:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0bWkg7Q4I8bENDzcbjB/xR8zc42ZRd/nWwAQlzcE91Q=;
        b=c8G5/cQUD86GhY8470AlVuHzTZPruhjsIRXvt9GeW64ovHecpcEcaw+2VYPH7RpCOl
         BKXmgxERH9qOOK255b14Dx72RHp4yoRyoWyBtpgEJacTxq1rfV/5FV/cR/sM85JRH4cT
         NhBzwUogf79eLnRt4m2Wic/7785s1lENfS1QiDa0sjkAUkBwUYcdpeMHEQH6HsqwLdvp
         H99doLzUV/UcrkNmvzhVzbB+XNAC0WIcoMxDKW0Wdqt692SFdbqJysaQ/jq0L6PZa1Vn
         iu8nSotA5my+ebj/z5biJT4Lpep8Z8uZaUpm8XfGRWTpORkWxBR4abQuATkOksRd9T6M
         lGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0bWkg7Q4I8bENDzcbjB/xR8zc42ZRd/nWwAQlzcE91Q=;
        b=XQ50sYguP41UrB1O/OK1bLuL7ME7nYw3c2OdVmz/uxymPU1ei9kLVIpnxkp3Ezh6nR
         xmn5Fu2XrwxnNNNHWIQTG0ryI1Yx1nDTnyKeL/iqbKRvOjfHsmbv1XxYj94TeHvXXTP5
         W/JOf+cKYSA7+S6S+6D5Z/C7JLdGbukXnN5Cb2xaPaFZadRrPB64X9BJnjeGpK71GdYS
         2vFxy+/OZCfSsoqs9ln65NLpR6/FVP8pid3J2GAiPz9qQzYdkcoZPkmInj32gnpPDCJh
         PwcD6gGcxarcAuMaPjXz3wKWsLfv486VdPJusMQ8qJYzY6PnFjTFyhFseYNUfyTDAoWF
         DWTA==
X-Gm-Message-State: APjAAAVSmzwuY6mY0WnT351jOoA4TZEbV3uBBzQ9sH5AZF8pXZy6W7fv
        laBAX/bLqWVCC9a4mTcO/qEz2w==
X-Google-Smtp-Source: APXvYqz21azgWfVbW+LSdFc5lEgnqAaDAuKLGJ2yUCdnzDwkSMqG/twy3VejBUt3X0uCvUHzvGs9WA==
X-Received: by 2002:ac8:2a06:: with SMTP id k6mr11306360qtk.145.1579711144921;
        Wed, 22 Jan 2020 08:39:04 -0800 (PST)
Received: from ovpn-123-97.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l33sm21559163qtf.79.2020.01.22.08.39.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jan 2020 08:39:04 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, will@kernel.org, elver@google.com,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
Date:   Wed, 22 Jan 2020 11:38:57 -0500
Message-Id: <20200122163857.4605-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KCSAN complains,

 write (marked) to 0xffff941ca3b3be00 of 8 bytes by task 670 on cpu 6:
  osq_lock+0x24c/0x340
  __mutex_lock+0x277/0xd20
  mutex_lock_nested+0x31/0x40
  memcg_create_kmem_cache+0x2e/0x190
  memcg_kmem_cache_create_func+0x40/0x80
  process_one_work+0x54c/0xbe0
  worker_thread+0x80/0x650
  kthread+0x1e0/0x200
  ret_from_fork+0x27/0x50

 read to 0xffff941ca3b3be00 of 8 bytes by task 703 on cpu 44:
  osq_lock+0x18e/0x340
  __mutex_lock+0x277/0xd20
  mutex_lock_nested+0x31/0x40
  memcg_create_kmem_cache+0x2e/0x190
  memcg_kmem_cache_create_func+0x40/0x80
  process_one_work+0x54c/0xbe0
  worker_thread+0x80/0x650
  kthread+0x1e0/0x200
  ret_from_fork+0x27/0x50

which points to those lines in osq_wait_next(),

  next = xchg(&node->next, NULL);
  if (next)
	break;

Since only the read is outside of critical sections, fixed it by adding
a READ_ONCE().

Signed-off-by: Qian Cai <cai@lca.pw>
---
 kernel/locking/osq_lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 6ef600aa0f47..8f565165019a 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -77,7 +77,7 @@ osq_wait_next(struct optimistic_spin_queue *lock,
 		 */
 		if (node->next) {
 			next = xchg(&node->next, NULL);
-			if (next)
+			if (READ_ONCE(next))
 				break;
 		}
 
-- 
2.21.0 (Apple Git-122.2)

