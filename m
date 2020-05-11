Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88C9C54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94598207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mf4oTEHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbgEKNOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730177AbgEKNOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:14:45 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D1DC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:14:43 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f18so9405397lja.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NUI8ReX5/Xpd2JtmMzMM9tmFtAIP0fE4oQnYr/awLr4=;
        b=Mf4oTEHJWwSVTn10OhDNWzpklozAK40LfcyfvQ9AbRpvTcuDFjkPFSTgO5oWQGfh5G
         +OoMFOjdEjCxi0z+ObuIxNswHw0bhXDyGkWNUTl69wkl7eYP5ORiOyP2SOSw9ZJh07J5
         t+Oeb77OKHbJQUcoGRbrxOJ0aX4BaIrOSX6Gmx2mOf6ABEKoPNrx83Mhn4TJmXvDdFNS
         sIhm5SpMofg5+pMCXVr1TB1bXdsDsd3Ayye8nOQNw3FhfcwSdzS7y7eDiy2IO/Q1qiJJ
         vjVa4x33tXG/P4XoV1zIpzeIOqROR8PMYTxcAcMVSQZMne9Bl7un44l5nMcX9BxiLTyq
         StWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NUI8ReX5/Xpd2JtmMzMM9tmFtAIP0fE4oQnYr/awLr4=;
        b=NVP8z4D6c8R4DVZOcFhJC30zuEWFSz9J/QUFavA3z/16kjSFPwfHM+sa+Sn8jh/K4H
         oR0KKjov9wCdJPXYvK8o7B7ySAKBQI9geQXU7Kv8dSIeJUh8zPjhB4uXBqmDk4GxuuA4
         3jdmEmBOAmh1oc9VZZc6YHZ6azhufKIzu4t7814ooN2XL14XpyV2qzHZIp1TU49gGZli
         CW/JedicJeKCqCDGSGiYR4MRSPaCZ78qbMmRuYnlbW1t0k2duNqRae704WDhxD4XqWIZ
         Nwit3zkeaO0BmGbCMVa1likvNUfyeRgOuMDmnqahqDBDAxmhy/Y0sssPFrWEpSZR9It2
         nFNg==
X-Gm-Message-State: AOAM532l5QFcevrO0CqycToGywH3PlrZT4TlDKZurITSJUtzejs7OPsW
        /6IU9suVGY5KNu+17Z4QSLD8+A==
X-Google-Smtp-Source: ABdhPJy2dZ6Y0VUcG0irmoqyiuwPNOkxYOUJZjg40KYU72VLIUApg9pgi+sw8OwzBxDCJ0ulK7v34g==
X-Received: by 2002:a2e:7412:: with SMTP id p18mr9935005ljc.256.1589202882058;
        Mon, 11 May 2020 06:14:42 -0700 (PDT)
Received: from localhost (c-8c28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.140])
        by smtp.gmail.com with ESMTPSA id r2sm9984936ljm.8.2020.05.11.06.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 06:14:41 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     john.johansen@canonical.com, jmorris@namei.org, serge@hallyn.com,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        brendanhiggins@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-security-module@vger.kernel.org,
        elver@google.com, davidgow@google.com,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH v3 5/6] fs: ext4: default KUNIT_* fragments to KUNIT_ALL_TESTS
Date:   Mon, 11 May 2020 15:14:38 +0200
Message-Id: <20200511131438.29953-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it easier to enable all KUnit fragments.

Adding 'if !KUNIT_ALL_TESTS' so individual tests can not be turned off.
Therefore if KUNIT_ALL_TESTS is enabled that will hide the prompt in
menuconfig.

Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 fs/ext4/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index 2a592e38cdfe..bc7815158503 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -103,9 +103,10 @@ config EXT4_DEBUG
 		echo 1 > /sys/module/ext4/parameters/mballoc_debug
 
 config EXT4_KUNIT_TESTS
-	tristate "KUnit tests for ext4"
+	tristate "KUnit tests for ext4" if !KUNIT_ALL_TESTS
 	select EXT4_FS
 	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
 	  This builds the ext4 KUnit tests.
 
-- 
2.20.1

