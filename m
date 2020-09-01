Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B47C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6318206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598980311;
	bh=wZYcmCEmIqGYnq6Min8mgzatzLhIO07/7HKSNXgnsWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i+d2ao+Z5xPufirpp6BBlokWHP1DtBYUWGN7IO4OIQdaHhB0UOJdFdpA4V6t63OYN
	 5vYJyyd0jrZIJXsqGkDo/NSFq/9xHVsMJhDuoz4l+rqGu/7zcRAiMqwBh0xSzKAjw8
	 kP12ZTEJvmFHMUHyEtNPSVZmF8OdOfKcauP0eeQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgIARLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:11:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:32806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729278AbgIAPQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:16:13 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB46E206EB;
        Tue,  1 Sep 2020 15:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973373;
        bh=wZYcmCEmIqGYnq6Min8mgzatzLhIO07/7HKSNXgnsWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=waWWXiS6o3GXLKbTAOwZge0FQA/FfbjJZKlL8RwCK7ihwXREaP8MVnFRA1JEMmfwW
         qNDC11NBI3azzDFo/gA8t9tHZh8z99EYZ5jdyHi5Vufi1BYIwrUYtaTRAtC2kPdaZ6
         5SRLTYHR5TebJMq4vkY588FNuN0/HFjIP3y28VIQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evgeny Novikov <novikov@ispras.ru>
Subject: [PATCH 4.9 52/78] USB: lvtest: return proper error code in probe
Date:   Tue,  1 Sep 2020 17:10:28 +0200
Message-Id: <20200901150927.352710759@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150924.680106554@linuxfoundation.org>
References: <20200901150924.680106554@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Evgeny Novikov <novikov@ispras.ru>

commit 531412492ce93ea29b9ca3b4eb5e3ed771f851dd upstream.

lvs_rh_probe() can return some nonnegative value from usb_control_msg()
when it is less than "USB_DT_HUB_NONVAR_SIZE + 2" that is considered as
a failure. Make lvs_rh_probe() return -EINVAL in this case.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200805090643.3432-1-novikov@ispras.ru
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/misc/lvstest.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/misc/lvstest.c
+++ b/drivers/usb/misc/lvstest.c
@@ -392,7 +392,7 @@ static int lvs_rh_probe(struct usb_inter
 			USB_DT_SS_HUB_SIZE, USB_CTRL_GET_TIMEOUT);
 	if (ret < (USB_DT_HUB_NONVAR_SIZE + 2)) {
 		dev_err(&hdev->dev, "wrong root hub descriptor read %d\n", ret);
-		return ret;
+		return ret < 0 ? ret : -EINVAL;
 	}
 
 	/* submit urb to poll interrupt endpoint */


