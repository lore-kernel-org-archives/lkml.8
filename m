Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3E2C2BA16
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7448A218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9FqvvcX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403833AbgDCNno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:43:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38613 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgDCNnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:43:41 -0400
Received: by mail-wm1-f67.google.com with SMTP id f6so7760641wmj.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 06:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xynefS7kXDWsf4tmiciQZT51tJqt7jbZfUXZqRPv1uQ=;
        b=K9FqvvcXNUCXOqtmPq56Afwa9a3Tn9wPisvsY4jYkp+CjcEny5Z4zG3darNmY+KlDj
         5tuzZxaBn7Cmk2B5rKtqya51SwlSzLIUBNrEcVU05G1gDOc5P/4KYYwX8gUO9XJ+mQQu
         c86iXZM80WxLctd+sGwXZe3bRfduc94dak8b1f3GzK62fs4qX3XKD5QKDdL5Js7i6OrU
         MdHjMFal35twYte95P8vSmHFRPwFP2xaZY6x9rQTPbjFV42Qsc5DpZ28NFA6KPGBstff
         hxdhKRIj9ltU2DkUVBdbnx/P+oV3itCTgNm0RL8J93Y1wdz3jhKdh9+vHi4BZIhYiFpY
         HFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xynefS7kXDWsf4tmiciQZT51tJqt7jbZfUXZqRPv1uQ=;
        b=MOtoTm9VidPanvMdsNEURaLQ4Ynex3TXdMpxqjRxnJI2BjCCG/XFn90+S+f3ynaXwq
         4IlCAdoLNHY8/1hngDLtD4vB2pJPrsHLZVmsrZ712lT2woJoHXdw6BJc1e9XybQT3zvy
         SAis7NitbD+zlwZogBfskyj5+7/WjPog5gp0dMrw9jIQmlpt6XJwQQxG6F/6DJGS8lo8
         B2SwbW6iLpWoDdw2uiffCxmzHddKrwajFlp02UuHLey49WYIdsg4VSzSKovum9DAgtnd
         C8HquPHbwGjccSgOk/h8cjAYGNxiSp5AwBHFeMJQTe+Wj0n7Sje6Es08eWlSuJxcL99q
         vpBA==
X-Gm-Message-State: AGi0PuaH0J2qhn9CPsRcqJDn8xFH0On6ss2Y2foCZLvRkOfQghITC1iW
        MRIEfa4dhcTOuW7uUZA3gqY=
X-Google-Smtp-Source: APiQypL++PrhLHjS62HQ8ftX7BAMnXifIWOZqWKzrd37jJzAM4nruZFyDM+eUd9sQpgtaKEnG3C1tg==
X-Received: by 2002:a05:600c:4148:: with SMTP id h8mr9265547wmm.144.1585921419298;
        Fri, 03 Apr 2020 06:43:39 -0700 (PDT)
Received: from debian.lan (host-84-13-17-86.opaltelecom.net. [84.13.17.86])
        by smtp.gmail.com with ESMTPSA id f12sm12081232wrm.94.2020.04.03.06.43.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 06:43:38 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 05/11] parport_amiga: Convert DPRINTK to pr_debug
Date:   Fri,  3 Apr 2020 14:43:19 +0100
Message-Id: <20200403134325.11523-5-sudipm.mukherjee@gmail.com>
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
 drivers/parport/parport_amiga.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/parport/parport_amiga.c b/drivers/parport/parport_amiga.c
index 8c7a598abcff..1e88bcfe0d7b 100644
--- a/drivers/parport/parport_amiga.c
+++ b/drivers/parport/parport_amiga.c
@@ -28,16 +28,10 @@
 #include <asm/amigaints.h>
 
 #undef DEBUG
-#ifdef DEBUG
-#define DPRINTK printk
-#else
-#define DPRINTK(x...)	do { } while (0)
-#endif
-
 
 static void amiga_write_data(struct parport *p, unsigned char data)
 {
-	DPRINTK(KERN_DEBUG "write_data %c\n",data);
+	pr_debug("write_data %c\n", data);
 	/* Triggers also /STROBE. This behavior cannot be changed */
 	ciaa.prb = data;
 	mb();
@@ -59,13 +53,13 @@ static unsigned char control_amiga_to_pc(unsigned char control)
 
 static void amiga_write_control(struct parport *p, unsigned char control)
 {
-	DPRINTK(KERN_DEBUG "write_control %02x\n",control);
+	pr_debug("write_control %02x\n", control);
 	/* No implementation possible */
 }
 	
 static unsigned char amiga_read_control( struct parport *p)
 {
-	DPRINTK(KERN_DEBUG "read_control \n");
+	pr_debug("read_control\n");
 	return control_amiga_to_pc(0);
 }
 
@@ -73,7 +67,7 @@ static unsigned char amiga_frob_control( struct parport *p, unsigned char mask,
 {
 	unsigned char old;
 
-	DPRINTK(KERN_DEBUG "frob_control mask %02x, value %02x\n",mask,val);
+	pr_debug("frob_control mask %02x, value %02x\n", mask, val);
 	old = amiga_read_control(p);
 	amiga_write_control(p, (old & ~mask) ^ val);
 	return old;
@@ -99,7 +93,7 @@ static unsigned char amiga_read_status(struct parport *p)
 	unsigned char status;
 
 	status = status_amiga_to_pc(ciab.pra & 7);
-	DPRINTK(KERN_DEBUG "read_status %02x\n", status);
+	pr_debug("read_status %02x\n", status);
 	return status;
 }
 
@@ -115,14 +109,14 @@ static void amiga_disable_irq(struct parport *p)
 
 static void amiga_data_forward(struct parport *p)
 {
-	DPRINTK(KERN_DEBUG "forward\n");
+	pr_debug("forward\n");
 	ciaa.ddrb = 0xff; /* all pins output */
 	mb();
 }
 
 static void amiga_data_reverse(struct parport *p)
 {
-	DPRINTK(KERN_DEBUG "reverse\n");
+	pr_debug("reverse\n");
 	ciaa.ddrb = 0; /* all pins input */
 	mb();
 }
-- 
2.11.0

