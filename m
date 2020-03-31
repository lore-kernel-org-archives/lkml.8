Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91120C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 02:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6034920732
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 02:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtaY57UN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgCaCRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 22:17:44 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43978 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729239AbgCaCRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 22:17:43 -0400
Received: by mail-pg1-f195.google.com with SMTP id g20so161573pgk.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 19:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AZ668oVqEFRu4Fk1JpLECbYmbDQ0SxQ3edw/nd3Wu+g=;
        b=FtaY57UNUpqbeniH+KDHAxFYnGuB4A2Bywh3P7VYBRJELFGKmxWzyhKAf7UgG4E1FF
         vP/M7n/qBfL7v96lqFcEET8HVTCvlft9vfFfaJCv+zTaNdBfJBRX7y48Jn7CSuB+KAKq
         p02drUOZG0z8OC5RcHVvnwIJrv1MfZNE+1h9NBS+2Z7EiMLV4IIrUvjpdcLpzZWt0Gob
         ylunaJ9xsisL5zA28hsHpHrcJwMmpbroF11TkXQSEApTxOBN1x5TWa0abp2nwS9cbdOQ
         2xpoxGAsPUPWv2PEwyil3UU1jbZceLCfd3HbgNwSjs55374McwoLk7CjgsO8oJhcD3Ca
         ZFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AZ668oVqEFRu4Fk1JpLECbYmbDQ0SxQ3edw/nd3Wu+g=;
        b=Qx5IdxJv/9sFOeveT2cxq793FfBEXBSdhsoF8GOO1507nxDgcxIkEvIsn3HHUAB3ac
         BpErU06dTGpqlfB1tG9xhoEf62KrjY5cArXnuO2Djij5cTyJDsMBJ2mTXs/FR+nC+ZZJ
         jS3MZ3XtAGIraWTZcLn8xrOlYwfMLg+0G6Qm5DCrPCugE8JCqpR7H7VeMkl3EGABLCj0
         B0oZ+VXSiXsFNsfctuPaT5V8gH9Smfu+kxRNLXI2JPfjos4nbICojYdi+INXWDJQaCib
         BkAtunI0ZVkYRIi9y7DN6HeG35h6Mhnsi8G/JFPFeATT2SGh/lHbZGCrrAU0KerSmHdG
         +9sw==
X-Gm-Message-State: AGi0Puas3O7jadLH2SwXcLLnb4fJ5QZ9kwXZcVb0Cj41/kISHce6Xz2o
        xWf82ao18GJ+FVymwps6a0w=
X-Google-Smtp-Source: APiQypKmIiIqiveId8iQcajfYjUw2rMhUF2Y6ltDELRjTQYJulpXfFyNyOrNo+BLv+4pp4p2IjEcRw==
X-Received: by 2002:a63:5e44:: with SMTP id s65mr2094326pgb.112.1585621062431;
        Mon, 30 Mar 2020 19:17:42 -0700 (PDT)
Received: from localhost.net ([131.107.160.147])
        by smtp.googlemail.com with ESMTPSA id m68sm1616602pjb.0.2020.03.30.19.17.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 19:17:42 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, michael.h.kelley@microsoft.com, wei.liu@kernel.org
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V2] x86/Hyper-V: don't allocate clockevent device when synthetic timer is unavailable
Date:   Mon, 30 Mar 2020 19:17:38 -0700
Message-Id: <20200331021738.2572-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Current code initializes clock event data structure for syn timer
even when it's unavailable. Fix it.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v1:
	Update title and commit log. 

 drivers/hv/hv.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 632d25674e7f..2e893768fc76 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -212,13 +212,16 @@ int hv_synic_alloc(void)
 		tasklet_init(&hv_cpu->msg_dpc,
 			     vmbus_on_msg_dpc, (unsigned long) hv_cpu);
 
-		hv_cpu->clk_evt = kzalloc(sizeof(struct clock_event_device),
-					  GFP_KERNEL);
-		if (hv_cpu->clk_evt == NULL) {
-			pr_err("Unable to allocate clock event device\n");
-			goto err;
+		if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
+			hv_cpu->clk_evt =
+				kzalloc(sizeof(struct clock_event_device),
+						  GFP_KERNEL);
+			if (hv_cpu->clk_evt == NULL) {
+				pr_err("Unable to allocate clock event device\n");
+				goto err;
+			}
+			hv_init_clockevent_device(hv_cpu->clk_evt, cpu);
 		}
-		hv_init_clockevent_device(hv_cpu->clk_evt, cpu);
 
 		hv_cpu->synic_message_page =
 			(void *)get_zeroed_page(GFP_ATOMIC);
-- 
2.14.5

