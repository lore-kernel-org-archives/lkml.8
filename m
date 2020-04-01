Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A72C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AD2212CC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758803;
	bh=/js1TKxHe2wJwHHX+YVGC8Z7Th8Aiw40ATA7XA+ZAfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VuMZ/T2+OvLSZIp4hbCNkbezivQzbs62cF1W2RITlL2Mdd4lrugzZY3jIqlYCxtTN
	 8XDJ3jUNFzDP3zkJCzZpmN2p1dY4+6C0wY/Gj5JqKMYdqRojugj36SjHv8XqA8FuJe
	 JNw4DNg3/PF95lJ+alO6G0xxbX6LKyZqRt4cGh5E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387910AbgDAQdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:33:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387529AbgDAQdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:33:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33855212CC;
        Wed,  1 Apr 2020 16:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758799;
        bh=/js1TKxHe2wJwHHX+YVGC8Z7Th8Aiw40ATA7XA+ZAfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fGeIQVYUlBGf6ucX9yPn3RwGbk4pxdSCjgq+12oTeQ3LynYlxSwHiuEtR3AaTruLS
         b6cGO9CaWrzi1/7y6RkEX5CkjaadvaukDeR42SsSc7GHuY4NVpsidzQdOxKjjqB9lH
         V02YL6FVWx+ziijPM15SUQzqx5+OPKAMT1QIweGs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 4.4 79/91] media: dib0700: fix rc endpoint lookup
Date:   Wed,  1 Apr 2020 18:18:15 +0200
Message-Id: <20200401161538.466318120@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161512.917494101@linuxfoundation.org>
References: <20200401161512.917494101@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit f52981019ad8d6718de79b425a574c6bddf81f7c upstream.

Make sure to use the current alternate setting when verifying the
interface descriptors to avoid submitting an URB to an invalid endpoint.

Failing to do so could cause the driver to misbehave or trigger a WARN()
in usb_submit_urb() that kernels with panic_on_warn set would choke on.

Fixes: c4018fa2e4c0 ("[media] dib0700: fix RC support on Hauppauge Nova-TD")
Cc: stable <stable@vger.kernel.org>     # 3.16
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Sean Young <sean@mess.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/dvb-usb/dib0700_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/usb/dvb-usb/dib0700_core.c
+++ b/drivers/media/usb/dvb-usb/dib0700_core.c
@@ -783,7 +783,7 @@ int dib0700_rc_setup(struct dvb_usb_devi
 
 	/* Starting in firmware 1.20, the RC info is provided on a bulk pipe */
 
-	if (intf->altsetting[0].desc.bNumEndpoints < rc_ep + 1)
+	if (intf->cur_altsetting->desc.bNumEndpoints < rc_ep + 1)
 		return -ENODEV;
 
 	purb = usb_alloc_urb(0, GFP_KERNEL);
@@ -805,7 +805,7 @@ int dib0700_rc_setup(struct dvb_usb_devi
 	 * Some devices like the Hauppauge NovaTD model 52009 use an interrupt
 	 * endpoint, while others use a bulk one.
 	 */
-	e = &intf->altsetting[0].endpoint[rc_ep].desc;
+	e = &intf->cur_altsetting->endpoint[rc_ep].desc;
 	if (usb_endpoint_dir_in(e)) {
 		if (usb_endpoint_xfer_bulk(e)) {
 			pipe = usb_rcvbulkpipe(d->udev, rc_ep);


