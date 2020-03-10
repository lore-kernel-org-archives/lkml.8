Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781E3C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BC76208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZYZ3dy3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731222AbgCJNX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:23:56 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55925 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730327AbgCJNXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:23:51 -0400
Received: by mail-wm1-f66.google.com with SMTP id 6so1380191wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 06:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qu2lw3ZMdrwKfuQS5Az0Y2I91d1iyT17fahD+FQIc7A=;
        b=GZYZ3dy3SH1F1KzpQL67050MlJI2B1XnreFQQisg5jZageYwSx1QdS87LMjWW1RTeZ
         MHlLxJkq7giYykvhYXPWlCN8Gf6a0BUC2Zgm/fudGoTGd8dp+QU5OdKx/e2JZV9XIdxv
         PESspqAEjvmZWmJ/PNzhQl10PZzfuKTz9PoJWf2vDCImhAB8A/HDg0SxvHHVwglaGz2I
         ec3bco1yfkbO7sqRbbTOf91rP0YYXzQ8/V9ai5+e1NMqbGX+is/6T35b4hBbcrGCkXyV
         k9K9ZM4UxsyrcoIHFy2fSCgcUMHXijDNFzxUq2XYF/OldB8dk+GWul4GjDjABhrtQ36b
         AxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qu2lw3ZMdrwKfuQS5Az0Y2I91d1iyT17fahD+FQIc7A=;
        b=E/L87VjxsoqqH3cuZzJDFc3PccEGS9urdm4Cs2NBWXjpcGfigrUocn6tngDE3VM4Sd
         Zn7Wm7sF+9z+kNnWQgQ5Y8Iei0XUFKDgPqydSMtL0GY+wXrVNaXEf30s9rR62iZmETYf
         SlnMmPIG6hwQdjO7zYqv0GrIuWXepDcmljh8HWtDJ3Yf0ljegYFRauYYkmFJHe0h1mMj
         QL1Yb8GTp+hucoPeJu9iQufZvAq0jf922Lj+zmY7zEETkHhJNFnSQriqXmdcc+qxSxVH
         jfF9NmLkbhvpQL3ASc+dAB/OP+lNNCl9DUnSM/KcovMlieKeHGoIieQZWh71JlCrB7eI
         xfLg==
X-Gm-Message-State: ANhLgQ3/zdEnaLTrxCkcWMKVszfNVrBkH5q9Nel/s1qFWtnJ8rQgQkgf
        qgsYhrLhsab80HccfPcriEkxAw==
X-Google-Smtp-Source: ADFU+vsnl10c74H/moJdIjTZh+FN9swVuA3axENgjSKxmCuMr1CqInUVB3P0Sn1hpo9YbIKGxtRPVw==
X-Received: by 2002:a7b:c204:: with SMTP id x4mr2255109wmi.20.1583846629385;
        Tue, 10 Mar 2020 06:23:49 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id s22sm3761199wmc.16.2020.03.10.06.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 06:23:48 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        kbuild test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        srinivas.kandagatla@linaro.org, prasannatsmkumar@gmail.com,
        malat@debian.org, paul@crapouillou.net
Subject: [PATCH 14/14] nvmem: jz4780-efuse: fix build warnings on ARCH=x86_64 or riscv
Date:   Tue, 10 Mar 2020 13:22:57 +0000
Message-Id: <20200310132257.23358-15-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
References: <20200310132257.23358-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>

kbuild-robot did find a type error in the min(a, b)
function used by this driver if built for x86_64 or riscv.

Althought it is very unlikely that this driver is built
for those platforms it could be used as a template
for something else and therefore should be correct.

The problem is that we implicitly cast a size_t to
unsigned int inside the implementation of the min() function.

Since size_t may differ on different compilers and
plaforms there may be warnings or not.

So let's use only size_t variables on all platforms.

Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: srinivas.kandagatla@linaro.org
Cc: prasannatsmkumar@gmail.com
Cc: malat@debian.org
Cc: paul@crapouillou.net
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/jz4780-efuse.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/jz4780-efuse.c b/drivers/nvmem/jz4780-efuse.c
index 51d140980b1e..512e1872ba36 100644
--- a/drivers/nvmem/jz4780-efuse.c
+++ b/drivers/nvmem/jz4780-efuse.c
@@ -72,9 +72,9 @@ static int jz4780_efuse_read(void *context, unsigned int offset,
 	struct jz4780_efuse *efuse = context;
 
 	while (bytes > 0) {
-		unsigned int start = offset & ~(JZ_EFU_READ_SIZE - 1);
-		unsigned int chunk = min(bytes, (start + JZ_EFU_READ_SIZE)
-					 - offset);
+		size_t start = offset & ~(JZ_EFU_READ_SIZE - 1);
+		size_t chunk = min(bytes, (start + JZ_EFU_READ_SIZE)
+				    - offset);
 		char buf[JZ_EFU_READ_SIZE];
 		unsigned int tmp;
 		u32 ctrl;
-- 
2.21.0

