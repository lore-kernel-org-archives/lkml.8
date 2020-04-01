Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D326DC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:29:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2A720658
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758574;
	bh=oGFDckR2TBmji8ob8AwdRWoVL7cZrdBE6BwdymPeHfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MKVCt7Zn5oAJIeVNAy2upXMTQZv5BpXWhrDLAHsoDU27wfcGPgyrdllytcaYKPn0j
	 kLqRqVveCvGDsrXYHUYLjb5v7uE+8VHr58CjwjMZsmZ/EcVQUPkGqie/IodYLhw9Ix
	 ebrv+pq0CWfrCM2OnXgvrYENjhb6N1AYa1Nc+Vjs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388188AbgDAQ3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:29:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:55036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387963AbgDAQ32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:29:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFAD52063A;
        Wed,  1 Apr 2020 16:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758568;
        bh=oGFDckR2TBmji8ob8AwdRWoVL7cZrdBE6BwdymPeHfc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pPX8nw1S1fJJ3z4D7LvZLly+UjF1KSQ6aKjMQgPqsrl8193bIyTr/d5l4yCi+Hr7q
         1g075is0N7B3WA4UP14UBnXdVw+FrFsMb37OcTxPixk2KexWjl56D7lJLrfGL2Hujs
         Jd2NaQ1L4bPLp4MG3IDfBK4ZPggzEuSYBzR41MU8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniele Palmas <dnlplm@gmail.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.4 10/91] USB: serial: option: add ME910G1 ECM composition 0x110b
Date:   Wed,  1 Apr 2020 18:17:06 +0200
Message-Id: <20200401161516.805635623@linuxfoundation.org>
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

From: Daniele Palmas <dnlplm@gmail.com>

commit 8e852a7953be2a6ee371449f7257fe15ace6a1fc upstream.

Add ME910G1 ECM composition 0x110b: tty, tty, tty, ecm

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Link: https://lore.kernel.org/r/20200304104310.2938-1-dnlplm@gmail.com
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/option.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1172,6 +1172,8 @@ static const struct usb_device_id option
 	  .driver_info = NCTRL(0) },
 	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x110a, 0xff),	/* Telit ME910G1 */
 	  .driver_info = NCTRL(0) | RSVD(3) },
+	{ USB_DEVICE_INTERFACE_CLASS(TELIT_VENDOR_ID, 0x110b, 0xff),	/* Telit ME910G1 (ECM) */
+	  .driver_info = NCTRL(0) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE910),
 	  .driver_info = NCTRL(0) | RSVD(1) | RSVD(2) },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE910_USBCFG4),


