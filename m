Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169ABC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1EB7206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJ5F5yld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728411AbgHQJCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbgHQJCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:02:34 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EA5C06138A;
        Mon, 17 Aug 2020 02:02:34 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m34so7797767pgl.11;
        Mon, 17 Aug 2020 02:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gm2DPvF4/I64ZAeUJOgSkbWKhyOzAElLnGagSu5aOZE=;
        b=mJ5F5yld6XickAHkvpBb6JckeIwY+bA+85siQwV3lN0jaztwnK365EyFRr/uQvz1yk
         XO0zlZv6rWVSyY8Dhd0gGIenv3YPdwJN3G69408jkglbW+u68hu8IBKc40WjDTLyTggH
         3RhPklarqCEx0e+sEHZ5XJET0lGsJEgbuSlU6OFZbJsF6sORYH51Iqccd1QD4gdYl3wo
         XcmGgxA0zhWX3i7FAwXWRRt7OAzBVmSsDo4xFkuLn1PyFan6fPqLb14InRHksPqD1Rm1
         I0ggraWJpV8DM9XeC34rrApCjEQGSgmlQ4ww4ZDkE19y+PJLZdca3xC1Waq5EHb4j4ZC
         ekaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gm2DPvF4/I64ZAeUJOgSkbWKhyOzAElLnGagSu5aOZE=;
        b=UI9LGtD3ucQjzDcJDbfBAsKeLlO6ARSW3yCKOGWPsoPiPd31XzfeDcQdK7NWjfM6JG
         s0gu3CLlsDf7RvVoJLaAmJMOdT8dlZQ6SXLF0xRKZZiuJ0NZUfVdnU9TIKqVmF92u6ja
         xhRIVAtsPJPjPACJ9rHTJTCLM+ftSXy3L4zky73V7AnjS6APDB2Aw4xbvXhy6++O2YgB
         3+T1C7OBTlq3ZGsKghVhAmRZXkU/MGup8vPDZBpy8fvm23esJ2mzeylik9wHEVR9cLS+
         Mp5r22OVVMzYQvOnSQaEpI+PBRNHvtQt7P1pIZjIQ6tvXI6BFRXvOeLYkj+gxGhKufYK
         DT2Q==
X-Gm-Message-State: AOAM531mbu5jrtXYHqvblB0IqomIGcsqG+6JwkNNCSjXbqkd9FsmRM2G
        8RJeuaWzs0UgMmHXilubt0E=
X-Google-Smtp-Source: ABdhPJzaHBXW6zQTImjBsJ8W8K4gYkr4wCtwsNf4qlxo3NDdA8id6na2HB0/9zVB74dwUb98LkWYLg==
X-Received: by 2002:a65:408c:: with SMTP id t12mr9819753pgp.204.1597654954303;
        Mon, 17 Aug 2020 02:02:34 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id f3sm19488238pfj.206.2020.08.17.02.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 02:02:33 -0700 (PDT)
From:   Allen Pais <allen.cryptic@gmail.com>
To:     duncan.sands@free.fr, gregkh@linuxfoundation.org,
        jacmet@sunsite.dk, balbi@kernel.org, leoyang.li@nxp.com,
        johan@kernel.org
Cc:     keescook@chromium.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 2/7] usb: c67x00: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 14:32:04 +0530
Message-Id: <20200817090209.26351-3-allen.cryptic@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817090209.26351-1-allen.cryptic@gmail.com>
References: <20200817090209.26351-1-allen.cryptic@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Allen Pais <allen.lkml@gmail.com>

In preparation for unconditionally passing the
struct tasklet_struct pointer to all tasklet
callbacks, switch to using the new tasklet_setup()
and from_tasklet() to pass the tasklet pointer explicitly.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Signed-off-by: Allen Pais <allen.lkml@gmail.com>
---
 drivers/usb/c67x00/c67x00-sched.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/c67x00/c67x00-sched.c b/drivers/usb/c67x00/c67x00-sched.c
index f7f6229082ca..6275cb77a15b 100644
--- a/drivers/usb/c67x00/c67x00-sched.c
+++ b/drivers/usb/c67x00/c67x00-sched.c
@@ -1122,9 +1122,9 @@ static void c67x00_do_work(struct c67x00_hcd *c67x00)
 
 /* -------------------------------------------------------------------------- */
 
-static void c67x00_sched_tasklet(unsigned long __c67x00)
+static void c67x00_sched_tasklet(struct tasklet_struct *t)
 {
-	struct c67x00_hcd *c67x00 = (struct c67x00_hcd *)__c67x00;
+	struct c67x00_hcd *c67x00 = from_tasklet(c67x00, t, tasklet);
 	c67x00_do_work(c67x00);
 }
 
@@ -1135,8 +1135,7 @@ void c67x00_sched_kick(struct c67x00_hcd *c67x00)
 
 int c67x00_sched_start_scheduler(struct c67x00_hcd *c67x00)
 {
-	tasklet_init(&c67x00->tasklet, c67x00_sched_tasklet,
-		     (unsigned long)c67x00);
+	tasklet_setup(&c67x00->tasklet, c67x00_sched_tasklet);
 	return 0;
 }
 
-- 
2.17.1

