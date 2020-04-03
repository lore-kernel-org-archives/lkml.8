Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACABC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CCDD2078C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKKAb+gM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390979AbgDCNnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:43:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33372 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390967AbgDCNnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:43:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id a25so8648793wrd.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 06:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D6UJS6gA2Oz0Azf+N2fn2fzknCwXYE4Y+L4wPk4MirU=;
        b=MKKAb+gMQ0TU9BWwjaBn1Og6YqJlaeVL0mxVvTiJxNVGRfh1WDXZPNSc2Aal2zSqs+
         6xvaFJyeyvyuZvfsVQ6XDu1DjYbQdN+ryR9X2caOY3nhy4W+lSwSbQCkjuG87AP/ukiz
         CeV5F/27rnT/F4NgpKPYzhjQGD8MYZ6g1Z0JsQM1tJWI+MU+Sa941Lijd/7/Tsgegutd
         1Tpg5yhoJFCbTWUl8SU/lPMhbOT7A0v/dQfjVFzQEtfHtERfAM5sUvEU3pOrXnTttHtK
         0Rf2aGuFHKuv3Vu6hh8g1D8x0anOFV8GWqEGvitdBPoZDISzQDjNMdFKVAfDpje8nkMp
         6UqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=D6UJS6gA2Oz0Azf+N2fn2fzknCwXYE4Y+L4wPk4MirU=;
        b=PdCoR+4wAI/ww91uZN5vkLpGMBJUivlfeWb7vrQYellOk73M2DTJM7n8y254Izk6XZ
         FI5JOYZ1UBPgCcq0l+3JHvyNo/ys7rRp0nZXrEnrwZAuuXT3PBm7CRadHHOET+epBMOj
         s7GkeyXcCpaNDr+iBZYMEo2xkJN2kR9p5PH/NA1hqO0+7QrGP/XwwHAQsDNSWdKjk0G+
         P8YNnDr8zXR7aBb1uQd/Lkdqs9ZE+4lo8XbovaUwGamqWkO7kibAA9cj8gMV0lxVX6Xd
         qLjfJ5hmZSAKjZSCRewWXdUbfZ5oudUrKBrxzRqJ4Agfn4WNpFx+q2BEd0N75HCmBVWk
         W4Sg==
X-Gm-Message-State: AGi0PuZAR+vDukrUDtTeABmuySqjB1NGHh+Cq7E2paQj8viGJ0ddg9Lm
        033hDIoU/U9ZkAt9hPzHQzE=
X-Google-Smtp-Source: APiQypKIBAOwn0dHlaSCPBbPRWJrF3gk9U6PfCiJdJ8QtIW5Lp6W5poqqmil/zfhw03AwhW2VawBvQ==
X-Received: by 2002:adf:fc45:: with SMTP id e5mr9879908wrs.56.1585921418348;
        Fri, 03 Apr 2020 06:43:38 -0700 (PDT)
Received: from debian.lan (host-84-13-17-86.opaltelecom.net. [84.13.17.86])
        by smtp.gmail.com with ESMTPSA id f12sm12081232wrm.94.2020.04.03.06.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 06:43:37 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 04/11] parport: daisy: Convert DPRINTK to pr_debug
Date:   Fri,  3 Apr 2020 14:43:18 +0100
Message-Id: <20200403134325.11523-4-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200403134325.11523-1-sudipm.mukherjee@gmail.com>
References: <20200403134325.11523-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>

Use a more common logging style.

Signed-off-by: Joe Perches <joe@perches.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/daisy.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/parport/daisy.c b/drivers/parport/daisy.c
index f87cc802167e..6d78ec3a762f 100644
--- a/drivers/parport/daisy.c
+++ b/drivers/parport/daisy.c
@@ -30,12 +30,6 @@
 
 #undef DEBUG
 
-#ifdef DEBUG
-#define DPRINTK(stuff...) printk(stuff)
-#else
-#define DPRINTK(stuff...)
-#endif
-
 static struct daisydev {
 	struct daisydev *next;
 	struct parport *port;
@@ -321,8 +315,7 @@ static int cpp_daisy(struct parport *port, int cmd)
 		  | PARPORT_STATUS_PAPEROUT
 		  | PARPORT_STATUS_SELECT
 		  | PARPORT_STATUS_ERROR)) {
-		DPRINTK(KERN_DEBUG "%s: cpp_daisy: aa5500ff(%02x)\n",
-			 port->name, s);
+		pr_debug("%s: cpp_daisy: aa5500ff(%02x)\n", port->name, s);
 		return -ENXIO;
 	}
 
@@ -332,8 +325,7 @@ static int cpp_daisy(struct parport *port, int cmd)
 					  | PARPORT_STATUS_SELECT
 					  | PARPORT_STATUS_ERROR);
 	if (s != (PARPORT_STATUS_SELECT | PARPORT_STATUS_ERROR)) {
-		DPRINTK(KERN_DEBUG "%s: cpp_daisy: aa5500ff87(%02x)\n",
-			 port->name, s);
+		pr_debug("%s: cpp_daisy: aa5500ff87(%02x)\n", port->name, s);
 		return -ENXIO;
 	}
 
@@ -368,7 +360,7 @@ static int cpp_mux(struct parport *port, int cmd)
 
 	s = parport_read_status(port);
 	if (!(s & PARPORT_STATUS_ACK)) {
-		DPRINTK(KERN_DEBUG "%s: cpp_mux: aa55f00f52ad%02x(%02x)\n",
+		pr_debug("%s: cpp_mux: aa55f00f52ad%02x(%02x)\n",
 			 port->name, cmd, s);
 		return -EIO;
 	}
@@ -454,8 +446,7 @@ static int assign_addrs(struct parport *port)
 		  | PARPORT_STATUS_PAPEROUT
 		  | PARPORT_STATUS_SELECT
 		  | PARPORT_STATUS_ERROR)) {
-		DPRINTK(KERN_DEBUG "%s: assign_addrs: aa5500ff(%02x)\n",
-			 port->name, s);
+		pr_debug("%s: assign_addrs: aa5500ff(%02x)\n", port->name, s);
 		return 0;
 	}
 
@@ -465,8 +456,7 @@ static int assign_addrs(struct parport *port)
 					  | PARPORT_STATUS_SELECT
 					  | PARPORT_STATUS_ERROR);
 	if (s != (PARPORT_STATUS_SELECT | PARPORT_STATUS_ERROR)) {
-		DPRINTK(KERN_DEBUG "%s: assign_addrs: aa5500ff87(%02x)\n",
-			 port->name, s);
+		pr_debug("%s: assign_addrs: aa5500ff87(%02x)\n", port->name, s);
 		return 0;
 	}
 
@@ -503,8 +493,7 @@ static int assign_addrs(struct parport *port)
 
 	parport_write_data(port, 0xff); udelay(2);
 	detected = numdevs - thisdev;
-	DPRINTK(KERN_DEBUG "%s: Found %d daisy-chained devices\n", port->name,
-		 detected);
+	pr_debug("%s: Found %d daisy-chained devices\n", port->name, detected);
 
 	/* Ask the new devices to introduce themselves. */
 	deviceid = kmalloc(1024, GFP_KERNEL);
-- 
2.11.0

