Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7498C18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A2820873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMZJz01m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgCKNi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 09:38:28 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:52921 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbgCKNi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:38:28 -0400
Received: by mail-pj1-f65.google.com with SMTP id f15so1018451pjq.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 06:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=iwO+qWgIM9f3My2kQh2h35ZK0GeUk2RHl41oBvJStTA=;
        b=eMZJz01mXe3/ifT+hdwJkqR2hwnztmZqsn/QxoJpTI7gXv9Hq7Mho/K3STadVNsqnJ
         Jx9efTHHul5gLpGYUqgE+I7KKMWhi54bV6FDskbH3N8PpmF7QAepzxONG3RQPwIfm1FY
         EFbD9hs6enLO4wjYYQS3FeNT7JymO2VaJToosruysIL++2mTBak1+80XCKaphPE0Pww1
         yhtQl+5WsH/zw3Ne0klDkA8tkO1R91+BvoGZftBIF5zK6tiCwqzLubSKJ3NDhj77PGVN
         EdCBc/RmqQy3E8C4/YfnfMYDa6N3Q1bO7+ACYUGVnVM0JZpGSJogyiUQNz5ZaMDTlLl+
         fTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=iwO+qWgIM9f3My2kQh2h35ZK0GeUk2RHl41oBvJStTA=;
        b=kK9jIqcWfrhkcQuhAep+uEwQok/ol7CTHjIsJf4MmSqsOQ9EspmANVHGyjhiqjNFH9
         CzbodLzpzJxfIuE3blTq4OZMUB+2JqVFSuf+MgNSWIKcz3uI5S/HpqbYOMelzZrhqvTP
         4a0ULJZqNTkyhlggvnw8wVF5o7txAvadLtFUuVC+C7PTCxgxz07f1u3x7Gm/klHBPdrC
         F/2xfPP8CNfyjifCsjVSxxCkQMcV86rqkDDDZMC74z2z2xjyP9pE+f3RjFclLBTaGLGN
         ZM1M65TdlO2gwQThFJOjipUS6DlxjFNOR0T5w9JCgMAlyoY8dhWF03+YVoGQFqWv9Fby
         Mydg==
X-Gm-Message-State: ANhLgQ3RUl4QxpV3yk/ukjXr1c10XuQrB6BUXF3C2fYaBCkOliOD21KP
        aXl2ydL8BehW/72QKaf7KxI=
X-Google-Smtp-Source: ADFU+vt+TmQHSgrVjNtg41NbMfFfFtaXhBRGeiR+y3qUhNsfgthVTB1cd+qPq8B4smxq2g4cVswDVQ==
X-Received: by 2002:a17:902:bcc5:: with SMTP id o5mr3126671pls.174.1583933905596;
        Wed, 11 Mar 2020 06:38:25 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:287:fb4d:18bc:a849:c699:3914])
        by smtp.gmail.com with ESMTPSA id k5sm5668922pju.29.2020.03.11.06.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 06:38:25 -0700 (PDT)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        sbrivio@redhat.com, daniel.baluta@gmail.com,
        nramas@linux.microsoft.com, hverkuil@xs4all.nl,
        shreeya.patel23498@gmail.com, Larry.Finger@lwfinger.net
Subject: [Outreachy kernel] [PATCH] Staging: rtl8723bs: sdio_halinit: Remove unnecessary conditions
Date:   Wed, 11 Mar 2020 19:08:11 +0530
Message-Id: <20200311133811.2246-1-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove if and else conditions since both are leading to the
initialization of "valueDMATimeout" and "valueDMAPageCount" with
the same value.

Found using coccinelle script.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index e813382e78a6..643592b0bd38 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -551,18 +551,11 @@ static void HalRxAggr8723BSdio(struct adapter *padapter)
 
 	pregistrypriv = &padapter->registrypriv;
 
-	if (pregistrypriv->wifi_spec) {
-		/*  2010.04.27 hpfan */
-		/*  Adjust RxAggrTimeout to close to zero disable RxAggr, suggested by designer */
-		/*  Timeout value is calculated by 34 / (2^n) */
-		valueDMATimeout = 0x06;
-		valueDMAPageCount = 0x06;
-	} else {
-		/*  20130530, Isaac@SD1 suggest 3 kinds of parameter */
-		/*  TX/RX Balance */
-		valueDMATimeout = 0x06;
-		valueDMAPageCount = 0x06;
-	}
+	/*  2010.04.27 hpfan */
+	/*  Adjust RxAggrTimeout to close to zero disable RxAggr, suggested by designer */
+	/*  Timeout value is calculated by 34 / (2^n) */
+	valueDMATimeout = 0x06;
+	valueDMAPageCount = 0x06;
 
 	rtw_write8(padapter, REG_RXDMA_AGG_PG_TH + 1, valueDMATimeout);
 	rtw_write8(padapter, REG_RXDMA_AGG_PG_TH, valueDMAPageCount);
-- 
2.17.1

