Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF389C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEA3F2068D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591726421;
	bh=MKi9Ec4ekA0zRqvxe3d+tTfsscx8C09ud9gHWbBEEOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2m3CMUxaHjIwySK+Jh3108QTKct6A2V5fVM2+QEswi50/oHB7mEKmg1/oVbyAjaxW
	 7yn93EjjejWdK+Kl49Dr/PPYXc2K2bX/7dznec6iN6ZWqxhGcv5k+rVlonmXQ58dab
	 NBGsD+vueeftx4ZGROfURXgX0fBB39XkoCvh7I5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732750AbgFIRuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:50:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732627AbgFIRuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:50:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3AD320801;
        Tue,  9 Jun 2020 17:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591725010;
        bh=MKi9Ec4ekA0zRqvxe3d+tTfsscx8C09ud9gHWbBEEOU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QIcNyU9ijW/WGXEWyW34zLXO9y8YuFXE+BTGoyEp9j0LvP++JUiMCZkzTtoXABZbt
         VH7F94Xb2RYrL+ZnHfHC+018MKIUfe39PLZrPqtFLdfNi+utBDy2qa2/noYxhv1ULe
         caUCPVcZHNeQPriyGTYh/v6hSxTr58kJ6fT8LZhg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.14 33/46] usb: musb: start session in resume for host port
Date:   Tue,  9 Jun 2020 19:44:49 +0200
Message-Id: <20200609174029.455219808@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174022.938987501@linuxfoundation.org>
References: <20200609174022.938987501@linuxfoundation.org>
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
@@ -2749,6 +2749,13 @@ static int musb_resume(struct device *de
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


