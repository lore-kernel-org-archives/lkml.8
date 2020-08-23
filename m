Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071A0C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 18:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E229621741
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 18:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgHWSNg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 14:13:36 -0400
Received: from smtprelay0245.hostedemail.com ([216.40.44.245]:37118 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725867AbgHWSNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 14:13:36 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 5721F18014950;
        Sun, 23 Aug 2020 18:13:34 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 73430182CED2A;
        Sun, 23 Aug 2020 18:13:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: idea45_11162582704c
X-Filterd-Recvd-Size: 1957
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sun, 23 Aug 2020 18:13:32 +0000 (UTC)
Message-ID: <e6cd92faf09722fe729a7de03e7bde592f62499c.camel@perches.com>
Subject: [likely PATCH] media: lmedm04: Fix misuse of comma
From:   Joe Perches <joe@perches.com>
To:     Malcolm Priestley <tvboxspy@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>
Date:   Sun, 23 Aug 2020 11:13:31 -0700
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a comma used instead of a semicolon that causes multiple
statements to be executed after an if instead of just the intended
single statement.

Replace the comma with a semicolon.

Signed-off-by: Joe Perches <joe@perches.com>
---

Untested, but really likely to be a defect given the indentation.

Found using Julia Lawall's (and my) coccinelle script.

https://lore.kernel.org/lkml/alpine.DEB.2.22.394.2008201856110.2524@hadrien/

 drivers/media/usb/dvb-usb-v2/lmedm04.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/dvb-usb-v2/lmedm04.c b/drivers/media/usb/dvb-usb-v2/lmedm04.c
index 8a3c0eeed959..cce431f34f61 100644
--- a/drivers/media/usb/dvb-usb-v2/lmedm04.c
+++ b/drivers/media/usb/dvb-usb-v2/lmedm04.c
@@ -391,7 +391,7 @@ static int lme2510_int_read(struct dvb_usb_adapter *adap)
 	ep = usb_pipe_endpoint(d->udev, lme_int->lme_urb->pipe);
 
 	if (usb_endpoint_type(&ep->desc) == USB_ENDPOINT_XFER_BULK)
-		lme_int->lme_urb->pipe = usb_rcvbulkpipe(d->udev, 0xa),
+		lme_int->lme_urb->pipe = usb_rcvbulkpipe(d->udev, 0xa);
 
 	usb_submit_urb(lme_int->lme_urb, GFP_ATOMIC);
 	info("INT Interrupt Service Started");


