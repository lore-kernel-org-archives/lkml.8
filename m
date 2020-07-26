Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF73C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 14:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2485A2065F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 14:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgiFHivj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgGZOVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 10:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGZOVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 10:21:15 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E637CC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 07:21:14 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id f185so2786843pfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 07:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qjht00DvaxzbF2A+NLzR7ECrZcRLCP22mrw14y7Hx28=;
        b=NgiFHivjsGNZ3EdgSkw/XPeHXByJJYCThEjKzT/95WcJS4D6IGan8Q+1TVYuaDeiMW
         EYdNisPea3wNp1/8s6CG8GzZ1mMH3Y6PQgQmxbxiXo1w9A/Nh0XqUtEgvGUoRM/RbQR+
         b2urreocYhk3Fi0ww9n3nOlWEnpDce+jY9J2FugAjUiXQqm9btQCOwt3sWpgF7fsrSgd
         G5TSDM4Tewvo5N706e1tkgGIRyWC/B3oX70DqlzKs3YvOe5MdygryRQtrsp7i9iT+Kpj
         eDfQ13hhJYyb+EUIOBKZ72cwN+1g9TTm2dVijqbAb7p7XGvBWAWgMsFYLZCQ50fGBm21
         Pckg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qjht00DvaxzbF2A+NLzR7ECrZcRLCP22mrw14y7Hx28=;
        b=T5USnb7pFgSMFPBAuo6QokbJC/4vhx0udj9T7JPXtwoQdcH51X1OWBnRBmEgowBwZK
         l8fh+mr2Z915RRSR5r/xYwAtd94OPLqBwOt5Kr5g7C/7NaUGfsvLArtHfnjX0UjwQXYe
         l0BCNK2rHwE8Odch24c8JpIJZFL3vwL4COA3jUbgY1/aQyT6SMwtpk0wG3BZUzGHvazj
         nA0xIZk4zShb8s5xacw1uTC0n6KG8wcP2t4BKQOik2hGainRIvArK3e25RHSmaUWntB9
         Ev8LbzPF0gBQidXYgdfLGIsSKpD91Oce5EXLoEu/f534z5hhEsqh14NSP2pMnyDjyMM0
         /hKw==
X-Gm-Message-State: AOAM531I6rkoVdLyNBQAn3tm83X5MAO1cRSZGyMUxKNez5pJXCff5Khr
        N+vpXqFUtSrnsyYSvaWLn/M=
X-Google-Smtp-Source: ABdhPJxjFE0+OA2BXqdUggqKPDScHt/CX8GUufWfJ5TvsqQtNvhSolgLB0xp3cYFvUI5jkxrVkmsRg==
X-Received: by 2002:a63:2104:: with SMTP id h4mr16515050pgh.427.1595773274380;
        Sun, 26 Jul 2020 07:21:14 -0700 (PDT)
Received: from localhost.localdomain ([122.167.86.75])
        by smtp.googlemail.com with ESMTPSA id a13sm12493235pfn.171.2020.07.26.07.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 07:21:13 -0700 (PDT)
From:   Aditya Jain <aditya.jainadityajain.jain@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Aditya Jain <aditya.jainadityajain.jain@gmail.com>
Subject: [PATCH v3 4/4] staging: rtl8723bs: include: Align macro definitions
Date:   Sun, 26 Jul 2020 19:50:13 +0530
Message-Id: <20200726142013.2891-4-aditya.jainadityajain.jain@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200726142013.2891-1-aditya.jainadityajain.jain@gmail.com>
References: <20200726141831.2662-1-aditya.jainadityajain.jain@gmail.com>
 <20200726142013.2891-1-aditya.jainadityajain.jain@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adjust spacing in macro definitions to align them and improve
readbility

Signed-off-by: Aditya Jain <aditya.jainadityajain.jain@gmail.com>
---
 drivers/staging/rtl8723bs/include/hal_phy_cfg.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
index 2b059c9c7851..b3d5d24126e8 100644
--- a/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
+++ b/drivers/staging/rtl8723bs/include/hal_phy_cfg.h
@@ -8,11 +8,11 @@
 #define __INC_HAL8723BPHYCFG_H__
 
 /*--------------------------Define Parameters-------------------------------*/
-#define LOOP_LIMIT				5
-#define MAX_STALL_TIME			50		/* us */
+#define LOOP_LIMIT		5
+#define MAX_STALL_TIME		50	/* us */
 #define AntennaDiversityValue	0x80	/* Adapter->bSoftwareAntennaDiversity ? 0x00:0x80) */
 #define MAX_TXPWR_IDX_NMODE_92S	63
-#define Reset_Cnt_Limit			3
+#define Reset_Cnt_Limit		3
 
 #define MAX_AGGR_NUM	0x07
 
-- 
2.25.1

