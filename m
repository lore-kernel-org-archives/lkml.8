Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7064C35240
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 08:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3E582071E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 08:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHwGpHp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbgAZIbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 03:31:39 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35800 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgAZIbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 03:31:39 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so3568684pgk.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 00:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=A/HVm3170PfNClVZmwRIPi9sbl79x5ttiRZ0PyXbaOs=;
        b=HHwGpHp8EjYpAYINXZLEuharzk0X51UuHHpyTyfFiQjf99Ug+UeaH7b6oMx3WSSJ9n
         75b3FsJrP9XMA2TDewW/ppYYDGPukuhvtVUIf+onMq/r1PID3jJEVzjaG5pA8hCjnTkw
         y8Tq7T424WEJ3+RhbZFT3776kKXwaSkFkb1NMs5TGXikTm1tl/qmdxuwkZGwfDngmTlT
         BTcs6t0/QyS3Cwk49wDsAk+J4ti3SBb3QwJgUoKEUTjZu0fB1+LnGndpGpKfTvTFiDJV
         Dsc7hOCi10ikLC0OxuCrdpkcc7nn7yUkK34myAk6LJDsH4uM3LYtdY0+CSKK6IYnEirD
         G/kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=A/HVm3170PfNClVZmwRIPi9sbl79x5ttiRZ0PyXbaOs=;
        b=fLfEEeKN2gnYPlS6jK/Kt1nueLJSycXcvJBLmE4aQhBkUmH5LArQT46qa+zfZOnyKA
         ciH88CbMvzdr+NQc2sdFV9F0W+/dSy3nk4wSNRX60Dpb2wa+oLk9KW6gCYpfOdN3GgsI
         8+HAUBjg7YvbYOtepfYXHrrnPuYLNb/RYJlJ/ctQJhiHRBwCxuLhndUTyvw2nybDFpX5
         ijhjgOiD6xjMv4gDOB8Sj3R0Ihu3wq3fkrirgruI3EH9SXdgJR9PDfaoZejTmR5yhqOM
         taxMALP145PzAUJI83BushaeywGmrHDihCXO4s4UNwkGgp7pj8ujlkAsObhAO0pF0Yqe
         nRgQ==
X-Gm-Message-State: APjAAAUExupfOBfdaldVRfNhCBY9TMsKDMnYtyYNEoW7JAWKMmi80tho
        D1T8+JWqOGtwYMML6msB3dg=
X-Google-Smtp-Source: APXvYqz2446wQU1D2ewWSd1GC8zgFgAP1p3+ZdA0gpPBv7Ouie0P26ycGZPJYf/Z05ATp0/rZQWRBA==
X-Received: by 2002:a65:5ccc:: with SMTP id b12mr13255457pgt.124.1580027498692;
        Sun, 26 Jan 2020 00:31:38 -0800 (PST)
Received: from google.com ([123.201.163.10])
        by smtp.gmail.com with ESMTPSA id z64sm11988940pfz.23.2020.01.26.00.31.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 26 Jan 2020 00:31:38 -0800 (PST)
Date:   Sun, 26 Jan 2020 14:01:30 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     vireshk@kernel.org, johan@kernel.org, elder@kernel.org,
        gregkh@linuxfoundation.org, greybus-dev@lists.linaro.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: greybus: fix fw is NULL but dereferenced.
Message-ID: <20200126083130.GA17725@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: Mutt/1.6.2-neo (NetBSD/sparc64)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the warning reported by cocci check.

Changes:

In queue_work fw dereference before it actually get assigned.
move queue_work before gb_bootrom_set_timeout.

As gb_bootrom_get_firmware () return NEXT_REQ_READY_TO_BOOT
only when there is no error and offset + size is actually equal
to fw->size. So initialized next_request to NEXT_REQ_GET_FIRMWARE
for return in other case.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
  drivers/staging/greybus/bootrom.c | 6 ++----
  1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/greybus/bootrom.c b/drivers/staging/greybus/bootrom.c
index a8efb86..f54514e 100644
--- a/drivers/staging/greybus/bootrom.c
+++ b/drivers/staging/greybus/bootrom.c
@@ -246,7 +246,7 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
  	struct gb_bootrom_get_firmware_response *firmware_response;
  	struct device *dev = &op->connection->bundle->dev;
  	unsigned int offset, size;
-	enum next_request_type next_request;
+	enum next_request_type next_request = NEXT_REQ_GET_FIRMWARE;
  	int ret = 0;
  
  	/* Disable timeouts */
@@ -296,13 +296,11 @@ static int gb_bootrom_get_firmware(struct gb_operation *op)
  unlock:
  	mutex_unlock(&bootrom->mutex);
  
-queue_work:
  	/* Refresh timeout */
  	if (!ret && (offset + size == fw->size))
  		next_request = NEXT_REQ_READY_TO_BOOT;
-	else
-		next_request = NEXT_REQ_GET_FIRMWARE;
  
+queue_work:
  	gb_bootrom_set_timeout(bootrom, next_request, NEXT_REQ_TIMEOUT_MS);
  
  	return ret;
-- 
1.9.1

