Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7E4C433F2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEBB7206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ziAfVv30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgGPOAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729204AbgGPOAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:00:07 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB181C08C5DF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:00:06 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so10395581wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h9Q3bTJZX3NDvreJxnZXUAz4v4ayzBXDJ3tm0mtPNPY=;
        b=ziAfVv30fXS8ze8sJobKL6Wnl0wB5LcRq5zYNZN7QBBRgefFsBvPnonlKcGj9LW/0s
         Fz7UenrYVPmXFgcF6XEJI2lPgfmp7byFmPMaRc0P8v23DRrDMHjwL55+nx4BpIOMxvXe
         YGUFcKGaNCuAnjQ8nNUaRlHfwr9OP2T4hPh7mxIj/qkhOjp8hMbOmW1NLsQ1q5lMN3Z6
         d+3ibLeltB8dbDdNJOmHStX3p+QvjgvOBjlMOt4FLsqCFiRAy5MO7emnTiZ0c3cjo029
         G9mUyJCdjavWgZ4cG7vDvrQoTSzY4qyzr9qDXhy8IiPByiEMLJbsbqpXRv7baOPJQzjY
         NBXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h9Q3bTJZX3NDvreJxnZXUAz4v4ayzBXDJ3tm0mtPNPY=;
        b=dLui2QSaaqkBHuTxTsOtTsRFpfWupmszfPvXjcDv18hyEmfOEbUQs2s9UjGUiz5Gh3
         RMg+zOMGg86XRg1QrIOp5gCgkC3qYbxGoWWtu1oaIATmd5fxWN2TZwc4IENZARuYCO4a
         tHT/W3EbSvHhXMmw2FBnxW/IxQKMCdEEEWvwtNdBEGDHHlkU+f5c+pwl5rnsHDzHGcSq
         xAOXhz7szIHgM2rbbaekCmGD9pjVMLb8cUBzmwi0euEP0hvJD/p5fT7ZMG9nDdfMv/+f
         nmmPrH6oY/Zo5nzd7n7XndSVhPm/dXcFJH1XHsE/Nf5q3mSFbDe8by/DY0bUSnZmUjJT
         4aPA==
X-Gm-Message-State: AOAM531vonToWQ6qUTzNahzNV4tisEhV1uYVdNSpNzPp689YgNLwoCLl
        MVp55ouQQKOYm2u9fOQLjlMCqw==
X-Google-Smtp-Source: ABdhPJybrr9cAklwujn3fxx1mowY6xGoBHDpPn3WqQCQ9G7qVh+ValpUYqPhWju9zlFPKh56e05p8Q==
X-Received: by 2002:a1c:790c:: with SMTP id l12mr4442466wme.50.1594908005504;
        Thu, 16 Jul 2020 07:00:05 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.07.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 07:00:04 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Kevin Tsai <ktsai@capellamicro.com>
Subject: [PATCH 27/30] iio: light: cm32181: Fix formatting and docrot issues in cm32181_acpi_get_cpm()
Date:   Thu, 16 Jul 2020 14:59:25 +0100
Message-Id: <20200716135928.1456727-28-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/iio/light/cm32181.c:107: warning: Function parameter or member 'dev' not described in 'cm32181_acpi_get_cpm'
 drivers/iio/light/cm32181.c:107: warning: Function parameter or member 'obj_name' not described in 'cm32181_acpi_get_cpm'
 drivers/iio/light/cm32181.c:107: warning: Function parameter or member 'values' not described in 'cm32181_acpi_get_cpm'
 drivers/iio/light/cm32181.c:107: warning: Function parameter or member 'count' not described in 'cm32181_acpi_get_cpm'

Cc: Kevin Tsai <ktsai@capellamicro.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/light/cm32181.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 160eb3f99795e..9764099faef9a 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -93,10 +93,10 @@ static int cm32181_read_als_it(struct cm32181_chip *cm32181, int *val2);
 #ifdef CONFIG_ACPI
 /**
  * cm32181_acpi_get_cpm() - Get CPM object from ACPI
- * @client	pointer of struct i2c_client.
- * @obj_name	pointer of ACPI object name.
- * @count	maximum size of return array.
- * @vals	pointer of array for return elements.
+ * @dev:	pointer of struct device.
+ * @obj_name:	pointer of ACPI object name.
+ * @values:	pointer of array for return elements.
+ * @count:	maximum size of return array.
  *
  * Convert ACPI CPM table to array.
  *
-- 
2.25.1

