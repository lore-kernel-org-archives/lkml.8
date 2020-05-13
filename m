Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E6EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8417C2054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:53:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KjW4pG1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgEMUxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 16:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgEMUxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 16:53:04 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA12C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 13:53:03 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id o18so1041431qvu.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 13:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=71HdHnmN8TyFcDA++Ka6XFKmm8bF3JudbFVjypVFt6Q=;
        b=KjW4pG1mGXHWCxz4oL4MDmdh7FTqnCOT3X7xYJPzqEI1ekwsbGX2qc1O03PUEjcXtg
         /Zq7qS4u8LjeFDh6Q7oicY8qUr+BYaV3tU0YQoQ8PbAEcr1atGLUbr8ObVGo2Tb//9nn
         CJJrzDE7LLoIWmoWydzDkuaQ75mg4hBYMPETHuX0zyJMvG7iVZ1HLM7znyqb3QwWlDv2
         T2dETCp7V2y+9PQZQssQvllUVfZ4skwVMOx0NYjHt5iD0PFR0mO00KhgrxZopADcAvBe
         UYHVBxefwADmYwlTVYt7KKGi4gmswHY0e73Ie38F5ytWgeOM+zX/WBel0O6ok38XmYj2
         dG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=71HdHnmN8TyFcDA++Ka6XFKmm8bF3JudbFVjypVFt6Q=;
        b=GRSa3XOCWEAFUVTwqmbjrkCv0e3LBVhNFewTTJoGN5FnZh2QQtN/zTaJWaPnc3q/9u
         zMGcr5FmwM8GcyXWJEyl1psNcod9djx7LJK0d9ANIM1DwF23lK/lYi3DjLomirZ3Ktk/
         F58zosU6gTOav5On81L1Nz8SwridkkgSHRja0iRfvNTaGWraDcq04iuq3zqKXWpCQjs8
         9v3ThRPWI3sk2HmlkEwJAIx+698rkQIh0n+UWT9LHaAzv62QZ4f4cZiFZxHUoOolMuym
         Beht4YUoCYE/Y+FfMoFoswaN4pDqWIe947YM+PTDayYOAdJkzoUt2An0ThjUvmSxzDlM
         wnUg==
X-Gm-Message-State: AOAM531S9K74jCy1t/101HKGA3QRkX89YgxMb2Ir4U9+timLvasjZdTy
        1SlFqi4PX9DLRpa2AnyOoiK9gZGZ+RkriI23
X-Google-Smtp-Source: ABdhPJzoDDG++JXRtbGjq1lH9KoGeACWGJXeEOGFxCZtoPl/Q6gZL/DDE97zTZTzO7SOZf0WX9coyDOfDbiHw8LX
X-Received: by 2002:ad4:4a8b:: with SMTP id h11mr1582071qvx.232.1589403182626;
 Wed, 13 May 2020 13:53:02 -0700 (PDT)
Date:   Wed, 13 May 2020 22:52:56 +0200
Message-Id: <e2638d6e4d38f97b46bee58b2c79a93b29b5718c.1589403150.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH] USB: dummy-hcd: use configurable endpoint naming scheme
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@gmail.com>

USB gadget subsystem uses the following naming convention for UDC
endpoints:

- "ep-a" names for fully configurable endpoints (address, direction and
  transfer type can be changed);

- "ep1in", "ep12out-bulk" names for fixed function endpoints (fixed
  address, direction and/or transfer type).

Dummy UDC endpoints are capable of full configuration, but named using
the second scheme.

This patch changes the names of generic Dummy UDC endpoints to "ep-aout",
"ep-bin", etc., to advertise that they have configurable addresses and
transfer types (except that Dummy UDC doesn't support ISO transfers), but
fixed direction.

This is required for Raw Gadget (and perhaps for some other drivers),
that reasons about whether an endpoint has configurable address based
on its name.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index 6e3e3ebf715f..7402ef0d66d2 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -187,31 +187,31 @@ static const struct {
 		USB_EP_CAPS(USB_EP_CAPS_TYPE_BULK, USB_EP_CAPS_DIR_IN)),
 
 	/* and now some generic EPs so we have enough in multi config */
-	EP_INFO("ep3out",
+	EP_INFO("ep-aout",
 		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_OUT)),
-	EP_INFO("ep4in",
+	EP_INFO("ep-bin",
 		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_IN)),
-	EP_INFO("ep5out",
+	EP_INFO("ep-cout",
 		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_OUT)),
-	EP_INFO("ep6out",
+	EP_INFO("ep-dout",
 		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_OUT)),
-	EP_INFO("ep7in",
+	EP_INFO("ep-ein",
 		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_IN)),
-	EP_INFO("ep8out",
+	EP_INFO("ep-fout",
 		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_OUT)),
-	EP_INFO("ep9in",
+	EP_INFO("ep-gin",
 		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_IN)),
-	EP_INFO("ep10out",
+	EP_INFO("ep-hout",
 		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_OUT)),
-	EP_INFO("ep11out",
+	EP_INFO("ep-iout",
 		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_OUT)),
-	EP_INFO("ep12in",
+	EP_INFO("ep-jin",
 		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_IN)),
-	EP_INFO("ep13out",
+	EP_INFO("ep-kout",
 		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_OUT)),
-	EP_INFO("ep14in",
+	EP_INFO("ep-lin",
 		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_IN)),
-	EP_INFO("ep15out",
+	EP_INFO("ep-mout",
 		USB_EP_CAPS(TYPE_BULK_OR_INT, USB_EP_CAPS_DIR_OUT)),
 
 #undef EP_INFO
-- 
2.26.2.645.ge9eca65c58-goog

