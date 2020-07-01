Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71ACC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4BAF207D0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LtzDURPA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgGAIcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbgGAIb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:58 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6939C03E97A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:57 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so21477231wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wkBklcgolThuSqx2B9FGDRJ2fQUF+10AbLJBzITnPbk=;
        b=LtzDURPA3UqAHJJlQZXZ4Im180vDOVf//S1nJ+4pKvBLZrgZ0BSbM4WzbEGYE1yjtk
         qYlbioS4BBKmdMJ58FMXd2IKFLG1YqsxWeHL9PLbQ9GZTGP4nbfZ+6qAi4b/MR7gmo6E
         Cd7yxYzL0lVRteVBWqtQvoUtB6heNxct3UPO1Fbsa0XweiOxkw1hrlwYht2NwUdjmp8r
         9D3PPv5ogLhvIsv6qiXm8/wubsGmmWf7/ZDjXT+z2A9MlWAwmatijI5jV2VsKH0l+nIp
         Y1+jhuV8JZlxPSSJzbJlUB8rw5rQZGsL2B7PP/j0tJqg4o0JEUSY6XWFioWb3evpAdIe
         V31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wkBklcgolThuSqx2B9FGDRJ2fQUF+10AbLJBzITnPbk=;
        b=cREPtzkcv921DRiFJXeZeCL61jrJ+jeXQn+T28Exoq7rLRwRf0Nonq6Hf9zUzajyE6
         zTQBsku0uxQRBi2yhNd+nQHp5yvSKc2mqcNcr+puwCdmqU8lcLdfcEwjbfMBgDvT/NYq
         hh20H/VTGv8uuEEg0jOVl4CVZ9MAkSkjG/5XnfjD+FoLrJ72DmziKhRi78YCUVXkrwaM
         w2B1/zYWcF7eE88NnbxTekewT9AcW01d4Gjor1iAIZmdQ/67Z2YvcNmvoaOuFP/KcDpH
         eItsrSBsF5ehubHulsvmIlfx+X9l1VytFj5Z6mytpLYv21b9pfflBLSCJNOt4Vf19AkA
         IElQ==
X-Gm-Message-State: AOAM533HB0Po2fwqtpE9ymhcnwhCeAXvKKiaFiF0WcFTPipaOYB/0iLt
        zmb6y9Jxvb7xqEzrpYX9EB9yiA==
X-Google-Smtp-Source: ABdhPJyENdo7ISE62kR3pGvu0NxL7io4Snel4VVQn2CmhOlTdSs8TUoC2Dp1mmRo8kUNBTyzgERkaA==
X-Received: by 2002:a7b:c09a:: with SMTP id r26mr25108034wmh.176.1593592316584;
        Wed, 01 Jul 2020 01:31:56 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:55 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 28/30] misc: ocxl: config: Provide correct formatting to function headers
Date:   Wed,  1 Jul 2020 09:31:16 +0100
Message-Id: <20200701083118.45744-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701083118.45744-1-lee.jones@linaro.org>
References: <20200701083118.45744-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A nice attempt was made to provide kerneldoc headers for
read_template_version() and read_afu_lpc_memory_info() however,
the provided formatting does not match what is expected by
kerneldoc.

Fixes the following W=1 warnings:

 drivers/misc/ocxl/config.c:286: warning: Function parameter or member 'dev' not described in 'read_template_version'
 drivers/misc/ocxl/config.c:286: warning: Function parameter or member 'fn' not described in 'read_template_version'
 drivers/misc/ocxl/config.c:286: warning: Function parameter or member 'len' not described in 'read_template_version'
 drivers/misc/ocxl/config.c:286: warning: Function parameter or member 'version' not described in 'read_template_version'
 drivers/misc/ocxl/config.c:489: warning: Function parameter or member 'dev' not described in 'read_afu_lpc_memory_info'
 drivers/misc/ocxl/config.c:489: warning: Function parameter or member 'fn' not described in 'read_afu_lpc_memory_info'
 drivers/misc/ocxl/config.c:489: warning: Function parameter or member 'afu' not described in 'read_afu_lpc_memory_info'

Cc: Frederic Barrat <fbarrat@linux.ibm.com>
Cc: Andrew Donnellan <ajd@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/ocxl/config.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
index c8e19bfb5ef90..e3b99a39d207e 100644
--- a/drivers/misc/ocxl/config.c
+++ b/drivers/misc/ocxl/config.c
@@ -273,11 +273,11 @@ static int read_afu_info(struct pci_dev *dev, struct ocxl_fn_config *fn,
 }
 
 /**
- * Read the template version from the AFU
- * dev: the device for the AFU
- * fn: the AFU offsets
- * len: outputs the template length
- * version: outputs the major<<8,minor version
+ * read_template_version - Read the template version from the AFU
+ * @dev: the device for the AFU
+ * @fn: the AFU offsets
+ * @len: outputs the template length
+ * @version: outputs the major<<8,minor version
  *
  * Returns 0 on success, negative on failure
  */
@@ -476,10 +476,10 @@ static int validate_afu(struct pci_dev *dev, struct ocxl_afu_config *afu)
 }
 
 /**
- * Populate AFU metadata regarding LPC memory
- * dev: the device for the AFU
- * fn: the AFU offsets
- * afu: the AFU struct to populate the LPC metadata into
+ * read_afu_lpc_memory_info - Populate AFU metadata regarding LPC memory
+ * @dev: the device for the AFU
+ * @fn: the AFU offsets
+ * @afu: the AFU struct to populate the LPC metadata into
  *
  * Returns 0 on success, negative on failure
  */
-- 
2.25.1

