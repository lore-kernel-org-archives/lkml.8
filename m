Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDADC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C81320737
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586954106;
	bh=92e03qfV5WzTTcnm4d7dLXBPeHPv6FHPB6NTC593rt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p+yhbpAcenUWij480cRecQbdctNGLMUou3qM5KBCONVnRI9/3OTpO32HKXsdvFZTY
	 0ynWjWwduMjflvz+zLcbDFtxR5EaEdJf2VrPP1PSwWQibQiy977/MpWsA+89FpUhQK
	 nARcyEPFX4sRqcl+zAbWH0ywb6bc6siDo2Gdf9kc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369797AbgDOMfA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:35:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409058AbgDOLoL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:44:11 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29B3B20737;
        Wed, 15 Apr 2020 11:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951050;
        bh=92e03qfV5WzTTcnm4d7dLXBPeHPv6FHPB6NTC593rt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mCPdP8IwV1z/6Bi9ZGJAKA7tf++CFwwss5dU33C2xinZ6/8FNQdZU9mM3GUJ7YlkN
         QjJGnc9TkhHoMeu0iHyUUga1SvivA/rwhirkS9cMa9SNQykof3wyBYXmgLFIf84i7v
         ZiDUbp1SdVA2f0UBlSnk1adOyQjX4Cw+MOfrWpM8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Oliver Neukum <oneukum@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 085/106] mfd: dln2: Fix sanity checking for endpoints
Date:   Wed, 15 Apr 2020 07:42:05 -0400
Message-Id: <20200415114226.13103-85-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114226.13103-1-sashal@kernel.org>
References: <20200415114226.13103-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit fb945c95a482200876993977008b67ea658bd938 ]

While the commit 2b8bd606b1e6 ("mfd: dln2: More sanity checking for endpoints")
tries to harden the sanity checks it made at the same time a regression,
i.e.  mixed in and out endpoints. Obviously it should have been not tested on
real hardware at that time, but unluckily it didn't happen.

So, fix above mentioned typo and make device being enumerated again.

While here, introduce an enumerator for magic values to prevent similar issue
to happen in the future.

Fixes: 2b8bd606b1e6 ("mfd: dln2: More sanity checking for endpoints")
Cc: Oliver Neukum <oneukum@suse.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/dln2.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 7841c11411d08..4faa8d2e5d045 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -90,6 +90,11 @@ struct dln2_mod_rx_slots {
 	spinlock_t lock;
 };
 
+enum dln2_endpoint {
+	DLN2_EP_OUT	= 0,
+	DLN2_EP_IN	= 1,
+};
+
 struct dln2_dev {
 	struct usb_device *usb_dev;
 	struct usb_interface *interface;
@@ -733,10 +738,10 @@ static int dln2_probe(struct usb_interface *interface,
 	    hostif->desc.bNumEndpoints < 2)
 		return -ENODEV;
 
-	epin = &hostif->endpoint[0].desc;
-	epout = &hostif->endpoint[1].desc;
+	epout = &hostif->endpoint[DLN2_EP_OUT].desc;
 	if (!usb_endpoint_is_bulk_out(epout))
 		return -ENODEV;
+	epin = &hostif->endpoint[DLN2_EP_IN].desc;
 	if (!usb_endpoint_is_bulk_in(epin))
 		return -ENODEV;
 
-- 
2.20.1

