Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6AAC1975A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 01:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7225220732
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 01:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="LKskb9/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgCWB5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 21:57:51 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34358 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgCWB5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 21:57:48 -0400
Received: by mail-qk1-f193.google.com with SMTP id i6so4714229qke.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 18:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vz9xBYT7w2JZFqAtcJyqqCJgtO34i29+WCO4KTVtkB8=;
        b=LKskb9/qJnxs+ndLBRI6a2Qvn4blylgqfSDZDNHlcfPrnXsyfOH+lvtJTl/4/hpMFZ
         ehZS19cQtTegYgR2LjnZPtCsQKUNC/VZ7WGPfwJnCLebkOze/3K6jTLYgwHpVxON6LKA
         ogda2WQ/xUnbauY8b7cNfrjtnYo/DoaCrYvko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vz9xBYT7w2JZFqAtcJyqqCJgtO34i29+WCO4KTVtkB8=;
        b=QnVCvVtMbu0jsZAr54w3lJCNhmdViqtAKdrl78zoRJBY2jR4rtNTHfFql4sOFddfI3
         66ZltaDfFmDBYjp9EYr4Yw9dWE+EQigui4jgrLVaMTaUiX/PoCFgh1wHYY6rXf///6Z3
         Ryw6qllbIGcbPYurZ/+Cs8NW3v0pbqDc9/aT4JGq1avLg9FpDOSjhbu66EV9sVJjKTWr
         7K0hsvW5ODMgsVq4j+YyArDAePY3Y46UCsDAo5Jg5SAj6WPpShL4Rrl09dpGAefNXO0B
         NrlHQ4miO4qLVHGEgXfIKIe7UiSwDx7x4QBW8mL2R9sxYi/zD0mC16PA4ACRGPWS/pjA
         PHPA==
X-Gm-Message-State: ANhLgQ3ZC5n7lGjx4MAAEagnmf6ouPkdGKke7V+HkoF+KPtkN5fmR50W
        Y6QbPD8RDTpUALpiO3IHdI4NVNpe+ho=
X-Google-Smtp-Source: ADFU+vt1yWrK2R2GI2UFyps1U5tV/pTHQam8GzIYyN4qfwwXi4mmjWSN2KEPsWPNu5U2UR1d7x9Ieg==
X-Received: by 2002:a37:8b01:: with SMTP id n1mr16659727qkd.407.1584928666324;
        Sun, 22 Mar 2020 18:57:46 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id e66sm10146233qkd.129.2020.03.22.18.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 18:57:46 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>, linux-doc@vger.kernel.org
Subject: [PATCH v2 4/4] MAINTAINERS: Update maintainers for new Documentaion/litmus-tests/
Date:   Sun, 22 Mar 2020 21:57:35 -0400
Message-Id: <20200323015735.236279-4-joel@joelfernandes.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200323015735.236279-1-joel@joelfernandes.org>
References: <20200323015735.236279-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Also add me as Reviewer for LKMM. Previously a patch to do this was
Acked but somewhere along the line got lost. Add myself in this patch.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc1d18cb5d186..fc38b181fdff9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9699,6 +9699,7 @@ M:	Luc Maranget <luc.maranget@inria.fr>
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 R:	Akira Yokosawa <akiyks@gmail.com>
 R:	Daniel Lustig <dlustig@nvidia.com>
+R:	Joel Fernandes <joel@joelfernandes.org>
 L:	linux-kernel@vger.kernel.org
 L:	linux-arch@vger.kernel.org
 S:	Supported
@@ -9709,6 +9710,7 @@ F:	Documentation/atomic_t.txt
 F:	Documentation/core-api/atomic_ops.rst
 F:	Documentation/core-api/refcount-vs-atomic.rst
 F:	Documentation/memory-barriers.txt
+F:	Documentation/litmus-tests/
 
 LIS3LV02D ACCELEROMETER DRIVER
 M:	Eric Piel <eric.piel@tremplin-utc.net>
-- 
2.25.1.696.g5e7596f4ac-goog

