Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F57C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A77A20728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nyCDumfv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgAQNhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:37:36 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:35898 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgAQNhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 08:37:35 -0500
Received: by mail-pj1-f68.google.com with SMTP id n59so3338267pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 05:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YHBJFZwYhK7Tmr8esHxqJUtoRn8WnZqTo+H+EnwYrJo=;
        b=nyCDumfvEcGI6zIFcDK5993aLcMZr2BSrphFpVcsIQuJdGZXvAjSxzqH+3c5I9Paf5
         AXRmanS3PLoIGFPLvxYipMqaTeiAD2kEWff4ROiwS4h0BEJd116OLwyHSiYcRxjm5iHB
         5qhIrMXvU0e+VyL0sw+9be4Jx0S6pXmg+kCSt9gDaNyoeFxk/Ph6os7uImlW3gbsAj0g
         DSlOUoP2+jyIkbnHe7USSl7SA/EgB4ObNw0G1wIcgPAXfUxelXegmmO/IDwMKirYFM5h
         /biIw7TgNJY/5OS6wogEgiDzzd/T16483kcJttOHMzl/0UzUU1J1odaLt0KmFfHrldT9
         Rpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YHBJFZwYhK7Tmr8esHxqJUtoRn8WnZqTo+H+EnwYrJo=;
        b=cWR6u/FtIniliqzDdrpdX6OqyKJuZ1rvPsCUb+GDXH89Icuu1J32XUBFgfWc/i8izu
         A839GJTzhLQig+or0etMbO0TbnyzoYsiRI5z04REpc2oIA+C8PkT9RoCld4vuxfhEvLl
         LiKOMp0V7UlK0y45DIx3GKXyJUPJUfdNmw0vJFTjIaNLVLcqGkyKetlATR2y7m7vlN44
         n1dohEipWFof8Y1Fzfe1NVDoTdbBp6ui2tc9WFDtFBF9sDTNRGflqdAooUSUbI96S/4L
         hGP4yEr99kyHc2+VA5QVZqlRopx9EST2HDFSnvkv8b5KR4ZjBXaaG+aOy7dOAWbl5mVZ
         A84w==
X-Gm-Message-State: APjAAAVdbzcGB8uzmT6fBy0hz0J3RqybA3Cr9QthJzpqOudwJIwKf8Lo
        amrdyDWMnTGccdU1HVN97UI=
X-Google-Smtp-Source: APXvYqw8EPpDPsWKBxlJK9XKZQjLvJ/SuPz8bvOZHAxShVJvBgezCmAcl0rhxK02SG64hvN+9RT1fQ==
X-Received: by 2002:a17:90b:4004:: with SMTP id ie4mr5679480pjb.49.1579268254980;
        Fri, 17 Jan 2020 05:37:34 -0800 (PST)
Received: from localhost.localdomain ([103.211.17.168])
        by smtp.googlemail.com with ESMTPSA id e15sm3229519pja.13.2020.01.17.05.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:37:34 -0800 (PST)
From:   Amol Grover <frextrite@gmail.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>
Subject: [PATCH v2] drivers: soc: ti: knav_qmss_queue: Pass lockdep expression to RCU lists
Date:   Fri, 17 Jan 2020 19:00:49 +0530
Message-Id: <20200117133048.31708-1-frextrite@gmail.com>
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

Add macro for the corresponding lockdep expression.

Signed-off-by: Amol Grover <frextrite@gmail.com>
---
v2:
- Remove rcu_read_lock_held() from lockdep expression since it is
  implicitly checked for.

 drivers/soc/ti/knav_qmss_queue.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 1ccc9064e1eb..37f3db6c041c 100644
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
+				knav_dev_lock_held())
 
 #define for_each_instance(idx, inst, kdev)		\
 	for (idx = 0, inst = kdev->instances;		\
-- 
2.24.1

