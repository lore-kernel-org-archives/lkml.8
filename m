Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B08C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 01:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1C7820736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 01:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xjy0j8oG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgDXBKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 21:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725888AbgDXBKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 21:10:07 -0400
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1262DC09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 18:10:07 -0700 (PDT)
Received: by mail-wm1-x349.google.com with SMTP id 72so4676447wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 18:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=88mZnk/yJJPxv8ksSnTZfxrk5uMuKcJLn1UiqJx+wmw=;
        b=Xjy0j8oGaQBfUC0+TLweiaTVBntI5YN9B+ojSDjBhyR5peIn+AA+/fa23bCTH3tEPR
         xUM6US7ZQz7kMwXzO9iMVgkYLxaFQDPMKIEwgVRG2Q/qb4+gRNlQ7ouRgyJ7HugzFiRC
         17y1xK81h1VFdRZXkpktGeDPnCtjQ/PJCjD5WVfxioYm4SaexlU0CU4JzXFC1f4bX9NR
         vfMCoQFcHtAUh9V3nvqvTcGUIrVN9SLhRr+P9M9NFr8Ijt1ZWKLuyUbuu2rzT2bF1nLG
         As3NVgP6NZGHzw0cl1VtyDbpl2WjwEIiAzOy+bT98IZxfp/A2baWrqYz4uiz4uSHZTjE
         SGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=88mZnk/yJJPxv8ksSnTZfxrk5uMuKcJLn1UiqJx+wmw=;
        b=G0ptYf+0JWq13qw9P/TUsE40yvd3SIJeAM1d2aoik30bv3N4xfsDiYh5sNNHRpjqdh
         yCJiYnJk8P1uN837gs3vgCz0SA9BPiObLgaUkf+7iGvr3Fuh6RzAIhq9vHH+eIRMQY/J
         VgJJbquUOu5boLiL1zRfX5gYvdBSmdHyTJQ5HC+Kt8rLnNfJ3ju65Z4Bd1ug3HITAIeO
         kOTN/QU+nVZGIZ5ESPmmWac6xUcitPs3LhXUshyRrWoL+Xr5xngbuYhXN/ftQZ0VGYNa
         6P8PO2BqlvqxqWMbL+pHPhHWQk8e4hEeuQtiAip3FcwZZ9OYA3oxXK/3qeBZ6sfGYVQd
         QJ/g==
X-Gm-Message-State: AGi0PuZugfQv4IPVPklkwAtkt1JSkgjkkWjYPQgp/B910s/vxPdYIjdy
        mbuqzySDS6Ko6jGd09CeNsCjjcn0jvV5c5MT
X-Google-Smtp-Source: APiQypLPbcD2u3CRgSM+YSTrO9Dn4z0hpKBCeWEN1/zI3eqQ7+bp2ft+MtTqNYq3W2P3SZPbmLzBuX/XwjTVCdVc
X-Received: by 2002:adf:a11a:: with SMTP id o26mr7819194wro.284.1587690604105;
 Thu, 23 Apr 2020 18:10:04 -0700 (PDT)
Date:   Fri, 24 Apr 2020 03:09:58 +0200
Message-Id: <ca6b79b47313aa7ee9d8c24c5a7f595772764171.1587690539.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
Subject: [PATCH USB 1/2] usb: raw-gadget: fix return value of ep read ioctls
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They must return the number of bytes transferred during the data stage.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/usb/gadget/legacy/raw_gadget.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index ca7d95bf7397..7b241992ad5a 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -669,12 +669,14 @@ static int raw_ioctl_ep0_read(struct raw_dev *dev, unsigned long value)
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 	ret = raw_process_ep0_io(dev, &io, data, false);
-	if (ret)
+	if (ret < 0)
 		goto free;
 
 	length = min(io.length, (unsigned int)ret);
 	if (copy_to_user((void __user *)(value + sizeof(io)), data, length))
 		ret = -EFAULT;
+	else
+		ret = length;
 free:
 	kfree(data);
 	return ret;
@@ -964,12 +966,14 @@ static int raw_ioctl_ep_read(struct raw_dev *dev, unsigned long value)
 	if (IS_ERR(data))
 		return PTR_ERR(data);
 	ret = raw_process_ep_io(dev, &io, data, false);
-	if (ret)
+	if (ret < 0)
 		goto free;
 
 	length = min(io.length, (unsigned int)ret);
 	if (copy_to_user((void __user *)(value + sizeof(io)), data, length))
 		ret = -EFAULT;
+	else
+		ret = length;
 free:
 	kfree(data);
 	return ret;
-- 
2.26.2.303.gf8c07b1a785-goog

