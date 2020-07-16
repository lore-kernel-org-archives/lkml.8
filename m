Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CE9C433F7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D42C72082F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oumlQEnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729181AbgGPN74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbgGPN7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:59:47 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6F2C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o11so7172911wrv.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Cb+wSympQ/t7mvjSrlchyDpaG5lOzmi7hZ5OiAi8Mno=;
        b=oumlQEnIha+gPZ486gfCpU6mSvsOEk0BcYWvK8/hsanQRyIRhlTtGw1XHd1ZKAntb3
         zDCnA15Semh4CaC/EsmkpiGdRQuSj3HgP1HhW3Qv/aHf5Td42D9Z4s/uVHYp4Fjz1XM1
         OCw8fiy1rDDE/qdrqb3Agd4WT/q9uKQc/RTWRkahnyGhccuQbTeTdywSX3gDFBt+N6RP
         DaFDmvWjnPap3vH8zCePAv8eTD5BA3XtcLMJHhOkJsJKl+VNjLZYQmU18Xd05QLMfFk/
         Y1tiTBVpPgEEjfvv8u3az3bSjHw7AHyPFTQ8fjW2rJ/PXcQiEzZfbNXbvkPrCkOxV1R1
         +g+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cb+wSympQ/t7mvjSrlchyDpaG5lOzmi7hZ5OiAi8Mno=;
        b=YYZojj/9SD1An2oPsfgP5uHx0pYdVfDeG9XUPV0q2u+lUnRyf9KAye+ivE5jQyO+lo
         PsISdK5Al0FcFu59eqrxSl87IZ3umRIYrEQ4b3bc6NdiB/2rBh5TGZtYJ3Wt4wJJmiJO
         diR97PVnkptqxywrMmZpdM1M58rBH2EenSq829UluPHl0QpLO3DiKINIFwzt9o5sIX9S
         uqe90cX29yrI1gruYqEfpAul9f/aDeMpLosbjv+/gZEUJFZP5zLcgtO+zSOsjmmzLNSR
         cNLVO9lJdfiDon0uXu/Z701x9pOtpgz6NZ/hEjk1s1ZXYQ0zCzSHMw/Xhw/qcAXbSINX
         oIEw==
X-Gm-Message-State: AOAM530YVY4gcwD6psMNGowt9jyQVf8eJpkNCtqtVc7ck3Zy/vN+4z6p
        FG4vDa5PNfKFLKj+3UHUfFcdsg==
X-Google-Smtp-Source: ABdhPJzTCQ3Uui/xfkaXvBiqKU2DEubjel0BONeoSaNK/ek/9whacXXXBE4S96ii0ZuJ6/6OxW817g==
X-Received: by 2002:adf:81c7:: with SMTP id 65mr4973510wra.47.1594907984888;
        Thu, 16 Jul 2020 06:59:44 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:44 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 10/30] iio: dummy: iio_simple_dummy: Add newline after function-end
Date:   Thu, 16 Jul 2020 14:59:08 +0100
Message-Id: <20200716135928.1456727-11-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following checkpatch.pl warning(s):

 CHECK: Please use a blank line after function/struct/union/enum declarations
 #46: FILE: drivers/iio/dummy/iio_simple_dummy.c:690:
  }
 +/*
 total: 0 errors, 0 warnings, 1 checks, 22 lines checked

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dummy/iio_simple_dummy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index be66b26373723..cc4335963d0cf 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -687,6 +687,7 @@ static int iio_dummy_remove(struct iio_sw_device *swd)
 
 	return 0;
 }
+
 /*
  * module_iio_sw_device_driver() -  device driver registration
  *
-- 
2.25.1

