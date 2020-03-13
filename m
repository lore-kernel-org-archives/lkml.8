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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD279C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FB0D20724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbpA6qyC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgCMKtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:49:35 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35929 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgCMKtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:49:35 -0400
Received: by mail-pj1-f67.google.com with SMTP id nu11so885276pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 03:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=o6afTbf7/yCeF+VeaZhhomT+KkYIZitsMbrfbHYx5jo=;
        b=vbpA6qyCkQZysoUFRYL8Xxn2pnO4dRlSazfhuWfmQUOk9n6sko2frj+BH233MglTZb
         76MOtY7REhMlznesQtdgjfFmpKRwaUVV8WfwRISpiZ5opVQaboLUU3gEb9pvqpcI6Iss
         0wASXvaqSwh9PcouLcW3OCaniq4chLiNblYClT0UDpq3R7b+zTSjGyQvdQ06VZwZgDPf
         tbXcKCtTmSvOUWIv0a6U9tMW49xwSAIVjFsDnAFiv9Ie+5nCAWpBNzpsgh44t1dQiihT
         9xaQTakJCyH3KphdV7CB9fj4UIT5c2jQE5wgMbTPi+qWPmUnG2ka9bU1bXwL7AsjXxyB
         lV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=o6afTbf7/yCeF+VeaZhhomT+KkYIZitsMbrfbHYx5jo=;
        b=MvS2Cc9Igt1tLVhhWz2nN8NyO65IXZ9Leuu/ubVlIe/xro2g4rXo5iOfbsJMjy61iW
         SaipJMVAoMkp8n6y5YCBdlLY8yrcx6/Yey3C9qpHnFJ/bO7vMQKDf35xD/t1dLaI03Ka
         NThatFvuMcTCJpkhDLRKm06Bqv/0/zhq0XhY83vRXwO7WF4QRfwUlweuGE7Rtuvl65ld
         cuUDD1ZjkF3Lb4BKMTWb1VxZufwgQbou9gu1jAUhxz/e4dydVYylNaOLHruqLBbXEcdV
         0SuzjEunLAXoRmnflZArfd6VvKO581jEiExpmRvHuyII5mUEbkgU9Aiol7pAcd9B+vYt
         0bXQ==
X-Gm-Message-State: ANhLgQ1wKfH2zLuajguLMwCmskqs0+8aaD2yeIBBpkp0Z4M//wfeRE/9
        VYL2htgl+XjQd3pqy9Icmjg=
X-Google-Smtp-Source: ADFU+vsG1QzFvwnpFiWnGkJfzVKicGJiYdRWpIUDd9jbdqYy1wC8kdBqYgh+gepJTEsfs1GQ0LVd0A==
X-Received: by 2002:a17:902:a408:: with SMTP id p8mr12893133plq.132.1584096574274;
        Fri, 13 Mar 2020 03:49:34 -0700 (PDT)
Received: from localhost.localdomain ([2405:204:22f:d418:f8a5:7ca8:f99b:fa30])
        by smtp.gmail.com with ESMTPSA id gx7sm11718756pjb.16.2020.03.13.03.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 03:49:33 -0700 (PDT)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        sbrivio@redhat.com, daniel.baluta@gmail.com,
        nramas@linux.microsoft.com, hverkuil@xs4all.nl,
        shreeya.patel23498@gmail.com, Larry.Finger@lwfinger.net
Subject: [Outreachy kernel] [PATCH v2] Staging: rtl8723bs: sdio_halinit: Remove unnecessary conditions
Date:   Fri, 13 Mar 2020 16:19:20 +0530
Message-Id: <20200313104920.19974-1-shreeya.patel23498@gmail.com>
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

