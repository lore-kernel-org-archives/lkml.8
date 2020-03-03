Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3DDC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3151F20838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tfVPG1Dw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgCCOp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:45:58 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41673 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729372AbgCCOp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:45:57 -0500
Received: by mail-pf1-f193.google.com with SMTP id j9so1555700pfa.8;
        Tue, 03 Mar 2020 06:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7+OPrhcCxhD88nBBppkS0Unot2bwdV1u+1a7nZ3TUsA=;
        b=tfVPG1Dw9PQ6yj4UwhgU3mxjYGO0RhTzt8ID6jjhlLmQXtMp52UV0OzfSqh/wdtHa6
         Kpadqio3VhBHTE/ZxRWUy1+y8qQOqbcUwNBdQzpRPBY51Ja6iPa7cgfxX5e3I0PU6xb+
         3WL6PQcWb1xkmUkC1ZN7+Bh++lKbI2tc4camwkdNPmwLbk9Xj0qcSe+fLn3nPG5N2QcC
         aijaQJOyDt0n9HnxM1+qspoC0ISrkUxvjH3HWzmLSpHaHEf4diNiiD9rpy/vkvbWPNFX
         KSRx9Qv2eJ4tsoDsMdim1pPo5zpt5UH4Bt2mpw2iEFESfH6aOgyG8tPXSdCc4dEzEKez
         9dHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7+OPrhcCxhD88nBBppkS0Unot2bwdV1u+1a7nZ3TUsA=;
        b=c8MmwVmG4cXiqKt1dJY7+J7O7mptli+5xaAOHOJeO9+lbHiZgr6thJ+O1X0U3/CFh/
         7gzK0q1Bca1sOZv3Dms5T2Q+PSc7Oph4QqnUqke9/Ce0aDbBGvOHzFrM2fACPQAg3+IU
         KS3NK59ck4Oa1cvLGYgOMuKCEp8k8V3MCnblDvTkV4ils2ewHC1MIpS7NxPIxRzuQjH9
         ERl4KeTXZRr7tGUqCLv7ZYk/dozDMBuFPB6CVc2Gcmh9nTm9fJ6MIhssbLuZj+KbA+/2
         I+0SizAKrR+ECrDYGZ8CO11cDEXEpYe29VOem71uqQGFPjTsEiuKfQ5UdyypRkOwBMAH
         AQwA==
X-Gm-Message-State: ANhLgQ0maYmUhQWETjhSsAWY1MJf2x8NcZtlOkeLgwyw06gBQoZtN6O6
        T2FRLf0wg16mXNNXisihj18=
X-Google-Smtp-Source: ADFU+vv+wWZZSCz/PWWSj2zrrPSejDYdYRTa8dEA0uwFrJBvvQJareiMv0Ev1scHr5djPToJqBs40A==
X-Received: by 2002:a63:fc62:: with SMTP id r34mr4498737pgk.437.1583246756508;
        Tue, 03 Mar 2020 06:45:56 -0800 (PST)
Received: from localhost.localdomain ([103.118.34.152])
        by smtp.gmail.com with ESMTPSA id e12sm9344869pff.168.2020.03.03.06.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:45:56 -0800 (PST)
From:   Pawan Kumar Meena <pawank1804@gmail.com>
To:     paulmck@kernel.org, joel@joelfernandes.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pawan Kumar Meena <pawank1804@gmail.com>
Subject: [PATCH RESEND] Documentation: RCU: lockdep.txt: Convert to lockdep.rst
Date:   Tue,  3 Mar 2020 20:15:46 +0530
Message-Id: <20200303144546.20405-1-pawank1804@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch converts lockdep.txt to lockdep.rst and adds it to index.rst.

Signed-off-by: Pawan Kumar Meena <pawank1804@gmail.com>
---
 Documentation/RCU/index.rst                    | 1 +
 Documentation/RCU/{lockdep.txt => lockdep.rst} | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)
 rename Documentation/RCU/{lockdep.txt => lockdep.rst} (97%)

diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 81a0a1e5f767..109dea13f165 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -10,6 +10,7 @@ RCU concepts
    arrayRCU
    rcubarrier
    rcu_dereference
+   lockdep
    whatisRCU
    rcu
    listRCU
diff --git a/Documentation/RCU/lockdep.txt b/Documentation/RCU/lockdep.rst
similarity index 97%
rename from Documentation/RCU/lockdep.txt
rename to Documentation/RCU/lockdep.rst
index 89db949eeca0..3a88d8a59753 100644
--- a/Documentation/RCU/lockdep.txt
+++ b/Documentation/RCU/lockdep.rst
@@ -1,4 +1,7 @@
+.. _lockdep_doc:
+
 RCU and lockdep checking
+========================
 
 All flavors of RCU have lockdep checking available, so that lockdep is
 aware of when each task enters and leaves any flavor of RCU read-side
@@ -63,7 +66,7 @@ checking of rcu_dereference() primitives:
 The rcu_dereference_check() check expression can be any boolean
 expression, but would normally include a lockdep expression.  However,
 any boolean expression can be used.  For a moderately ornate example,
-consider the following:
+consider the following::
 
 	file = rcu_dereference_check(fdt->fd[fd],
 				     lockdep_is_held(&files->file_lock) ||
@@ -82,7 +85,7 @@ RCU read-side critical sections, in case (2) the ->file_lock prevents
 any change from taking place, and finally, in case (3) the current task
 is the only task accessing the file_struct, again preventing any change
 from taking place.  If the above statement was invoked only from updater
-code, it could instead be written as follows:
+code, it could instead be written as follows::
 
 	file = rcu_dereference_protected(fdt->fd[fd],
 					 lockdep_is_held(&files->file_lock) ||
@@ -105,7 +108,7 @@ false and they are called from outside any RCU read-side critical section.
 
 For example, the workqueue for_each_pwq() macro is intended to be used
 either within an RCU read-side critical section or with wq->mutex held.
-It is thus implemented as follows:
+It is thus implemented as follows::
 
 	#define for_each_pwq(pwq, wq)
 		list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node,
-- 
2.17.1

