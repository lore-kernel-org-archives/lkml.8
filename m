Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0194BC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 20:17:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9FC20848
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 20:17:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6px74uV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgCHURM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 16:17:12 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34109 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgCHURL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 16:17:11 -0400
Received: by mail-pl1-f196.google.com with SMTP id a23so412927plm.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 13:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gCmJ+G7TCrvBbeETOpvYyLbw+i9yV7qmAncCZUfBuCM=;
        b=d6px74uVt1+SFm603mg3MlgNgNOBAcMTO19U7/2hWVGFyedLMM5yckn/R+48b5etZx
         3Xb6/0DVjti8txu9xDFY7uv4U2qU1VbJechlphDAV96GpJWz04TopcYoYWmfeo7sKKZi
         wmSIWW/htWhHjxMJF8PZiwlqEIloDcBMCQmrbQsnZarhT4qzoq6VIwBqk6FRLPEq1Sm5
         CZmAYHnSDFvBTZIUVzZqLM4u4wkfu9WIMUvMliljoVJDrXC048pFPjcFrJhT+1NnvDrr
         0SXIhBbFzV638h0TwcNZ1ZbL6AB1E+U3vNYUnPuZbqaqJmjJqUHZwU1cHHTi1AZH1Gka
         KRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gCmJ+G7TCrvBbeETOpvYyLbw+i9yV7qmAncCZUfBuCM=;
        b=IhwtHU/wyxLwtMV1gcr4J0r/t/gXYn25wwfdraRjAsr/UOxVUV6VNZypJOd0NSbwX5
         XjfVqnJWnx3RgsUep/Mdo7kkCsyvfTWXu04Jrkjn52nPMK69f1X9EL7Vqj60e8iwPAdk
         JaP5BPkB95Rq1T/seVkUofeaEeIVU7snIXrG6pRQ0agyZndGuLpGiln5KKCcArj4CbHt
         9DHGFbuo/Yw3WzRk/XC+xroY7E0VutTz4f5Lt5JI47zosFrjeefcJIYGRoXCuCojjYrS
         3Ve4notLsk51HYPstKmsRKqmVjPVetZm03wbHj0VFINmlpoFxwiiBUKj1LtL/ScwmKDn
         x2Zw==
X-Gm-Message-State: ANhLgQ2N/KzXwb2F7vScbRvpmw5PJaJrqlDQxM355OQBqp+n3u0WLnRR
        s9+FRo/V1a85luin1fTGpzM=
X-Google-Smtp-Source: ADFU+vsTUpY7jCDZfW0/R+WkfqwvdKUgKOITOsCqpTYhd1ubT+1xw1/oODsZ6ZKNY36UXwic9p/FRw==
X-Received: by 2002:a17:90a:17e3:: with SMTP id q90mr15491962pja.12.1583698630751;
        Sun, 08 Mar 2020 13:17:10 -0700 (PDT)
Received: from localhost.localdomain ([1.23.250.201])
        by smtp.gmail.com with ESMTPSA id x197sm27062658pfd.74.2020.03.08.13.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 13:17:10 -0700 (PDT)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        sbrivio@redhat.com, daniel.baluta@gmail.com,
        nramas@linux.microsoft.com, hverkuil@xs4all.nl
Cc:     Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [Outreachy kernel] [PATCH] Staging: rtl8723bs: Remove comparison to true
Date:   Mon,  9 Mar 2020 01:47:03 +0530
Message-Id: <20200308201703.31709-1-shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove comparison to "true" from if statement to
maintain the kernel coding style.

Reported by checkpatch.pl

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 7117d16a30f9..a76e81330756 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -2417,7 +2417,7 @@ void stop_ap_mode(struct adapter *padapter)
 		paclnode = LIST_CONTAINOR(plist, struct rtw_wlan_acl_node, list);
 		plist = get_next(plist);
 
-		if (paclnode->valid == true) {
+		if (paclnode->valid) {
 			paclnode->valid = false;
 
 			list_del_init(&paclnode->list);
-- 
2.17.1

