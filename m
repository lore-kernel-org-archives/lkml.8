Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB23C47259
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7497420721
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 20:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCMMgaph"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbgEEUKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 16:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728356AbgEEUKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 16:10:37 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084C6C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 13:10:37 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z1so1445259pfn.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 13:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Sttwj9+++HR+1VhnJuAjEhjW0sDdTaju3mSXfhlj8P8=;
        b=VCMMgaphbNxg+Q7DTHKjrov27rYBuH37S+xcFFO8LAU821H+q0E3CgvrR8jX/GZFqi
         yi8UE04cq0TB+C6nITXL+cAZoSze6Fp/pFEY3B28eA1o0PnEf4Fv/l2+1vm5hF6SpwPI
         WK8F4I09WT1eXspEyouXUhEIjwVYoU4m8llHLzLS7w+unkeLnPinsMZoXuuBCUhzki/9
         /VZEixiLabs2seul8+P7lZ6bkSHmw8bB/gJZ+MDH96C+hQmGhQgXnGlg+HbFaVq7Woeq
         yf4N3fR/gsspjAN1KFwbCpV5Ebrj8E/DHGT1cy663fNnU57I5bcQbBKfENNciWrQG2VO
         V69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Sttwj9+++HR+1VhnJuAjEhjW0sDdTaju3mSXfhlj8P8=;
        b=cCGwGcnKylkNROCCrxEOKeDVprO+ziLj3fnod7g8bDGdlP/ckOD/+TH8A/NJgagADt
         yd7pQKFuLpXSPyggpvNC8Q+T/gskgViV1e4S+MF+DHeQFkjXZ93YB9YdEP1k1m1kIEIU
         3Au6fw11rM+IUpvUjkyKCCSLZQiS1wxgAZWOD01QVayds0dn/BGTtPBBsuYE/Yvj9qUC
         y+1XLJm5knIRHwO7nGHms0JL4NC4RExei5xGkSezT0ZUqQZSsrpqFUpSuN+YfNxAI0Os
         Q15Snio5oTz7tBSbv+1AUCtSKwnwP0iBNsO1UBi6Y9y0OnRDYzk4T+Ke/yqk3LuWXswx
         fVng==
X-Gm-Message-State: AGi0PubWgVInYlMcKezXWJQ7X4mxXTqcaSLgMDRA41JkoLz6ndFGHw1T
        O6ZWnG373m0qEoDQ2VyKiII=
X-Google-Smtp-Source: APiQypIELrT1XwxWS7ofmHB8LiFrvRIrDLQqgQdrjdL0LO5fwnoP2+7H+Wz46VJ28HkN1P6q2zANIA==
X-Received: by 2002:a65:62ce:: with SMTP id m14mr3961456pgv.29.1588709436534;
        Tue, 05 May 2020 13:10:36 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.167.156.195])
        by smtp.gmail.com with ESMTPSA id v64sm2745288pfb.20.2020.05.05.13.10.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 13:10:35 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org, jgg@ziepe.ca,
        hubcap@omnibond.com, daniel.vetter@ffwll.ch, dvhart@infradead.org,
        sgarzare@redhat.com, tglx@linutronix.de, ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] VMCI: Avoid extra check for access_ok()
Date:   Wed,  6 May 2020 01:48:32 +0530
Message-Id: <1588709912-8065-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_user_pages_fast() is already having a check for the same. This
double check can be removed.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/misc/vmw_vmci/vmci_host.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_host.c b/drivers/misc/vmw_vmci/vmci_host.c
index ce16d6b..2d8328d9 100644
--- a/drivers/misc/vmw_vmci/vmci_host.c
+++ b/drivers/misc/vmw_vmci/vmci_host.c
@@ -233,8 +233,6 @@ static int vmci_host_setup_notify(struct vmci_ctx *context,
 	 * about the size.
 	 */
 	BUILD_BUG_ON(sizeof(bool) != sizeof(u8));
-	if (!access_ok((void __user *)uva, sizeof(u8)))
-		return VMCI_ERROR_GENERIC;
 
 	/*
 	 * Lock physical page backing a given user VA.
-- 
1.9.1

