Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1CCC2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7637D20658
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758786;
	bh=PIrfnSuER25OZ9F/dfyzhTcX/5FOxYCwiej3kBYp+W8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zu+Dq5iYo8sN8vKpKgfgMnE75+tNCy2ja0BHCEzI1B6HLFDWy6IjjikF6xfqVS4jg
	 WmNijTkdsMS7hSkLh8xFvyNBFIfYnyo0kdtxkqdx2ELPMC1bd+IMa1VCHyI8ucN8q2
	 aA6HvG/RqZDcCfewOQv3stIvd7Gvfn/SFdfoG9ro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388495AbgDAQdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:33:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388479AbgDAQdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:33:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6A9E20658;
        Wed,  1 Apr 2020 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758781;
        bh=PIrfnSuER25OZ9F/dfyzhTcX/5FOxYCwiej3kBYp+W8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WtM6x3WRXciJ9e8TrZ1HcAWPPoI7B1pihvd+oPQ3vCJ1s2QC+te3fNF2lr8PlEZuw
         0OmWeiieZd+oueUpBjv1EEpCebgJ/bzSyISJeHEaJzzY8mliySbKgnfg1xr06sFHah
         rrEA6H8LnhfCg3nDlp/85ku2xK+dJFlj1mhexvEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 4.4 74/91] media: usbtv: fix control-message timeouts
Date:   Wed,  1 Apr 2020 18:18:10 +0200
Message-Id: <20200401161537.373852922@linuxfoundation.org>
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

commit 536f561d871c5781bc33d26d415685211b94032e upstream.

The driver was issuing synchronous uninterruptible control requests
without using a timeout. This could lead to the driver hanging on
various user requests due to a malfunctioning (or malicious) device
until the device is physically disconnected.

The USB upper limit of five seconds per request should be more than
enough.

Fixes: f3d27f34fdd7 ("[media] usbtv: Add driver for Fushicai USBTV007 video frame grabber")
Fixes: c53a846c48f2 ("[media] usbtv: add video controls")
Cc: stable <stable@vger.kernel.org>     # 3.11
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Lubomir Rintel <lkundrak@v3.sk>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/usbtv/usbtv-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/usb/usbtv/usbtv-core.c
+++ b/drivers/media/usb/usbtv/usbtv-core.c
@@ -42,7 +42,7 @@ int usbtv_set_regs(struct usbtv *usbtv,
 
 		ret = usb_control_msg(usbtv->udev, pipe, USBTV_REQUEST_REG,
 			USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-			value, index, NULL, 0, 0);
+			value, index, NULL, 0, USB_CTRL_GET_TIMEOUT);
 		if (ret < 0)
 			return ret;
 	}


