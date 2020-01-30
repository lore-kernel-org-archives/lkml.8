Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A964AC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 781512082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580409988;
	bh=VqDmHkwwQXUzjmkuYi1yVAWOTe1K9YymAZQllXMZIEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lwWiBlVUTtWEJb6xDtsG39oiQzui1SsNGJIhk0P0Vg5JJ5JxwB2BgzzI/Js6RN92I
	 uSLnocJTSzFi+od4i9nwcYfeSBgvXaSPrRUgfmYE1TTdnWo8byJAhsqfO2gQlvcVji
	 oBbTGVtJpsY43OVUxBN/8aZ1yc9aTtZspEk58/tY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbgA3Sq1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:46:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:56312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730878AbgA3SqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:46:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7029A217BA;
        Thu, 30 Jan 2020 18:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409980;
        bh=VqDmHkwwQXUzjmkuYi1yVAWOTe1K9YymAZQllXMZIEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k//I/OdIoJjeTpZLvhovMTJxoQGiARLGDUKsfpn3f6tBNGP/0dAegjF/R/JmTLke5
         svG5J3puTU38j1AINhGCJxHOjVxamM2rwlnar4+lNH07l3OtTT91IilcNXreTg6hRV
         I69n1jq2bIDGAGsluBMwI1JO52gZ9602LsBNdw30=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Artur Rojek <contact@artur-rojek.eu>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 5.4 110/110] power/supply: ingenic-battery: Dont change scale if theres only one
Date:   Thu, 30 Jan 2020 19:39:26 +0100
Message-Id: <20200130183626.282928977@linuxfoundation.org>
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

From: Paul Cercueil <paul@crapouillou.net>

commit 86b9182df8bb12610d4d6feac45a69f3ed57bfd2 upstream.

The ADC in the JZ4740 can work either in high-precision mode with a 2.5V
range, or in low-precision mode with a 7.5V range. The code in place in
this driver will select the proper scale according to the maximum
voltage of the battery.

The JZ4770 however only has one mode, with a 6.6V range. If only one
scale is available, there's no need to change it (and nothing to change
it to), and trying to do so will fail with -EINVAL.

Fixes: fb24ccfbe1e0 ("power: supply: add Ingenic JZ47xx battery driver.")

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Artur Rojek <contact@artur-rojek.eu>
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/power/supply/ingenic-battery.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/drivers/power/supply/ingenic-battery.c
+++ b/drivers/power/supply/ingenic-battery.c
@@ -100,10 +100,17 @@ static int ingenic_battery_set_scale(str
 		return -EINVAL;
 	}
 
-	return iio_write_channel_attribute(bat->channel,
-					   scale_raw[best_idx],
-					   scale_raw[best_idx + 1],
-					   IIO_CHAN_INFO_SCALE);
+	/* Only set scale if there is more than one (fractional) entry */
+	if (scale_len > 2) {
+		ret = iio_write_channel_attribute(bat->channel,
+						  scale_raw[best_idx],
+						  scale_raw[best_idx + 1],
+						  IIO_CHAN_INFO_SCALE);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static enum power_supply_property ingenic_battery_properties[] = {


