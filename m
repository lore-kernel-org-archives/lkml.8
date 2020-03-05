Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56899C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BF6F208C3
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="yUJonfYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbgCEWNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:13:39 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:40293 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCEWNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:13:38 -0500
Received: by mail-qv1-f68.google.com with SMTP id u17so54408qvv.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 14:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+B1geMfKugZ9/Y0qjQLB48rxQUh2J0QAO4pKzK9MPtc=;
        b=yUJonfYkzQmASLfePqIhRviUDsAM+NazCmszFozaooCnRqJBeQ04Ol7bzuEhApnWu/
         6z+YcC4kmkO9bpOh0sQ7sXKgWLpk6VI9cD97Lv69w9p65AnjBmQDn5Tak8mcpvMakWa1
         lHaM3zQB9LWo5dvFjy/l6+RnJAzC3oJsttK1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+B1geMfKugZ9/Y0qjQLB48rxQUh2J0QAO4pKzK9MPtc=;
        b=aoBCVSUnXofvIDaxw9Yy48ZMfppLGpXCGeW5mWq30RPBS3UO3Jn5djZbfSLysXCa3O
         fyD17CsZwek6x9Gs/yN1h1vzSTgPCuvG6y503lt1RUAOrpz7CEDIq1Ww43ML1cV+QayW
         9mYcLu0kJq45r9PToOgJIs/c4ise6IEZAUqJMrw8Dfnfkpfq+y/CC8yFLhubQiXREkND
         vfmOcLdSY2qL4gj7Ebg9IqV99gwSezksF4Wwzk60gdBvHzbX5T/5jPCOFi+bLDbxE5ML
         sGZmkKpqB3KC/M40MZY91e+D8HwJdhK4N63kdMl6KdsGfTh5sXUz345WYS/ipRUTypsC
         QaKA==
X-Gm-Message-State: ANhLgQ0R+mlnqZscJP499I62LsHtHcD8Rc4QJw9/SNlS+yPI1fqhezwE
        Ru5t71Hdyy6RmJNF7SFg5kYafLBBq4k=
X-Google-Smtp-Source: ADFU+vt6v0+EF3++rFKijcSaojGu0jqGRlv6a89byICbegBod4UGPa8P3gUncs01N8yuFqjTtyMQTQ==
X-Received: by 2002:a05:6214:1404:: with SMTP id n4mr374856qvx.237.1583446417238;
        Thu, 05 Mar 2020 14:13:37 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id n8sm16366198qke.37.2020.03.05.14.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 14:13:36 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, urezki@gmail.com
Subject: [PATCH linus/master 1/2] rcuperf: Add ability to increase object allocation size
Date:   Thu,  5 Mar 2020 17:13:22 -0500
Message-Id: <20200305221323.66051-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows us to increase memory pressure dynamically using a new
rcuperf boot command line parameter called 'rcumult'.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

---
 kernel/rcu/rcuperf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
index da94b89cd5310..36f0ed75c7cf3 100644
--- a/kernel/rcu/rcuperf.c
+++ b/kernel/rcu/rcuperf.c
@@ -87,6 +87,7 @@ torture_param(bool, shutdown, RCUPERF_SHUTDOWN,
 torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
 torture_param(int, writer_holdoff, 0, "Holdoff (us) between GPs, zero to disable");
 torture_param(int, kfree_rcu_test, 0, "Do we run a kfree_rcu() perf test?");
+torture_param(int, kfree_mult, 1, "Multiple of kfree_obj size to allocate.");
 
 static char *perf_type = "rcu";
 module_param(perf_type, charp, 0444);
@@ -627,7 +628,7 @@ kfree_perf_thread(void *arg)
 
 	do {
 		for (i = 0; i < kfree_alloc_num; i++) {
-			alloc_ptr = kmalloc(sizeof(struct kfree_obj), GFP_KERNEL);
+			alloc_ptr = kmalloc(kfree_mult * sizeof(struct kfree_obj), GFP_KERNEL);
 			if (!alloc_ptr)
 				return -ENOMEM;
 
@@ -712,6 +713,8 @@ kfree_perf_init(void)
 		schedule_timeout_uninterruptible(1);
 	}
 
+	pr_alert("kfree object size=%lu\n", kfree_mult * sizeof(struct kfree_obj));
+
 	kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
 			       GFP_KERNEL);
 	if (kfree_reader_tasks == NULL) {
-- 
2.25.0.265.gbab2e86ba0-goog

