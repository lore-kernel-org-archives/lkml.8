Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6149C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E6920704
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686657;
	bh=Gvw4IBVvTbh7LJegV1H9BhU7bNh5YLZ2sWO/BXanA6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=irKoSJPV/eWdTnS/8JPco64mWUn4GTwnXKNsiScYEEyak69g08cWIYY0b/O2nDKNa
	 XK71+MjAAXcxAEn1XJhCj65SbHKLRE9B7fSh3SByUDHPqMhpsiZtEiA5SNUjWVG1Lg
	 WSL2QNq3Fmj1JMBIgrU41MXq78Orabz8+We93CGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732602AbgAVJhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:37:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:53818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731259AbgAVJhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:37:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 385662467E;
        Wed, 22 Jan 2020 09:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685857;
        bh=Gvw4IBVvTbh7LJegV1H9BhU7bNh5YLZ2sWO/BXanA6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FmdyVefxvDDlOtdSEHsN54TntZZdeVL2p6qcfQQ/hwCkL7dSbd8nYIS9jll2K79JQ
         J2pbxy2YpSKuag+cX/G9XBRajjwdO5C44yZ/icyFQs3nEOZpv944WdZz3JQ0ahl4QF
         By3FJwQanKEJInA3lHhrAby4vD+p+fPRBX1Zb340=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Martin Jansen <martin.jansen@opticon.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 4.14 11/65] USB: serial: opticon: fix control-message timeouts
Date:   Wed, 22 Jan 2020 10:28:56 +0100
Message-Id: <20200122092752.846945076@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092750.976732974@linuxfoundation.org>
References: <20200122092750.976732974@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 5e28055f340275a8616eee88ef19186631b4d136 upstream.

The driver was issuing synchronous uninterruptible control requests
without using a timeout. This could lead to the driver hanging
on open() or tiocmset() due to a malfunctioning (or malicious) device
until the device is physically disconnected.

The USB upper limit of five seconds per request should be more than
enough.

Fixes: 309a057932ab ("USB: opticon: add rts and cts support")
Cc: stable <stable@vger.kernel.org>     # 2.6.39
Cc: Martin Jansen <martin.jansen@opticon.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/serial/opticon.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/serial/opticon.c
+++ b/drivers/usb/serial/opticon.c
@@ -116,7 +116,7 @@ static int send_control_msg(struct usb_s
 	retval = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
 				requesttype,
 				USB_DIR_OUT|USB_TYPE_VENDOR|USB_RECIP_INTERFACE,
-				0, 0, buffer, 1, 0);
+				0, 0, buffer, 1, USB_CTRL_SET_TIMEOUT);
 	kfree(buffer);
 
 	if (retval < 0)


