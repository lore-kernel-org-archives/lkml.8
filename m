Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CC3C55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2CA32077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="U6MmSMBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgDWL42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:56:28 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41764 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728184AbgDWL4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:56:25 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03NBqWu1025463;
        Thu, 23 Apr 2020 13:56:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=BCdNw/6bNXDgvzYMM/yuCjYQaZbw1vGHMQ1wGH6OfQw=;
 b=U6MmSMBAFtju9TIfyfARL7+zBExJ1rFHpv8Pz9BAqe1QGj43VEk+F6zswnEfuue998Vq
 y+5/TvErKyfRRYJTjjpLMjqKFYcUijgEAgxLUN9yhopTH5YEJszGDBYwJ8wY9k89kl/i
 wuh3nk3jveeWSBDi3X6yJamja44ASgWSqlqXHx65lDLbBQ3Z0BgnL/AWOLRlX1PXyqUq
 VektRD6eJYG55ysqLOPgfaJGUGDBN7yLm5cdTuuf3rQCUg7UqIGlMYvRbIuMhF9jvTG9
 AlFbzaU4slX5Gsp6Ie2190uLMQXR2FqGy5eLuSd/PCd2SJRxIfJsbHEVCEAGoNONNOJo 0g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30fregvjtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Apr 2020 13:56:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3003D10002A;
        Thu, 23 Apr 2020 13:56:17 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2624E2ADA08;
        Thu, 23 Apr 2020 13:56:17 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG5NODE3.st.com (10.75.127.15)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 23 Apr 2020 13:56:16
 +0200
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <balbi@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@st.com>, <fabrice.gasnier@st.com>
Subject: [PATCH v2 2/4] usb: gadget: u_serial: add suspend resume callbacks
Date:   Thu, 23 Apr 2020 13:55:54 +0200
Message-ID: <1587642956-8157-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587642956-8157-1-git-send-email-fabrice.gasnier@st.com>
References: <1587642956-8157-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-23_07:2020-04-22,2020-04-23 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suspend resume callbacks to handle the case seen when the bus is
suspended by the HOST, and the device opens the port (cat /dev/ttyGS0).

Gadget controller (like DWC2) doesn't accept usb requests to be queued in
this case (when in L2 state), from the gs_open() call. Error log is printed
- configfs-gadget gadget: acm ttyGS0 can't notify serial state, -11
If the HOST resumes (opens) the bus, the port still isn't functional.

Use suspend/resume callbacks to monitor the gadget suspended state by using
'suspended' flag. In case the port gets opened (cat /dev/ttyGS0), the I/O
stream will be delayed until the bus gets resumed by the HOST.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/usb/gadget/function/u_serial.c | 57 +++++++++++++++++++++++++++++-----
 drivers/usb/gadget/function/u_serial.h |  2 ++
 2 files changed, 51 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 8167d37..3cfc6e2 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -120,6 +120,8 @@ struct gs_port {
 	wait_queue_head_t	drain_wait;	/* wait while writes drain */
 	bool                    write_busy;
 	wait_queue_head_t	close_wait;
+	bool			suspended;	/* port suspended */
+	bool			start_delayed;	/* delay start when suspended */
 
 	/* REVISIT this state ... */
 	struct usb_cdc_line_coding port_line_coding;	/* 8-N-1 etc */
@@ -630,13 +632,19 @@ static int gs_open(struct tty_struct *tty, struct file *file)
 
 	/* if connected, start the I/O stream */
 	if (port->port_usb) {
-		struct gserial	*gser = port->port_usb;
-
-		pr_debug("gs_open: start ttyGS%d\n", port->port_num);
-		gs_start_io(port);
-
-		if (gser->connect)
-			gser->connect(gser);
+		/* if port is suspended, wait resume to start I/0 stream */
+		if (!port->suspended) {
+			struct gserial	*gser = port->port_usb;
+
+			pr_debug("gs_open: start ttyGS%d\n", port->port_num);
+			gs_start_io(port);
+
+			if (gser->connect)
+				gser->connect(gser);
+		} else {
+			pr_debug("delay start of ttyGS%d\n", port->port_num);
+			port->start_delayed = true;
+		}
 	}
 
 	pr_debug("gs_open: ttyGS%d (%p,%p)\n", port->port_num, tty, file);
@@ -680,7 +688,7 @@ static void gs_close(struct tty_struct *tty, struct file *file)
 	pr_debug("gs_close: ttyGS%d (%p,%p) ...\n", port->port_num, tty, file);
 
 	gser = port->port_usb;
-	if (gser && gser->disconnect)
+	if (gser && !port->suspended && gser->disconnect)
 		gser->disconnect(gser);
 
 	/* wait for circular write buffer to drain, disconnect, or at
@@ -708,6 +716,7 @@ static void gs_close(struct tty_struct *tty, struct file *file)
 	else
 		kfifo_reset(&port->port_write_buf);
 
+	port->start_delayed = false;
 	port->port.count = 0;
 	port->port.tty = NULL;
 
@@ -1403,6 +1412,38 @@ void gserial_disconnect(struct gserial *gser)
 }
 EXPORT_SYMBOL_GPL(gserial_disconnect);
 
+void gserial_suspend(struct gserial *gser)
+{
+	struct gs_port	*port = gser->ioport;
+	unsigned long	flags;
+
+	spin_lock_irqsave(&port->port_lock, flags);
+	port->suspended = true;
+	spin_unlock_irqrestore(&port->port_lock, flags);
+}
+EXPORT_SYMBOL_GPL(gserial_suspend);
+
+void gserial_resume(struct gserial *gser)
+{
+	struct gs_port *port = gser->ioport;
+	unsigned long	flags;
+
+	spin_lock_irqsave(&port->port_lock, flags);
+	port->suspended = false;
+	if (!port->start_delayed) {
+		spin_unlock_irqrestore(&port->port_lock, flags);
+		return;
+	}
+
+	pr_debug("delayed start ttyGS%d\n", port->port_num);
+	gs_start_io(port);
+	if (gser->connect)
+		gser->connect(gser);
+	port->start_delayed = false;
+	spin_unlock_irqrestore(&port->port_lock, flags);
+}
+EXPORT_SYMBOL_GPL(gserial_resume);
+
 static int userial_init(void)
 {
 	unsigned			i;
diff --git a/drivers/usb/gadget/function/u_serial.h b/drivers/usb/gadget/function/u_serial.h
index e5b08ab..009a959 100644
--- a/drivers/usb/gadget/function/u_serial.h
+++ b/drivers/usb/gadget/function/u_serial.h
@@ -68,6 +68,8 @@ ssize_t gserial_get_console(unsigned char port_num, char *page);
 /* connect/disconnect is handled by individual functions */
 int gserial_connect(struct gserial *, u8 port_num);
 void gserial_disconnect(struct gserial *);
+void gserial_suspend(struct gserial *p);
+void gserial_resume(struct gserial *p);
 
 /* functions are bound to configurations by a config or gadget driver */
 int gser_bind_config(struct usb_configuration *c, u8 port_num);
-- 
2.7.4

