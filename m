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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BB6C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F30F62078C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:43:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nu9QaEDc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390969AbgDCNnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:43:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52065 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgDCNni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:43:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id z7so7181771wmk.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 06:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iREvdTpBgHupinhqYUTLOv6ABiy7AtkLXzmxvowBtBE=;
        b=nu9QaEDcOhxZdK9WG26yHUFGE0BgroDpEr4ATxUF9giovwRqwj2fNt4rFK9gI4vN7Z
         vlPmaSys+EG8n61Upb7MOt4lLFxbOaTlPy+kznq3zDp8AeKYUJCNyUAQ4omPvOO9cHln
         ZHqqsAdIMhw70yXMPyr9Ek+aBgszciPvMz0rM0YqJaIfFK+0qtBKSv0oAte6w7Q+eaHe
         MpZ09Bpba5ZHk5CDkobMgMSxJjyBd/lZbrfc6wUIr9B9iI1pjEFTKlY+xVLibntwIgnd
         bKv25VqZwPR7B7C1abaqecf9h8gKcskzsVEwBwZoeXOAJM9jK5GyELx6XQigtHL3A4nN
         R2ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iREvdTpBgHupinhqYUTLOv6ABiy7AtkLXzmxvowBtBE=;
        b=Pp5SF5kekJZ1Jr8Ht6nkLOsJSOfqCUcaxUB6QfrX/0UI5oDawvQY2Y95D8GLURt9A5
         mOB6/wVjH9A32J9qxteKf7WqDaszj2mXcJMDhhMMZNJ+7VRnuEI+HnPpVBxbQhavg25u
         oY7U9Zhp/V5cjj9Qsgf1EvBVkZZ0J7hbpVge9Gi+Z3dAr6P3sq3WlmDe0yO8pMSghcm2
         PNT7jWh5lcaUqDuf10gDGsrocIp+WNaHQEfqFmLM7hIaHRurPaJYWf5DuH2P/uoogJOH
         QkzqNnHP3t0cm91BVfOVXgkROx134rR/lZtraw46wA6h+P+fxUS0pQdjZbvR6JkH8HKy
         xkmA==
X-Gm-Message-State: AGi0PuasP2UzKstX284n9TnFWM6El/MUr1d5QNRnqC59WDfWz0A5r9Ac
        QWbeVy1yY/Y3jJ8VbxKdxmU=
X-Google-Smtp-Source: APiQypKWzVPjN7S2haq1L64Gdn1F6ztfJ7pkU8ludbPsoSB3vAXmzY1BLzKHgao7kIV7xH/gixizxA==
X-Received: by 2002:a1c:41d6:: with SMTP id o205mr8676909wma.122.1585921415227;
        Fri, 03 Apr 2020 06:43:35 -0700 (PDT)
Received: from debian.lan (host-84-13-17-86.opaltelecom.net. [84.13.17.86])
        by smtp.gmail.com with ESMTPSA id f12sm12081232wrm.94.2020.04.03.06.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 06:43:34 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 01/11] parport: fix if-statement empty body warnings
Date:   Fri,  3 Apr 2020 14:43:15 +0100
Message-Id: <20200403134325.11523-1-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Perches <joe@perches.com>

Eliminate warnings by using pr_debug which is the more typical
kernel debugging style and also enable dynamic_debug on these
outputs.

Miscellaneous:

o A few messages were logged at KERN_INFO when enabled, now KERN_DEBUG
o Convert %d/%d to %zd/%zu to avoid compilation warnings

Original-patch-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Joe Perches <joe@perches.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/ieee1284.c     | 90 ++++++++++++++++--------------------------
 drivers/parport/ieee1284_ops.c | 67 +++++++++++--------------------
 2 files changed, 57 insertions(+), 100 deletions(-)

diff --git a/drivers/parport/ieee1284.c b/drivers/parport/ieee1284.c
index 90fb73575495..ba562bcd4b80 100644
--- a/drivers/parport/ieee1284.c
+++ b/drivers/parport/ieee1284.c
@@ -31,12 +31,6 @@
 #undef DEBUG /* Don't want a garbled console */
 #endif
 
-#ifdef DEBUG
-#define DPRINTK(stuff...) printk (stuff)
-#else
-#define DPRINTK(stuff...)
-#endif
-
 /* Make parport_wait_peripheral wake up.
  * It will be useful to call this from an interrupt handler. */
 static void parport_ieee1284_wakeup (struct parport *port)
@@ -258,12 +252,11 @@ static void parport_ieee1284_terminate (struct parport *port)
 						     PARPORT_STATUS_PAPEROUT,
 						     PARPORT_STATUS_PAPEROUT);
 			if (r)
-				DPRINTK (KERN_INFO "%s: Timeout at event 49\n",
+				pr_debug("%s: Timeout at event 49\n",
 					 port->name);
 
 			parport_data_forward (port);
-			DPRINTK (KERN_DEBUG "%s: ECP direction: forward\n",
-				 port->name);
+			pr_debug("%s: ECP direction: forward\n", port->name);
 			port->ieee1284.phase = IEEE1284_PH_FWD_IDLE;
 		}
 
@@ -281,8 +274,7 @@ static void parport_ieee1284_terminate (struct parport *port)
 		/* Event 24: nAck goes low */
 		r = parport_wait_peripheral (port, PARPORT_STATUS_ACK, 0);
 		if (r)
-			DPRINTK (KERN_INFO "%s: Timeout at event 24\n",
-				 port->name);
+			pr_debug("%s: Timeout at event 24\n", port->name);
 
 		/* Event 25: Set nAutoFd low */
 		parport_frob_control (port,
@@ -294,8 +286,7 @@ static void parport_ieee1284_terminate (struct parport *port)
 					     PARPORT_STATUS_ACK, 
 					     PARPORT_STATUS_ACK);
 		if (r)
-			DPRINTK (KERN_INFO "%s: Timeout at event 27\n",
-				 port->name);
+			pr_debug("%s: Timeout at event 27\n", port->name);
 
 		/* Event 29: Set nAutoFd high */
 		parport_frob_control (port, PARPORT_CONTROL_AUTOFD, 0);
@@ -304,8 +295,7 @@ static void parport_ieee1284_terminate (struct parport *port)
 	port->ieee1284.mode = IEEE1284_MODE_COMPAT;
 	port->ieee1284.phase = IEEE1284_PH_FWD_IDLE;
 
-	DPRINTK (KERN_DEBUG "%s: In compatibility (forward idle) mode\n",
-		 port->name);
+	pr_debug("%s: In compatibility (forward idle) mode\n", port->name);
 }		
 #endif /* IEEE1284 support */
 
@@ -406,8 +396,7 @@ int parport_negotiate (struct parport *port, int mode)
 				      PARPORT_CONTROL_SELECT
 				      | PARPORT_CONTROL_AUTOFD,
 				      PARPORT_CONTROL_SELECT);
-		DPRINTK (KERN_DEBUG
-			 "%s: Peripheral not IEEE1284 compliant (0x%02X)\n",
+		pr_debug("%s: Peripheral not IEEE1284 compliant (0x%02X)\n",
 			 port->name, parport_read_status (port));
 		port->ieee1284.phase = IEEE1284_PH_FWD_IDLE;
 		return -1; /* Not IEEE1284 compliant */
@@ -430,8 +419,7 @@ int parport_negotiate (struct parport *port, int mode)
 				     PARPORT_STATUS_ACK,
 				     PARPORT_STATUS_ACK)) {
 		/* This shouldn't really happen with a compliant device. */
-		DPRINTK (KERN_DEBUG
-			 "%s: Mode 0x%02x not supported? (0x%02x)\n",
+		pr_debug("%s: Mode 0x%02x not supported? (0x%02x)\n",
 			 port->name, mode, port->ops->read_status (port));
 		parport_ieee1284_terminate (port);
 		return 1;
@@ -442,7 +430,7 @@ int parport_negotiate (struct parport *port, int mode)
 	/* xflag should be high for all modes other than nibble (0). */
 	if (mode && !xflag) {
 		/* Mode not supported. */
-		DPRINTK (KERN_DEBUG "%s: Mode 0x%02x rejected by peripheral\n",
+		pr_debug("%s: Mode 0x%02x rejected by peripheral\n",
 			 port->name, mode);
 		parport_ieee1284_terminate (port);
 		return 1;
@@ -463,9 +451,7 @@ int parport_negotiate (struct parport *port, int mode)
 		/* Event 52: nAck goes low */
 		if (parport_wait_peripheral (port, PARPORT_STATUS_ACK, 0)) {
 			/* This peripheral is _very_ slow. */
-			DPRINTK (KERN_DEBUG
-				 "%s: Event 52 didn't happen\n",
-				 port->name);
+			pr_debug("%s: Event 52 didn't happen\n", port->name);
 			parport_ieee1284_terminate (port);
 			return 1;
 		}
@@ -481,10 +467,9 @@ int parport_negotiate (struct parport *port, int mode)
 					     PARPORT_STATUS_ACK)) {
 			/* This shouldn't really happen with a compliant
 			 * device. */
-			DPRINTK (KERN_DEBUG
-				 "%s: Mode 0x%02x not supported? (0x%02x)\n",
+			pr_debug("%s: Mode 0x%02x not supported? (0x%02x)\n",
 				 port->name, mode,
-				 port->ops->read_status (port));
+				 port->ops->read_status(port));
 			parport_ieee1284_terminate (port);
 			return 1;
 		}
@@ -495,8 +480,8 @@ int parport_negotiate (struct parport *port, int mode)
 		/* xflag should be high. */
 		if (!xflag) {
 			/* Extended mode not supported. */
-			DPRINTK (KERN_DEBUG "%s: Extended mode 0x%02x not "
-				 "supported\n", port->name, mode);
+			pr_debug("%s: Extended mode 0x%02x not supported\n",
+				 port->name, mode);
 			parport_ieee1284_terminate (port);
 			return 1;
 		}
@@ -505,7 +490,7 @@ int parport_negotiate (struct parport *port, int mode)
 	}
 
 	/* Mode is supported */
-	DPRINTK (KERN_DEBUG "%s: In mode 0x%02x\n", port->name, mode);
+	pr_debug("%s: In mode 0x%02x\n", port->name, mode);
 	port->ieee1284.mode = mode;
 
 	/* But ECP is special */
@@ -522,13 +507,11 @@ int parport_negotiate (struct parport *port, int mode)
 					     PARPORT_STATUS_PAPEROUT,
 					     PARPORT_STATUS_PAPEROUT);
 		if (r) {
-			DPRINTK (KERN_INFO "%s: Timeout at event 31\n",
-				port->name);
+			pr_debug("%s: Timeout at event 31\n", port->name);
 		}
 
 		port->ieee1284.phase = IEEE1284_PH_FWD_IDLE;
-		DPRINTK (KERN_DEBUG "%s: ECP direction: forward\n",
-			 port->name);
+		pr_debug("%s: ECP direction: forward\n", port->name);
 	} else switch (mode) {
 	case IEEE1284_MODE_NIBBLE:
 	case IEEE1284_MODE_BYTE:
@@ -573,7 +556,7 @@ void parport_ieee1284_interrupt (void *handle)
 	if (port->ieee1284.phase == IEEE1284_PH_REV_IDLE) {
 		/* An interrupt in this phase means that data
 		 * is now available. */
-		DPRINTK (KERN_DEBUG "%s: Data available\n", port->name);
+		pr_debug("%s: Data available\n", port->name);
 		parport_ieee1284_ack_data_avail (port);
 	}
 #endif /* IEEE1284 support */
@@ -617,13 +600,12 @@ ssize_t parport_write (struct parport *port, const void *buffer, size_t len)
 		parport_negotiate (port, IEEE1284_MODE_COMPAT);
 		/* fall through */
 	case IEEE1284_MODE_COMPAT:
-		DPRINTK (KERN_DEBUG "%s: Using compatibility mode\n",
-			 port->name);
+		pr_debug("%s: Using compatibility mode\n", port->name);
 		fn = port->ops->compat_write_data;
 		break;
 
 	case IEEE1284_MODE_EPP:
-		DPRINTK (KERN_DEBUG "%s: Using EPP mode\n", port->name);
+		pr_debug("%s: Using EPP mode\n", port->name);
 		if (addr) {
 			fn = port->ops->epp_write_addr;
 		} else {
@@ -631,8 +613,7 @@ ssize_t parport_write (struct parport *port, const void *buffer, size_t len)
 		}
 		break;
 	case IEEE1284_MODE_EPPSWE:
-		DPRINTK (KERN_DEBUG "%s: Using software-emulated EPP mode\n",
-			port->name);
+		pr_debug("%s: Using software-emulated EPP mode\n", port->name);
 		if (addr) {
 			fn = parport_ieee1284_epp_write_addr;
 		} else {
@@ -641,7 +622,7 @@ ssize_t parport_write (struct parport *port, const void *buffer, size_t len)
 		break;
 	case IEEE1284_MODE_ECP:
 	case IEEE1284_MODE_ECPRLE:
-		DPRINTK (KERN_DEBUG "%s: Using ECP mode\n", port->name);
+		pr_debug("%s: Using ECP mode\n", port->name);
 		if (addr) {
 			fn = port->ops->ecp_write_addr;
 		} else {
@@ -650,8 +631,7 @@ ssize_t parport_write (struct parport *port, const void *buffer, size_t len)
 		break;
 
 	case IEEE1284_MODE_ECPSWE:
-		DPRINTK (KERN_DEBUG "%s: Using software-emulated ECP mode\n",
-			 port->name);
+		pr_debug("%s: Using software-emulated ECP mode\n", port->name);
 		/* The caller has specified that it must be emulated,
 		 * even if we have ECP hardware! */
 		if (addr) {
@@ -662,13 +642,13 @@ ssize_t parport_write (struct parport *port, const void *buffer, size_t len)
 		break;
 
 	default:
-		DPRINTK (KERN_DEBUG "%s: Unknown mode 0x%02x\n", port->name,
-			port->ieee1284.mode);
+		pr_debug("%s: Unknown mode 0x%02x\n",
+			 port->name, port->ieee1284.mode);
 		return -ENOSYS;
 	}
 
 	retval = (*fn) (port, buffer, len, 0);
-	DPRINTK (KERN_DEBUG "%s: wrote %d/%d bytes\n", port->name, retval, len);
+	pr_debug("%s: wrote %zd/%zu bytes\n", port->name, retval, len);
 	return retval;
 #endif /* IEEE1284 support */
 }
@@ -715,7 +695,7 @@ ssize_t parport_read (struct parport *port, void *buffer, size_t len)
 		if ((port->physport->modes & PARPORT_MODE_TRISTATE) &&
 		    !parport_negotiate (port, IEEE1284_MODE_BYTE)) {
 			/* got into BYTE mode OK */
-			DPRINTK (KERN_DEBUG "%s: Using byte mode\n", port->name);
+			pr_debug("%s: Using byte mode\n", port->name);
 			fn = port->ops->byte_read_data;
 			break;
 		}
@@ -724,17 +704,17 @@ ssize_t parport_read (struct parport *port, void *buffer, size_t len)
 		}
 		/* fall through - to NIBBLE */
 	case IEEE1284_MODE_NIBBLE:
-		DPRINTK (KERN_DEBUG "%s: Using nibble mode\n", port->name);
+		pr_debug("%s: Using nibble mode\n", port->name);
 		fn = port->ops->nibble_read_data;
 		break;
 
 	case IEEE1284_MODE_BYTE:
-		DPRINTK (KERN_DEBUG "%s: Using byte mode\n", port->name);
+		pr_debug("%s: Using byte mode\n", port->name);
 		fn = port->ops->byte_read_data;
 		break;
 
 	case IEEE1284_MODE_EPP:
-		DPRINTK (KERN_DEBUG "%s: Using EPP mode\n", port->name);
+		pr_debug("%s: Using EPP mode\n", port->name);
 		if (addr) {
 			fn = port->ops->epp_read_addr;
 		} else {
@@ -742,8 +722,7 @@ ssize_t parport_read (struct parport *port, void *buffer, size_t len)
 		}
 		break;
 	case IEEE1284_MODE_EPPSWE:
-		DPRINTK (KERN_DEBUG "%s: Using software-emulated EPP mode\n",
-			port->name);
+		pr_debug("%s: Using software-emulated EPP mode\n", port->name);
 		if (addr) {
 			fn = parport_ieee1284_epp_read_addr;
 		} else {
@@ -752,19 +731,18 @@ ssize_t parport_read (struct parport *port, void *buffer, size_t len)
 		break;
 	case IEEE1284_MODE_ECP:
 	case IEEE1284_MODE_ECPRLE:
-		DPRINTK (KERN_DEBUG "%s: Using ECP mode\n", port->name);
+		pr_debug("%s: Using ECP mode\n", port->name);
 		fn = port->ops->ecp_read_data;
 		break;
 
 	case IEEE1284_MODE_ECPSWE:
-		DPRINTK (KERN_DEBUG "%s: Using software-emulated ECP mode\n",
-			 port->name);
+		pr_debug("%s: Using software-emulated ECP mode\n", port->name);
 		fn = parport_ieee1284_ecp_read_data;
 		break;
 
 	default:
-		DPRINTK (KERN_DEBUG "%s: Unknown mode 0x%02x\n", port->name,
-			 port->physport->ieee1284.mode);
+		pr_debug("%s: Unknown mode 0x%02x\n",
+			 port->name, port->physport->ieee1284.mode);
 		return -ENOSYS;
 	}
 
diff --git a/drivers/parport/ieee1284_ops.c b/drivers/parport/ieee1284_ops.c
index 5d41dda6da4e..b1c9f513167b 100644
--- a/drivers/parport/ieee1284_ops.c
+++ b/drivers/parport/ieee1284_ops.c
@@ -27,12 +27,6 @@
 #undef DEBUG /* Don't want a garbled console */
 #endif
 
-#ifdef DEBUG
-#define DPRINTK(stuff...) printk (stuff)
-#else
-#define DPRINTK(stuff...)
-#endif
-
 /***                                *
  * One-way data transfer functions. *
  *                                ***/
@@ -115,7 +109,7 @@ size_t parport_ieee1284_write_compat (struct parport *port,
 		if (signal_pending (current))
 			break;
 
-		DPRINTK (KERN_DEBUG "%s: Timed out\n", port->name);
+		pr_debug("%s: Timed out\n", port->name);
 		break;
 
 	ready:
@@ -178,9 +172,8 @@ size_t parport_ieee1284_read_nibble (struct parport *port,
 		if (parport_wait_peripheral (port,
 					     PARPORT_STATUS_ACK, 0)) {
 			/* Timeout -- no more data? */
-			DPRINTK (KERN_DEBUG
-				 "%s: Nibble timeout at event 9 (%d bytes)\n",
-				 port->name, i/2);
+			pr_debug("%s: Nibble timeout at event 9 (%d bytes)\n",
+				 port->name, i / 2);
 			parport_frob_control (port, PARPORT_CONTROL_AUTOFD, 0);
 			break;
 		}
@@ -201,8 +194,7 @@ size_t parport_ieee1284_read_nibble (struct parport *port,
 					     PARPORT_STATUS_ACK,
 					     PARPORT_STATUS_ACK)) {
 			/* Timeout -- no more data? */
-			DPRINTK (KERN_DEBUG
-				 "%s: Nibble timeout at event 11\n",
+			pr_debug("%s: Nibble timeout at event 11\n",
 				 port->name);
 			break;
 		}
@@ -219,9 +211,8 @@ size_t parport_ieee1284_read_nibble (struct parport *port,
 		/* Read the last nibble without checking data avail. */
 		if (parport_read_status (port) & PARPORT_STATUS_ERROR) {
 		end_of_data:
-			DPRINTK (KERN_DEBUG
-				"%s: No more nibble data (%d bytes)\n",
-				port->name, i/2);
+			pr_debug("%s: No more nibble data (%d bytes)\n",
+				 port->name, i / 2);
 
 			/* Go to reverse idle phase. */
 			parport_frob_control (port,
@@ -272,8 +263,7 @@ size_t parport_ieee1284_read_byte (struct parport *port,
 			/* Timeout -- no more data? */
 			parport_frob_control (port, PARPORT_CONTROL_AUTOFD,
 						 0);
-			DPRINTK (KERN_DEBUG "%s: Byte timeout at event 9\n",
-				 port->name);
+			pr_debug("%s: Byte timeout at event 9\n", port->name);
 			break;
 		}
 
@@ -288,8 +278,7 @@ size_t parport_ieee1284_read_byte (struct parport *port,
 					     PARPORT_STATUS_ACK,
 					     PARPORT_STATUS_ACK)) {
 			/* Timeout -- no more data? */
-			DPRINTK (KERN_DEBUG "%s: Byte timeout at event 11\n",
-				 port->name);
+			pr_debug("%s: Byte timeout at event 11\n", port->name);
 			break;
 		}
 
@@ -307,8 +296,7 @@ size_t parport_ieee1284_read_byte (struct parport *port,
 		/* Read the last byte without checking data avail. */
 		if (parport_read_status (port) & PARPORT_STATUS_ERROR) {
 		end_of_data:
-			DPRINTK (KERN_DEBUG
-				 "%s: No more byte data (%zd bytes)\n",
+			pr_debug("%s: No more byte data (%zd bytes)\n",
 				 port->name, count);
 
 			/* Go to reverse idle phase. */
@@ -353,12 +341,10 @@ int ecp_forward_to_reverse (struct parport *port)
 					  PARPORT_STATUS_PAPEROUT, 0);
 
 	if (!retval) {
-		DPRINTK (KERN_DEBUG "%s: ECP direction: reverse\n",
-			 port->name);
+		pr_debug("%s: ECP direction: reverse\n", port->name);
 		port->ieee1284.phase = IEEE1284_PH_REV_IDLE;
 	} else {
-		DPRINTK (KERN_DEBUG "%s: ECP direction: failed to reverse\n",
-			 port->name);
+		pr_debug("%s: ECP direction: failed to reverse\n", port->name);
 		port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
 	}
 
@@ -384,12 +370,10 @@ int ecp_reverse_to_forward (struct parport *port)
 
 	if (!retval) {
 		parport_data_forward (port);
-		DPRINTK (KERN_DEBUG "%s: ECP direction: forward\n",
-			 port->name);
+		pr_debug("%s: ECP direction: forward\n", port->name);
 		port->ieee1284.phase = IEEE1284_PH_FWD_IDLE;
 	} else {
-		DPRINTK (KERN_DEBUG
-			 "%s: ECP direction: failed to switch forward\n",
+		pr_debug("%s: ECP direction: failed to switch forward\n",
 			 port->name);
 		port->ieee1284.phase = IEEE1284_PH_ECP_DIR_UNKNOWN;
 	}
@@ -450,7 +434,7 @@ size_t parport_ieee1284_ecp_write_data (struct parport *port,
 		}
 
 		/* Time for Host Transfer Recovery (page 41 of IEEE1284) */
-		DPRINTK (KERN_DEBUG "%s: ECP transfer stalled!\n", port->name);
+		pr_debug("%s: ECP transfer stalled!\n", port->name);
 
 		parport_frob_control (port, PARPORT_CONTROL_INIT,
 				      PARPORT_CONTROL_INIT);
@@ -466,8 +450,7 @@ size_t parport_ieee1284_ecp_write_data (struct parport *port,
 		if (!(parport_read_status (port) & PARPORT_STATUS_PAPEROUT))
 			break;
 
-		DPRINTK (KERN_DEBUG "%s: Host transfer recovered\n",
-			 port->name);
+		pr_debug("%s: Host transfer recovered\n", port->name);
 
 		if (time_after_eq (jiffies, expire)) break;
 		goto try_again;
@@ -565,23 +548,20 @@ size_t parport_ieee1284_ecp_read_data (struct parport *port,
                    command or a normal data byte, don't accept it. */
 		if (command) {
 			if (byte & 0x80) {
-				DPRINTK (KERN_DEBUG "%s: stopping short at "
-					 "channel command (%02x)\n",
+				pr_debug("%s: stopping short at channel command (%02x)\n",
 					 port->name, byte);
 				goto out;
 			}
 			else if (port->ieee1284.mode != IEEE1284_MODE_ECPRLE)
-				DPRINTK (KERN_DEBUG "%s: device illegally "
-					 "using RLE; accepting anyway\n",
+				pr_debug("%s: device illegally using RLE; accepting anyway\n",
 					 port->name);
 
 			rle_count = byte + 1;
 
 			/* Are we allowed to read that many bytes? */
 			if (rle_count > (len - count)) {
-				DPRINTK (KERN_DEBUG "%s: leaving %d RLE bytes "
-					 "for next time\n", port->name,
-					 rle_count);
+				pr_debug("%s: leaving %d RLE bytes for next time\n",
+					 port->name, rle_count);
 				break;
 			}
 
@@ -596,7 +576,7 @@ size_t parport_ieee1284_ecp_read_data (struct parport *port,
 					     PARPORT_STATUS_ACK)) {
 			/* It's gone wrong.  Return what data we have
                            to the caller. */
-			DPRINTK (KERN_DEBUG "ECP read timed out at 45\n");
+			pr_debug("ECP read timed out at 45\n");
 
 			if (command)
 				printk (KERN_WARNING
@@ -620,7 +600,7 @@ size_t parport_ieee1284_ecp_read_data (struct parport *port,
 			memset (buf, byte, rle_count);
 			buf += rle_count;
 			count += rle_count;
-			DPRINTK (KERN_DEBUG "%s: decompressed to %d bytes\n",
+			pr_debug("%s: decompressed to %d bytes\n",
 				 port->name, rle_count);
 		} else {
 			/* Normal data byte. */
@@ -686,7 +666,7 @@ size_t parport_ieee1284_ecp_write_addr (struct parport *port,
 		}
 
 		/* Time for Host Transfer Recovery (page 41 of IEEE1284) */
-		DPRINTK (KERN_DEBUG "%s: ECP transfer stalled!\n", port->name);
+		pr_debug("%s: ECP transfer stalled!\n", port->name);
 
 		parport_frob_control (port, PARPORT_CONTROL_INIT,
 				      PARPORT_CONTROL_INIT);
@@ -702,8 +682,7 @@ size_t parport_ieee1284_ecp_write_addr (struct parport *port,
 		if (!(parport_read_status (port) & PARPORT_STATUS_PAPEROUT))
 			break;
 
-		DPRINTK (KERN_DEBUG "%s: Host transfer recovered\n",
-			 port->name);
+		pr_debug("%s: Host transfer recovered\n", port->name);
 
 		if (time_after_eq (jiffies, expire)) break;
 		goto try_again;
-- 
2.11.0

