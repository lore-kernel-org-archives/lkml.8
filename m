Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7323C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 841DD205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cyEJYbuo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390033AbgEMSBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 14:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732488AbgEMSBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:01:50 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28300C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:01:50 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id h185so619565ybg.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 11:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=5/MRceWyn7IA9pmXU1Ty874NROsCdfVXPSq0u2J/dn0=;
        b=cyEJYbuoTCZwv/JsnJBEdVmnQ08+rJVCHUfnXpjw128J6smQ4hrmkq2g50efB/eedA
         XV5xHOXTYGeGEuee1G7pe2Zpw8/80UZC50cT2fcIuXIaiCx+GaAFketbc4CGpNGGP87V
         mQcTySPjLpKyPF9jyRn9Q5QgBn3IXJZITq3QDXPao4y5YJjgT6jbCvHHdrO2y8IlLX/U
         lRmnImSFuOZRaRV1omRTFJeKCK5o+Wk6KdmJ8kUGU6ROsMKa0GoQlN1oenuJ30Ne0B1z
         uUpnTabyDpe1JCNnMheGtM8SA/UHb95RHyKxn59/KD3i0o/zmRrg11F7PSx395ghxN9b
         lQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=5/MRceWyn7IA9pmXU1Ty874NROsCdfVXPSq0u2J/dn0=;
        b=o1ogoedGr0S0vbvd/mAGNz46XE27k1wJszzp/pV2RPBqQhwTG1Wdzq4KlfYW4UwRzu
         W8nDjvC9kFI4MiBfUyBAa60P8BWSK+YjtjrCpA/ZBUt6n7jNMfDdS42OVIrkQc8JnLE6
         3KWpF+6YcDYvLBTdJlz9HVAaX5PK2ksf888BW6sS5GK1dVjxFtib/4ZdktopX8sfcu1y
         qrujriijr8+wMyQPq6IGr5MRUwkHai3XTGHRIIKRjjmjvv8j2HM+jQI1GB1rVuXSdd5/
         Wtg2zQRQ3eSZKaemQ0PDajN9LrR6P2T2XWaPdNy6GkfWiXW9tMddw4D8wPc3CwpxL9q6
         YkOg==
X-Gm-Message-State: AOAM531BjPqb4WMQSCRUKjJUmpnfdVpLouZT6C6vD/mWIdm8/r40iX2J
        fGV3NNf1MkvREM7IITyT5AewG7dz7Us1kSYu
X-Google-Smtp-Source: ABdhPJzByBrBAtuTVt//2PEhmGvansFFvV+KulV8oXted/AGzBiO6VtlMfXhTAQAalvYmvNwUeaRobr214loYVWO
X-Received: by 2002:a25:d084:: with SMTP id h126mr361526ybg.424.1589392909379;
 Wed, 13 May 2020 11:01:49 -0700 (PDT)
Date:   Wed, 13 May 2020 20:01:42 +0200
Message-Id: <76557d920a125f6e42b3dc46d3ae84bffbe9a2f9.1589392709.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH USB] usb: raw-gadget: fix null-ptr-deref when reenabling endpoints
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we preassign gadget endpoints to raw-gadget endpoints during
initialization. Fix resetting this assignment in raw_ioctl_ep_disable(),
otherwise we will get null-ptr-derefs when an endpoint is reenabled.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---

Felipe, this is technically a fix for "usb: raw-gadget: fix gadget
endpoint selection", which AFAICS is already in your testing/fixes tree.
Please let me know if you would like me resend that patch with this fix
folded in.

---
 drivers/usb/gadget/legacy/raw_gadget.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
index d73ba77014c8..e01e366d89cd 100644
--- a/drivers/usb/gadget/legacy/raw_gadget.c
+++ b/drivers/usb/gadget/legacy/raw_gadget.c
@@ -867,7 +867,6 @@ static int raw_ioctl_ep_disable(struct raw_dev *dev, unsigned long value)
 	spin_lock_irqsave(&dev->lock, flags);
 	usb_ep_free_request(dev->eps[i].ep, dev->eps[i].req);
 	kfree(dev->eps[i].ep->desc);
-	dev->eps[i].ep = NULL;
 	dev->eps[i].state = STATE_EP_DISABLED;
 	dev->eps[i].disabling = false;
 
-- 
2.26.2.645.ge9eca65c58-goog

