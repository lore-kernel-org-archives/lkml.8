Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43123C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6E02073B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qvTHk5sp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgCFQIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:08:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53703 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCFQIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:08:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id g134so3053420wme.3;
        Fri, 06 Mar 2020 08:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1rQw/frsMaF2gnOOhkHrb+4riB7NiM0f9L7AjHG7DPU=;
        b=qvTHk5spZc1f8k9bKjvWAA8YD7FUjnFJRWKDLRSAaYiZKcKM0Wr7mVZAEb++wJ4sHE
         4zCeGexAyVjqyDUnkJeSS5Cm8tXjlQeeYrkZb4pVDMS9Q/bsJR1+ZcYC4t/QNIAVb8g1
         rWbWp96pmCdtRyhh1y1GYqp97MzaqhaQd0R7R5R+aHSd10jestzLb4PsGq4iHmide4s4
         Mn2LsNhiVBlYqNHdTFO6UznSgQg3hogWCfUC00U/iUADRCjghcVKwuZX7QsIPeQz1wZC
         R8HVmJ+ffDNBx5ZAbhcM3nXZS0J9xWPfW8t00b36UwXSy//mRjKD6Ysbu5w1JTO/fdSR
         pN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1rQw/frsMaF2gnOOhkHrb+4riB7NiM0f9L7AjHG7DPU=;
        b=RGTvpR7RxgOGDtw+XzCiiVEnAVDHKyviMJqojgcA1qaHRej7w01gysaJLoiUgZHK1f
         6j1Iyz6C7zsxpPbBRoXNNEcECaDK6JonB0FbfFTwrIem0C6fofdrhL6JOJqWVURPpe3p
         lEcU9X5YHov+8yqIKOvPHscy5t32Pf5NiC4PvaVDKB+aGvGIc+AyW2U3rv6x92uvJkqk
         BGaVYEJ4AASjVdM3HkoLR6xEtQ22wUGyyhibcKU+SEEmPScjr14A3BX8CzNfVEd7IrQ7
         upv5BP81slDEILpCrGJspJItOOD3KB5MsDtU4L85i41Lb9+eXsWnk6223UL53BXGvUtQ
         Xzng==
X-Gm-Message-State: ANhLgQ2j3xhkivWDhOMjGhsnb06ZKiGSf+4PLtobrtXxCT4ffRGjuV+h
        sdI1h9OKcB3kAas9DIqWiPRuGzEz
X-Google-Smtp-Source: ADFU+vv8pIrURBIxmS0ltgeQiAoP8UFEjEZbeudU4SQGtedpFRWTby5elBxa9EDpX8rmNRh7llUv2Q==
X-Received: by 2002:a7b:c8d5:: with SMTP id f21mr4660807wml.60.1583510877374;
        Fri, 06 Mar 2020 08:07:57 -0800 (PST)
Received: from stbsrv-and-01.and.broadcom.net ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id c72sm8218975wme.35.2020.03.06.08.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 08:07:56 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>
Subject: [PATCH] usb: xhci: Error enumerating USB TV Tuner
Date:   Fri,  6 Mar 2020 11:06:59 -0500
Message-Id: <20200306160659.16319-1-alcooperx@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unable to complete the enumeration of a USB TV Tuner device.

Per XHCI spec (4.6.5), the EP state field of the input context shall
be cleared for a set address command. In the special case of an FS
device that has "MaxPacketSize0 = 8", the Linux XHCI driver does
not do this before evaluating the context. With an XHCI controller
that checks the EP state field for parameter context error this
causes a problem in cases such as the device getting reset again
after enumeration.

When that field is cleared, the problem does not occur.

This was found and fixed by Sasi Kumar.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/host/xhci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index dbac0fa9748d..5f034e143082 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1428,6 +1428,7 @@ static int xhci_check_maxpacket(struct xhci_hcd *xhci, unsigned int slot_id,
 				xhci->devs[slot_id]->out_ctx, ep_index);
 
 		ep_ctx = xhci_get_ep_ctx(xhci, command->in_ctx, ep_index);
+		ep_ctx->ep_info &= cpu_to_le32(~EP_STATE_MASK);/* must clear */
 		ep_ctx->ep_info2 &= cpu_to_le32(~MAX_PACKET_MASK);
 		ep_ctx->ep_info2 |= cpu_to_le32(MAX_PACKET(max_packet_size));
 
-- 
2.17.1

