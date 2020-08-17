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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E12C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A8242080D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8e7p5A+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgHQJC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgHQJCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:02:54 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0081EC061389;
        Mon, 17 Aug 2020 02:02:53 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x25so7919257pff.4;
        Mon, 17 Aug 2020 02:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9gjqpRS8olyjc/G08W3tsbKuo7w0JyAKTnFiPDwOnLs=;
        b=Y8e7p5A+U70fs8zMCX99v4qWd6fhAwzqCgzVw6MybAu0YKzv985Gzz88KVzjlO00kH
         ZAjoOPBR7uVDqzY14l50NCRxWKxebE4hCuLp3K82NcoayY1F4MmINy2f5odh9eHAndnu
         C2NiQKq3ADK50JyGQPJa+npJ4re/v4TtPyhWg9Ji4D+RO3dxkLFyhA1P0wFFg7kTBxd1
         b7RqHitiCauEPujt1dsnfyTsWUKed/bl9Yh7l8IX1Jvl2G6n9K6la8snK/umY1tdQSgW
         KDOIL8eRZTWF6bSt4eI8gJuznMohjSDQ+jTZsbLhNXvtsfB7P7kVvBJ+6WNyPH7oaPwN
         8b6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9gjqpRS8olyjc/G08W3tsbKuo7w0JyAKTnFiPDwOnLs=;
        b=hu76dRLqQQQ7cYCNjUxDfwUB5IQzLxrTDCuG/dBZcI8lZp73S4AR4UqYKtvukn9UxK
         8o2y+9DhdDYVs18/jxQqf6AMCfKQXQE7xZllI9RHdID4t3sBKB8H99jgAxzdTQ9xkd2G
         7RTZ/v4TeRg9b67NNx8T7pNYavRvaYV8sI9wwzs35yx/NMsU4OFIE2PNq/5ITKl87PFB
         3ZiEBV4Lzbsh/33wdnOjvYcF8Sy5WcJK6Y/OC1ntv0gOwkP4GgTaD6/kwKStqgejKMUx
         sCiA5Fg/3CuM+cXTa3s/hJV4IAbK1gROeqiG1dk3nbinQIT4qKyYUJhZhWicC/RPAXq+
         iF5g==
X-Gm-Message-State: AOAM530RHXIQZN3/MXNHf4N3XKEDXFqAYRokY+n/YebSvjWtjLhBvh4Y
        lgp02Uyj4ZYxWTTybSvngp4=
X-Google-Smtp-Source: ABdhPJwCbYSaFDUdxe1jOJYWD7q8rFdA3Zk4x0wFc5VcGkSDok1smRFfy3wXDtC7EEtu4HiZJA6q+w==
X-Received: by 2002:aa7:9ecd:: with SMTP id r13mr7291913pfq.317.1597654973506;
        Mon, 17 Aug 2020 02:02:53 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id f3sm19488238pfj.206.2020.08.17.02.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 02:02:52 -0700 (PDT)
From:   Allen Pais <allen.cryptic@gmail.com>
To:     duncan.sands@free.fr, gregkh@linuxfoundation.org,
        jacmet@sunsite.dk, balbi@kernel.org, leoyang.li@nxp.com,
        johan@kernel.org
Cc:     keescook@chromium.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 6/7] usb: xhci: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 14:32:08 +0530
Message-Id: <20200817090209.26351-7-allen.cryptic@gmail.com>
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
 drivers/usb/host/xhci-dbgtty.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index b8918f73a432..ae4e4ab638b5 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -288,14 +288,14 @@ static const struct tty_operations dbc_tty_ops = {
 	.unthrottle		= dbc_tty_unthrottle,
 };
 
-static void dbc_rx_push(unsigned long _port)
+static void dbc_rx_push(struct tasklet_struct *t)
 {
 	struct dbc_request	*req;
 	struct tty_struct	*tty;
 	unsigned long		flags;
 	bool			do_push = false;
 	bool			disconnect = false;
-	struct dbc_port		*port = (void *)_port;
+	struct dbc_port		*port = from_tasklet(port, t, push);
 	struct list_head	*queue = &port->read_queue;
 
 	spin_lock_irqsave(&port->port_lock, flags);
@@ -382,7 +382,7 @@ xhci_dbc_tty_init_port(struct xhci_dbc *dbc, struct dbc_port *port)
 {
 	tty_port_init(&port->port);
 	spin_lock_init(&port->port_lock);
-	tasklet_init(&port->push, dbc_rx_push, (unsigned long)port);
+	tasklet_setup(&port->push, dbc_rx_push);
 	INIT_LIST_HEAD(&port->read_pool);
 	INIT_LIST_HEAD(&port->read_queue);
 	INIT_LIST_HEAD(&port->write_pool);
-- 
2.17.1

