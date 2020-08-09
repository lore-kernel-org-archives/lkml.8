Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E445C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 11:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE1EC206B5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 11:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUtJTkev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgHILxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 07:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgHILxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 07:53:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4737BC061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 04:53:45 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c15so5626656wrs.11
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 04:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=prpbN7AUllGku+IK/2xkTNMvzdVmo18cz79umi2Yw0I=;
        b=dUtJTkevAESQ2alEwytJ0lsDaE8Pr4OiNApy89tVcLYl7kEl0FcSCXw2xbBIjXPnGE
         fFEtjqNCWGT48es51bh9k4dHwZ48KHEzj7Ee/XC5a5Fyogd+tKl3qPmK62QOd6PjxTly
         KUHCZhZuAENL20Nb2PmHXlhaB1SbBLd/DeU/PQdnanU0gmd14IV9/evVE2w+Bud/1ruC
         AD2Mc9VLXpI/W046Uduf1E6bbxXa2wFEH5ZR1ZOoCsJWRy4snYn2AfjNbq9ON1WMJ5hi
         nvXCwN5Atpg2nmiA/f/0tKZc1+Lppu5ZM9ZOofDj2JVx4PQYeKa+nGaXeJkOb1B/PU9N
         mniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=prpbN7AUllGku+IK/2xkTNMvzdVmo18cz79umi2Yw0I=;
        b=e/BkhcAsHl99Cjx/xYqmhB7YnY8xtdTAyg1JQYiOt9VGDrWzuxPpAo7+/JdhjSYuYw
         thweyvALufTqnvb6iDNkIWRkoAi+8vX4ekGVxYbURKkayrrYDszBub6va53MQWi9G37o
         vtOGCZrGl1ytX2XxTaFfs46u6rEf+SW4xu4UB9NhF77rRwe1zaBeQMq1y8OUlC+y+HHg
         VqoUVTasTEA1P2eFemWNMFL/aSWBEX/fKgb4asygsEmr9DMEKElCUTbgeMRUto+Fmm/y
         3ReN58aOUdsUKAXGHb9vgLDhFr+jall/xAlZ3wRhELBL86R1qYGVCNWG0oJI+4AS7dTx
         eFJw==
X-Gm-Message-State: AOAM533v9GvtZUVnIbK1ttb8Mc8Sq4wjVy2ooe5y0kriOLrGnptlEL+B
        XnpYnLaBRkx3JJ1uYZ95D99ZyoQO
X-Google-Smtp-Source: ABdhPJwY+yTrmU2bHmVVV2xhHq3sSr8bh7kRH87kqIWkh5U+PUBlGlC3WJ0FiRIOPdK2TbwaVr6plA==
X-Received: by 2002:a05:6000:150:: with SMTP id r16mr19742823wrx.63.1596974021448;
        Sun, 09 Aug 2020 04:53:41 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id f12sm17376932wmc.46.2020.08.09.04.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 04:53:40 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/4] habanalabs: verify user input in cs_ioctl_signal_wait
Date:   Sun,  9 Aug 2020 14:53:34 +0300
Message-Id: <20200809115337.23402-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

User input must be validated before using it to
access internal structures.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/command_submission.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
index b9840e368eb5..2e3fcbc794db 100644
--- a/drivers/misc/habanalabs/common/command_submission.c
+++ b/drivers/misc/habanalabs/common/command_submission.c
@@ -808,6 +808,14 @@ static int cs_ioctl_signal_wait(struct hl_fpriv *hpriv, enum hl_cs_type cs_type,
 
 	/* currently it is guaranteed to have only one chunk */
 	chunk = &cs_chunk_array[0];
+
+	if (chunk->queue_index >= hdev->asic_prop.max_queues) {
+		dev_err(hdev->dev, "Queue index %d is invalid\n",
+			chunk->queue_index);
+		rc = -EINVAL;
+		goto free_cs_chunk_array;
+	}
+
 	q_idx = chunk->queue_index;
 	hw_queue_prop = &hdev->asic_prop.hw_queues_props[q_idx];
 	q_type = hw_queue_prop->type;
-- 
2.17.1

