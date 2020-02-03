Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EADC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4B22086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580746823;
	bh=sHEQDUxJfVWLAxmiD8XRiG1UUW3yDrMrHX0kipaQi00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CUz9O2c6lf1Z8ErMlgUe3otp3OT0MC7DMyI1652hIdEnmK15fozol5CHFn/QNn7Aq
	 a8kBqXQD5oO50flW0cxUuB+eJEAjEdR+dNNrKo/+YCdlPh0QmRklytZXut5Rgt0pCb
	 5v6Az5pPxIi4D8/VrYB61QMznNm9DoauE43I/M/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgBCQUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:20:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:60062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728824AbgBCQUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:20:19 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9690620838;
        Mon,  3 Feb 2020 16:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580746819;
        bh=sHEQDUxJfVWLAxmiD8XRiG1UUW3yDrMrHX0kipaQi00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gQv2GXP/TGTf8YVVJmPAd1FGYPdvjbC/SYrgAu2tD0nn26B/Dny4MSCyrvT1yonaM
         3twDSEaVmsiN4TQBH33qd1U+uAvjLDRMxWrR/pgdlz+po5/eC8WefCcBKJJB43IV4V
         1fhsHQpaRm4R3LECV3WTdX0dun/BzKCa7jcG2ePM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.4 02/53] orinoco_usb: fix interface sanity check
Date:   Mon,  3 Feb 2020 16:18:54 +0000
Message-Id: <20200203161903.457277571@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161902.714326084@linuxfoundation.org>
References: <20200203161902.714326084@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit b73e05aa543cf8db4f4927e36952360d71291d41 upstream.

Make sure to use the current alternate setting when verifying the
interface descriptors to avoid binding to an invalid interface.

Failing to do so could cause the driver to misbehave or trigger a WARN()
in usb_submit_urb() that kernels with panic_on_warn set would choke on.

Fixes: 9afac70a7305 ("orinoco: add orinoco_usb driver")
Cc: stable <stable@vger.kernel.org>     # 2.6.35
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/orinoco/orinoco_usb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/orinoco/orinoco_usb.c
+++ b/drivers/net/wireless/orinoco/orinoco_usb.c
@@ -1601,9 +1601,9 @@ static int ezusb_probe(struct usb_interf
 	/* set up the endpoint information */
 	/* check out the endpoints */
 
-	iface_desc = &interface->altsetting[0].desc;
+	iface_desc = &interface->cur_altsetting->desc;
 	for (i = 0; i < iface_desc->bNumEndpoints; ++i) {
-		ep = &interface->altsetting[0].endpoint[i].desc;
+		ep = &interface->cur_altsetting->endpoint[i].desc;
 
 		if (usb_endpoint_is_bulk_in(ep)) {
 			/* we found a bulk in endpoint */


