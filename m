Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7D3C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 417022467B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErOK+PKg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgA1H2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 02:28:55 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33663 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgA1H2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 02:28:55 -0500
Received: by mail-pl1-f193.google.com with SMTP id ay11so4764257plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 23:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TawkIIO8Cb/tgElG2C0aCqCdkT8w60kpDmt3fNug/+o=;
        b=ErOK+PKgLRTXy1g+eXt3RPbgNMGJ+fJJgirflfywne1W8bVviXLif+rxPq2ttpBrxU
         NWSZnmUgNnk97CfVlkQotJmDRhtSYT57PDJmwE22yqZdLt54ZXWU9xgnuCEn9ZVQPvBv
         KeLS0CyffyxruVl1X6nKiDu/m6YIbFpUh83GuxAUz3c9WmkvlMEDPDsL5yEjlPHzIFLB
         MaydMBc7Wu4ax3jrHNGVCcVN/DjSS1SfC+rx4StGYW6t6CL1L2mTpUQIezntT7Kd7r2q
         IK9h3+/cwtwg0LFlZNuFmFQHfWNKh+zDY7O3neLu9wQ/j3zKpVjO8aKto6sByZejXsjA
         +OkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TawkIIO8Cb/tgElG2C0aCqCdkT8w60kpDmt3fNug/+o=;
        b=aZnW+kWUsucjr4kvMxTrlbH86euKvDb/3sY3AISqoMo/itqrD4CW/CqGOq4yDNnuVe
         hvjpX5x11CMUMht6bMqp5yFaN7IL1A5KNE2pfQ5lMvGpZYI2NUaaGDI2Cnz2d9FPaLDY
         G3y1KWqX1mFYLAvBXD5NK6TgZNhkiBVWM/JjRNEZAU5Le/CRjixisr4ckqPeqaqGihEm
         IlB3mjMQYPcD1co+Q5U+ZVAN7qQiOHvUv9ePK18wYeK8erK71TjR5a8NC2l35G1fRJjK
         /s+RF7sTJ879mUj8H3gze+HgxCrA5tn4CLfzi/m1e6U+vRQHLNFUmHDgsqXwcEgH/OZE
         7ChQ==
X-Gm-Message-State: APjAAAX60hdOZQUY0cerGSQbMkYBeMLJZhcqtbqlfu1q5UN+4uAtz/E8
        X7tLaZSR1n/OVXitQ8YV55g=
X-Google-Smtp-Source: APXvYqy0iufQreHHLowZtxXJRW3T0q5xrqdUwdfyK1KW2xyLCd9zueHsqYHKYZsqGj+Pc/kp2WU0ZQ==
X-Received: by 2002:a17:90a:8a98:: with SMTP id x24mr3295738pjn.113.1580196534294;
        Mon, 27 Jan 2020 23:28:54 -0800 (PST)
Received: from localhost.localdomain ([103.211.17.252])
        by smtp.googlemail.com with ESMTPSA id j17sm18566735pfa.28.2020.01.27.23.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 23:28:53 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Amol Grover <frextrite@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH] cred: Use RCU primitives to access RCU pointers
Date:   Tue, 28 Jan 2020 12:57:41 +0530
Message-Id: <20200128072740.21272-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

task_struct.cred and task_struct.real_cred are annotated by __rcu,
hence use rcu_access_pointer to access them.

Fixes the following sparse errors:
kernel/cred.c:144:9: error: incompatible types in comparison expression
(different address spaces):
kernel/cred.c:144:9:    struct cred *
kernel/cred.c:144:9:    struct cred const [noderef] <asn:4> *
kernel/cred.c:145:9: error: incompatible types in comparison expression
(different address spaces):
kernel/cred.c:145:9:    struct cred *
kernel/cred.c:145:9:    struct cred const [noderef] <asn:4> *

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 kernel/cred.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index 809a985b1793..3043c8e1544d 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -141,8 +141,8 @@ void __put_cred(struct cred *cred)
 	cred->magic = CRED_MAGIC_DEAD;
 	cred->put_addr = __builtin_return_address(0);
 #endif
-	BUG_ON(cred == current->cred);
-	BUG_ON(cred == current->real_cred);
+	BUG_ON(cred == rcu_access_pointer(current->cred));
+	BUG_ON(cred == rcu_access_pointer(current->real_cred));
 
 	if (cred->non_rcu)
 		put_cred_rcu(&cred->rcu);
-- 
2.24.1

