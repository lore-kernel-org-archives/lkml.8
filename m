Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A13C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 22:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F99C20775
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 22:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEYHyGmQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgCUW3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 18:29:23 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38791 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727700AbgCUW3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 18:29:23 -0400
Received: by mail-pj1-f68.google.com with SMTP id m15so4179411pje.3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 15:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SuELOfyOz/CEz/99d3bI8dTWcwrsJmXIVlGN6B64z0M=;
        b=aEYHyGmQpxeFZqEXPnIVSbEYZqdPTYPzvm6I7qtE9TfIpAIOdzBlTi5iQpxQZlcjY+
         v46ovDZ4QD5bsOL8QD/SOypuvp3yLfF3VTvNJr8wwkG50UhaKBXUbcMJfrF2xzgMRf9b
         TuA1ghjjfDsIAX/O/QH57ctYs/8ODWVLDBjBfKtrLTWrJxnfrx7ER/1Scv2dOykwUnpy
         B3xUNHZs4YUtnsoX8WUneCtV8CnMNOdOlmFtV0LsdZVdcgX/ftj3A92R386vsk9bMo+G
         +I9nrPrWutswAjFF1ubcdoadzbzhZqYvqHVYOYDjomtorqarhDIb6c80fhG/3AiUKyKe
         voxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SuELOfyOz/CEz/99d3bI8dTWcwrsJmXIVlGN6B64z0M=;
        b=dqoqUa9WQ7fYcw88HbiP822o83iG+KhKAzdpbIliMxt6UFnSqbfLLaeVKSUUUpqAnQ
         cM4ja5Ts8WOtJgRUL67jI5BH3y3+O8TikDOEIzSLFvY5HlM3anK53787VHsN6Cb03JQs
         CYUg60SK8GRUw0kuE3hsbMziNaBeUaBnja0jzWh29hnRi+MyFk3YH/VYjhuYwveN6Q4t
         URA91XfSYsQB6U2UM7JtCvdQES/FTriHqr+2VXSqvndwhqHwOJcijS+raUdcu42+p0kn
         mm9gTlhBXh1qAmn+ouf6yX5w7MkNyavFH22tSyeio+9KBtNMajuRCoyP6TD8z4nLdxSq
         E0RQ==
X-Gm-Message-State: ANhLgQ2QsCxaVOV2QENfbQoB3EO9xO9FOF1nY8RGbamaEy1nOgHmu5c/
        /6Spu0sMrHMEseOQssi98Ls=
X-Google-Smtp-Source: ADFU+vvEnDB1dz6+ndUAeivdzOPLvm3W9fFG9Yls8/RDTvznA0NNoNF6MWOmJVwaAVKvbjHjsGGndw==
X-Received: by 2002:a17:90b:3c3:: with SMTP id go3mr17475019pjb.10.1584829761900;
        Sat, 21 Mar 2020 15:29:21 -0700 (PDT)
Received: from localhost.localdomain ([113.193.33.115])
        by smtp.gmail.com with ESMTPSA id e38sm8416270pgb.32.2020.03.21.15.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 15:29:21 -0700 (PDT)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Cc:     Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [Outreachy kernel] [PATCH 10/11] Staging: rtl8188eu: rtl8188e_rxdesc: Add space around operators
Date:   Sun, 22 Mar 2020 03:59:15 +0530
Message-Id: <8d558ee0228cee22a2b0e058dba0c505b14ee1b6.1584826154.git.shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1584826154.git.shreeya.patel23498@gmail.com>
References: <cover.1584826154.git.shreeya.patel23498@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add space around operators for improving the code
readability.
Reported by checkpatch.pl

git diff -w shows no difference.
diff of the .o files before and after the changes shows no difference.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---

shreeya@Shreeya-Patel:~git/kernels/staging$ git diff -w drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
shreeya@Shreeya-Patel:~git/kernels/staging$

shreeya@Shreeya-Patel:~git/kernels/staging/drivers/staging/rtl8188eu/hal$ diff rtl8188e_rxdesc_old.o rtl8188e_rxdesc.o
shreeya@Shreeya-Patel:~git/kernels/staging/drivers/staging/rtl8188eu/hal$

 drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c b/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
index 0a900827c4fc..7d0135fde795 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
@@ -182,7 +182,7 @@ void update_recvframe_phyinfo_88e(struct recv_frame *precvframe,
 			rtl8188e_process_phy_info(padapter, precvframe);
 		}
 	} else if (pkt_info.bPacketToSelf || pkt_info.bPacketBeacon) {
-		if (check_fwstate(&padapter->mlmepriv, WIFI_ADHOC_STATE|WIFI_ADHOC_MASTER_STATE)) {
+		if (check_fwstate(&padapter->mlmepriv, WIFI_ADHOC_STATE | WIFI_ADHOC_MASTER_STATE)) {
 			if (psta)
 				precvframe->psta = psta;
 		}
-- 
2.17.1

