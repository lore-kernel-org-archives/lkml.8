Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0454BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4B222073E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="roxDTnsx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgFKTKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 15:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgFKTKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:10:23 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6842C08C5C2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:10:22 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c3so7275398wru.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IDjXCIQ6oy9AG2/pAkYufwb6REFjjpJ4B8gnt4Zt3Qc=;
        b=roxDTnsx93wtEbhdmNp/ObyGhmi+f3+VAw9dB/+c4wPouQTJejpLzI43QCaztDmC76
         FsQYssZM6YdWtBpc/xye5/PPeT9fkympjTFzq2LlJzFpQWjy/NMhLZLRqNmIAwuSLdl+
         0XyU6ubyiAgi5zkeNVhRLVnIPobMvU+jyMKAt+oGBme/DkkLKL5A6GncPcRLcHPI6JpO
         KXBhng/PcNI/BBcMbs+RAD45GuBtOZcICXDRZ2RqV1cnEsgS+X9K1K3nUB5XHYCioiG5
         3ARROCFXZ4ay8C1CJncLXslWG6uk2W3/pf6uTssMvCu6AoA8e3vjPGw7MSJ8FkpWN1At
         ufhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IDjXCIQ6oy9AG2/pAkYufwb6REFjjpJ4B8gnt4Zt3Qc=;
        b=FSoLAKL2GUc+KL/M9W0//tLTVZHK/TamX69o/hiF+top6HpEpapLguZfFsJVMQjXda
         v65GKb+Mm4Yc6haasu7V0TMKTSXxDhPWof7aU64yDDEcnWhKEZUs4u+G2an5xnw0yfFb
         OL4Q/HD4tQznPGl87uKGpYSGSjKo5ucKsVQI38Xcd7OqvtGezus7QzdygBQSouQyxMie
         IHFT99856ValKL1nXcJhhb7y9hu8KxkAS8XJOFimWyK58xz3v76uxo/cf2Sbsb4zvOQt
         kHQoa0G7ALg3FhrdmpF+xJMXsVvT0FbyHTJV9jHEAauw6BbucYBkF/s8YU4cxfbvIAZ5
         gvfQ==
X-Gm-Message-State: AOAM533ElfSi1GYqw12RCs4ID4dhVu/4hxzBuJk0cepKbmmte21+ezlO
        GHkFSLu4Aaj1DivfLWR/07Vyvw==
X-Google-Smtp-Source: ABdhPJxIRvyeatyC1UQ1W9xf4a6D082xrhYZ0Tc1eoIVTbGiHfuzVmpVOlfwI45cj2a0wndw/BO7cg==
X-Received: by 2002:a5d:4008:: with SMTP id n8mr10771319wrp.82.1591902621670;
        Thu, 11 Jun 2020 12:10:21 -0700 (PDT)
Received: from localhost.localdomain ([2.27.167.101])
        by smtp.gmail.com with ESMTPSA id 128sm5658097wme.39.2020.06.11.12.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 12:10:20 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     andy.shevchenko@gmail.com, michael@walle.cc, robh+dt@kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux@roeck-us.net,
        andriy.shevchenko@linux.intel.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 2/3] mfd: core: Fix formatting of MFD helpers
Date:   Thu, 11 Jun 2020 20:10:01 +0100
Message-Id: <20200611191002.2256570-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200611191002.2256570-1-lee.jones@linaro.org>
References: <20200611191002.2256570-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary '\'s and leading tabs.

This will help to clean-up future diffs when subsequent changes are
made.

Hint: The aforementioned changes follow this patch.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 include/linux/mfd/core.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index a148b907bb7f1..ae1c6f90388ba 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -26,20 +26,20 @@
 		.id = (_id),						\
 	}
 
-#define OF_MFD_CELL(_name, _res, _pdata, _pdsize,_id, _compat)		\
-	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, NULL)	\
+#define OF_MFD_CELL(_name, _res, _pdata, _pdsize,_id, _compat) \
+	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, NULL)
 
-#define ACPI_MFD_CELL(_name, _res, _pdata, _pdsize, _id, _match)	\
-	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, _match)	\
+#define ACPI_MFD_CELL(_name, _res, _pdata, _pdsize, _id, _match) \
+	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, _match)
 
-#define MFD_CELL_BASIC(_name, _res, _pdata, _pdsize, _id)		\
-	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, NULL)	\
+#define MFD_CELL_BASIC(_name, _res, _pdata, _pdsize, _id) \
+	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, NULL)
 
-#define MFD_CELL_RES(_name, _res)					\
-	MFD_CELL_ALL(_name, _res, NULL, 0, 0, NULL, NULL)		\
+#define MFD_CELL_RES(_name, _res) \
+	MFD_CELL_ALL(_name, _res, NULL, 0, 0, NULL, NULL)
 
-#define MFD_CELL_NAME(_name)						\
-	MFD_CELL_ALL(_name, NULL, NULL, 0, 0, NULL, NULL)		\
+#define MFD_CELL_NAME(_name) \
+	MFD_CELL_ALL(_name, NULL, NULL, 0, 0, NULL, NULL)
 
 struct irq_domain;
 struct property_entry;
-- 
2.25.1

