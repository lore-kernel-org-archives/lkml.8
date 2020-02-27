Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C1AAC3F37B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5631C246A5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811563;
	bh=Z1DU4+Um6gFHn8qnTTuXqBgAJpwCBlWICAXSJKZeCko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=P+C/mE0c3BUyk/RsPUBFhv2rG86CIh10dJeBnEoIAtDBeKg0oIs2dw+VG+zzEAZJw
	 VsilIrcUz1V2gOxwgsbUnYQc07+9d8SNU2yqCMzIVHVuD9l2mQOWH0bEnlSlSnsFZu
	 CkIBwrq/0URA0n6LT1soPKq3brpH6G3T3bjlSsmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbgB0Nwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:52:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:51892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731523AbgB0NwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:52:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D948420578;
        Thu, 27 Feb 2020 13:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811543;
        bh=Z1DU4+Um6gFHn8qnTTuXqBgAJpwCBlWICAXSJKZeCko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MVpH7CwEePLslPPxRTBNXRfsV1yV0RfiHRAhoNjSUCldaAxy6bkcSMyxFwx16x28K
         L0GZ9PMr8Y/nSMIR4GT2ku8McJGJRXzvKK4v7h+9iSsZ1Brdqx690/eYPNPqdGhLLf
         isRtZqy5a/P3niUxA/EvV2NqkkCe7eyC2UEBJGrE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Dodd <richard.o.dodd@gmail.com>
Subject: [PATCH 4.9 125/165] USB: Fix novation SourceControl XL after suspend
Date:   Thu, 27 Feb 2020 14:36:39 +0100
Message-Id: <20200227132249.368667224@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Dodd <richard.o.dodd@gmail.com>

commit b692056db8ecc7f452b934f016c17348282b7699 upstream.

Currently, the SourceControl will stay in power-down mode after resuming
from suspend. This patch resets the device after suspend to power it up.

Signed-off-by: Richard Dodd <richard.o.dodd@gmail.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200212142220.36892-1-richard.o.dodd@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/quirks.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -291,6 +291,9 @@ static const struct usb_device_id usb_qu
 	/* INTEL VALUE SSD */
 	{ USB_DEVICE(0x8086, 0xf1a5), .driver_info = USB_QUIRK_RESET_RESUME },
 
+	/* novation SoundControl XL */
+	{ USB_DEVICE(0x1235, 0x0061), .driver_info = USB_QUIRK_RESET_RESUME },
+
 	{ }  /* terminating entry must be last */
 };
 


