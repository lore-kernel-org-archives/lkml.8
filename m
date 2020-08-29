Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1013C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 01:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E36E207BB
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 01:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Opj1LNCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgH2BPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 21:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgH2BPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 21:15:03 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3A2C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 18:15:03 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id h10so879537ioq.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 18:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vxf7wgPeqLBabv1qOZthQnmoMUNbcbCMRZRv8B/GiMg=;
        b=Opj1LNCXNlXvkflsoK43cbKot9oqmkOo6+IZa/KEjk365anWH/gs7yT32PBD0YHMdK
         dFd/6mcwA/lVrmjMW2VFdHLxIE7Q3dWeRoK7Uv4sVxGAhrkL5/V4EzdpP0ynKJ0R//f0
         AtiZDc3udTbtviy7PviS9WgvZWBrVljjHZHiAOIMgD4M9xpdKQN6bCm8ibyOLWuIbh5o
         hYt4vq/tXwWuMdz9SV3p4UbY+XUQXiXj6qg8/K7iRfTG/9Xt1PE8Qp/TzuwPOTEqXJdC
         sn3Yd/yYPo7lK8BWa2V1/u+TBrn2BAGX+0FkoR+DW9FXb4NioTcVyI9+wjQGMURxyiBF
         RYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vxf7wgPeqLBabv1qOZthQnmoMUNbcbCMRZRv8B/GiMg=;
        b=WORgTaXbquc2GtjdQvLDqODbRqqSG5HSoJ5qscFTsCr9Y7K5Xfhg6UT4tvpbrZDseX
         JsQLwYbmK37u1+BLduosep2IrgchyP9vQBhKh9+a33cu7htaBus9ESSdpdRjpGA+CZpF
         TXqWV/i5JjLnIEgvnq/gplrEX/CLQsTmjTOEmFqv5sNaQ/3i4g1Mkt0XCrrQjDTzlq7g
         5W8nvzuh78jwI+LFArMV8/saJun6IwyQmzlsBGE3s9ZeoFRXvTR26L7xISsh2bZro8MV
         E/t0n6lXoY0uTenSjcKBxyPNf3m+o3BXUxsOp9eAundU622syU2fPOu+P+oPnD64+JeH
         VUrg==
X-Gm-Message-State: AOAM533uSwkHkNXafs3GD9s6uP91QD/cGgLqnGg2qh3oc/I4BpBUCIxD
        JYRPLY4v2+9sGjwLEVO5GrVHljDwLOo=
X-Google-Smtp-Source: ABdhPJxa6QgFX0IFJ+MWlMZxMd54+W6h+M9i7hsSajiazkRvrQ3/fk4rFtXRbPM1a7gfb5XbaWuG0A==
X-Received: by 2002:a5d:9a15:: with SMTP id s21mr1143658iol.141.1598663701448;
        Fri, 28 Aug 2020 18:15:01 -0700 (PDT)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id v75sm570527ila.19.2020.08.28.18.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 18:15:01 -0700 (PDT)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH] Staging: rtl8723bs: os_dep: fixed some coding style issues
Date:   Fri, 28 Aug 2020 20:14:05 -0500
Message-Id: <20200829011405.2869-1-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed some coding style issues.

Signed-off-by: Ross Schmidt <ross.schm.dev@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index f1e2829a19a7..2b2f4505b98b 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -121,6 +121,7 @@ extern unsigned int oob_irq;
 static irqreturn_t gpio_hostwakeup_irq_thread(int irq, void *data)
 {
 	struct adapter *padapter = data;
+
 	DBG_871X_LEVEL(_drv_always_, "gpio_hostwakeup_irq_thread\n");
 	/* Disable interrupt before calling handler */
 	/* disable_irq_nosync(oob_irq); */
@@ -131,6 +132,7 @@ static irqreturn_t gpio_hostwakeup_irq_thread(int irq, void *data)
 static u8 gpio_hostwakeup_alloc_irq(struct adapter *padapter)
 {
 	int err;
+
 	if (oob_irq == 0) {
 		DBG_871X("oob_irq ZERO!\n");
 		return _FAIL;
-- 
2.26.2

