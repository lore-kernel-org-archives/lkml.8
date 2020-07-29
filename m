Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68938C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 424142075D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 18:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNJ3sx5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgG2Swm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Swl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 14:52:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBBDC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 11:52:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mt12so2346448pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 11:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JKan5hWVyx9npp6/yhxgLJA7QZFKpXwZ3cmeNfakJnw=;
        b=uNJ3sx5oPSmxdVuR4J+Z4O3oRyDH5k1dzSM5TlRIzxR48j05T7oce55cr1GlEotctq
         XsuilZWDDtWwUhObPmA2MdLr6QjkZz+vSx3oG4fVFP8eMR0SgRyyX6LJ+2QhF3hTWlHh
         unukN5f0UmGzImFMhVKs6fU+ul3bPKS+/+lJPXC9Ypwf4X7SXdlArmfJwWZsUmSMyZmn
         fAXrn6Rh20SdlG9rHVDguqgJ3SDm2GRtb5s7THSwsbB0Ce55uOkqjR0z1eGrs9U8MU8D
         /gQCpFMFl2PvUhvwdo2h2+jJ1ACK4+mnVE4f1m+F2OqKnwgpU5dfdpTszUMOhNR0xRcd
         4v9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JKan5hWVyx9npp6/yhxgLJA7QZFKpXwZ3cmeNfakJnw=;
        b=bMhhvcSgRtArSxN6n28grFnoUvtVqnbkNENptlQBD0purydzF2gkuiS5tVrk0g7EPl
         tvdy4lBG6+D4wRPaH9p+ZkRvL3nRmKBvKXQe7o443D+thnvjMW7KHg64/zmj81A6m+6q
         lAtMVhgEN3d/qn9lThXbYXL73xI3sQoodYmMabKPO1jPqAOppis+5KqDZgDT1rfk7O3W
         j1WJ0Q166jokqmEU5ckAOOEPnBOmbQ1aAx2uxvNCEgsl4K6uij1stWgLAtGE2vZ3WkuH
         MTVfu15kVxGmQuHJDKCUcZZKjv2T0zoyIX4coYgbxj8BgvpDqFOqy6Jet661cFfVSFWD
         +7zQ==
X-Gm-Message-State: AOAM533mryXkrP4m4AmiLC3nzvtvxPedPedSgLPjZW9qQ87zpr1B3ZeC
        EsUADrRi8GnffnxLg6nR+vY=
X-Google-Smtp-Source: ABdhPJzz/nH8yWtky4qFCUB7fSvVpdYp4LKXR24ZmuUK7RU0XMJU6h4LNQN7N6xzaNFVMT5CNVg35w==
X-Received: by 2002:a17:90a:71c1:: with SMTP id m1mr3588850pjs.163.1596048760906;
        Wed, 29 Jul 2020 11:52:40 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.179.38.221])
        by smtp.gmail.com with ESMTPSA id v128sm1043784pfc.14.2020.07.29.11.52.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2020 11:52:40 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     jgg@ziepe.ca, dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        mchehab+samsung@kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2] drivers/virt/fsl_hypervisor: Correcting error handling path
Date:   Thu, 30 Jul 2020 00:31:09 +0530
Message-Id: <1596049269-14950-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, when memory allocation for sg_list_unaligned failed, there
is no point of calling put_pages() as we haven't pinned any pages.

Second, if get_user_pages_fast() failed we should unpinned num_pinned
pages, no point of checking till num_pages.

This will address both.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
v2:
	Added review tag.

 drivers/virt/fsl_hypervisor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
index 1b0b11b..ea344d7 100644
--- a/drivers/virt/fsl_hypervisor.c
+++ b/drivers/virt/fsl_hypervisor.c
@@ -157,7 +157,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
 
 	unsigned int i;
 	long ret = 0;
-	int num_pinned; /* return value from get_user_pages() */
+	int num_pinned = 0; /* return value from get_user_pages() */
 	phys_addr_t remote_paddr; /* The next address in the remote buffer */
 	uint32_t count; /* The number of bytes left to copy */
 
@@ -293,7 +293,7 @@ static long ioctl_memcpy(struct fsl_hv_ioctl_memcpy __user *p)
 
 exit:
 	if (pages) {
-		for (i = 0; i < num_pages; i++)
+		for (i = 0; i < num_pinned; i++)
 			if (pages[i])
 				put_page(pages[i]);
 	}
-- 
1.9.1

