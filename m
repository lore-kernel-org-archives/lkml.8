Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D3AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FDEB206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591725580;
	bh=fl6azMfhIGuZjCmH+CkUOjvcD7goDESkGF2l0XOjBvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KJM9OiTabedag+86YzAu7STGsVpbN2wZ5bYLGI4u9EYzVPPkYCXQrnHLdv1yuYOT3
	 j7e40YY7gzhBeJ/b0y3Qft24Fs/WQPeJ1ANwafhlmAKMwfwTTtA9MkLEZ/ws+0cEEO
	 ndliL49tKLvrpO+eePnzQVpazMhpqe0hgDrmRX8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387720AbgFIR7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:59:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731893AbgFIRy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:54:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4A8520734;
        Tue,  9 Jun 2020 17:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591725298;
        bh=fl6azMfhIGuZjCmH+CkUOjvcD7goDESkGF2l0XOjBvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bhzcg44vqK8RWYhy7WADBz8ampII2KE42bPksNjd9roLENl6y7ej0JYo5mbrHwwEg
         YIjrH6Py/Sh+sAKAY5eL411LYSNTYWV4oMX1elRj083rF4V9ha87A14jkz58aWGUj4
         Y9OFL/e6GwBQ1qjnP0YBm8Cz8wLj+3qgf8PSrtxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bin Liu <b-liu@ti.com>
Subject: [PATCH 5.7 10/24] usb: musb: start session in resume for host port
Date:   Tue,  9 Jun 2020 19:45:41 +0200
Message-Id: <20200609174150.155237499@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174149.255223112@linuxfoundation.org>
References: <20200609174149.255223112@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bin Liu <b-liu@ti.com>

commit 7f88a5ac393f39319f69b8b20cc8d5759878d1a1 upstream.

Commit 17539f2f4f0b ("usb: musb: fix enumeration after resume") replaced
musb_start() in musb_resume() to not override softconnect bit, but it
doesn't restart the session for host port which was done in musb_start().
The session could be disabled in musb_suspend(), which leads the host
port doesn't stay in host mode.

So let's start the session specifically for host port in musb_resume().

Fixes: 17539f2f4f0b ("usb: musb: fix enumeration after resume")

Cc: stable@vger.kernel.org
Signed-off-by: Bin Liu <b-liu@ti.com>
Link: https://lore.kernel.org/r/20200525025049.3400-3-b-liu@ti.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/musb_core.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -2877,6 +2877,13 @@ static int musb_resume(struct device *de
 	musb_enable_interrupts(musb);
 	musb_platform_enable(musb);
 
+	/* session might be disabled in suspend */
+	if (musb->port_mode == MUSB_HOST &&
+	    !(musb->ops->quirks & MUSB_PRESERVE_SESSION)) {
+		devctl |= MUSB_DEVCTL_SESSION;
+		musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
+	}
+
 	spin_lock_irqsave(&musb->lock, flags);
 	error = musb_run_resume_work(musb);
 	if (error)


