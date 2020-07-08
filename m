Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAD4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B48D206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20150623.gappssmtp.com header.i=@kernelci-org.20150623.gappssmtp.com header.b="HhHhUMfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgGHS7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgGHS7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:59:13 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5749C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 11:59:13 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id u185so18325077pfu.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 11:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:content-transfer-encoding:subject:to
         :from:cc;
        bh=ClsA6dEohOlMgD/rKh0xXnlfO2zfxDy9jgiTncGNw/s=;
        b=HhHhUMfCQnek8ldgdRLBd5RexZtOm0vB2Ks3R4yPXwXULCJiVAiD4xb1UVGCcWSwzi
         EdMUjWqoEWCh/ZfmnRZJ7OTw1wg7cM5/seWGhqpugmjQWdujoW+WogEG+TEHvMpQocPj
         iiOUa+ADUqCkxCaIhvwHsZ95ycYAH1ilGsW6DlwvYJBW2IY7O8HAxhHluC93jI2ZvBVG
         tBEEOP9rL7/v+1VHB/3MghKbOYKvXOI5oP49j998cOA7kFm1e6FdXVXKZDmq/NQMpGYm
         ohVbiwYamcCICtJiRCdjZcfsMBvVvNc/nA/TYQbd+R1LOs2jWcLExmw9SK8wYV9J551v
         Ys5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version
         :content-transfer-encoding:subject:to:from:cc;
        bh=ClsA6dEohOlMgD/rKh0xXnlfO2zfxDy9jgiTncGNw/s=;
        b=BWyCOC1w1lgKD7zOjx6NQjpIMwDUxsD2Jk3WpSVjLYSgj9B+h2govBdoWeYeRMMIrq
         xiI8B+VkF64QngjZFzdj7rds5ojvdF99b7dTuUodd2omGd++KIRMp52ThFx4X7vBKUTl
         PqCI07wgV12vKMXeimnJ/nKB4QZ6FNXw7/Zfuc7DEhbXc7Va+ybVzCrr9HSYBWGrf9rs
         0Wuy2oQ30mxahPK758+mRs2rRpworGMz2QEtsDt68YV+0qOEhhdPYingtyWEjzNqoNex
         BEaqwDiV1EfiEK02YGi75ZjU+WWeLEXZbgGUQKoUCENbdQhSznB1VC1sh0EFEGzxTHHN
         gIDw==
X-Gm-Message-State: AOAM5332gQGLcFP0DvL6DYrFwHWBd9RpLlmEnKQk7C8ite6/V+Jj6IKF
        kvlCziGctDw1rMXzPC4S5WQVjQ==
X-Google-Smtp-Source: ABdhPJxAXk7Ea8KL9vOn40pCfkB6sTQ7Vyu3ckccYEEU8UoMZB7GnczZ/4EHrK1eiH02QnVuiqYDdA==
X-Received: by 2002:a63:ea02:: with SMTP id c2mr50795064pgi.66.1594234752399;
        Wed, 08 Jul 2020 11:59:12 -0700 (PDT)
Received: from kernelci-production.internal.cloudapp.net ([52.250.1.28])
        by smtp.gmail.com with ESMTPSA id q7sm534722pfn.23.2020.07.08.11.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 11:59:11 -0700 (PDT)
Message-ID: <5f06177f.1c69fb81.ed8e4.1a92@mx.google.com>
Date:   Wed, 08 Jul 2020 11:59:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v5.8-rc1-20-g154353417996
X-Kernelci-Report-Type: bisect
X-Kernelci-Tree: chrome-platform
X-Kernelci-Branch: for-kernelci
X-Kernelci-Lab-Name: lab-collabora
Subject: chrome-platform/for-kernelci bisection:
 baseline.bootrr.rockchip-dp-probed on rk3399-gru-kevin
To:     gtucker@collabora.com, Guenter Roeck <linux@roeck-us.net>,
        kernelci-results@groups.io,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
From:   "kernelci.org bot" <bot@kernelci.org>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
* This automated bisection report was sent to you on the basis  *
* that you may be involved with the breaking commit it has      *
* found.  No manual investigation has been done to verify it,   *
* and the root cause of the problem may be somewhere else.      *
*                                                               *
* If you do send a fix, please include this trailer:            *
*   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
*                                                               *
* Hope this helps!                                              *
* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

chrome-platform/for-kernelci bisection: baseline.bootrr.rockchip-dp-probed =
on rk3399-gru-kevin

Summary:
  Start:      154353417996 KERNELCI: x86_64_defconfig: Enable support for C=
hromebooks devices
  Plain log:  https://storage.kernelci.org/chrome-platform/for-kernelci/v5.=
8-rc1-20-g154353417996/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-=
gru-kevin.txt
  HTML log:   https://storage.kernelci.org/chrome-platform/for-kernelci/v5.=
8-rc1-20-g154353417996/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-=
gru-kevin.html
  Result:     8c9a6ef40bf4 platform/chrome: cros_ec_proto: Convert EC error=
 codes to Linux error codes

Checks:
  revert:     PASS
  verify:     PASS

Parameters:
  Tree:       chrome-platform
  URL:        https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platfo=
rm/linux.git
  Branch:     for-kernelci
  Target:     rk3399-gru-kevin
  CPU arch:   arm64
  Lab:        lab-collabora
  Compiler:   gcc-8
  Config:     defconfig
  Test case:  baseline.bootrr.rockchip-dp-probed

Breaking commit found:

---------------------------------------------------------------------------=
----
commit 8c9a6ef40bf400c64c9907031bd32b59f9d4aea2
Author: Guenter Roeck <linux@roeck-us.net>
Date:   Sat Jul 4 07:26:07 2020 -0700

    platform/chrome: cros_ec_proto: Convert EC error codes to Linux error c=
odes
    =

    The EC reports a variety of error codes. Most of those, with the except=
ion
    of EC_RES_INVALID_VERSION, are converted to -EPROTO. As result, the act=
ual
    error code gets lost. Convert all EC errors to Linux error codes to rep=
ort
    a more meaningful error to the caller to aid debugging.
    =

    Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
    Cc: Prashant Malani <pmalani@chromium.org>
    Signed-off-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chr=
ome/cros_ec_proto.c
index 3e745e0fe092..10aa9e483d35 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -543,6 +543,29 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 }
 EXPORT_SYMBOL(cros_ec_cmd_xfer);
 =

+static const int cros_ec_error_map[] =3D {
+	[EC_RES_INVALID_COMMAND] =3D -EOPNOTSUPP,
+	[EC_RES_ERROR] =3D -EIO,
+	[EC_RES_INVALID_PARAM] =3D -EINVAL,
+	[EC_RES_ACCESS_DENIED] =3D -EACCES,
+	[EC_RES_INVALID_RESPONSE] =3D -EPROTO,
+	[EC_RES_INVALID_VERSION] =3D -ENOTSUPP,
+	[EC_RES_INVALID_CHECKSUM] =3D -EBADMSG,
+	[EC_RES_IN_PROGRESS] =3D -EINPROGRESS,
+	[EC_RES_UNAVAILABLE] =3D -ENODATA,
+	[EC_RES_TIMEOUT] =3D -ETIMEDOUT,
+	[EC_RES_OVERFLOW] =3D -EOVERFLOW,
+	[EC_RES_INVALID_HEADER] =3D -EBADR,
+	[EC_RES_REQUEST_TRUNCATED] =3D -EBADR,
+	[EC_RES_RESPONSE_TOO_BIG] =3D -EFBIG,
+	[EC_RES_BUS_ERROR] =3D -EFAULT,
+	[EC_RES_BUSY] =3D -EBUSY,
+	[EC_RES_INVALID_HEADER_VERSION] =3D -EBADMSG,
+	[EC_RES_INVALID_HEADER_CRC] =3D -EBADMSG,
+	[EC_RES_INVALID_DATA_CRC] =3D -EBADMSG,
+	[EC_RES_DUP_UNAVAILABLE] =3D -ENODATA,
+};
+
 /**
  * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
  * @ec_dev: EC device.
@@ -555,8 +578,7 @@ EXPORT_SYMBOL(cros_ec_cmd_xfer);
  *
  * Return:
  * >=3D0 - The number of bytes transferred
- * -ENOTSUPP - Operation not supported
- * -EPROTO - Protocol error
+ * <0 - Linux error code
  */
 int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 			    struct cros_ec_command *msg)
@@ -566,13 +588,12 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec=
_dev,
 	ret =3D cros_ec_cmd_xfer(ec_dev, msg);
 	if (ret < 0) {
 		dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
-	} else if (msg->result =3D=3D EC_RES_INVALID_VERSION) {
-		dev_dbg(ec_dev->dev, "Command invalid version (err:%d)\n",
-			msg->result);
-		return -ENOTSUPP;
 	} else if (msg->result !=3D EC_RES_SUCCESS) {
-		dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg->result);
-		return -EPROTO;
+		if (msg->result < ARRAY_SIZE(cros_ec_error_map) && cros_ec_error_map[msg=
->result])
+			ret =3D cros_ec_error_map[msg->result];
+		else
+			ret =3D -EPROTO;
+		dev_dbg(ec_dev->dev, "Command result (err: %d [%d])\n", msg->result, ret=
);
 	}
 =

 	return ret;
---------------------------------------------------------------------------=
----


Git bisection log:

---------------------------------------------------------------------------=
----
git bisect start
# good: [b3a9e3b9622ae10064826dccb4f7a52bd88c7407] Linux 5.8-rc1
git bisect good b3a9e3b9622ae10064826dccb4f7a52bd88c7407
# bad: [15435341799604f20adcbb5f69b7f0beb2a2f964] KERNELCI: x86_64_defconfi=
g: Enable support for Chromebooks devices
git bisect bad 15435341799604f20adcbb5f69b7f0beb2a2f964
# good: [3c5ca501b46b91e68b935b4bd752a0aba5232208] platform/chrome: cros_ec=
_spi: Document missing function parameters
git bisect good 3c5ca501b46b91e68b935b4bd752a0aba5232208
# good: [20b736872f7f324438649a277ec711a646ce8e8d] platform/chrome: cros_ec=
_typec: Add PM support
git bisect good 20b736872f7f324438649a277ec711a646ce8e8d
# bad: [8c9a6ef40bf400c64c9907031bd32b59f9d4aea2] platform/chrome: cros_ec_=
proto: Convert EC error codes to Linux error codes
git bisect bad 8c9a6ef40bf400c64c9907031bd32b59f9d4aea2
# good: [e48bc01ed5adec203676c735365373b31c3c7600] platform/chrome: cros_ec=
_sensorhub: Fix EC timestamp overflow
git bisect good e48bc01ed5adec203676c735365373b31c3c7600
# first bad commit: [8c9a6ef40bf400c64c9907031bd32b59f9d4aea2] platform/chr=
ome: cros_ec_proto: Convert EC error codes to Linux error codes
---------------------------------------------------------------------------=
----
