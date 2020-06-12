Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727D1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 06:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3597C207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 06:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/zznz8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgFLG1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 02:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgFLG1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 02:27:50 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9C9C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 23:27:50 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y17so8482707wrn.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 23:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=IzXjmolgMmhJgm8InBBgTqdbG2RMdUsfTt8IzU+viR4=;
        b=J/zznz8jGKXkyOEfZWJKjUE/8BQIzOTBTApQ/OLXvusFSwvpb7cVLDBDqnBY5OUGrn
         ysgHA7h73KTpG9l/F1c/YxfozNx+itckSqjQoAXuzV0df5AfemnFiE3ic/Ajn9nL3hQz
         HWxH/q1P/l6yNjqZXvL7zKhYuCcD1g2zlL8pAAnGcxcjy8GJMEFevZgkgRGHBs3UK/z0
         Lxj9jomx8UVr53jDb/bm5hQA9vmHJLwQKsxG2Srd3vwN8iSd3K4sJnWDrDMXtFMUVhRZ
         WF3aHcFjhleH9S20D0l7igo5Ir0NPv/XX9wMxZJaicl3Z57rFxt/Bgy30srXy2Ih6wRn
         VM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IzXjmolgMmhJgm8InBBgTqdbG2RMdUsfTt8IzU+viR4=;
        b=cxshDNaOmLZYxoKLxVv3OFuR+69TIDd/NkNr8iUYcWED+rUQQQ0LSA9wSoTGZBJPQJ
         TL0IGaKZl+TrsEw7bKgIwYYeNvEDTwHjn6bJYUDA2kzcLBGcQoAbyEivEeMGsFzmhI95
         FaVPMQfHPqySGCTV6ckEy4XK6bKk7MzVqoZg25aWKMyW5Pru54PRSSZOxAa+b2jeGV7S
         6DmXDLe1ltRHWxmE+IMjcLXOKJdsIZH2fG5kdT7YNumL+8a0JO9G7g8WMS5UoMkb7cXD
         VZJM6vygwKneOFkKgU4KEygJ6079AVrs086LxeQFOe7BWAXq0wTnkD7IXHwXFuKBr9dt
         T/Vw==
X-Gm-Message-State: AOAM532Azzj9TRdfPvybdu8e5YQ5kjEA6xPJT0lNdrUJnfIAyOr5f/Mr
        /4KxNEzKelDDvILpswAeH2973yL4
X-Google-Smtp-Source: ABdhPJwcY+in0JYq4WLaZyq0ZV6lDDZRkIuSud+0E0a/+dcXcAORgPefMIvVQnZXXrXWyvN2A78A5w==
X-Received: by 2002:a05:6000:1146:: with SMTP id d6mr13041531wrx.400.1591943268337;
        Thu, 11 Jun 2020 23:27:48 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id s2sm7010560wmh.11.2020.06.11.23.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 23:27:47 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: increase GAUDI QMAN ARB WDT timeout
Date:   Fri, 12 Jun 2020 09:27:44 +0300
Message-Id: <20200612062744.29316-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current timeout is too low for some of the workloads and we see false
errors as a result.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 211547d4f8a7..69317d2ebdfa 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -96,7 +96,7 @@
 
 #define GAUDI_NUM_OF_QM_ARB_ERR_CAUSE	3
 
-#define GAUDI_ARB_WDT_TIMEOUT		0x400000
+#define GAUDI_ARB_WDT_TIMEOUT		0x1000000
 
 static const char gaudi_irq_name[GAUDI_MSI_ENTRIES][GAUDI_MAX_STRING_LEN] = {
 		"gaudi cq 0_0", "gaudi cq 0_1", "gaudi cq 0_2", "gaudi cq 0_3",
-- 
2.17.1

