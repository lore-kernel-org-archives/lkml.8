Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56549C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:18:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 332DB20656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKlzs4sb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733305AbgF2USy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388538AbgF2USj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:18:39 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8720EC061755;
        Mon, 29 Jun 2020 13:18:38 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b25so16139293ljp.6;
        Mon, 29 Jun 2020 13:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=8KS8I9Q3x2kXGfX+XyyK1sOmdPbnTRSOpvvTvwkAeTs=;
        b=kKlzs4sb6gvS9zYIlKdtNO9qZQptM0LCZ/5tTmz0g8zeAuvX6L7DG9YSQv5O6J8o0t
         +CfV51o+Z9H4vt+N0eAH1ce3eZwBa+rTl+XL8Hf1acezphKbNdejOR7/uTqpvIv9SfQA
         2KWUGHa9aRo43YP5EqG7Hx9mGJwieKRlykPLqMKejsyZIky6Rpy0C0LZHNa3HINiVxpa
         MEuoN5HtplNVLYZFprLtWZFMPJ3H2GbFy+unFlOKGfRMW6Tbn6F2doUdsuu+6jTP+uWQ
         nvvaoXQQPTxy7YodFAQgWWGj5w3UiZCX3Y67jQeJz9wcdsDAK+XaohzCuEGB9fN7piJ+
         ahYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8KS8I9Q3x2kXGfX+XyyK1sOmdPbnTRSOpvvTvwkAeTs=;
        b=KsE/W+rfDYRWXsZsV0vEPeO4m2I8BnQfISLxWwOGtmoFlB9ZXp3T7ukjSXuPLDlj7/
         Lf4xy7+4cL01mKYGweluUT0/2ONBfOzLFso/UimyzlhQCa1Z/jjKXTtEKxrrYW9V9f/K
         1JJYYrPeAGlqEyVGgHYMFuHWRXfgIJUeqz+tVMOQrhpWgdjrfEjXZwSswOWuQrJ7uedy
         lfl4PBR7oCb90Q4khyrBbGkvpMaT8fWyUfoP68v02RraaIfdpNOtc5DbiReY8mw3+fao
         8ncno4+QxpzC6L6c9eBVxjtykwjCKunDZ2AMqFoD/z6twJA89jhbTuLkt+iGT4iVVS6a
         oEIg==
X-Gm-Message-State: AOAM531wiCNvQQWz9dUIZ6HnAPli7IyRKMfwpbbDRPVNhcEX/U3YUmyN
        P5Dk4rTmfYYNPpvTM4KSaqk=
X-Google-Smtp-Source: ABdhPJxxtuESaMskdjQR3zZ4lP77PTmYj17q1RARRdk3vtTHJODW8Xdzzd0fpl4TxUPk/wOQ6/FF6w==
X-Received: by 2002:a2e:b88e:: with SMTP id r14mr8307120ljp.197.1593461917004;
        Mon, 29 Jun 2020 13:18:37 -0700 (PDT)
Received: from localhost ([80.64.86.170])
        by smtp.gmail.com with ESMTPSA id x64sm154660lff.14.2020.06.29.13.18.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jun 2020 13:18:36 -0700 (PDT)
From:   Ruslan Bilovol <ruslan.bilovol@gmail.com>
To:     balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: gadget: epautoconf: claim smallest endpoints first
Date:   Mon, 29 Jun 2020 23:18:45 +0300
Message-Id: <20200629201845.28138-1-ruslan.bilovol@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UDC hardware may have endpoints with different maxpacket
size. Current endpoint matching code takes first matching
endpoint from the list.

It's always possible that gadget allocates endpoints for
small transfers (maxpacket size) first, then larger ones.
That works fine if all matching UDC endpoints have same
maxpacket size or are big enough to serve that allocation.

However, some UDCs have first endpoints in the list with
bigger maxpacket size, whereas last endpoints are much
smaller. In this case endpoint allocation will fail for
the gadget (which allocates smaller endpoints first) on
final endpoint allocations.

To make endpoint allocation fair, pick up smallest
matching endpoints first, leaving bigger ones for
heavier applications.

Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
---

v2: rebased onto latest balbi/next branch

 drivers/usb/gadget/epautoconf.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
index 1eb4fa2e623f..6c453b5d87bb 100644
--- a/drivers/usb/gadget/epautoconf.c
+++ b/drivers/usb/gadget/epautoconf.c
@@ -66,7 +66,7 @@ struct usb_ep *usb_ep_autoconfig_ss(
 	struct usb_ss_ep_comp_descriptor *ep_comp
 )
 {
-	struct usb_ep	*ep;
+	struct usb_ep	*ep, *ep_min = NULL;
 
 	if (gadget->ops->match_ep) {
 		ep = gadget->ops->match_ep(gadget, desc, ep_comp);
@@ -74,14 +74,27 @@ struct usb_ep *usb_ep_autoconfig_ss(
 			goto found_ep;
 	}
 
-	/* Second, look at endpoints until an unclaimed one looks usable */
+	/*
+	 * Second, look at endpoints until an unclaimed one looks usable.
+	 * Try to find one with smallest maxpacket limit, leaving larger
+	 * endpoints for heavier applications
+	 */
 	list_for_each_entry (ep, &gadget->ep_list, ep_list) {
-		if (usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
-			goto found_ep;
+		if (usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp)) {
+			if (desc->wMaxPacketSize == 0)
+				goto found_ep;
+			else if (!ep_min)
+				ep_min = ep;
+			else if (ep->maxpacket_limit < ep_min->maxpacket_limit)
+				ep_min = ep;
+		}
 	}
 
 	/* Fail */
-	return NULL;
+	if (!ep_min)
+		return NULL;
+
+	ep = ep_min;
 found_ep:
 
 	/*
-- 
2.17.1

