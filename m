Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E86BC2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1916F20BED
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758450;
	bh=h74ejmZRkUXqWK9qRDs8IjDoU7X8jdD/ST0PfyG2Zlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HKrXWcrQC4A/vD4Itn20YuOaMTVj0lRoPk2Z8XUf+v4GFJUBW/Xop9NWtj0f7tV7d
	 5BKoZPJRBNogYvlb3ZhGjIzPQphio4l435F5vCf5ufs4lTj1Nij8IjyCv832qDKE+6
	 S+S7Krf73xokbeRkyaE/FUoKOq1L0Mf1WVAEkYlQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387745AbgDAQ13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:27:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387488AbgDAQ1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:27:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BA55214D8;
        Wed,  1 Apr 2020 16:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758442;
        bh=h74ejmZRkUXqWK9qRDs8IjDoU7X8jdD/ST0PfyG2Zlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eH7La00/zMSU06qlcwsDqgJVtB2OHaHnO5gOw0IoBde49fAaolttocZKKli2TJ6aH
         CMxjRlQVAYYETlOI06CRjn8Jz1bO/lDZ5q/Fn8fSXAgCZkBzim7wOL/dvmfWF/l5Ls
         nNVnhxyV0nx/TZuLab5Sq7ab+TWY1Ni0mlO1Y4/g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 4.19 093/116] media: dib0700: fix rc endpoint lookup
Date:   Wed,  1 Apr 2020 18:17:49 +0200
Message-Id: <20200401161554.292734734@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161542.669484650@linuxfoundation.org>
References: <20200401161542.669484650@linuxfoundation.org>
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
@@ -821,7 +821,7 @@ int dib0700_rc_setup(struct dvb_usb_devi
 
 	/* Starting in firmware 1.20, the RC info is provided on a bulk pipe */
 
-	if (intf->altsetting[0].desc.bNumEndpoints < rc_ep + 1)
+	if (intf->cur_altsetting->desc.bNumEndpoints < rc_ep + 1)
 		return -ENODEV;
 
 	purb = usb_alloc_urb(0, GFP_KERNEL);
@@ -841,7 +841,7 @@ int dib0700_rc_setup(struct dvb_usb_devi
 	 * Some devices like the Hauppauge NovaTD model 52009 use an interrupt
 	 * endpoint, while others use a bulk one.
 	 */
-	e = &intf->altsetting[0].endpoint[rc_ep].desc;
+	e = &intf->cur_altsetting->endpoint[rc_ep].desc;
 	if (usb_endpoint_dir_in(e)) {
 		if (usb_endpoint_xfer_bulk(e)) {
 			pipe = usb_rcvbulkpipe(d->udev, rc_ep);


