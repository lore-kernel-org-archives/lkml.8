Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12738C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F20C620784
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgDWXSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:18:23 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:48994 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728273AbgDWXGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:06:38 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1jRkvP-0004fP-2K; Fri, 24 Apr 2020 00:06:31 +0100
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1jRkvN-00E6lt-9c; Fri, 24 Apr 2020 00:06:29 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Johan Hovold" <johan@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Fri, 24 Apr 2020 00:05:13 +0100
Message-ID: <lsq.1587683028.548461089@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 086/245] USB: serial: io_edgeport: fix epic endpoint
 lookup
In-Reply-To: <lsq.1587683027.831233700@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.83-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit 7c5a2df3367a2c4984f1300261345817d95b71f8 upstream.

Make sure to use the current alternate setting when looking up the
endpoints on epic devices to avoid binding to an invalid interface.

Failing to do so could cause the driver to misbehave or trigger a WARN()
in usb_submit_urb() that kernels with panic_on_warn set would choke on.

Fixes: 6e8cf7751f9f ("USB: add EPIC support to the io_edgeport driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://lore.kernel.org/r/20191210112601.3561-5-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/serial/io_edgeport.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -2859,16 +2859,18 @@ static int edge_startup(struct usb_seria
 	response = 0;
 
 	if (edge_serial->is_epic) {
+		struct usb_host_interface *alt;
+
+		alt = serial->interface->cur_altsetting;
+
 		/* EPIC thing, set up our interrupt polling now and our read
 		 * urb, so that the device knows it really is connected. */
 		interrupt_in_found = bulk_in_found = bulk_out_found = false;
-		for (i = 0; i < serial->interface->altsetting[0]
-						.desc.bNumEndpoints; ++i) {
+		for (i = 0; i < alt->desc.bNumEndpoints; ++i) {
 			struct usb_endpoint_descriptor *endpoint;
 			int buffer_size;
 
-			endpoint = &serial->interface->altsetting[0].
-							endpoint[i].desc;
+			endpoint = &alt->endpoint[i].desc;
 			buffer_size = usb_endpoint_maxp(endpoint);
 			if (!interrupt_in_found &&
 			    (usb_endpoint_is_int_in(endpoint))) {

