Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C717CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B44D206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598973222;
	bh=0IHfMM1s3befRcEn9mSaFSTKf4HKZA9VqVK3eO/CPXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ihxNyIWGrJshv9bpf0cI/8h11TQWC3NhpQAgyhBDxdv/pmronDpz1phovKR6P5xVV
	 STPPYNxj61xwx6J/AVtSJ5a/GWylELC5sLnsvROPev2EcfL6SM/9GUkcnONkOQQu+R
	 XqPQlzba2erpKFU5NAPISZYMhK4usJ7HFhXQIlDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgIAPNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:13:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:55970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbgIAPNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:13:07 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3BDA2078B;
        Tue,  1 Sep 2020 15:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973187;
        bh=0IHfMM1s3befRcEn9mSaFSTKf4HKZA9VqVK3eO/CPXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q3ZCXnOdggcAUXwtaMr5BXzALKFEyqAbQlT32pumxV+clVlleHvOji2xJPQl1y9SY
         5dIcKhe3HzcYewUWo1zKLqT3ShUpRmkGAhFbsUTQJgIgj+Uxp5qpouOGm919u3ET4X
         CgwkzY9QJkvto5RMB03t9fq088kdqjX174pXXKOY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evgeny Novikov <novikov@ispras.ru>
Subject: [PATCH 4.4 41/62] USB: lvtest: return proper error code in probe
Date:   Tue,  1 Sep 2020 17:10:24 +0200
Message-Id: <20200901150922.799754719@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150920.697676718@linuxfoundation.org>
References: <20200901150920.697676718@linuxfoundation.org>
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
@@ -396,7 +396,7 @@ static int lvs_rh_probe(struct usb_inter
 			USB_DT_SS_HUB_SIZE, USB_CTRL_GET_TIMEOUT);
 	if (ret < (USB_DT_HUB_NONVAR_SIZE + 2)) {
 		dev_err(&hdev->dev, "wrong root hub descriptor read %d\n", ret);
-		return ret;
+		return ret < 0 ? ret : -EINVAL;
 	}
 
 	/* submit urb to poll interrupt endpoint */


