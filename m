Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F03C433E4
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A88C22CE3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="M3hQ0f4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgHFJ7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 05:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgHFJ6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 05:58:52 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE562C061757
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 02:58:51 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a15so43378064wrh.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 02:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=IjCAb6ElutCFPhXtiRRhexkYUeHi/3Oyyo9f5qPCuTw=;
        b=M3hQ0f4LkSWB8thUbjJc+2oJa6y5cmCLs5eD1KoJQkMPuLQbkCSP5TGo61vhJUeK/x
         okUOHv5gpWr71ku2i/E36Skxdbfnn18rmL3eBJWrH+0mYVz8okIXXR53bQDWRM4TxMP9
         F+WT5h45ad3rWeJjwT0ygsg4yvC6H/6m9hivJlY3OWDsq0ODZmdxUxpF/P/UBC2jXGpK
         OhGd+Oegw56eEjiekzwedj9yzzMzY99ZpiyBy7A0qJZLnr0RiclFMXaA32e1fEeijQ7Q
         yD4AYk6PV8a0dusI2VcgtO4BYhK0SK16GMfSWoSG06raXRA5r1h1S+GM0meA+9tmSTYD
         AsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IjCAb6ElutCFPhXtiRRhexkYUeHi/3Oyyo9f5qPCuTw=;
        b=OJNZb4u3+b8LrE6hNuW/tnScSjAq6Mt8nu4D1kdryXTpc+QTDHXmPTwebPnBzUGjym
         6W8XmnmI35Ojl+QCw5WRyUekdJMEqstk9KeqRIG7fQ4B+5qgwN4gHCFUp10lvsA3W2Xo
         /PuB5miuCiNQ4fYAMmKX1XmOam0C4tQJY/2BR8KyKfVcs1FZa0YB0GkV9uMZznH2lD1j
         V0CyOeVTmvmrz9scieL9rEehzSNB1ZvXVi2ub0WGRXE3wP2ZTHT6CXYB+b2pQYmDUGvd
         6MlDBRRMTwNQo+eupqaBrpxLgy93Zm9DUHYHcNslOckllsFKByVBLegsVF836ZJXmL/Z
         vsUQ==
X-Gm-Message-State: AOAM532xDnuXbWozLjzcYtO9M4mFenp/o4mQdPaHmSrvS01f7ebbyEG+
        Kc1iOENjc3poX9/INh6PEj+h5g==
X-Google-Smtp-Source: ABdhPJwn+3pUhsigOTALX0nYV9hiGuaZwXe1U6BCXbpNO1wYrek2IXuJiZU9Zca5n1jK+Wg7rHfjpg==
X-Received: by 2002:adf:9e90:: with SMTP id a16mr7074410wrf.40.1596707930696;
        Thu, 06 Aug 2020 02:58:50 -0700 (PDT)
Received: from localhost.localdomain (239.red-83-34-184.dynamicip.rima-tde.net. [83.34.184.239])
        by smtp.gmail.com with ESMTPSA id z66sm5793181wme.16.2020.08.06.02.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 02:58:50 -0700 (PDT)
From:   Jorge Ramirez-Ortiz <jorge@foundries.io>
To:     jorge@foundries.io, sumit.garg@linaro.org,
        jens.wiklander@linaro.org
Cc:     herbert@gondor.apana.org.au, mpm@selenic.com, arnd@arndb.de,
        ricardo@foundries.io, mike@foundries.io,
        gregkh@linuxfoundation.org, op-tee@lists.trustedfirmware.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCHv3 2/2] hwrng: optee: fix wait use case
Date:   Thu,  6 Aug 2020 11:58:45 +0200
Message-Id: <20200806095845.20288-2-jorge@foundries.io>
X-Mailer: git-send-email 2.17.1
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

