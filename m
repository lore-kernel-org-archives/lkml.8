Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC83C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78EE52073B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Qar0iZGn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407327AbgE1Ufn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:35:43 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:53726 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407308AbgE1Ufe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:35:34 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 49Xzwj6wHTz9vYf4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:35:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZElmSatlFNVn for <linux-kernel@vger.kernel.org>;
        Thu, 28 May 2020 15:35:33 -0500 (CDT)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 49Xzwj5KpQz9vYdZ
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:35:33 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 49Xzwj5KpQz9vYdZ
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 49Xzwj5KpQz9vYdZ
Received: by mail-il1-f198.google.com with SMTP id b8so325647ilr.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mqu7gI4QVys8rtXwsMUtQ4ipaqsDcZVMy4ODpZfEEB4=;
        b=Qar0iZGnZTOmqVYbtvV6Bqi3LAkl3rpcSO2bfkQuHgwL1hZF0//9lMQMlMJTwceFvL
         XSq/fO0OV0Wfc/J7UGGZDZgR9ltgK2yz81m68ZYAxqQJSGhEXFR4ATTa4mHldJ2dhBry
         nXiC0IrJzyijGnzaiLgjXlp9aDcEzZCEeuha3bsIpBoLeLWPeayFqFvUryomq9DHPIoR
         EEG2hkh1oTANinUNsd9A8P5MBvJS5svc2vt/zx6hEqC3Nt4hpEHvuSzdIhYGCvk/V/yA
         ElDHwhpT7MLOi6EZ8s/v2P2wfK49Tmk4a+t4Q+iafHlY1rcVa6C1oNrWWUfuQW9dVO7l
         nCJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mqu7gI4QVys8rtXwsMUtQ4ipaqsDcZVMy4ODpZfEEB4=;
        b=ZyLKykSDe2nqLck2oJFELhf2L3huFMwUquWr8LDu4w+ccpzlLfQKrvY9Z+J3kc1mFb
         CIq2FoMcTmcW9+Y8ss85hk5N3HgZzCqcyihKQ3k1IHK7RnnAKzTX3EK0vYpU/OJwgVfK
         7y2YZwKOTByqB3uB0VYA4s8uziabSm1O6mxC+On3JhEA0yLibE3nUVl9Ubv3Lwg2Sdza
         rSKPXibNWa3p7ESj2Eno27Cx0QExUJ0fvTE4ZEtnF15sqDIr0bDTb9y4khVdwr22QahM
         QTjhD6huU0LoYFWhbOrOio59Lxw3GDPg6FEMmC1CyfVX5GEIhkyzBFnz4ojAraMvB4bt
         l5xg==
X-Gm-Message-State: AOAM530Usv1FGu90o6ZPSUMu8Ox6wU+ujOcRJSwmGV84NjIKCJSEvCT1
        6mNzmBIyTnvMapAEAuP0zDKb6r8QAEtKzo7oo7hopwrWqfv4kNMmgttPYSqMv9DjMyQcrsr4JuD
        quTgI9XeiYwhJIs+nuRUIWn811JnO
X-Received: by 2002:a92:b0d:: with SMTP id b13mr4533078ilf.225.1590698132456;
        Thu, 28 May 2020 13:35:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVTzTdO4UtcoTiTguZKte9c73KtyMrLZemXQsrQkcm5GCYIsZ7eSH3Lp2M+AWyg8VqZX3J0g==
X-Received: by 2002:a92:b0d:: with SMTP id b13mr4533057ilf.225.1590698132154;
        Thu, 28 May 2020 13:35:32 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id 17sm3671353ill.14.2020.05.28.13.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:35:31 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        Doug Thompson <dougthompson@xmission.com>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] edac: Fix reference count leak in edac_device_register_sysfs_main_kobj.
Date:   Thu, 28 May 2020 15:35:26 -0500
Message-Id: <20200528203526.20908-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() should be handled when it return an error,
because kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object. Previous
commit "b8eb718348b8" fixed a similar problem.

Fixes: b2ed215a3338 ("Kobject: change drivers/edac to use kobject_init_and_add")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/edac/edac_device_sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index 0e7ea3591b78..5e7593753799 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -275,6 +275,7 @@ int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
 
 	/* Error exit stack */
 err_kobj_reg:
+	kobject_put(&edac_dev->kobj);
 	module_put(edac_dev->owner);
 
 err_out:
-- 
2.17.1

