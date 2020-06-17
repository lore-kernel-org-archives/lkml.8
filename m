Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD904C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E87A208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5J2jPv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgFQCwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 22:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgFQCwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 22:52:30 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2052C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 19:52:30 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id b5so541013pgm.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 19:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=JKan5hWVyx9npp6/yhxgLJA7QZFKpXwZ3cmeNfakJnw=;
        b=n5J2jPv0QjR1DpKaibcKwRPYDoW3EUtqnpKVwjFeU46sdq31Q/JU+0aA/HjqUtW1JX
         YMf1t7p7SMI6nYIiThHivqM92nSuLbitsrOi1K5mH+yAwaYgGf4Cer91FIhRJZug7pyi
         HVDzf2nwcqMy3ojGvssk5x8pdQLdyHc8NGaCdWAGflV9qKL1o6RQqR0KRVxFYT2g+g3z
         e/ZNfwzskvY92mgW3FnKGEraUWWJpG5Ef6IQoy4DCw0B5Ir3K5w9e0FrbsLeNs48fSk+
         RIYZWLeQhrAhCzx/HIaQ1k43vzuBrXuX2Z45TE7g4wvtn21yolISdFskOxopBbKO72Br
         DALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=JKan5hWVyx9npp6/yhxgLJA7QZFKpXwZ3cmeNfakJnw=;
        b=DeXmNPI3A9MwmLoyZNNpxivsmXUjMUFL7DHmDXCqGxNFIj5rdbgrnCscklZ/xH34B6
         UY2cjJ4hoVRCcFcJceagP/WR7PmxNQfH5q31CTh8I6y9YAjEIq/Sq8KrYFEuug3lFCgj
         yBUG8Ahu8C1mkOZyblnbqAWuFVF0nJ6FcPRivSM3Niw0dmm/lRnGuHVrtkzu5lMcYkdN
         mvgoWh/Mbb5upTfThgs9ebyiLNZI9xmql6P87G+g3bWC2XiZG4yInEV4uiEoOND7nHHr
         7B5x7y4+YGu1OnxeWWCqSFPSb/ic/A2DCiOnJlluCU5Kf8A+Et5b32LnPU858h2LOJcU
         Hj0w==
X-Gm-Message-State: AOAM533ycKIaSOGpZdJ+7tTc4j3xtlbdIpk1EBrgKeVUGukoridzrMlB
        507+7JacY6m69UZnoEKJmeo=
X-Google-Smtp-Source: ABdhPJwzxOYzToYoIj3XGjY8EqSVWtlMEr+xu4rePHVTiHAHMpTPcfxbw16yW8W/jaJOWaTXdRl5YA==
X-Received: by 2002:a05:6a00:801:: with SMTP id m1mr4894316pfk.200.1592362350235;
        Tue, 16 Jun 2020 19:52:30 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.213.184])
        by smtp.gmail.com with ESMTPSA id y10sm15822181pgi.54.2020.06.16.19.52.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 19:52:29 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     jgg@ziepe.ca, dan.j.williams@intel.com, gregkh@linuxfoundation.org,
        arnd@arndb.de, mchehab+samsung@kernel.org,
        akpm@linux-foundation.org
Cc:     dan.carpenter@oracle.com, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2] drivers/virt/fsl_hypervisor: Correcting error handling path
Date:   Wed, 17 Jun 2020 08:30:39 +0530
Message-Id: <1592362839-4050-1-git-send-email-jrdr.linux@gmail.com>
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

