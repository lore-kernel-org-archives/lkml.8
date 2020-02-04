Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84089C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D70B2084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T6kTopMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgBDNHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:07:47 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36641 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbgBDNHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:07:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id a6so7271156plm.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 05:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EbwaprPrZGCOYIwfEnMtNO3dQPuMiwviJCmc3lmn8AY=;
        b=T6kTopMX/IE6bhMCYtQ4WKwM9QoWkqGI52ktEvb/CYwJDzF3PnFjHAiN8ke3XbIwOU
         GgCV2jxSllzPwPWGx0W1EsxXFrR+a4H6hAU4RJMk23teezouAOAZ3rOPFj+obdJ4EqPf
         30zHFAsNZ9ZUvkNJu5KAkrv341Yl6mOyNwqPUi+9p8nHgs2b3On/a+GGbqEaxat6rcRx
         UM69Pe5Sg1oJJ8TKNOyvSaESkIubRVEH8r3xO9ERS2WwfNONJbRltu/YiOsjedAQ4/lI
         Cresribjp+vGb0d7bM1D5pTwYyC5RPM7ckI7ExEMfrxKUFwPq2Qu1YoYvcfSSnFuX+GR
         N2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EbwaprPrZGCOYIwfEnMtNO3dQPuMiwviJCmc3lmn8AY=;
        b=B3s3ttS2ssiYIu4/EBsdmDFE4jzh68pYXBKsg0ZPwxpolIgk6x5uEcDzzoM3HrqFVG
         SFOqwACD9IRuH2NPwczeo6Yv2vrWMZqm5Xfoqs/1bQtelqA7K+hl7H3rDozaZ3YDcDyV
         VBBtQ1qfQcDan20IvGO9QZHwpNwyPfMAUtrEiPns9yZEcyQlHihPoIK3lmwysOTJg2Jt
         GOEhJWCFL3oUw8KoPUCbPSXobE9egtF42N7ieQa4qFfs0PXBVAc+SdRl6WpyAyEFhVH5
         HKvAb6IILKXUObR7r7srR+DHUBCr2NmQ3XTU92uFES+BLxiNXwDpZ46m/u56o6evCi3J
         Ns1w==
X-Gm-Message-State: APjAAAXHTWNyI7AaCtMDalCozZvw4nM5wsPG6PrPDSPUJQwT9Ci5BsQi
        UwfaLIT90MJ1rLqQEytOl3hpnI3K9sg=
X-Google-Smtp-Source: APXvYqzvyzaEOxV0QJUyXYt+5q+oS8lBLbSV20p56tyno+5AMPJ2FSxFNanEydHqXwD64TuCMKADSw==
X-Received: by 2002:a17:902:8f8e:: with SMTP id z14mr30087427plo.195.1580821666564;
        Tue, 04 Feb 2020 05:07:46 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id i66sm24427537pfg.85.2020.02.04.05.07.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 04 Feb 2020 05:07:45 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com
Cc:     linux-kernel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH 1/2] pstore/platform: fix potential mem leak if pstore_init_fs failed
Date:   Tue,  4 Feb 2020 21:07:13 +0800
Message-Id: <1580821634-15246-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

There is a potential mem leak when pstore_init_fs failed,
since the pstore compression maybe unlikey to initialized
successfully. We must clean up the allocation once this
unlikey issue happens.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 fs/pstore/platform.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/pstore/platform.c b/fs/pstore/platform.c
index d896457..114dbdf15 100644
--- a/fs/pstore/platform.c
+++ b/fs/pstore/platform.c
@@ -822,10 +822,10 @@ static int __init pstore_init(void)
 	allocate_buf_for_compression();
 
 	ret = pstore_init_fs();
-	if (ret)
-		return ret;
+	if (ret < 0)
+		free_buf_for_compression();
 
-	return 0;
+	return ret;
 }
 late_initcall(pstore_init);
 
-- 
1.9.1

