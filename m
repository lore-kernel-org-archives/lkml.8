Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C476C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 648DC2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lFmz9hEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404331AbgFXPHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404237AbgFXPHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:07:23 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78A9C061798
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:07:22 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h15so2631231wrq.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 08:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HqgBI5p9cdp/gbRtc5/Vf5SqfkaArMfvY8eaitdy6zc=;
        b=lFmz9hEr/UQJ+lwMW8roCnq3g4o/1IdbpIbo0yOY9Gr1j8oubjm/YxUQtoUtEG4z0u
         iDnDFflx74sHdoX4yqDg6oV4pfxet8NvFU2/FHLuALUQr3an4yKs9S+Fs79eIDpc3dcb
         JtXFXWW12p27qVi6qpB5nk9/t1ogYLmnsm7xyLKp4i3FT22qLqFqH+ICOvXShxjlQnys
         fqySQyjcMI+FVhbec+8k44RhRNFhvVdmz31l5lW8qOFH+vEQucZDKToab5H7wXcx15lc
         lpA6UmZdV5LtxK5uhrMDob/Slw1ZsJUiIbWJiEEXLvXoJKmphPdN8AP4XYBMgBlADmQW
         sBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HqgBI5p9cdp/gbRtc5/Vf5SqfkaArMfvY8eaitdy6zc=;
        b=E+9TjXk7vxGsIrxp8nhWTIi6bexIczj/DXT4EUGXYi/AMseYXp8ZU+GjEu9VWwZPgD
         9+mS3n0euaDdV1Xlc10Tc9dC9sS/SgDPnNB9+maSEabulQ4+PCaJ91cghi+hUPq6QuyH
         pxT1KQdmIZ79RDsLKPPXMyyZHlJqOXwd7w1BTUx6OXLSCMzPUgD4mhya/Mr7UMOAN2mr
         /OAlgBNSE2KA5q249Hei4ABQX/5K54VZV1PxqiJhyW6Y22P27ufetxY7zQnHRepZw9IR
         0lMPVNaStDH6SvvZEStbtgUS0t8p0qrZRaDugy1H8tPAwQKSSGECGzUbzUqsz9dvR3YP
         aGmA==
X-Gm-Message-State: AOAM532TQ7BmM29T62ug3iYZUl8JCEDI4xmpDmB2sYB/rIe7ZuProfw1
        ZEweh8Vfxpg1yCv4tuWlt3VcJg==
X-Google-Smtp-Source: ABdhPJwOvWTMTp+xIS2/s8zG18Vu4DqV2sM9Odv7Zzraz2b8w8qwdPgvlZ7TBTtcClG7K1YLPU2I8A==
X-Received: by 2002:a05:6000:10c4:: with SMTP id b4mr18542660wrx.50.1593011241512;
        Wed, 24 Jun 2020 08:07:21 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id h14sm11543361wrt.36.2020.06.24.08.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 08:07:21 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 08/10] mfd: tc3589x: Remove invalid use of kerneldoc syntax
Date:   Wed, 24 Jun 2020 16:07:02 +0100
Message-Id: <20200624150704.2729736-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200624150704.2729736-1-lee.jones@linaro.org>
References: <20200624150704.2729736-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc is for documenting function arguments and return values.

Prevents warnings like:

 drivers/mfd/tc3589x.c:32: warning: Enum value 'TC3589X_TC35890' not described in enum 'tc3589x_version'
 drivers/mfd/tc3589x.c:32: warning: Enum value 'TC3589X_TC35892' not described in enum 'tc3589x_version'
 drivers/mfd/tc3589x.c:32: warning: Enum value 'TC3589X_TC35893' not described in enum 'tc3589x_version'
 drivers/mfd/tc3589x.c:32: warning: Enum value 'TC3589X_TC35894' not described in enum 'tc3589x_version'
 drivers/mfd/tc3589x.c:32: warning: Enum value 'TC3589X_TC35895' not described in enum 'tc3589x_version'
 drivers/mfd/tc3589x.c:32: warning: Enum value 'TC3589X_TC35896' not described in enum 'tc3589x_version'
 drivers/mfd/tc3589x.c:32: warning: Enum value 'TC3589X_UNKNOWN' not described in enum 'tc3589x_version'

Cc: <stable@vger.kernel.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/tc3589x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tc3589x.c b/drivers/mfd/tc3589x.c
index 67c9995bb1aa6..7882a37ffc352 100644
--- a/drivers/mfd/tc3589x.c
+++ b/drivers/mfd/tc3589x.c
@@ -18,7 +18,7 @@
 #include <linux/mfd/tc3589x.h>
 #include <linux/err.h>
 
-/**
+/*
  * enum tc3589x_version - indicates the TC3589x version
  */
 enum tc3589x_version {
-- 
2.25.1

