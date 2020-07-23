Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3E0C433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D0AE2080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="wNsCGurt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgGWIq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgGWIq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:46:28 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F904C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 01:46:28 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so4206480wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 01:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=QHOcU/AHWfp7cpU6Aga751e/Kq9YnV85ILpM7tybMLY=;
        b=wNsCGurt0cH0CckFhI3ZxNLC6qK7Hl9zjEhAqkJsR1WemxWbgpi1zUPeGMzCpD8yeB
         zEEmnwD+ltTnaT75UjIouJHql6ZdkAUJgM3mGwzdvRIQhGmJeUzF8FJSURFtzXt1ucYT
         mhPqMIpt84RKLvRlrH7LrHg+6bCMM7IKQlrpwMx5Sy/jAmA38hITTqESJTGgAZFKgFVv
         Si530jl2cRCmYMiWwhI+fvzaCr5NYpV1bDLzk74IHc8Bo88yywQqW+IN88fV8ipl3h10
         3gfhoFbXC2Hqp2OnBspWZIcSRwnGu+S4E8I2HKxOuiLpTm9YazRyAsDw027SZ5IYBicQ
         is1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QHOcU/AHWfp7cpU6Aga751e/Kq9YnV85ILpM7tybMLY=;
        b=SI/Guc6Ng/Y86kR9CFXB1ZPXmvWAAEmvUKZnfUPl8nvMjJRWz8JfcUAe31ZcZtRRiO
         ITlLqjr00mMZSlVfm+ACIsZXcur0SdJSm6l487Nm1CZMA/RDV9Wm/DQweeDQrBVekS35
         sQOTaLAaXW3NokUkCWEgUNpSQ7TqK1Mt7kVFbwne2nqT7SuQmGmNxJqWzRTMJABO9feD
         7asg57DCc/HTbXsyOwYU3XFif88TGvUk3gMre9VhE4bp5H0QxIIEs3una44uZZLBiXpD
         cre5Ddqx8BEixDdGkmLKl0r4Dqef8Evx+J9n9MhPihgzDLSZTVQB/HZnsQ268gXzPVjf
         GLQA==
X-Gm-Message-State: AOAM530UFza0Uq6fDtmFkvkxT3q/e6aqci++4VU6BAoflIvIvOK4Sh1g
        cFOTtOgK2xpk+uFiFG7k1nTHPw==
X-Google-Smtp-Source: ABdhPJz729xHjPfkTl+uBB2RMnORZGmzvSPdZUISlbC3M5uLk/4pAdXygXOPQNhUFDUoPzxgh1oh1Q==
X-Received: by 2002:a1c:f31a:: with SMTP id q26mr3096499wmq.59.1595493987223;
        Thu, 23 Jul 2020 01:46:27 -0700 (PDT)
Received: from localhost.localdomain (126.red-83-36-179.dynamicip.rima-tde.net. [83.36.179.126])
        by smtp.gmail.com with ESMTPSA id f15sm2454435wmj.44.2020.07.23.01.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 01:46:26 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge@foundries.io>
To:     jorge@foundries.io, sumit.garg@linaro.org, mpm@selenic.com,
        herbert@gondor.apana.org.au
Cc:     jens.wiklander@linaro.org, arnd@arndb.de, ricardo@foundries.io,
        mike@foundries.io, gregkh@linuxfoundation.org,
        op-tee@lists.trustedfirmware.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHv2 1/2] hwrng: optee: handle unlimited data rates
Date:   Thu, 23 Jul 2020 10:46:21 +0200
Message-Id: <20200723084622.31134-1-jorge@foundries.io>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Data rates of MAX_UINT32 will schedule an unnecessary one jiffy
timeout on the call to msleep. Avoid this scenario by using 0 as the
unlimited data rate.

Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
---
 drivers/char/hw_random/optee-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/optee-rng.c
index 49b2e02537dd..5bc4700c4dae 100644
--- a/drivers/char/hw_random/optee-rng.c
+++ b/drivers/char/hw_random/optee-rng.c
@@ -128,7 +128,7 @@ static int optee_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
 		data += rng_size;
 		read += rng_size;
 
-		if (wait) {
+		if (wait && pvt_data->data_rate) {
 			if (timeout-- == 0)
 				return read;
 			msleep((1000 * (max - read)) / pvt_data->data_rate);
-- 
2.17.1

