Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96380C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6101E24650
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 20:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SC5YoVe0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389794AbgBNUuD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 15:50:03 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34634 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388699AbgBNUtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:49:00 -0500
Received: by mail-wr1-f67.google.com with SMTP id n10so10520304wrm.1;
        Fri, 14 Feb 2020 12:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uq88D+keDepJKIVvbuTX4kSPlYqyVksIjrRrdshhUkQ=;
        b=SC5YoVe0T6iEmlpUW2GNg+FU5MewjAO9K9DVXhNovNA1UE14pSF5Mju1ZUCYcAmgxH
         Rg0mfp45vFlDsRCSxptWrd69XH+g0dOIrh4i5qvfzFJR/rIjF9YcJC0iTosn4qanSXke
         VDjCCyKoafpv0gbp9p3d+Csvsm40yvNaY5Q+rlKIMeUkh7DGZB6tvoudWWRIVjZcJemu
         r5NwEu6s7bLSSEErfmX++Bho1Pn7GCZ+xRnz+bdwcCHAu2J5ALTpzAkySLFS+7J8PggB
         /G5NcFsQ98Cd9xaVeRbgJAbo8L0yJ0JdULmvqetFUQvmR0pxzZTZ/frpi43w9X/2bA5F
         H9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uq88D+keDepJKIVvbuTX4kSPlYqyVksIjrRrdshhUkQ=;
        b=WkCaJRJznMw8p1picXzE1j5l8lhX5RFRQTtWIbmGbp0VKndzbj/T7qsiDmWfePtYSq
         8u221mZt7opqcK9uyjXcQB+j1mBOihJ5lLsxzLa0RT7iGlahMZLfsfaqcvEu/0kf77rp
         kgcelfS5CwiwKopiidKof8dy0nJBM+Vfwe0yroFELz98W+doBpQFg6iDP+XSNnPKOUA4
         H6ut8AF4NTIVUpo/4qu2z91JZM7gC2egFdEjpDDzX42P2d0ptv5Ud9CjZLKvlidPJdtW
         AqiM9HHRTI8k4zX0LPaMlrhJ5sxNWuaoot04p7jn+2nDBUSsReCcZ38R2nzvbu7A1ZFI
         CJcA==
X-Gm-Message-State: APjAAAUdfvm9GYiTDADZzh5iomuRxP35zl2NnXz7BDtfMYZN7TjNod9R
        +39J4r3BCDo86PgdziGie5PIec0bT6yJ
X-Google-Smtp-Source: APXvYqz3rzXcFi+wZpoc+zuWUIN+d3hJ9stDpMvLVoqDfrNAWFd4tWW+KsDPzBMYQ4qYjr1DjypQaw==
X-Received: by 2002:a5d:4c88:: with SMTP id z8mr5766819wrs.395.1581713338222;
        Fri, 14 Feb 2020 12:48:58 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id y12sm8660782wmj.6.2020.02.14.12.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 12:48:57 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org (open list:USB XHCI DRIVER)
Subject: [PATCH 22/30] xhci: Add missing annotation for xhci_set_port_power()
Date:   Fri, 14 Feb 2020 20:47:33 +0000
Message-Id: <20200214204741.94112-23-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200214204741.94112-1-jbi.octave@gmail.com>
References: <0/30>
 <20200214204741.94112-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports a warning at xhci_set_port_power()

warning: context imbalance in xhci_set_port_power - unexpected unlock

The root cause is the missing annotation at xhci_set_port_power()
Add the missing __must_hold(&xhci->lock) annotattion

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/usb/host/xhci-hub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index 7a3a29e5e9d2..57e3f2c5475a 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -558,6 +558,7 @@ struct xhci_hub *xhci_get_rhub(struct usb_hcd *hcd)
  */
 static void xhci_set_port_power(struct xhci_hcd *xhci, struct usb_hcd *hcd,
 				u16 index, bool on, unsigned long *flags)
+	__must_hold(&xhci->lock)
 {
 	struct xhci_hub *rhub;
 	struct xhci_port *port;
-- 
2.24.1

