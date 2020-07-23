Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44ADC433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDDA12080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="LgQ3Ic3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgGWIqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727980AbgGWIqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:46:31 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F1EC0619E2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 01:46:31 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z15so4325930wrl.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 01:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FcRXaF78mNmiZtgYlFReVlulxbcIjaDa19dqrQlC5EQ=;
        b=LgQ3Ic3Lit61vsptS98+djM7vNqQIhjuWu47gAYe9JkvhYcfrJAQRGUBRnyFxKEWDC
         Kxktu99+8TH17zb1VYqWy7cXNCkWkpZYYH5mbxSO7wlBMFKOo5uLkaMCkoDxFGE0dU0C
         pjN1clxQcIFbV/Ko7EkrOEb8FQfZZQU478woCsE8vJe9hTjKUfDxBPBhtDFZN3urpNeU
         77dbG9oi+Um+nKWDTpTNBqRQcnRXvDO4ft2gNnckTl7yvkNvEK5Iz30c1uYuyETfX7I+
         ofKOklG4KIOwxd+bF0eyHEJRN4GqBE2cimNGIZxlO8eJaT9pABfOt6pKjR0c/I7kimt+
         w8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FcRXaF78mNmiZtgYlFReVlulxbcIjaDa19dqrQlC5EQ=;
        b=owi+4iw3l/apP+0Vlp/m9GCGNys5IvRJtaXJY1Q4UeRKfuLJ4lW+faIcXOOyUw5hw+
         E2EmR2Mjl0J9D9Tt3A1ac/NFK+9/UtQG1vaQmwZcTwH8wHjssAqDzfGGTGK+UwAuiwTn
         g5dFJo78jIC44jayxDE0kOp/B8UtJwo+LgBVPAteFJgRbD5xm3XWK2LcuQxt+1/Fdu9S
         7ww8yK+QhbexT1CGG2Ez4U0Y5SQmzFaIwgYWhsoV6qHa7kXsHc0SKAQGHvkSgL3Bjlg7
         oq00kBn6uPK/FwUbdNQlue6eZy/rC+LoyCZsUU+sn3b9REze5OfCkr4FEJuJxQcXr7eE
         iJmQ==
X-Gm-Message-State: AOAM530wVHH6A7d3/w0h6yaeuVpNobPhbzIKbGPPtAKHFvgoskT8vBid
        r6gt5uH7LxVGJoY/DK2js+ZfOw==
X-Google-Smtp-Source: ABdhPJz1rPRfKKjiS/JJQ3Lq7JTsamW0m62+C9dbFh3AxOG1gaQGsrn0yqRNbJ9qIq3Ay/3+moe4+Q==
X-Received: by 2002:a5d:6744:: with SMTP id l4mr806213wrw.105.1595493988478;
        Thu, 23 Jul 2020 01:46:28 -0700 (PDT)
Received: from localhost.localdomain (126.red-83-36-179.dynamicip.rima-tde.net. [83.36.179.126])
        by smtp.gmail.com with ESMTPSA id f15sm2454435wmj.44.2020.07.23.01.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 01:46:28 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge@foundries.io>
To:     jorge@foundries.io, sumit.garg@linaro.org, mpm@selenic.com,
        herbert@gondor.apana.org.au
Cc:     jens.wiklander@linaro.org, arnd@arndb.de, ricardo@foundries.io,
        mike@foundries.io, gregkh@linuxfoundation.org,
        op-tee@lists.trustedfirmware.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCHv2 2/2] hwrng: optee: fix wait use case
Date:   Thu, 23 Jul 2020 10:46:22 +0200
Message-Id: <20200723084622.31134-2-jorge@foundries.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723084622.31134-1-jorge@foundries.io>
References: <20200723084622.31134-1-jorge@foundries.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code waits for data to be available before attempting a
second read. However the second read would not be executed as the
while loop exits.

This fix does not wait if all data has been read and reads a second
time if only partial data was retrieved on the first read.

This fix also does not attempt to read if not data is requested.

Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
---
 v2: tidy up the while loop to avoid reading when no data is requested

 drivers/char/hw_random/optee-rng.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/optee-rng.c
index 5bc4700c4dae..a99d82949981 100644
--- a/drivers/char/hw_random/optee-rng.c
+++ b/drivers/char/hw_random/optee-rng.c
@@ -122,14 +122,14 @@ static int optee_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
 	if (max > MAX_ENTROPY_REQ_SZ)
 		max = MAX_ENTROPY_REQ_SZ;
 
-	while (read == 0) {
+	while (read < max) {
 		rng_size = get_optee_rng_data(pvt_data, data, (max - read));
 
 		data += rng_size;
 		read += rng_size;
 
 		if (wait && pvt_data->data_rate) {
-			if (timeout-- == 0)
+			if ((timeout-- == 0) || (read == max))
 				return read;
 			msleep((1000 * (max - read)) / pvt_data->data_rate);
 		} else {
-- 
2.17.1

