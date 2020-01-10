Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5049CC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 12:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF4F2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 12:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEXo+Y+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgAJMlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 07:41:09 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38919 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbgAJMlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 07:41:08 -0500
Received: by mail-pl1-f195.google.com with SMTP id g6so823230plp.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 04:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KdKUDe5VNtZZyWUDsEVdrhShf2Kcu/VrtdXGE+9fTXo=;
        b=aEXo+Y+Ie5rmicBedqlm+l0xcucSqrT0flZYEl8YMu8DkFlvzVXCDfNNBt0Ss7lIxo
         Ee6QISm89zpDn37usCnsQkHlOScps8LfSO+fn02Z8bMAO/Om7/QL03ogwBfHRxQ/b90p
         BD0vwMHX7I1oywX/wtQ4z7CWLumArREiGtSx7sFxv/iZuwHJl8srnYQkAlwAP6CA13C+
         q4JtK15TFGnjxhw+GpDudO0ScQWna7BEvHzLoM1SLIdMMYuC79rUla8uak+ryyjU52PB
         KPxrj6LMdZmVwlp0CqjledxBozinckQdFyzr4R/PNh2/7L+AFJgb2gnaaTp/SNhu8tb9
         R0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KdKUDe5VNtZZyWUDsEVdrhShf2Kcu/VrtdXGE+9fTXo=;
        b=NkCVzEFJfnzfd+1Z6rklzRpOdheVcBjRxs1xWisyvjNMTBZJ36V1PUWhBKLRAqrDur
         4UBQxVU/OhG+UpHXtbzKgw17JBp7D/yGh9ynB0XCKZvT9PWaN0mwxq97WetEMDCcI5d4
         rNmBk1IEPIQ8695+pmZjBgL7hDeBL4FfAwYHen3Jcd3+4aWFcBZCUPZtRqjpPb9baFWl
         N7dgYotMoY5Vz51TEPT67R+7WFeKv339f4EJ/PXBYxzAiJiMO3H2aaWEbdz1UW1b9Cvb
         LrDBcliorgumjhSWrGCY8fIxrdYARMPzyeOsKH0N5bRLMNoeCwbo7GY4shMDiyDuFc2P
         QYMQ==
X-Gm-Message-State: APjAAAWHdkF7qwTUSyrXNKrhWMXmCp/r7etRPBvD+YLV3uI4W4vIfDzf
        pVIm4OJrqPtaGx2SSoYyTes=
X-Google-Smtp-Source: APXvYqz1hwPwNDFF8rpc5BstYqeYvTPUUxNEteYq7zFknzooAoSivNVQ2BUO0MS/yigWPRMlbviL0A==
X-Received: by 2002:a17:902:ab8c:: with SMTP id f12mr4195297plr.268.1578660068150;
        Fri, 10 Jan 2020 04:41:08 -0800 (PST)
Received: from localhost.localdomain ([103.211.17.220])
        by smtp.googlemail.com with ESMTPSA id i11sm2890922pjg.0.2020.01.10.04.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 04:41:07 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH] drivers: soc: ti: knav_qmss_queue: Pass lockdep expression to RCU lists
Date:   Fri, 10 Jan 2020 18:02:13 +0530
Message-Id: <20200110123212.26756-1-frextrite@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

inst->handles is traversed using list_for_each_entry_rcu
outside an RCU read-side critical section but under the protection
of knav_dev_lock.

Hence, add corresponding lockdep expression to silence false-positive
lockdep warnings, and harden RCU lists.

Add macro for the corresponding lockdep expression to make the code
clean and concise.

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
 drivers/soc/ti/knav_qmss_queue.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 1ccc9064e1eb..888dc091c63b 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -25,6 +25,8 @@
 
 static struct knav_device *kdev;
 static DEFINE_MUTEX(knav_dev_lock);
+#define knav_dev_lock_held() \
+	lockdep_is_held(&knav_dev_lock)
 
 /* Queue manager register indices in DTS */
 #define KNAV_QUEUE_PEEK_REG_INDEX	0
@@ -52,8 +54,9 @@ static DEFINE_MUTEX(knav_dev_lock);
 #define knav_queue_idx_to_inst(kdev, idx)			\
 	(kdev->instances + (idx << kdev->inst_shift))
 
-#define for_each_handle_rcu(qh, inst)			\
-	list_for_each_entry_rcu(qh, &inst->handles, list)
+#define for_each_handle_rcu(qh, inst)				\
+	list_for_each_entry_rcu(qh, &inst->handles, list,	\
+				rcu_read_lock_held() || knav_dev_lock_held())
 
 #define for_each_instance(idx, inst, kdev)		\
 	for (idx = 0, inst = kdev->instances;		\
-- 
2.24.1

