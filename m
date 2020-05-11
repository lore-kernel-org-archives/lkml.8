Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6635C54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5E7D2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:27:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gn3qk7+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730678AbgEKQ1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726934AbgEKQ1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:27:32 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D851C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:27:32 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id m12so13787682wmc.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0BF3bA9JhF97PrSfdTNbNu1Y3C/CiYWUHU/YeauczSs=;
        b=Gn3qk7+c30POnWys+xu4b7lJbwXKvzQ4APIk9vYPoDXKggFWD+ZARV9RSzDQ71uqar
         NLAW3k3ZjaSh7Dt+0mZPau7Sg6Ohjv82qo3tx4dj+5w2xNd7tC+TI3JRwJr3l0o+ArOB
         o1k3Xo+BF9iRTr1Ml4eSDENeyneK+X7FqfTT+FDayEK56vgvjqQqcKvYHIBar3Z4cL4z
         DxYsEoZuoZtFTvtCDZvY55uSMFa8ZguYk9ipnJ+aq2y+LE0i8wC6p6p4k/iFpOz9l/b0
         kqFSz2ckjxoIxTTzUcj4K9NUjVXBev5Tj+XMO9Tm+p6mOOaBindxz3GX9IQS9tNXqpUa
         rtqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0BF3bA9JhF97PrSfdTNbNu1Y3C/CiYWUHU/YeauczSs=;
        b=UsJ1mGwdJe5sT5/G8g7DLSLAIoLHBGEBnYQKMvMHilAKEVVDHzE315AlhfpSz+pZlQ
         GzIjK4zEp+FKNnP+eynNZ5UNU5nXQ9ceZIEzpqXJsl/6NhWDKkwFMyT7LJo3tfuQFz6G
         JztQoa1A9up8G4BhV4htBmi5owcPA4yJs/A2IPLoaK/hSWjIcmfRkTrUy0SfMDLiCIEf
         0jR/ZYvlfORtK+g8fDLVrxi+oJJjdAwrLdvpA5o5qOnMqUQPjAZoCWBqjN+yHuu1poX7
         bxcydRohTqPIwX6ac8Ji+C4GemhWIVhz6zFqssVbnz0lDtEYM+0slqlPcWvhbsXf3c4/
         b/sA==
X-Gm-Message-State: AGi0PubWFel/HMBdSDVozt0p6vYbgt4PQL91/Us2QjGHEsOTH2LVSVBr
        NgTNAwW7TYauobF6MjaV+xdEDg==
X-Google-Smtp-Source: APiQypIQRwpNO19dwzGtXD6zLZNcH01Mm6QekWBnZp4+F46EceTgShV9JecQ2vLkWoPBjgM2/Xe1sQ==
X-Received: by 2002:a1c:818e:: with SMTP id c136mr14989555wmd.157.1589214450863;
        Mon, 11 May 2020 09:27:30 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id k17sm26876602wmi.10.2020.05.11.09.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 09:27:30 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2] misc: fastrpc: Fix an incomplete memory release in fastrpc_rpmsg_probe()
Date:   Mon, 11 May 2020 17:27:22 +0100
Message-Id: <20200511162722.2552-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fastrpc_channel_ctx is not freed if misc_register() fails, this would
lead to a memory leak. Fix this leak by adding kfree in misc_register()
error path.

Fixes: 278d56f970ae ("misc: fastrpc: Reference count channel context")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Changes since v1:
	- Update subject as suggested
	- added fixes tag

 drivers/misc/fastrpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index c562e285e0f4..07065728e39f 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1615,8 +1615,10 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
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

