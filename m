Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D81C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B5BD20578
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:12:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LTXCD78c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbgGHNMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:12:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32727 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729195AbgGHNMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594213972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=dpcN6uhzyYQ/ewztTgf0OWdeJAZ75wA/b6rJJQ+xVDs=;
        b=LTXCD78c8WKfs+M4LqeYYWuXHRgNrp0qfwHxhr3jVpk0DT1mltbpbKj8RW3s314dufbVSX
        Va/IcR31/AtFTEBfNUGcg/ypb9L1h1kgurxUVcjhWOFMGOE3XDWkbo2sN5DJy9DVMy2A4f
        WoFFQcGPqciwYs8X1Ar9tX0jaHGeSyw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-leoqs0txMHCyIAjFmcu1Ag-1; Wed, 08 Jul 2020 09:12:50 -0400
X-MC-Unique: leoqs0txMHCyIAjFmcu1Ag-1
Received: by mail-qk1-f199.google.com with SMTP id i145so12031785qke.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 06:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dpcN6uhzyYQ/ewztTgf0OWdeJAZ75wA/b6rJJQ+xVDs=;
        b=kTsYw5MZHIVtzRhKoXvjO70hZFbJFr1mb3nttRlzFueXEdG3tYgI/ENNe1WZf5Uecz
         6Vzx4TMxmSDkGCRyQHqnED3BUmSuJXisJtMP5LUMO2cPfHucCrkRKgHjc9o8x4YbPJaV
         YgDKOYyfAMHEsgIStpjaLfDCcWEJeVIVfzgE96SPalfZ/twLI86nEg70bPGWzIPL80nA
         XyHC4xPDa6ZHxMcBUKktqodlTzFCgcn0io6k3dQqJHseesTOhxNh1vMu9rFr7211gsYn
         RotvoXSF0lTTe8C2q45B7/u6TmxButgzRpYoskMsS0e4Vqlc+LH3s4XNk/xtZOzEKJ/Z
         ZWHQ==
X-Gm-Message-State: AOAM533ctKaiowdkITZmkYMMBGvaJ4GpbKI28PL7Lu3J7uY/tbOXkfUh
        JSLZ2UeKNWD/LW5XcOxiYLzmvle+O1C1IuTNVNjSaR0nd83qTJ4vbN8w9f68n7DVDz15lH+XuxB
        EARzXmHcVTCFYtL5rCpxNgp8O
X-Received: by 2002:a05:620a:7d6:: with SMTP id 22mr56815624qkb.311.1594213970199;
        Wed, 08 Jul 2020 06:12:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxitu/hHcDwF3flowJxfpEmgEDZRQIJzjglSzVYv/A5vvAMuGPmy88ZU3gyB0peMa9Z/OfSHA==
X-Received: by 2002:a05:620a:7d6:: with SMTP id 22mr56815595qkb.311.1594213969919;
        Wed, 08 Jul 2020 06:12:49 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k6sm21494856qki.123.2020.07.08.06.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 06:12:49 -0700 (PDT)
From:   trix@redhat.com
To:     jacmet@sunsite.dk, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] USB: c67x00: fix use after free in c67x00_giveback_urb
Date:   Wed,  8 Jul 2020 06:12:43 -0700
Message-Id: <20200708131243.24336-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags this error

c67x00-sched.c:489:55: warning: Use of memory after it is freed [unix.Malloc]
        usb_hcd_giveback_urb(c67x00_hcd_to_hcd(c67x00), urb, urbp->status);
                                                             ^~~~~~~~~~~~
Problem happens in this block of code

	c67x00_release_urb(c67x00, urb);
	usb_hcd_unlink_urb_from_ep(c67x00_hcd_to_hcd(c67x00), urb);
	spin_unlock(&c67x00->lock);
	usb_hcd_giveback_urb(c67x00_hcd_to_hcd(c67x00), urb, urbp->status);

In the call to c67x00_release_urb has this freeing of urbp

	urbp = urb->hcpriv;
	urb->hcpriv = NULL;
	list_del(&urbp->hep_node);
	kfree(urbp);

And so urbp is freed before usb_hcd_giveback_urb uses it as its 3rd
parameter.

Since all is required is the status, pass the status directly as is
done in c64x00_urb_dequeue

Fixes: e9b29ffc519b ("USB: add Cypress c67x00 OTG controller HCD driver")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/usb/c67x00/c67x00-sched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/c67x00/c67x00-sched.c b/drivers/usb/c67x00/c67x00-sched.c
index ef1e4ecaee99..f7f6229082ca 100644
--- a/drivers/usb/c67x00/c67x00-sched.c
+++ b/drivers/usb/c67x00/c67x00-sched.c
@@ -486,7 +486,7 @@ c67x00_giveback_urb(struct c67x00_hcd *c67x00, struct urb *urb, int status)
 	c67x00_release_urb(c67x00, urb);
 	usb_hcd_unlink_urb_from_ep(c67x00_hcd_to_hcd(c67x00), urb);
 	spin_unlock(&c67x00->lock);
-	usb_hcd_giveback_urb(c67x00_hcd_to_hcd(c67x00), urb, urbp->status);
+	usb_hcd_giveback_urb(c67x00_hcd_to_hcd(c67x00), urb, status);
 	spin_lock(&c67x00->lock);
 }
 
-- 
2.18.1

