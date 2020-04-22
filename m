Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E395C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC082075A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587551337;
	bh=fDk4iEc1m2CZ0EJ6EEGzbIyU4/+VR2cjgOKoQRhmoXk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cDEMlsyyRhbYrgw1uAW65HNFzpaen9XrT/0U1oW0BVMhoGZTmirxHd1jvrWkTK/6s
	 YqrGpTQW/VNHym6Mn3WBA5aEQePnKBBBm9nUd/bVuh2TZzaOyPbmTS/i9df0Tz9eN7
	 FbeoAttUehLDplN+OX/8j7MBb/MfKkEQivNwDTmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbgDVK13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:27:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730863AbgDVK1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:27:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5F1320857;
        Wed, 22 Apr 2020 10:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587551239;
        bh=fDk4iEc1m2CZ0EJ6EEGzbIyU4/+VR2cjgOKoQRhmoXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G3RcARyDfEp1gCRu+BoDExpFwV1Qr1AmyrudylAimCgtCWE91r5tVXFSAAiVGcGuZ
         N30miQ0nmXOMigJyY5ZnUMo9Tmact/WISz6nb6n4xE27+/azW4ISJFNn2NCI6r20xy
         6cW6xsxhBGnOAsDu/Yx+hH2jWIxTihNl2XcWgnvk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.6 155/166] iio: st_sensors: handle memory allocation failure to fix null pointer dereference
Date:   Wed, 22 Apr 2020 11:58:02 +0200
Message-Id: <20200422095105.126701618@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095047.669225321@linuxfoundation.org>
References: <20200422095047.669225321@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit 9960c70949d4356abed8747a20637e0946bb0bad upstream.

A null pointer deference on pdata can occur if the allocation of
pdata fails.  Fix this by adding a null pointer check and handle
the -ENOMEM failure in the caller.

Addresses-Coverity: ("Dereference null return value")
Fixes: 3ce85cc4fbb7 ("iio: st_sensors: get platform data from device tree")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/common/st_sensors/st_sensors_core.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -328,6 +328,8 @@ static struct st_sensors_platform_data *
 		return NULL;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
 	if (!device_property_read_u32(dev, "st,drdy-int-pin", &val) && (val <= 2))
 		pdata->drdy_int_pin = (u8) val;
 	else
@@ -371,6 +373,8 @@ int st_sensors_init_sensor(struct iio_de
 
 	/* If OF/DT pdata exists, it will take precedence of anything else */
 	of_pdata = st_sensors_dev_probe(indio_dev->dev.parent, pdata);
+	if (IS_ERR(of_pdata))
+		return PTR_ERR(of_pdata);
 	if (of_pdata)
 		pdata = of_pdata;
 


