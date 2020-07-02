Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CD4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68B9C20885
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG8Gwq3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgGBPpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgGBPpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:45:19 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FE5C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 08:45:17 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id t11so7843985pfq.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 08:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=5+axulHBFG80o0OaU9aOnx+9TZZxhZZELeuFYpmONSM=;
        b=PG8Gwq3rWJPcVF+jFxr5uuHm11vnxhR+0IQYKA4dwUKgCs+TqST48oRFgXWCvmAQuZ
         vcuv/JCn8i9YN+jUlt7/NmUXJox3VYX75dXPLgIp8Y8Wa55O9uDI4MFAPFkDzFMJoD9j
         1rh6pT8u50HIJxnBzvtEtNLhW18jBUuJtX7oeaQGZ3RK14lOsTO9zbygqBmfLKAe4w5D
         Y84pfO5EgUzmWu/Dciu7jhQGi3UFGGYpzA3EPmnxFPgH0r5BeX6el4KXyaWQBxZsOn+P
         dMnHB7RLTL7uPERZvVDgAoHaeFe4W416gWNnue3l4c3Ehie2sP1sZ3mTMbyo+3oM3fK6
         pFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=5+axulHBFG80o0OaU9aOnx+9TZZxhZZELeuFYpmONSM=;
        b=LxUd3oKl8QJJhBWOzhmgO2HfyPs+hRfgNIj1X9vJua1WVIXDGD2D/NaR8M5zVJexY9
         EYXWdKDYU1Mvt3bhg6Y7IyKufLUd4s0lMuuGXcIMEaE/tjD8X8g2J+51ecgsPYlzUMLJ
         o8sWH27nRlmFytjeQUcZ8zgIUf+tOGxzPtrLLpalhGX3d9LoPtiyUOxzWY7epPRHRAfe
         qCx5YkZTZdOsNN8vzBHEzWAfmoFLH8Y8rcy3CtUm+6elIp4X7KUrR2jGXT5ts/XzyqaN
         vUh8BKljhkY5QOPYAERO+bYv58jbJAeVdjwedAXpLv+jlEwO83m0usLuPNo/M1OU7qSZ
         W2KA==
X-Gm-Message-State: AOAM531IDFkFy39uHZu9dDuOe2jqm8C3dfgK+4xyV8U887MYuz2fAzi8
        f2yOnA1ZILpowZisTLYtpiMHkZIJ
X-Google-Smtp-Source: ABdhPJxUXWrtR21f3aQL9Tj8/iND7zjSPCdCy5fkuDbaVbgwT3J0BZlwyr2far/zF7nepSBrzUsxNg==
X-Received: by 2002:aa7:8f03:: with SMTP id x3mr27786612pfr.64.1593704717537;
        Thu, 02 Jul 2020 08:45:17 -0700 (PDT)
Received: from localhost.localdomain (n11923716050.netvigator.com. [119.237.16.50])
        by smtp.gmail.com with ESMTPSA id f15sm7166804pgr.36.2020.07.02.08.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 08:45:17 -0700 (PDT)
From:   Simon Fong <simon.fodin@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     Simon Fong <simon.fodin@gmail.com>, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: rtl8188eu: Fix CHECK of coding style
Date:   Thu,  2 Jul 2020 23:44:19 +0800
Message-Id: <9f1f9d7d4723aa8d9bc2d7149fd01aacc1191860.1593703689.git.simon.fodin@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1593703689.git.simon.fodin@gmail.com>
References: <cover.1593703689.git.simon.fodin@gmail.com>
In-Reply-To: <cover.1593703689.git.simon.fodin@gmail.com>
References: <cover.1593703689.git.simon.fodin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed a CHECK of Lines should not end with a '('.

Signed-off-by: Simon Fong <simon.fodin@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_recv.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index 282d0f869758..656fe70ae4fb 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -702,10 +702,9 @@ static int sta2sta_data_frame(struct adapter *adapter,
 	return ret;
 }
 
-static int ap2sta_data_frame(
-	struct adapter *adapter,
-	struct recv_frame *precv_frame,
-	struct sta_info **psta)
+static int ap2sta_data_frame(struct adapter *adapter,
+			     struct recv_frame *precv_frame,
+			     struct sta_info **psta)
 {
 	u8 *ptr = precv_frame->pkt->data;
 	struct rx_pkt_attrib *pattrib = &precv_frame->attrib;
-- 
2.17.1

