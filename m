Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE017C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78845217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608025;
	bh=bhXjVC8VmY5frRL0G9VZnhws3DvkdX7+ZXxq8jOBiuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qYwthM7QybVe7OFWyUZh7ErFHLreBE96MJJVTAbRDC+eN9Rno2LPe+bN5qYGBSK1A
	 38wV3XpbaKypEBOH9OTlU737EmlAyZiURqC4eDCG4FziXCRYqXhFRjRBulhgpC8GpX
	 QuERQOLqbJrGOQi33LQHQpweqIU9kmEDPDt7Gd9Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729915AbgBMPdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:33:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:58792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729665AbgBMP3G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:29:06 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EB05206DB;
        Thu, 13 Feb 2020 15:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607745;
        bh=bhXjVC8VmY5frRL0G9VZnhws3DvkdX7+ZXxq8jOBiuk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W+HK1fXUSpl2Ma9/sL/riNAd3bX3j+8isPgJFDrl/EiKPD31ffCGljc8iv2MQXidl
         a2S68es5ZpOJC6lNYWhL8p8a1aS8R/XRAJcDua9M6v8c2wWDo55QynZ2zLuZNrGSo9
         xnS1Evy+rVU52IyhxGCD0VjeVa9TsxPt/55tBVZc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Raul E Rangel <rrangel@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 5.5 102/120] i2c: cros-ec-tunnel: Fix ACPI identifier
Date:   Thu, 13 Feb 2020 07:21:38 -0800
Message-Id: <20200213151935.176394459@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raul E Rangel <rrangel@chromium.org>

commit b49f8e0e7bd17b968129790e40f9e2566f4f95ec upstream.

The initial patch was using the incorrect identifier.

Fixes: 9af1563a5486 ("i2c: cros-ec-tunnel: Make the device acpi compatible")
Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-cros-ec-tunnel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
+++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
@@ -299,7 +299,7 @@ static const struct of_device_id cros_ec
 MODULE_DEVICE_TABLE(of, cros_ec_i2c_of_match);
 
 static const struct acpi_device_id cros_ec_i2c_tunnel_acpi_id[] = {
-	{ "GOOG001A", 0 },
+	{ "GOOG0012", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, cros_ec_i2c_tunnel_acpi_id);


