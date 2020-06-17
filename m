Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B571C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 485472085B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BH3W9Rvs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgFQCTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 22:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgFQCTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 22:19:42 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A506C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 19:19:41 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y18so236466plr.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 19:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=axDMTPhYiD/Km+IVh4JuAqAJaHHRrVK+kCUNoDRVkdg=;
        b=BH3W9Rvs8Dc8HKreJFfrADu/RgfYcpyxxj9qaBcIdNA/JmLD58BMdZg867nSZ3ezA1
         OcFY1FsfXwQJNolEWDL7pt+ALNdHYGe/0vRd7VsAb5JVVxTuxNg/UW5EMQpKRFDlAShs
         yLBJnGSsQTWqPCdZhXr3ROLP2upT3q5Obn/50IWtzZqyfmBWXolC4WV753kxeg+SUTn3
         Zp0QHaeqW7wIcYykTBkOBksnfFByV01U2ngOD/yD8RPfxna66ZzWtpp7+DRMvJSGH/Yc
         0otSL1t9kWbLt/lRAFRRAoehETgx1jbQPYhqYjbfskP316uqP+X/jW1sr42Wtr93Xuc4
         v2rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=axDMTPhYiD/Km+IVh4JuAqAJaHHRrVK+kCUNoDRVkdg=;
        b=a1l895qV9QzsypGEpo0/qeF4sXnrDNHItxwd2VGIA2bz8zlL576iN+D8teybXZwF4M
         6Nlmyp9JeomJCoCx8LGQh/d4dAnmPdpFSq2T18MR5m7xJ+Nt5pW00vr6XhPthqA2gykx
         aE757OVI9v8sM5Ihx0iwIzhtTb1bhiu1RMIZHD7Fra4KuNmEidiNX+g2vnEUBBk+dYLC
         3YmkSVeGK9A9St/oQ1ulxN5Ydq/duAy8Wiuy9jMrDbWiwNkSHLusOO0XqUe+r4CoAcaH
         DS4gNy5by7CxE14baimuJO+fqlAWK6k1pbAz/DUlOlathEKQwuEM3to/PNV9NT5s3u1v
         Jwfw==
X-Gm-Message-State: AOAM530GUJWHzQH6mRXHDvr155vHrXB9Khp3/0fTaCgYA0aCokwlZl9a
        QHkK4mBAlg1quBwFRjty8po=
X-Google-Smtp-Source: ABdhPJwANyk83r6EG1MGw311BijTTXggESe0AcQ+zO8izI/aRQP6hz6MrWjIVANJBBTuOZ1YqFUxJw==
X-Received: by 2002:a17:90a:ea18:: with SMTP id w24mr5533713pjy.42.1592360381007;
        Tue, 16 Jun 2020 19:19:41 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.171.213.184])
        by smtp.gmail.com with ESMTPSA id h9sm1203208pfe.32.2020.06.16.19.19.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jun 2020 19:19:40 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     gregkh@linuxfoundation.org, jane.pnx9@gmail.com, pakki001@umn.edu,
        ldufour@linux.ibm.com, harshjain32@gmail.com, simon@nikanor.nu,
        walken@google.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Bharath Vedartham <linux.bhar@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 1/4] staging: kpc2000: Unpin partial pinned pages
Date:   Wed, 17 Jun 2020 07:57:20 +0530
Message-Id: <1592360843-3440-2-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1592360843-3440-1-git-send-email-jrdr.linux@gmail.com>
References: <1592360843-3440-1-git-send-email-jrdr.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a bug, when get_user_pages() failed but partially pinned
pages are not unpinned. Fixed it.

Also, int is more appropriate type for rv. Changed it.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Bharath Vedartham <linux.bhar@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index 8975346..b136353 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -35,7 +35,7 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 			    unsigned long iov_base, size_t iov_len)
 {
 	unsigned int i = 0;
-	long rv = 0;
+	int rv = 0;
 	struct kpc_dma_device *ldev;
 	struct aio_cb_data *acd;
 	DECLARE_COMPLETION_ONSTACK(done);
@@ -193,6 +193,10 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 		put_page(acd->user_pages[i]);
 
  err_get_user_pages:
+	if (rv > 0) {
+		for (i = 0; i < rv; i++)
+			put_pages(acd->user_pages[i])
+	}
 	kfree(acd->user_pages);
  err_alloc_userpages:
 	kfree(acd);
-- 
1.9.1

