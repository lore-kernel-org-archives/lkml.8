Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC41C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5586D208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 15:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJHNPZGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgDQP0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 11:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728542AbgDQP0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 11:26:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A343BC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:26:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d1so1217755pfh.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 08:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DH5AjWb5Y/HC4rBu1O6z9vHzFuPiXlFK1AmlrEvjj1A=;
        b=AJHNPZGamNVhXj58t/rjjOmLiPwPhdg3Cmlp2SvMNpyIAXJg83bmi/2+TShr3PED4q
         Q+oIbSREwdqz6sKTkYNsDy+2g4NVIFHK+hEsTnRDyahOhREzVwCiKh4u1+/RYg+wzQOQ
         bvycfFGUVNCpF049Gd0ffo45Z61vIZ0AKjf6DNu+s1orFIeOqJKxRc4JOO2TozTMxLwX
         1GA/U1Hei91bRTglzUEw1StxZv3zDkxxZSzbThVAcXHfhyi6nDj5iRnX+q/TmiEd8yaL
         8GdEOVaSOQNcRMwbq62nPCxZN4zgYtesoUzRZgo0yaBpnCECDPgQWaIutlScWzOL7mfV
         Xoug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DH5AjWb5Y/HC4rBu1O6z9vHzFuPiXlFK1AmlrEvjj1A=;
        b=ev0jyNvdc8XHbP6uh2tM/e0CG+Sm8RbEDytHoX5wNtVBfzVi71AS0D9+HUwviJ6JMh
         NzkkSOo389TF/7S0yoQjzEYF1JaJsqnxUtlwID8fDo2twBveC0iYoE5NbqiHUtAUh8Tw
         x8bRZVPaYsrwbzjxgYx5RODHREBPYQts5cXxsmYmixmrL61gaOeGQ/tFQt1eNgfRczbz
         R9kk8gQCuwaQF+faM8E6OkV2EQqmBmR0nYUjiOfs5CheZtfbAd5sazrSWBT3IiDIjPAW
         FE/VrG2QgMTFdaXH1Ds1wKy5oYvatX/JFgH6gUJ27j7msFmYsrA07bbv1Y7f2/Ul+I3q
         Hajg==
X-Gm-Message-State: AGi0PuZNY6FY/zdKFs2gmgFOBgvBr0aP78TPgnDGgjQidNqNzdDzpSrR
        xA2hqFyv76lnRpkRZ+tQyUQ=
X-Google-Smtp-Source: APiQypKeRXG2E61w4rat3AOZywRaxqK4VdTTZAbbbIZ4/PWI3LoCg+td2GI0G3iPti4SdUu57/PgSg==
X-Received: by 2002:aa7:9f93:: with SMTP id z19mr3832007pfr.187.1587137199052;
        Fri, 17 Apr 2020 08:26:39 -0700 (PDT)
Received: from minnich.svl.corp.google.com ([2620:15c:2c5:3:65f9:fd8e:a0b8:2917])
        by smtp.googlemail.com with ESMTPSA id z6sm18265299pgg.39.2020.04.17.08.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 08:26:38 -0700 (PDT)
From:   "Ronald G. Minnich" <rminnich@gmail.com>
X-Google-Original-From: "Ronald G. Minnich" <rminnich@google.com>
Cc:     "Ronald G. Minnich" <rminnich@google.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Jethro Beekman <jethro@fortanix.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: spi-nor: controllers: intel-spi: Add support for command line partitions
Date:   Fri, 17 Apr 2020 08:26:11 -0700
Message-Id: <20200417152613.176554-1-rminnich@google.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Intel platforms, the usable SPI area is located several
MiB in from the start, to leave room for descriptors and
the Management Engine binary. Further, not all the remaining
space can be used, as the last 16 MiB contains firmware.

To make the SPI usable for mtdblock and other devices,
it is necessary to enable command line partitions so the
middle usable region can be specified.

Add a part_probes array which includes only "cmdelineparts",
and change to mtd_device_parse_register to use this part_probes.

Signed-off-by: Ronald G. Minnich <rminnich@google.com>
---
 drivers/mtd/spi-nor/controllers/intel-spi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/controllers/intel-spi.c b/drivers/mtd/spi-nor/controllers/intel-spi.c
index 61d2a0ad2131..132129e89d07 100644
--- a/drivers/mtd/spi-nor/controllers/intel-spi.c
+++ b/drivers/mtd/spi-nor/controllers/intel-spi.c
@@ -894,6 +894,8 @@ static const struct spi_nor_controller_ops intel_spi_controller_ops = {
 	.erase = intel_spi_erase,
 };
 
+static const char * const part_probes[] = { "cmdlinepart", NULL };
+
 struct intel_spi *intel_spi_probe(struct device *dev,
 	struct resource *mem, const struct intel_spi_boardinfo *info)
 {
@@ -941,7 +943,8 @@ struct intel_spi *intel_spi_probe(struct device *dev,
 	if (!ispi->writeable || !writeable)
 		ispi->nor.mtd.flags &= ~MTD_WRITEABLE;
 
-	ret = mtd_device_register(&ispi->nor.mtd, &part, 1);
+	ret = mtd_device_parse_register(&ispi->nor.mtd, part_probes,
+				       NULL, &part, 1);
 	if (ret)
 		return ERR_PTR(ret);
 
-- 
2.26.1.301.g55bc3eb7cb9-goog

