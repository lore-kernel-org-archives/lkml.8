Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1205C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B74F21D7F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sslab.ics.keio.ac.jp header.i=@sslab.ics.keio.ac.jp header.b="YwkDJHyK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730212AbgIINJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 09:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729913AbgIINAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 09:00:02 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4075CC061755
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 05:57:23 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 67so1992134pgd.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 05:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/xkIWni8SgM73BFi4hmvbWE+41W2IJ3UZaLFsKLGrO0=;
        b=YwkDJHyKoglYQYFHc7LcxMWbQGCUl28Hi1L9vfSTiRoQHDFZ/9HixdLYvuQzUyBm15
         z6QM6Om7t/Yg4JfftmrNdAYJIUIpCD9O62viw/Qaha/v962oMvVgzddrvI3w+kF200RS
         AoIIjoXRgEo78UrMFb6wOCqZ4yAzq9mwLPv0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/xkIWni8SgM73BFi4hmvbWE+41W2IJ3UZaLFsKLGrO0=;
        b=StQcGtKa30v8zk+2jdRXLR50eek159ZJNi2q2u3TUqTKJH/GOvQ2QZC7wTm0dfqD9o
         E8uSsIw1UtK+W2q9q/WWvyco+0Ee3c3J83ymgBaPBPdD8HjNShFWreSJYcxsgiE4AdM1
         Yn41enMlVzrmMG0XGZ5LqPyHLh8ouv35I/bkkeLLoLJmqO8gqLDAPwb6nvG+xVcvMJ4a
         aI754OrIlIxgpF0TiclT0sjgykNRxvzLXdpLLB5IIor4462pZOuOmpjm1hogmJnFR73P
         Th5rwATZv/JPtFc6zNzJeU/o1mlzOO+3j7UNrulzEt5u2rfJCTYFK/cM3kTIQyblPCoy
         dS1g==
X-Gm-Message-State: AOAM531mLanSXF3d7an2eq04NnakmwgRg98sPEaz2YwYt31mH4FUxDRD
        06oXo6SvoSVDvxrbKxNiAR6eig==
X-Google-Smtp-Source: ABdhPJwT/47DO5VQWrTBUV23H0KtdJegUF7iPDdwPNWnUhe3halt7b6g1qpksE6Sf0QqVS79V7FBQw==
X-Received: by 2002:a63:e813:: with SMTP id s19mr545536pgh.33.1599656242537;
        Wed, 09 Sep 2020 05:57:22 -0700 (PDT)
Received: from brooklyn.i.sslab.ics.keio.ac.jp (sslab-relay.ics.keio.ac.jp. [131.113.126.173])
        by smtp.googlemail.com with ESMTPSA id l21sm2192191pgb.35.2020.09.09.05.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 05:57:21 -0700 (PDT)
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     keitasuzuki.park@sslab.ics.keio.ac.jp,
        takafumi@sslab.ics.keio.ac.jp,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: siano: fix memory leak of debugfs members in smsdvb_hotplug
Date:   Wed,  9 Sep 2020 12:56:57 +0000
Message-Id: <20200909125659.20586-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When dvb_create_media_graph fails, the debugfs kept inside client should
be released. However, the current implementation does not release them.

Fix this by adding a new goto label to call smsdvb_debugfs_release.

Fixes: 0d3ab8410dcb ("[media] dvb core: must check dvb_create_media_graph()")
Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
---
 drivers/media/common/siano/smsdvb-main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/common/siano/smsdvb-main.c b/drivers/media/common/siano/smsdvb-main.c
index 88f90dfd368b..ae17407e477a 100644
--- a/drivers/media/common/siano/smsdvb-main.c
+++ b/drivers/media/common/siano/smsdvb-main.c
@@ -1169,12 +1169,15 @@ static int smsdvb_hotplug(struct smscore_device_t *coredev,
 	rc = dvb_create_media_graph(&client->adapter, true);
 	if (rc < 0) {
 		pr_err("dvb_create_media_graph failed %d\n", rc);
-		goto client_error;
+		goto media_graph_error;
 	}
 
 	pr_info("DVB interface registered.\n");
 	return 0;
 
+media_graph_error:
+	smsdvb_debugfs_release(client);
+
 client_error:
 	dvb_unregister_frontend(&client->frontend);
 
-- 
2.17.1

