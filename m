Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A52EC83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309532073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 15:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="whxuS1tB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgD2Pac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 11:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgD2Pac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 11:30:32 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33B3C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:30:31 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so2492783wma.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 08:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9yPL5U8quFESl4Stw3OsG4QqTTqIkWJu59ukHEiK9k=;
        b=whxuS1tBIOGCXGKR4D9txfj0YrmvLOppPzKf133Orw2xrDFaxNC2NVAj2Yxms3Btjw
         NHvTheC/ne7068Zqc8rsMg+2BAga/XkLIMao16bcGyxemQ9q9tPqOjHk0EluqowWkXKP
         rm2JZAmN0vdwbkYiYGVNeiyAnsrCfqjEdvzEutsmoYC9XAyQMi2c6PjQHLansB11bjyF
         bAUz0LQ+Eq99vqYrtX7aMn19G5+Vdwv7XDOACYvKaODSQs9rSt0XJ86Th9EXer1tOHDZ
         ZX6Bc45zaPh7n7Ra92xD31RtoqDp7AyFTEGH76JSzCHwW70/ZSoSvsFSSJUMHHiKJ0T5
         Qbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N9yPL5U8quFESl4Stw3OsG4QqTTqIkWJu59ukHEiK9k=;
        b=t0fgS+yB8MnZY6OXsVZd43jWBEMuj3v5/x4jVNr/dJBjeqPmxwiHqWXHlfGewTE6D6
         YQjDNsXhPT/soeT2VDaQYC+a1Lsgg5ici0/vl30OifMAxpEWmS1yf463naRgzTEqPrIK
         0VdulGl+IoPOSwTYaBGw36SKsiqVVA5jFkbI2F8qey1ub5Ox6je+gJIOC6Un5XDH3he5
         GvWJi1OAy/Kl6zDP2H1NIKDBPwXgbMsyWMH6eQ7kKYfwoR9QPRhAUQkRpeTxL8QB3iju
         cZb4cXKWgXs/0MbBWoxGkO99UL10kxNrjELufj8ABy0mL/mP4+2xVTCyeZiZAHWMegAK
         QLgw==
X-Gm-Message-State: AGi0PuaXUAmCrXHylqsmkh3UJKT2e+f3CK1ytXP7b01uDCGyYKsuNXfu
        iTEBO5Lh+Yq6jZNdqv61N25eglcL19Q=
X-Google-Smtp-Source: APiQypI9ooSvKXGzfgE7VydIt8jFs20yFTtVFE5oUkIKvGGCN0t6yST0jxtjPo1HsMTn0kxs9wv4CQ==
X-Received: by 2002:a05:600c:2314:: with SMTP id 20mr4090739wmo.118.1588174200388;
        Wed, 29 Apr 2020 08:30:00 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id l5sm7923729wmi.22.2020.04.29.08.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 08:29:59 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] misc: fastrpc: fix memory leak
Date:   Wed, 29 Apr 2020 16:29:51 +0100
Message-Id: <20200429152951.18504-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if misc_register() fails, previously allocated data is left without freeing,
this could result in memory leak.

So fix it!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/misc/fastrpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index e3e085e33d46..9065d3e71ff7 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1613,8 +1613,10 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 					    domains[domain_id]);
 	data->miscdev.fops = &fastrpc_fops;
 	err = misc_register(&data->miscdev);
-	if (err)
+	if (err) {
+		kfree(data);
 		return err;
+	}
 
 	kref_init(&data->refcount);
 
-- 
2.21.0

