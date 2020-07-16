Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA75C433EB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ED5B207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xxL5Ag3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729337AbgGPOBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgGPN7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:59:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72953C08C5E0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so7094261wrj.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xS5iaY7lfvInFgzdYtfbJOMULW0PjIgmtSXBGbeSKP0=;
        b=xxL5Ag3IresWgQw0UNbgMhC8UUPDoSjfaeodJ14sFm3DDAPplrnoea1LlKXlrLmsSQ
         H+ViunaN8TaBXhiQ42uSBOBQRJ/Tj3qVHVpYLEHkqg0B+ykx75a69k+HK9wM9pxRgzbQ
         msvRRgeMRBI4z5xmbL1p8sMLUjz13LItqneeEcZ+WBLqTS+1BQsTTyVb80iy6I5fQGkq
         bT1NyvWPobGdkt7RYGfQhv6DWxOF/p3vcoVx9zOS4/MtVofe2FEDHLt2LmNX6JLbRvuE
         o0ycpNrLICFEj+hNnlyYRW2z3KmklAnWHiES2PuwZrizhLE/6BmBbWfXLW6nYaeQedpB
         yxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xS5iaY7lfvInFgzdYtfbJOMULW0PjIgmtSXBGbeSKP0=;
        b=hlukCIiSrL9U0/jf3EKs25VDh57moU46lrplfAVRCsA21WQll/kSaYpJSZTF11LplA
         UAvW4DiWC2gcL1qJ9tP1bwiInSnH2iEdfQVaYi0USVmdo+vZ3L4YhsXBwHWuh2ypl/0R
         adqbVn+UnIB1N8mVz9abTVAWj570zcYeS/Llm67084xj3EiLuukEROQQdFBIcNJq71D0
         HVsO+1PBrSqQcFxUdj+o6+cN4lnqyf1otHDCnerH6PMize2zOdnVCqHXfrHnB9+5A9DL
         wBVqbKgMoQThvmCqLA/9/D4KqoHB7b8M8+a7PDvx1qjYbVeTV2iMLZxLNq2ZPGZJrJE8
         2xCA==
X-Gm-Message-State: AOAM530w9QOeQQGWJU5D5nAC81/a+RcZPLLm6f3PcSOVCy13qZkQEgsI
        R+LcXYRyx2gqUUGMxdQO0/MxPg==
X-Google-Smtp-Source: ABdhPJz+3bOsT4wSiHZeM6v8NBbP0nQ87ipkThT9NtG3fkIz00axC34VQ9CXjTVwPymWMRsbdcNijg==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr5144226wru.310.1594907989226;
        Thu, 16 Jul 2020 06:59:49 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:48 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 14/30] iio: dac: ad5064: Value returned by ad5064_vref_name may not be 'const * const'
Date:   Thu, 16 Jul 2020 14:59:12 +0100
Message-Id: <20200716135928.1456727-15-lee.jones@linaro.org>
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

 drivers/iio/dac/ad5064.c:790:8: warning: type qualifiers ignored on function return type [-Wignored-qualifiers]
 790 | static const char * const ad5064_vref_name(struct ad5064_state *st,
 | ^~~~~

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dac/ad5064.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5064.c b/drivers/iio/dac/ad5064.c
index d33642de9720e..303f6d1a5f311 100644
--- a/drivers/iio/dac/ad5064.c
+++ b/drivers/iio/dac/ad5064.c
@@ -787,7 +787,7 @@ static const char * const ad5064_vref_names[] = {
 	"vrefD",
 };
 
-static const char * const ad5064_vref_name(struct ad5064_state *st,
+static const char *ad5064_vref_name(struct ad5064_state *st,
 	unsigned int vref)
 {
 	return st->chip_info->shared_vref ? "vref" : ad5064_vref_names[vref];
-- 
2.25.1

