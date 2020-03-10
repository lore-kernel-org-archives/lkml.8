Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D95C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8F32253D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844767;
	bh=TPw2k5RTp3jIJwl5cVpO8uiiXKwu7hHDfLYGxuIr0Go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QojRuFLtW58SMAuJZI90lDlMik/zi3uDpRRC+5N1G0w3SVfWoKRbCSjJ9Z1OlZDX8
	 izZscma0FOnSFHPEwcs8pkFsnYUGerTlY/AfzyK1L5KdOq2XBDhEtYHxF7cIsbXOZq
	 rtS+zbeIwdBdK+JYy6cUpd0bFPCxNLABykOzlKaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgCJMwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:52:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728284AbgCJMwm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:52:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A75212253D;
        Tue, 10 Mar 2020 12:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844762;
        bh=TPw2k5RTp3jIJwl5cVpO8uiiXKwu7hHDfLYGxuIr0Go=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sKPTBcVMhlh1GVgvPwusIVJ74tnzwHJZHU1oc1taCR9J9fPQYn9lUa8ZhmYfvILEw
         be7BuYIAsbKgDoZ7SMUr83t0/6VLaeAE24DCHKfNJXNHhVptNqQFQOTRYpPV+SESvK
         ritTY1VTIPSfangj5QdL2JAc/Zau59wDb3s8H2SE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Subject: [PATCH 5.4 071/168] usb: core: hub: fix unhandled return by employing a void function
Date:   Tue, 10 Mar 2020 13:38:37 +0100
Message-Id: <20200310123642.454327306@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugeniu Rosca <erosca@de.adit-jv.com>

commit 63d6d7ed475c53dc1cabdfedf63de1fd8dcd72ee upstream.

Address below Coverity complaint (Feb 25, 2020, 8:06 AM CET):

---
 drivers/usb/core/hub.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1865,7 +1865,7 @@ static int hub_probe(struct usb_interfac
 
 	if (id->driver_info & HUB_QUIRK_DISABLE_AUTOSUSPEND) {
 		hub->quirk_disable_autosuspend = 1;
-		usb_autopm_get_interface(intf);
+		usb_autopm_get_interface_no_resume(intf);
 	}
 
 	if (hub_configure(hub, &desc->endpoint[0].desc) >= 0)


