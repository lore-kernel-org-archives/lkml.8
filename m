Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7ADC43446
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 274DB20787
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PM/T9mUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbgGPOBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbgGPN7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:59:40 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0B7C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:40 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id o8so10402081wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fj2Sj0XBOTrpGgH9u3LbiKzQE/KWClevdkHkCrkv1Yg=;
        b=PM/T9mUg57/CuVzSIuFJHVpwMZAsIApx9CGqyg4/eDIC/7dh9PlknGvhE+A+c7966q
         XybA6myfzfBuH/Qh+OX1ITKny8XjO5LLjfsFV/fYTP9VMB5rmlvpW3iQsQuj8CITWU3h
         jx97ObdkSLVlMbtORCmzu6vjidAYr+koJ+vGxd6udM4RZnXcrx2mGhZkzYwCBntnXg3e
         mW/gVTm2uoeLOtllsIa/q8FTPSiXXd9ce7yyleepQoME4liFOQn5OUlCWrbtmqkK3imr
         URy4fSosY1s0usmRsDFnkdkpLHNHYKXWKI9DgAhON/D+z9hadcuNobUG+pSlu75aJuQC
         8Tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fj2Sj0XBOTrpGgH9u3LbiKzQE/KWClevdkHkCrkv1Yg=;
        b=GTHZ+UiSaTVSnHa2UnMm6S/HpkvOjYKuwp5v9oIp/CPDdHOPQB/ga5DUM0TtcZku9C
         DBt6oD5Zs2bOvfiU6LgFnuM0KhJbSi/2MN4r50h2Ml/L1yLH/t4lCsc4CqoXWILO5VZH
         C27q4js0gPG0qWYAuYmKQ4ykRLSBvLlf9sZFRMB4iwzs+Knxhe068JKaLCArcFCSI1+t
         Eu4PGjeEFuI0/2rwOamSNIvd0ctGXPvzAs8Mk9qxPngfGGh5gTyaqpkzYC7lP4rkAKUL
         So+sKAfaHzORncTwd6T7jvQK1Bpfo6Sx/hTqg5lWLWNB/sS5/Ybbl11AhGBgyqEMnm7F
         o3qg==
X-Gm-Message-State: AOAM531skO6d0OagII+KvXrM7RinZN7HmBvdLZIkhLEVDssWEHTZYOQo
        7BD6sRG68F3PLa9GtR5frL5gZg==
X-Google-Smtp-Source: ABdhPJyySGT29h69n7yXJV4PeAehRLjC+H/BTtk2NLBpgHq2750weLnkYpp73TD509FUkx9aIrc1cw==
X-Received: by 2002:a1c:14e:: with SMTP id 75mr4753360wmb.151.1594907979060;
        Thu, 16 Jul 2020 06:59:39 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:38 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Patrick Vasseur <patrick.vasseur@c-s.fr>
Subject: [PATCH 06/30] iio: adc: ad7923: Demote obvious misuse of kerneldoc to standard comment blocks
Date:   Thu, 16 Jul 2020 14:59:04 +0100
Message-Id: <20200716135928.1456727-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document either of the demoted functions here

Fixes the following W=1 kernel build warning(s):

 drivers/iio/adc/ad7923.c:159: warning: Function parameter or member 'indio_dev' not described in 'ad7923_update_scan_mode'
 drivers/iio/adc/ad7923.c:159: warning: Function parameter or member 'active_scan_mask' not described in 'ad7923_update_scan_mode'
 drivers/iio/adc/ad7923.c:202: warning: Function parameter or member 'irq' not described in 'ad7923_trigger_handler'
 drivers/iio/adc/ad7923.c:202: warning: Function parameter or member 'p' not described in 'ad7923_trigger_handler'

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Patrick Vasseur <patrick.vasseur@c-s.fr>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/adc/ad7923.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 1d124c87c6ace..2a11bc7fdb567 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -151,9 +151,9 @@ static const struct ad7923_chip_info ad7923_chip_info[] = {
 	},
 };
 
-/**
+/*
  * ad7923_update_scan_mode() setup the spi transfer buffer for the new scan mask
- **/
+ */
 static int ad7923_update_scan_mode(struct iio_dev *indio_dev,
 				   const unsigned long *active_scan_mask)
 {
@@ -192,12 +192,12 @@ static int ad7923_update_scan_mode(struct iio_dev *indio_dev,
 	return 0;
 }
 
-/**
+/*
  * ad7923_trigger_handler() bh of trigger launched polling to ring buffer
  *
  * Currently there is no option in this driver to disable the saving of
  * timestamps within the ring.
- **/
+ */
 static irqreturn_t ad7923_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
-- 
2.25.1

