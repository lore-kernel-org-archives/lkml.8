Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A6FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1189520702
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580410397;
	bh=rkr4v3w3gcxDIUGXLSQY/xRcj719qPpxS+Rw5Z/tExw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dWaOwWcOdELwFryDz8eRQovbnVH25VdIc1UuzJDI0HHzrTauTczB2jGriDnAOSl2K
	 yC7w1j/jx0jrPcHR80/wP4gORL7L9bC3lPcuf990aKFMUBXm5hWVALrEWScGLcIpjD
	 W2zNNGekVtG9s4HeX1AcyOEiXP5W572sPdf1TpYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731758AbgA3SxQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:53:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:50372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730331AbgA3SmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:42:11 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 127792173E;
        Thu, 30 Jan 2020 18:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409730;
        bh=rkr4v3w3gcxDIUGXLSQY/xRcj719qPpxS+Rw5Z/tExw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FcMlPDzwJvuE/a6PAQ8HRKhqDOwe64+BqSkjNCfJdmKUfxIA56/2WASTcZvet5Wew
         dOtL/GmINYqVJ0pd75uox32TRRDh/2UAWqv95GkG+Cy8HL4V7HBNsdtLjcdw/WZ/WT
         kEfMcrSr++GoCMevkHrXQUCBLimtvMyTty4TMrXI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fariya Fatima <fariyaf@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.4 003/110] rsi_91x_usb: fix interface sanity check
Date:   Thu, 30 Jan 2020 19:37:39 +0100
Message-Id: <20200130183614.333507488@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183613.810054545@linuxfoundation.org>
References: <20200130183613.810054545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 3139b180906af43bc09bd3373fc2338a8271d9d9 upstream.

Make sure to use the current alternate setting when verifying the
interface descriptors to avoid binding to an invalid interface.

Failing to do so could cause the driver to misbehave or trigger a WARN()
in usb_submit_urb() that kernels with panic_on_warn set would choke on.

Fixes: dad0d04fa7ba ("rsi: Add RS9113 wireless driver")
Cc: stable <stable@vger.kernel.org>     # 3.15
Cc: Fariya Fatima <fariyaf@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/rsi/rsi_91x_usb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/rsi/rsi_91x_usb.c
+++ b/drivers/net/wireless/rsi/rsi_91x_usb.c
@@ -117,7 +117,7 @@ static int rsi_find_bulk_in_and_out_endp
 	__le16 buffer_size;
 	int ii, bin_found = 0, bout_found = 0;
 
-	iface_desc = &(interface->altsetting[0]);
+	iface_desc = interface->cur_altsetting;
 
 	for (ii = 0; ii < iface_desc->desc.bNumEndpoints; ++ii) {
 		endpoint = &(iface_desc->endpoint[ii].desc);


