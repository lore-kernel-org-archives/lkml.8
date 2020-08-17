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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8145C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F5CD207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UGys9s0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728696AbgHQJDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgHQJC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:02:59 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2827C061389;
        Mon, 17 Aug 2020 02:02:58 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d188so7911952pfd.2;
        Mon, 17 Aug 2020 02:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xXbF1OGSfwps8eIxFqyJWCOGFrRBRoS9IAapxWYH5tU=;
        b=UGys9s0cH3XJ7ytiyAvyHhECfx/sgE7VT+4dU+PFtuVRKYibSk4ZdfmReJ5RHeo4oB
         cE77BSIVRi+aL2qPqpPHpFAR1LSBTrzvNNl5+1z2oukApZE2Lh0c8Y3/yCTaGn1btkI3
         DvfBXKhyn1mhWjbBF8kHKW4euTK7Ux3RSg5XFcHWLBm6Ex4WbXmFJRsy6oz8LHIem23T
         s/vVZgJ8dTQWc7edHye0v87zndklTmo3yTfDJa2KJhz3KKYSGaQVeY4NJka4LW2TDcnd
         io8PK2w/yoaTYclhmldJ4rX2kkhp+HrYmndLi4PUVEPGGhD9ac4NWIc9Y4RAyWFd0HTP
         8flQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xXbF1OGSfwps8eIxFqyJWCOGFrRBRoS9IAapxWYH5tU=;
        b=t/TwHd8HmtIHs+F7YY2ICaMIAyEfzGNsuk+72JWdY7gu3mxi8qbKwQ7vRc3NT4sGgm
         5D061goswTMYEpLiwN9hPe+FZM+Pij22PBQrrmUlQj6l6gBLf8AwbHm1PGjWnCYhIw7I
         g7UjtIj5f49Pd6q4Kuc4o+JvqXfrXh5UGX++fIB+gJ+GjwfNiL4gP8Iuuxs+jvzftucM
         t0jcvRdPHDyCHe+4+9zAts8eYbBrPMr2ku+4cBYgVlPqjiKdXyhmM6FGEtyCOAjq9PN7
         qnC8PD4XPtd6kHgMYA1KJ0coL8Cs/lAjAZBsY6nD3C1h8GNtbgRIL/ZYsy2NGdoVY+qL
         ENeA==
X-Gm-Message-State: AOAM5311USW/0l7OIp4AryyLL7dGQeSwQTlOBBkZDoARQQqWjqUqBMCP
        qFdA6mabNDKYpkELFh0gPnw=
X-Google-Smtp-Source: ABdhPJxAkXUAop1wEFaah3YAPnjGLxZjtihx6qYBEHA3JVTfQ+jUGc2wTge02f2yvKEBQPSGJto8nw==
X-Received: by 2002:a62:3856:: with SMTP id f83mr10808398pfa.35.1597654978435;
        Mon, 17 Aug 2020 02:02:58 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
        by smtp.gmail.com with ESMTPSA id f3sm19488238pfj.206.2020.08.17.02.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 02:02:57 -0700 (PDT)
From:   Allen Pais <allen.cryptic@gmail.com>
To:     duncan.sands@free.fr, gregkh@linuxfoundation.org,
        jacmet@sunsite.dk, balbi@kernel.org, leoyang.li@nxp.com,
        johan@kernel.org
Cc:     keescook@chromium.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Allen Pais <allen.lkml@gmail.com>,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 7/7] usb: mos7720: convert tasklets to use new tasklet_setup() API
Date:   Mon, 17 Aug 2020 14:32:09 +0530
Message-Id: <20200817090209.26351-8-allen.cryptic@gmail.com>
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
 drivers/usb/serial/mos7720.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index 2ec4eeacebc7..5eed1078fac8 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -282,11 +282,12 @@ static void destroy_urbtracker(struct kref *kref)
  * port callback had to be deferred because the disconnect mutex could not be
  * obtained at the time.
  */
-static void send_deferred_urbs(unsigned long _mos_parport)
+static void send_deferred_urbs(struct tasklet_struct *t)
 {
 	int ret_val;
 	unsigned long flags;
-	struct mos7715_parport *mos_parport = (void *)_mos_parport;
+	struct mos7715_parport *mos_parport = from_tasklet(mos_parport, t,
+							   urb_tasklet);
 	struct urbtracker *urbtrack, *tmp;
 	struct list_head *cursor, *next;
 	struct device *dev;
@@ -716,8 +717,7 @@ static int mos7715_parport_init(struct usb_serial *serial)
 	INIT_LIST_HEAD(&mos_parport->deferred_urbs);
 	usb_set_serial_data(serial, mos_parport); /* hijack private pointer */
 	mos_parport->serial = serial;
-	tasklet_init(&mos_parport->urb_tasklet, send_deferred_urbs,
-		     (unsigned long) mos_parport);
+	tasklet_setup(&mos_parport->urb_tasklet, send_deferred_urbs);
 	init_completion(&mos_parport->syncmsg_compl);
 
 	/* cycle parallel port reset bit */
-- 
2.17.1

