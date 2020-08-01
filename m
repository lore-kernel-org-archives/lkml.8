Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0424C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 15:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A30F32076B
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 15:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOPfhxbO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbgHAPWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 11:22:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43637 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725804AbgHAPWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 11:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596295323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Aa47QBUvL1X5/ije6bSZUOh1Pa7QFATyRjxhRckOakw=;
        b=dOPfhxbO1PD51jgIL9vBA+wqrY5KaOJV+KkpUcIopYcPrgMPojIEWhiBH8HfbVrSRMCvYv
        nK0pa+jPvmGxGaPeNaDGK5RIb3Ndm6WAnB2vVzUi6AdkUq+Rh5r0t+gMnhxfTHHnQ5md3c
        0dlmvi1ysXgfxLAkUk3FhBDew6Cdphs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-YHV1N2Z1NfSQZbTBW_7QfQ-1; Sat, 01 Aug 2020 11:22:01 -0400
X-MC-Unique: YHV1N2Z1NfSQZbTBW_7QfQ-1
Received: by mail-qv1-f69.google.com with SMTP id k17so8766573qvj.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 08:22:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Aa47QBUvL1X5/ije6bSZUOh1Pa7QFATyRjxhRckOakw=;
        b=Zn5AZufP3VD+nEiQvcCMnsNstjRsQNEH9y3JoBZx9UkMiOh8Zjp3obJO7bC2aE8JMT
         4LXpUP1NU5e1yDS3xQq9SOLox7Sada4oHNFJev4N2V0UM77/yyP2mrgM7WLNcurQjHcJ
         ehl6itL4I/yF953nJYUKLo2fWjIgbgXVAPCmQM9wctIFcyUL9zKLCKLu4saOSwUGx57D
         qU/ITYXrrCIs3akcP0dOwfzyHnmfJkBdIHJAVbbfzqKk0xFnLmb4YMmVwvPDJAJjg+3R
         +ilYAcVg48s11dloULVOgXmBe8YH/zxJwhMw7PcEio70ZRSGLRYfM9rSADGM5G+SeIA8
         Lx/A==
X-Gm-Message-State: AOAM5312OXRqKolCCdRNSiQShyW2ZH/OsATgdqLCsCUT/OYmLJeGLzo1
        9mr1E7hzVrgD3cZHBS8pQLnSlanJ3Bwgqp0gP3xk0RCrg64hiHC0f1cyNl+Kt+ugaNGNmiMh50N
        pMn805oZWZSuTn/R3g45nyqlJ
X-Received: by 2002:a0c:ea30:: with SMTP id t16mr545402qvp.177.1596295321367;
        Sat, 01 Aug 2020 08:22:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw73AUwUmFTAuZ7DyyAoNHXO6SHKos49TZE5HmQekEo4Df5iKE43aeKLbPbixNrpPZNnAWNCA==
X-Received: by 2002:a0c:ea30:: with SMTP id t16mr545381qvp.177.1596295321117;
        Sat, 01 Aug 2020 08:22:01 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 6sm12135784qkj.134.2020.08.01.08.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 08:22:00 -0700 (PDT)
From:   trix@redhat.com
To:     oneukum@suse.com, gregkh@linuxfoundation.org, t-herzog@gmx.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] cdc-acm: rework notification_buffer resizing
Date:   Sat,  1 Aug 2020 08:21:54 -0700
Message-Id: <20200801152154.20683-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this error

cdc-acm.c:409:3: warning: Use of memory after it is freed
        acm_process_notification(acm, (unsigned char *)dr);

There are three problems, the first one is that dr is not reset

The variable dr is set with

if (acm->nb_index)
	dr = (struct usb_cdc_notification *)acm->notification_buffer;

But if the notification_buffer is too small it is resized with

		if (acm->nb_size) {
			kfree(acm->notification_buffer);
			acm->nb_size = 0;
		}
		alloc_size = roundup_pow_of_two(expected_size);
		/*
		 * kmalloc ensures a valid notification_buffer after a
		 * use of kfree in case the previous allocation was too
		 * small. Final freeing is done on disconnect.
		 */
		acm->notification_buffer =
			kmalloc(alloc_size, GFP_ATOMIC);

dr should point to the new acm->notification_buffer.

The second problem is any data in the notification_buffer is lost
when the pointer is freed.  In the normal case, the current data
is accumulated in the notification_buffer here.

	memcpy(&acm->notification_buffer[acm->nb_index],
	       urb->transfer_buffer, copy_size);

When a resize happens, anything before
notification_buffer[acm->nb_index] is garbage.

The third problem is the acm->nb_index is not reset on a
resizing buffer error.

So switch resizing to using krealloc and reassign dr and
reset nb_index.

Fixes: ea2583529cd1 ("cdc-acm: reassemble fragmented notifications")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/usb/class/cdc-acm.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 991786876dbb..7f6f3ab5b8a6 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -378,21 +378,19 @@ static void acm_ctrl_irq(struct urb *urb)
 	if (current_size < expected_size) {
 		/* notification is transmitted fragmented, reassemble */
 		if (acm->nb_size < expected_size) {
-			if (acm->nb_size) {
-				kfree(acm->notification_buffer);
-				acm->nb_size = 0;
-			}
+			u8 *new_buffer;
 			alloc_size = roundup_pow_of_two(expected_size);
-			/*
-			 * kmalloc ensures a valid notification_buffer after a
-			 * use of kfree in case the previous allocation was too
-			 * small. Final freeing is done on disconnect.
-			 */
-			acm->notification_buffer =
-				kmalloc(alloc_size, GFP_ATOMIC);
-			if (!acm->notification_buffer)
+			/* Final freeing is done on disconnect. */
+			new_buffer = krealloc(acm->notification_buffer,
+					      alloc_size, GFP_ATOMIC);
+			if (!new_buffer) {
+				acm->nb_index = 0;
 				goto exit;
+			}
+
+			acm->notification_buffer = new_buffer;
 			acm->nb_size = alloc_size;
+			dr = (struct usb_cdc_notification *)acm->notification_buffer;
 		}
 
 		copy_size = min(current_size,
-- 
2.18.1

