Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38037C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E28A20724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:46:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rB/JrxX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCMKqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:46:51 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51386 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgCMKqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:46:51 -0400
Received: by mail-pj1-f68.google.com with SMTP id hg10so17511pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 03:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=o6afTbf7/yCeF+VeaZhhomT+KkYIZitsMbrfbHYx5jo=;
        b=rB/JrxX0L7LaAtUV00dCdFiedhiTR681/8tixC3LeFg+mmm/oXg1UoXM5C8wHRbfnZ
         fhZ2bENDyBia9zKeDoain0e20+dVQldHc4w+6WHRXveP9NpqXpKJAfyXWEaUOHVWb9cF
         0fYHTuY9ZYI6bh8h4rwiiaPGCV4lqZsKOoIPDisRmUTiQAlmo1fJdz/PHZ76ep+qDac2
         hGGZ33A4d3LhU9ZGvvurTqRgkJsr3kZn7a+BHs6Cqyg2oQ0Jlt6V0QF3w4SdSPbU9NTZ
         /YPCNnoDIfm54kn3HrYFONeqKy8RbdGFDdtHcNRof1B9P+zh9H8ObS8EBDVKmlMWxGBC
         0JCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=o6afTbf7/yCeF+VeaZhhomT+KkYIZitsMbrfbHYx5jo=;
        b=CPKa1h7CKGR6i7TOEeOpdv14rFYniAwfquXno/w4Fs+69WliknY/iO5rH7bJTJd29B
         IsRhCUg6/+e/efwEWUS8h7yb5VZ+smJtyHyB+EAsS3yCuGz6XC0gtQeNPeB49lJmVXt9
         mgafWtTEPb+TVFDhk/mxW2EbPGWQVaJ1P2LXh8NFgDUUqAadN2+1Z+CPsFz2fCz6QlNG
         o1zTep+GWKPS09qNZQD9miosfOm5cF/MiRrcEnnGBAgixEpZXpHApxm4MJA2mTiMcBNY
         unyx99VMoM/iGJ7O7dIO0ivMbQ94jxHIKZUDj43MBXweL++iDtoe+FL/i0xGxzulHJMN
         RaWA==
X-Gm-Message-State: ANhLgQ2QD9Vogc8TIRzJhrNdTdz8q8LxdDVX/g1sB9Ufg1Jg/QXx4QYU
        HxaUcC9xs/j/c3DStS6DRlo=
X-Google-Smtp-Source: ADFU+vsBKShzUZkSlbgiH+IFdbb9Pnz5biKuJqGZx7Od9k3U6Ftq7+V5D8q4+UaAnGA7aLhmxhpf3Q==
X-Received: by 2002:a17:90a:2042:: with SMTP id n60mr1625659pjc.0.1584096410372;
        Fri, 13 Mar 2020 03:46:50 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:22f:d418:f8a5:7ca8:f99b:fa30])
        by smtp.gmail.com with ESMTPSA id p70sm1709171pjp.47.2020.03.13.03.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 03:46:49 -0700 (PDT)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     regkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        sbrivio@redhat.com, daniel.baluta@gmail.com,
        nramas@linux.microsoft.com, hverkuil@xs4all.nl,
        shreeya.patel23498@gmail.com, Larry.Finger@lwfinger.net
Subject: [Outreachy kernel] [PATCH v2] Staging: rtl8723bs: sdio_halinit: Remove unnecessary conditions
Date:   Fri, 13 Mar 2020 16:16:40 +0530
Message-Id: <20200313104640.19787-1-shreeya.patel23498@gmail.com>
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

Changes in v2
  - Remove unnecessary comments.

 drivers/staging/rtl8723bs/hal/sdio_halinit.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index e813382e78a6..4894f7d9a1d4 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -551,18 +551,8 @@ static void HalRxAggr8723BSdio(struct adapter *padapter)
 
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
+	valueDMATimeout = 0x06;
+	valueDMAPageCount = 0x06;
 
 	rtw_write8(padapter, REG_RXDMA_AGG_PG_TH + 1, valueDMATimeout);
 	rtw_write8(padapter, REG_RXDMA_AGG_PG_TH, valueDMAPageCount);
-- 
2.17.1

