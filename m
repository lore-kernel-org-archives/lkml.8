Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E7AC433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 14:26:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB1E6208E4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 14:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maMritpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgGDO0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 10:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGDO0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 10:26:10 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB70C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 07:26:10 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t15so727452pjq.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 07:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=sJThXt18vj76dxg1XcYlMwFo2sABsgrySSJXPsuoOYY=;
        b=maMritpNagy30HECmq6aoOT2GspL3it8/9m5yAxAVDOG8QZocql/yeZ2/WNGd8lUVa
         u+XXqRTIpdF1HoajLLLk1rm8R5FfBBKc3CEbM7KZVIlwXJeT2RshCn5nNRj+jZpc52vQ
         Zt3FPqA7ZNPpXTXgVPyVgrBFG2YdMcAXW/i3XQlOWprHufsPXXk9WVCqBgxwYFiqfNhE
         ro6chsTbVP1hAThtuXxCOLjGmt2KnV5NHsC1MGE9HWyTNrEH4ZJALLEtYlyL2ksrQyGV
         UTvNpeOxkd0DZSsxohxpcbTuaW/PMuWiciJUl3QtiBRJUjOrEbQKJfiOuzG4a2pFCzhO
         Ip4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=sJThXt18vj76dxg1XcYlMwFo2sABsgrySSJXPsuoOYY=;
        b=ItZXbhnNpJ9nuXjXDXZmpIZJ2l6PGqoIi86aInmuipEGN1fPiQ67h2JZCqx8NV0+Ji
         tmvj3nOpPsZPi6Dp6+IjVl40DHrnqAkFN9HOLEfWHCdj9Ra4swcXHtgWAhlBdJmtcZsD
         TQm7jhdHrulX3ag7D0bQunsGCX4nztlb+7Szax2ESCjgxdWAgEUajpXsQEPM/BNXq+L6
         rkabFPv40S/WTjWVacZ7ukKPDbnDKw5xq5En1YObsMsizxRvCMe8cXQTn8dDZu97PM7v
         zfaNX8Hco9wQzXvEPZieQnxcs7QacMe5W3zdmRvoRW8DRA/Ia9+kv4jr5lSn0fh7iv2H
         joxQ==
X-Gm-Message-State: AOAM533yhufdIVOIru6oQSc79p71JMoNkAcIZYwQryjOncPrQ5SYs5OC
        5Rbuwf5hcx65xuqJZXDc1Kw=
X-Google-Smtp-Source: ABdhPJya3qQ8oSRMdsfXQr3Ni068EwPYVbgNPhChuYbXVTZaro9XU9XytC2v5Qb04uhykrPqdBvvJQ==
X-Received: by 2002:a17:902:d896:: with SMTP id b22mr35085917plz.87.1593872770214;
        Sat, 04 Jul 2020 07:26:10 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t1sm15022776pgq.66.2020.07.04.07.26.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Jul 2020 07:26:09 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Benson Leung <bleung@chromium.org>, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH] platform/chrome: cros_ec_proto: Convert EC error codes to Linux error codes
Date:   Sat,  4 Jul 2020 07:26:07 -0700
Message-Id: <20200704142607.171400-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The EC reports a variety of error codes. Most of those, with the exception
of EC_RES_INVALID_VERSION, are converted to -EPROTO. As result, the actual
error code gets lost. Convert all EC errors to Linux error codes to report
a more meaningful error to the caller to aid debugging.

Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/platform/chrome/cros_ec_proto.c | 37 +++++++++++++++++++------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 3e745e0fe092..10aa9e483d35 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -543,6 +543,29 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 }
 EXPORT_SYMBOL(cros_ec_cmd_xfer);
 
+static const int cros_ec_error_map[] = {
+	[EC_RES_INVALID_COMMAND] = -EOPNOTSUPP,
+	[EC_RES_ERROR] = -EIO,
+	[EC_RES_INVALID_PARAM] = -EINVAL,
+	[EC_RES_ACCESS_DENIED] = -EACCES,
+	[EC_RES_INVALID_RESPONSE] = -EPROTO,
+	[EC_RES_INVALID_VERSION] = -ENOTSUPP,
+	[EC_RES_INVALID_CHECKSUM] = -EBADMSG,
+	[EC_RES_IN_PROGRESS] = -EINPROGRESS,
+	[EC_RES_UNAVAILABLE] = -ENODATA,
+	[EC_RES_TIMEOUT] = -ETIMEDOUT,
+	[EC_RES_OVERFLOW] = -EOVERFLOW,
+	[EC_RES_INVALID_HEADER] = -EBADR,
+	[EC_RES_REQUEST_TRUNCATED] = -EBADR,
+	[EC_RES_RESPONSE_TOO_BIG] = -EFBIG,
+	[EC_RES_BUS_ERROR] = -EFAULT,
+	[EC_RES_BUSY] = -EBUSY,
+	[EC_RES_INVALID_HEADER_VERSION] = -EBADMSG,
+	[EC_RES_INVALID_HEADER_CRC] = -EBADMSG,
+	[EC_RES_INVALID_DATA_CRC] = -EBADMSG,
+	[EC_RES_DUP_UNAVAILABLE] = -ENODATA,
+};
+
 /**
  * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
  * @ec_dev: EC device.
@@ -555,8 +578,7 @@ EXPORT_SYMBOL(cros_ec_cmd_xfer);
  *
  * Return:
  * >=0 - The number of bytes transferred
- * -ENOTSUPP - Operation not supported
- * -EPROTO - Protocol error
+ * <0 - Linux error code
  */
 int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 			    struct cros_ec_command *msg)
@@ -566,13 +588,12 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 	ret = cros_ec_cmd_xfer(ec_dev, msg);
 	if (ret < 0) {
 		dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
-	} else if (msg->result == EC_RES_INVALID_VERSION) {
-		dev_dbg(ec_dev->dev, "Command invalid version (err:%d)\n",
-			msg->result);
-		return -ENOTSUPP;
 	} else if (msg->result != EC_RES_SUCCESS) {
-		dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg->result);
-		return -EPROTO;
+		if (msg->result < ARRAY_SIZE(cros_ec_error_map) && cros_ec_error_map[msg->result])
+			ret = cros_ec_error_map[msg->result];
+		else
+			ret = -EPROTO;
+		dev_dbg(ec_dev->dev, "Command result (err: %d [%d])\n", msg->result, ret);
 	}
 
 	return ret;
-- 
2.17.1

