Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A125CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79F7B206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TTWz3kQi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388534AbgF3NwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388473AbgF3Nvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F12C08C5DD
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:45 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w3so7224317wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wkBklcgolThuSqx2B9FGDRJ2fQUF+10AbLJBzITnPbk=;
        b=TTWz3kQiTzBuca298CfBMS58ag+bVWHWFEQdNDu9C1/PN/lY6EyJ+tgg5gFUVnhl5Y
         jlXcfraF1hxROmd3FRyUNLm3DWxMTagFU4Jzmxrjk03uYoJMBVmM50Fk17nCcENFff7l
         VpuFlVFptef5rsjSkbqRJOg16a9ZddGY/Btdr7e/BdQ435+Gu0zF9saFRJFU/VsYtbjH
         aKf4HahUOxW6bcYHyRwiuaWGgH2XQvgiqQzDVvnQVmDgZG7nM4/L3LYwLg8waw2y+3xB
         1TlptulEwTSHjHG+aEC0qopP/o3e/sb+oK7NvFdiJXhd6uEI6ECNffztfSwHOK5IumFc
         orCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wkBklcgolThuSqx2B9FGDRJ2fQUF+10AbLJBzITnPbk=;
        b=qiJn0yt64a/oSSBmDOGPmwqNfUxgNHujHNQhawOuAflAaSFoj92HCDMa8+sUZFm1SO
         sXMhyc+qHSidy7+TQ5YcZb9IuTg6CGnd3MkWEHkUnQhBxmqGUX0U+9vXYrAupzDYgITX
         e+wd6b9z3pe8GWBph8Y/CpmhOZhYCHmny+qkVZ1pxj+6i9hxRYBEa2/y0ixB73ZjyLLb
         yPMReBcPms4RRXJrrrYrQ+Qr3EHCG2zOcyIpL5pqHPP1uIL4mzqpFuyzDfi/Gnb4Is2Y
         P0P6gr0j0TV4GljoUZmMwU/4gYHU5Q3HOiOmiT1d9JF9BS8kjWAkSF9D1oVN8szTbnBm
         UYaQ==
X-Gm-Message-State: AOAM533zh0uoK4in1xJMrIsdivwzz5nicgBt8dmWyfLryGpZ/jJLrRN2
        Mfzle3n4n5p4aDurFPsO6o/F8Q==
X-Google-Smtp-Source: ABdhPJxrpKuIXyZ4jZXgdzGC5pflyyO+oF9AqHsNWY4gxzEb6UyNUUElbKvxkAnL54GMA/mXFAjShQ==
X-Received: by 2002:a1c:1b90:: with SMTP id b138mr21475735wmb.21.1593525103867;
        Tue, 30 Jun 2020 06:51:43 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:43 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 28/30] misc: ocxl: config: Provide correct formatting to function headers
Date:   Tue, 30 Jun 2020 14:51:08 +0100
Message-Id: <20200630135110.2236389-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
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

