Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DB3C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 18:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23C8620714
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 18:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXe8ONkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgH3ShB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 14:37:01 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31315 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726155AbgH3Sg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 14:36:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598812616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=QozYeGLLb3VY909mnDA2JjEU+D2LsIUp8jIV0Jpgmp4=;
        b=XXe8ONkAOIOg48XgLbK5kVSJL4L1HGy63VAqzpewlKUEeZZcOl8S7OKa+XgxzXuI/It+Ta
        oeNNkJ2d+yd+RKfS2cFbIy4P0RsI08MVsHlXS0eoqiByT9dLC4S+nV0eCdaPy4B1n/uUEH
        YDS2G2RzR17t8uwpM8qyYc1TVbFmxPY=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-P7ZniasyOW6L0w4wh2Pl1g-1; Sun, 30 Aug 2020 14:36:53 -0400
X-MC-Unique: P7ZniasyOW6L0w4wh2Pl1g-1
Received: by mail-il1-f200.google.com with SMTP id a15so2335695ilb.22
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 11:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QozYeGLLb3VY909mnDA2JjEU+D2LsIUp8jIV0Jpgmp4=;
        b=EEf6JH44fWpnUveYg6hIBspeIShBhvHZcBazAXqLnNri6hl1kw2tVmrn3Zkdl7whpb
         EFhk8s6UEyrYNdypXbKdROkjdkxM7z7DHuwKy2r/t45TowrNK3G9TD5Ihg77fc2BicBB
         iD9Iqj3f0mfzolf5vTnkSe7hY5AihUJiWdRGtOoe5wL2bEjjbYBgAcAt3gp+Cf81RHG+
         9aHxXH39FKB9UCsiv1lXWSYC+BIm2igaL+RGt60vftC9V+yhUPvbQZuMvDYfBwfcAQUK
         wYqTj72ynHwWeP9fFmaHEjBq6uPkRhRy42Yda7NAMkC1QHRwUOwakUv/pggMXpV4v+OT
         Xdxw==
X-Gm-Message-State: AOAM533o/KNCVgCT8fxDKRDIxo2SJTZdU3yKui7i+0Ev7iFmgaxQxFNu
        37NiPpNwnW8FHZonCngA9XIZwcrxsZV1THZflTJs9NtUpUqrRMcfvJYWMRfAcAygSqT2SWOb3sz
        CDQkqDHCL44beDgQcTFo0aPM2
X-Received: by 2002:a92:c904:: with SMTP id t4mr6323566ilp.257.1598812612571;
        Sun, 30 Aug 2020 11:36:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJws0aS2JRLx2nRnOEJQonJ8J7aNV73fnvMcA6Cq8vQw0/+MPUr+w4mfxekC3wDSgZkuIXIHRg==
X-Received: by 2002:a92:c904:: with SMTP id t4mr6323556ilp.257.1598812612345;
        Sun, 30 Aug 2020 11:36:52 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x185sm2883927iof.41.2020.08.30.11.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 11:36:51 -0700 (PDT)
From:   trix@redhat.com
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        natechancellor@gmail.com, ndesaulniers@google.com,
        christophe.jaillet@wanadoo.fr, peter.chen@nxp.com, b-liu@ti.com,
        chunfeng.yun@mediatek.com, novikov@ispras.ru, yanaijie@huawei.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] usb: gadget: net2272: assert for a valid dma request
Date:   Sun, 30 Aug 2020 11:36:46 -0700
Message-Id: <20200830183646.24930-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags this representive problem

net2272.c:1541:8: warning: Dereference of null pointer
    if ((req->req.length % ep->ep.maxpacket != 0) ||
         ^~~~~~~~~~~~~~~
This is mostly not a problem.

In net2272_handle_dma(), even though every path through
the routine dereferences req, it is set to NULL when the
ep->queue is empty.  If the eq->queue was ever empty this
would have oops.

So the else statement should not be needed.  If it is,
flag it as a BUG.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/usb/gadget/udc/net2272.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
index 44d1ea2307bb..8301723a8b1a 100644
--- a/drivers/usb/gadget/udc/net2272.c
+++ b/drivers/usb/gadget/udc/net2272.c
@@ -1506,17 +1506,16 @@ static int net2272_stop(struct usb_gadget *_gadget)
 static void
 net2272_handle_dma(struct net2272_ep *ep)
 {
-	struct net2272_request *req;
+	struct net2272_request *req = NULL;
 	unsigned len;
 	int status;
 
 	if (!list_empty(&ep->queue))
 		req = list_entry(ep->queue.next,
 				struct net2272_request, queue);
-	else
-		req = NULL;
 
 	dev_vdbg(ep->dev->dev, "handle_dma %s req %p\n", ep->ep.name, req);
+	BUG_ON(!req);
 
 	/* Ensure DREQ is de-asserted */
 	net2272_write(ep->dev, DMAREQ,
-- 
2.18.1

