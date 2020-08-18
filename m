Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE47C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54E0920786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 15:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kyXcab8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgHRPL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 11:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgHRPLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 11:11:39 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59AEC061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 08:11:38 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id p20so18637243wrf.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 08:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/TUviTxTr5RENHKS204/Amvu2wl72islAoTAztRD38o=;
        b=kyXcab8PtKT5O5lVakr4loj+OMQcj8nCmqIZjBKRtV+t4CcXPuHW4hNfYc5nk6z6bo
         jirtPaLC5ptB1rQ/DpBkYGJxkb76UeHDHlJBTzYMek/sJoU88ecQi+PibR5IkbCncqHc
         a1vKyEy4lqWk2wPjbrlKzeVAKyZKsJOEcqyu0a9bi/JJHyCt5oY3wXhRP21/6owQi7al
         YB9NVxB7eXyr6CAcU8BMCYiCqADWpW0D5BSkCcv6qZBt9BU6qGJvqy6JiFoHEXEk34uY
         pVOHOtGaNE1OcPlMHgUKo9EQBv6FmzG+7ra/0YjZDVhsoAV+Bzda900niFw6lUowByu6
         cA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/TUviTxTr5RENHKS204/Amvu2wl72islAoTAztRD38o=;
        b=NbTIqbE2ON58/ZyNG4jJr/yVjCU/0e3q5PelDe8+jpkQxlFvy/cv1RlgzyVn9jWo53
         CB6kA1bkQaKoviguDmbcRFkwtVLaeq1EIrBqh0D7Jo32Q79mt86yE+Mm7Pj5nQbrY2qp
         7dDkzelUS+0cYVVxDxYPn4IQzxbEtqjihTjsRJnqUtAxzOeIp4kMp6mAG2U6J1gxEutJ
         5+lcqQ4o/RvIGpGpNJY9VRAdI1uR/gjN7u6NCMNNmuRDPWRfwxSyosHLysVJuFRhEPfy
         ifR1uUBJQVWIvS4dUi7ig6hxxzj+XRtdAn9hds4m4g/rJivVnCrSgOsXSSS0YAaQEAvA
         o3FA==
X-Gm-Message-State: AOAM5323h9yJfQezqeRqb4740Dlet0QRaCgA0ipvAausVqaIzUuk4RrF
        zOT3dCcyXo/mG0XenlflsDU=
X-Google-Smtp-Source: ABdhPJz8jQ2UIZ0e4glv5rwM4+hhWPDfagKdjFGyY2wc2UVtfUyBEuZJPiHY3sdThsZ2Fy6iJYrkRw==
X-Received: by 2002:a5d:5084:: with SMTP id a4mr21374691wrt.191.1597763497564;
        Tue, 18 Aug 2020 08:11:37 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id x82sm299863wmb.30.2020.08.18.08.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 08:11:37 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Dewar <alex.dewar90@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: emxx_udc: Allow for building on !ARM
Date:   Tue, 18 Aug 2020 16:11:29 +0100
Message-Id: <20200818151133.583382-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the module can only be test built on ARM, although it seems to
build fine on x86. Change this to allow for broader test coverage.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/staging/emxx_udc/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/emxx_udc/Kconfig b/drivers/staging/emxx_udc/Kconfig
index ad1478c53e9e..e7a95b3b6a2f 100644
--- a/drivers/staging/emxx_udc/Kconfig
+++ b/drivers/staging/emxx_udc/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 config USB_EMXX
 	tristate "EMXX USB Function Device Controller"
-	depends on USB_GADGET && (ARCH_RENESAS || (ARM && COMPILE_TEST))
+	depends on USB_GADGET && (ARCH_RENESAS || COMPILE_TEST)
 	help
 	   The Emma Mobile series of SoCs from Renesas Electronics and
 	   former NEC Electronics include USB Function hardware.
-- 
2.28.0

