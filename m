Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA89C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C6FC207D5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 18:46:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="umDxVyYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgFBSqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 14:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBSqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 14:46:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52EEBC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 11:46:32 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a127so3467317pfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 11:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KjGFYyFxgPYs05yaRJGkiTGGqOdTYKxkxLdoLAX2dfc=;
        b=umDxVyYdwoQVgslyAnCov/qRec06itnasXt33K/1Tx+Q8ZmZvHyxMaMvFdd28DbusM
         00OSH9nQ3R40zOLyUUXqK4jyjOKSjW5IZxLS+ityplv0VxKv8HxdfUDHTVT7PQKaoSeB
         CIRzOgqkQJ56y9F5GjagLKE5/3qqD8eGm3UZA6j2Ujd5zNrI2Q8Qat3qcFHeqOL3uKbo
         LaQsDdUIxL9GPZoHUNdLRXS1BBeitjt7kbbmGf2Al1kpzpNbAUm3iZg1x6oA7jGpcBh+
         hrI64AI9nCHF3YvHI0J1geuB6VLPTt20Gw0XZYK0+rAKn2jSk24PzrIGOl4HCvLJQKn3
         ZT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KjGFYyFxgPYs05yaRJGkiTGGqOdTYKxkxLdoLAX2dfc=;
        b=HzKfuaJ2pAD17h20swF+irmOVOSfQcxytVUEf0jfiD8OdgwdfG3RegAZZRIZbDVdgR
         C7qsJAn5HOp0XmTGkQyyWi+glJ4nVbD+ps9Nv0x3vaEB54e6RipQLE9XMdprMtdHpbQW
         /VgfZhYid5lFtZehp4wZVNPsqJF6NWVfYz9JEILKjkmqxGGmvAZyLeNTWYCsOILUTK/h
         pvQonhCx2y5zFz70CiU8WazdDoAPIYAxnehKvFS0EVFDncoLdnrwMY9YaWETBdVaaLV0
         K+kdKUoc/A+YZ+lfBAZ3sWUjOCgG7jhF++qMMYizxbTLUSDeW19AdDfHC5AAk1+NqaGy
         bvAA==
X-Gm-Message-State: AOAM531R8/DZSMsRILU8K2SxBBM/YMqDWBHyZ3OGDuBuC2Ix40rORBpZ
        3l2VzBwcPZS69bdfT3SYSSo=
X-Google-Smtp-Source: ABdhPJzXP7o7aqixQ14sESQ0eCXX2+MysWeKa5rOX2JW53KzJBa/ov2sDcBhfSB4Q3HNGTYycAWfDQ==
X-Received: by 2002:aa7:9910:: with SMTP id z16mr3427117pff.53.1591123591678;
        Tue, 02 Jun 2020 11:46:31 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.172.1])
        by smtp.gmail.com with ESMTPSA id o21sm3056833pfp.12.2020.06.02.11.46.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jun 2020 11:46:30 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     gregkh@linuxfoundation.org, jamal.k.shareef@gmail.com,
        dan.carpenter@oracle.com, marcgonzalez@google.com,
        hariprasad.kelam@gmail.com, tasman@leaflabs.com,
        nachukannan@gmail.com
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] staging: vc04_services: Convert get_user_pages*() --> pin_user_pages*()
Date:   Wed,  3 Jun 2020 00:24:17 +0530
Message-Id: <1591124057-27696-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In 2019, we introduced pin_user_pages*() and now we are converting
get_user_pages*() to the new API as appropriate. [1] & [2] could
be referred for more information.

[1] Documentation/core-api/pin_user_pages.rst

[2] "Explicit pinning of user-space pages":
        https://lwn.net/Articles/807108/

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
Hi,

I'm compile tested this, but unable to run-time test, so any testing
help is much appriciated.

 .../vc04_services/interface/vchiq_arm/vchiq_2835_arm.c   | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
index 38a13e4..4616013 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
@@ -287,12 +287,8 @@ int vchiq_dump_platform_state(void *dump_context)
 			     pagelistinfo->num_pages, pagelistinfo->dma_dir);
 	}
 
-	if (pagelistinfo->pages_need_release) {
-		unsigned int i;
-
-		for (i = 0; i < pagelistinfo->num_pages; i++)
-			put_page(pagelistinfo->pages[i]);
-	}
+	if (pagelistinfo->pages_need_release)
+		unpin_user_pages(pagelistinfo->pages, pagelistinfo->num_pages);
 
 	dma_free_coherent(g_dev, pagelistinfo->pagelist_buffer_size,
 			  pagelistinfo->pagelist, pagelistinfo->dma_addr);
@@ -395,7 +391,7 @@ int vchiq_dump_platform_state(void *dump_context)
 		}
 		/* do not try and release vmalloc pages */
 	} else {
-		actual_pages = get_user_pages_fast(
+		actual_pages = pin_user_pages_fast(
 					  (unsigned long)buf & PAGE_MASK,
 					  num_pages,
 					  type == PAGELIST_READ,
@@ -407,10 +403,8 @@ int vchiq_dump_platform_state(void *dump_context)
 				       __func__, actual_pages, num_pages);
 
 			/* This is probably due to the process being killed */
-			while (actual_pages > 0) {
-				actual_pages--;
-				put_page(pages[actual_pages]);
-			}
+			if (actual_pages > 0)
+				unpin_user_pages(pages, actual_pages);
 			cleanup_pagelistinfo(pagelistinfo);
 			return NULL;
 		}
-- 
1.9.1

