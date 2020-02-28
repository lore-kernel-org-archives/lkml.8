Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47C7C3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 02:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C62246A6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 02:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbgB1Ceb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 21:34:31 -0500
Received: from smtprelay0070.hostedemail.com ([216.40.44.70]:56958 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726943AbgB1Cea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 21:34:30 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 3970A2839;
        Fri, 28 Feb 2020 02:34:28 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: ink90_26a43b7fde626
X-Filterd-Recvd-Size: 10040
Received: from XPS-9350 (unknown [172.58.38.199])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Feb 2020 02:34:24 +0000 (UTC)
Message-ID: <8ce0d190e0e6061c14daf469d454bb3626e33549.camel@perches.com>
Subject: Re: [PATCH] parport: fix if-statement empty body warnings
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-parport@lists.infradead.org
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Date:   Thu, 27 Feb 2020 18:32:50 -0800
In-Reply-To: <e7868a5c-5356-bbbb-f416-799a7f75f7ad@infradead.org>
References: <e7868a5c-5356-bbbb-f416-799a7f75f7ad@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-27 at 18:08 -0800, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> When debugging via DPRINTK() is not enabled, make the DPRINTK()
> macro be an empty do-while block.
> 
> This fixes gcc warnings when -Wextra is set:
> 
> ../drivers/parport/ieee1284.c:262:18: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
> ../drivers/parport/ieee1284.c:285:17: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
> ../drivers/parport/ieee1284.c:298:17: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
> ../drivers/parport/ieee1284_ops.c:576:18: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
> 
> I have verified that there is no object code change (with gcc 7.5.0).
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
> Cc: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
> Cc: linux-parport@lists.infradead.org
> ---
>  drivers/parport/ieee1284.c     |    2 +-
>  drivers/parport/ieee1284_ops.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20200225.orig/drivers/parport/ieee1284.c
> +++ linux-next-20200225/drivers/parport/ieee1284.c
> @@ -34,7 +34,7 @@
>  #ifdef DEBUG
>  #define DPRINTK(stuff...) printk (stuff)
>  #else
> -#define DPRINTK(stuff...)
> +#define DPRINTK(stuff...) do {} while (0)

It's frequently better to use noprintk

And perhaps this should just become

#define DPRINTK pr_debug

or perhaps a conversion of DPRINTK uses
---
 drivers/parport/ieee1284_ops.c | 67 +++++++++++++++---------------------------
 1 file changed, 23 insertions(+), 44 deletions(-)

diff --git a/drivers/parport/ieee1284_ops.c b/drivers/parport/ieee1284_ops.c
index 5d41dd..b1c9f51 100644
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


