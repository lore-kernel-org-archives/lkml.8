Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF2EC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54AB246A4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607489;
	bh=SVhXEM5ip6DL8l6Fd0jQhEMKOcT/fCDb5xo5D0hWBBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JYn3wUtr5LuOhzIfBBnNgDOaCyDLF1net4fn3cYAoXtJ8kQsb61NBCYPn+KANGhur
	 ck0yBKmGJeqckxpkwROkwyAwaD5TL1c5e5RDUNPO68x7p4gOnWSXByH6osXRAZTH2X
	 0IY5zwK9LDNosDajsUNt29Z4vVaQsy8EAMVJlS6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728796AbgBMPYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:24:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727597AbgBMPX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:23:27 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D801F24699;
        Thu, 13 Feb 2020 15:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607407;
        bh=SVhXEM5ip6DL8l6Fd0jQhEMKOcT/fCDb5xo5D0hWBBU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w0gVkUWBrREVkLs6K8vMS+4DAUowoebY9qI3X514MrFWmE1cmnnyLdfYFhGwYMAWh
         gWMSBwtN+7xagsZeaT2XDp7XMeSE6/b1r3WwJe+tKOOL7wSVi9Py+Z/FNRhZabrZl2
         xZNqW9GEpH3JqE76Muov53hryypSzQsSzGlFyUoc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roger Quadros <rogerq@ti.com>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH 4.9 018/116] usb: gadget: legacy: set max_speed to super-speed
Date:   Thu, 13 Feb 2020 07:19:22 -0800
Message-Id: <20200213151850.063028852@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151842.259660170@linuxfoundation.org>
References: <20200213151842.259660170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roger Quadros <rogerq@ti.com>

commit 463f67aec2837f981b0a0ce8617721ff59685c00 upstream.

These interfaces do support super-speed so let's not
limit maximum speed to high-speed.

Cc: <stable@vger.kernel.org>
Signed-off-by: Roger Quadros <rogerq@ti.com>
Signed-off-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/gadget/legacy/cdc2.c  |    2 +-
 drivers/usb/gadget/legacy/g_ffs.c |    2 +-
 drivers/usb/gadget/legacy/multi.c |    2 +-
 drivers/usb/gadget/legacy/ncm.c   |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/usb/gadget/legacy/cdc2.c
+++ b/drivers/usb/gadget/legacy/cdc2.c
@@ -229,7 +229,7 @@ static struct usb_composite_driver cdc_d
 	.name		= "g_cdc",
 	.dev		= &device_desc,
 	.strings	= dev_strings,
-	.max_speed	= USB_SPEED_HIGH,
+	.max_speed	= USB_SPEED_SUPER,
 	.bind		= cdc_bind,
 	.unbind		= cdc_unbind,
 };
--- a/drivers/usb/gadget/legacy/g_ffs.c
+++ b/drivers/usb/gadget/legacy/g_ffs.c
@@ -153,7 +153,7 @@ static struct usb_composite_driver gfs_d
 	.name		= DRIVER_NAME,
 	.dev		= &gfs_dev_desc,
 	.strings	= gfs_dev_strings,
-	.max_speed	= USB_SPEED_HIGH,
+	.max_speed	= USB_SPEED_SUPER,
 	.bind		= gfs_bind,
 	.unbind		= gfs_unbind,
 };
--- a/drivers/usb/gadget/legacy/multi.c
+++ b/drivers/usb/gadget/legacy/multi.c
@@ -486,7 +486,7 @@ static struct usb_composite_driver multi
 	.name		= "g_multi",
 	.dev		= &device_desc,
 	.strings	= dev_strings,
-	.max_speed	= USB_SPEED_HIGH,
+	.max_speed	= USB_SPEED_SUPER,
 	.bind		= multi_bind,
 	.unbind		= multi_unbind,
 	.needs_serial	= 1,
--- a/drivers/usb/gadget/legacy/ncm.c
+++ b/drivers/usb/gadget/legacy/ncm.c
@@ -203,7 +203,7 @@ static struct usb_composite_driver ncm_d
 	.name		= "g_ncm",
 	.dev		= &device_desc,
 	.strings	= dev_strings,
-	.max_speed	= USB_SPEED_HIGH,
+	.max_speed	= USB_SPEED_SUPER,
 	.bind		= gncm_bind,
 	.unbind		= gncm_unbind,
 };


