Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F0DC4345D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A595C22D02
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="07ssaopV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729332AbgHFKDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 06:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729312AbgHFKAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 06:00:36 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356D8C0617A0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 03:00:18 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a5so33432764wrm.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 03:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IjCAb6ElutCFPhXtiRRhexkYUeHi/3Oyyo9f5qPCuTw=;
        b=07ssaopVlpy25M08Sfu8/Ed2KaEWKD7qpGWYm9QQsMA5sjGrjsDEg2rNUkOkeFqb+W
         E51HB2POCciK3fXe+LVmMAMbYu+08znf/dSU3+QzzliE3YIlxf3l/aiFYRCF/nzSJmbe
         nZI4TjWfA9aCvbvYAlnZyBtmW5qh5/PkFnRL6V1I+Cc/7PQ/Ine1LrRKCEfcvBuYRsdg
         0fRn19HfsnOyGGVrutacfiZkr1jXoQ4B5spsLH61a490BqxKsYA5R40F9Iglc+bSC4jM
         MhicEySUJqULV14ucCB1y29WSWTHVjAZiO8d2/r9fgaPcvewP8SLBg1vxsxwSa4B0FgL
         1BBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IjCAb6ElutCFPhXtiRRhexkYUeHi/3Oyyo9f5qPCuTw=;
        b=pCEltv9BAjXQy3tCNm3nImUEo9rPVkFTMbinXIH8rYEXtxk77Wr6Auf6BRuqgiNqPa
         rAyQi5EQ9fQwy04wyI1NZb2YQMlWMyM/zqOuIoTqDL27Fqz94gPL2bLVYLcztdgWCJbA
         3MkO8vx/2FpqEPLYuScUoJ9Nw56iiGcYbx3Sp+4A7mmZSxFL1atH74SUbeF6kL2A6YF2
         RqoZH+IRvtbitL+n6o5P5Yeifmfz0uGYaVAy/2B/qZnVqqtP5TCbYp5YP9LJMor5pbmM
         eenD30fm1eA9KnWo3DGtuu9qSlz58WslEXImBsquuyLnDvG5aBg1gpLFo+v7/TWFZ9GI
         VOyg==
X-Gm-Message-State: AOAM5307HjnnFGlxNCP0rrJLJfuxrf/g4QJCEHREAQhIuD7gkHtwpvEp
        2Nc7dK7dqqG3lXxsH1rTEOzTnQ==
X-Google-Smtp-Source: ABdhPJzflnDm5lBDSKdsku0RgxeIpkyuqg7F5psga7JqMeU7TsH7cOl9HX/ejXDzhuS7Q4ZjSsVC7Q==
X-Received: by 2002:a5d:6744:: with SMTP id l4mr7288655wrw.105.1596708015448;
        Thu, 06 Aug 2020 03:00:15 -0700 (PDT)
Received: from localhost.localdomain (239.red-83-34-184.dynamicip.rima-tde.net. [83.34.184.239])
        by smtp.gmail.com with ESMTPSA id p3sm5741376wma.44.2020.08.06.03.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 03:00:15 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge@foundries.io>
To:     jorge@foundries.io, sumit.garg@linaro.org,
        jens.wiklander@linaro.org
Cc:     mpm@selenic.com, herbert@gondor.apana.org.au, arnd@arndb.de,
        ricardo@foundries.io, mike@foundries.io,
        gregkh@linuxfoundation.org, op-tee@lists.trustedfirmware.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv3 2/2] hwrng: optee: fix wait use case
Date:   Thu,  6 Aug 2020 12:00:10 +0200
Message-Id: <20200806100010.20509-2-jorge@foundries.io>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806100010.20509-1-jorge@foundries.io>
References: <20200806100010.20509-1-jorge@foundries.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code waits for data to be available before attempting a
second read. However the second read would not be executed as the
while loop will exit.

This fix does not wait if all data has been read (skips the call to
msleep(0)) and reads a second time if partial data was retrieved on
the first read.

Worth noticing that since msleep(0) schedules a one jiffy timeout is
better to skip such a call.

Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
---
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

