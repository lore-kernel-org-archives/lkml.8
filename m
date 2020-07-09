Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069E6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D17592065D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SIK7xtQ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgGIG44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 02:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgGIG4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 02:56:55 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61D0C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 23:56:54 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 17so686615wmo.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 23:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Wcz1X2aMI4wLAwmC/YcHtbFjsUgNxZUhx2oTPKovSdI=;
        b=SIK7xtQ1ZwjCMbOJj8SaWAbOcjJjQxj/PLiDND12LcX+IT6pg5CKd5VSce06Esth1C
         tjZAcMGJP7lgp0MW+RSgIN6cfTi3ndq8AxGnl6OkEUImbPGMbxPD79cQ7Nms8/XBRI8m
         DiBujo29jQgV1djDLijkwqi4n2NCN8N/cx39JyMxcCyjekM3316o7vX7647QSVQQXITh
         gQoElcghul+GRYV26uHkUU8Q8zAwKOgiyWE348Rc6E3/9E6aJAJWKPW1X6v96eOklZnA
         hEpQvye4SxWYDUo1OCfnMJ8Q0Gk1C5gO6qc9BFnbGsMSaZlmVBguT14spVCZq3355Ycb
         st3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Wcz1X2aMI4wLAwmC/YcHtbFjsUgNxZUhx2oTPKovSdI=;
        b=WTPAgRdxG4TJ1o7lUNIMZnZTxhPm6o3xUY1gN0MIhdm4O97YCwI5T+PsNhfAcRy5sN
         vZ/mPM2ZAjQffxNyToRfu26nnLp728zLpUByxq/EWmczPt7pG+Pi8yOM2wiiH7FPOy1Q
         Xh00SsG1UNGU7msDDRmYQpoerAJDa8d4sZGWNID27ztHXaiLbxcrhXVRPmgVTtmeF+bb
         jQ4lLyg8lprbnS1z8FdjO4hIfv+nTaqiUpx/re5qjziE1ZmecHFi7O2iQoz5j/HT1A1w
         VP3BS9qcKffY/xPgkTqk8m6GLEH2uU9peI9jsNIyK8DQvRgOzpivKy4KGh4v84yqBwOh
         f+SA==
X-Gm-Message-State: AOAM530FIh5QkZPl01i7YFGOQyW55+7JHTXRQIJ8AWBmtCaQUG+brDas
        RNCgFIioXPxnpc+J791ZD0g4EOkUzXE=
X-Google-Smtp-Source: ABdhPJwGYuNnqxYo1af0qUZYMa4Nco75fT1qnFm7LZCMHjtPUU5qRn6vAxb8puXXlwwJ03KgDY726w==
X-Received: by 2002:a1c:96c5:: with SMTP id y188mr13135281wmd.71.1594277813587;
        Wed, 08 Jul 2020 23:56:53 -0700 (PDT)
Received: from dell ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id f17sm3732156wme.14.2020.07.08.23.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 23:56:53 -0700 (PDT)
Date:   Thu, 9 Jul 2020 07:56:51 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 3/3] misc: cxl: flash: Remove unused variable 'drc_index'
Message-ID: <20200709065651.GY3500@dell>
References: <20200708125711.3443569-1-lee.jones@linaro.org>
 <20200708125711.3443569-4-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200708125711.3443569-4-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Keeping the pointer increment though.

Fixes the following W=1 kernel build warning:

 drivers/misc/cxl/flash.c: In function ‘update_devicetree’:
 drivers/misc/cxl/flash.c:178:16: warning: variable ‘drc_index’ set but not used [-Wunused-but-set-variable]
 178 | __be32 *data, drc_index, phandle;
 | ^~~~~~~~~

Cc: Frederic Barrat <fbarrat@linux.ibm.com>
Cc: Andrew Donnellan <ajd@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
Changelog:

v1 => v2:
 - Fix "flash.c:216:6: error: value computed is not used [-Werror=unused-value]"
   - ... as reported by Intel's Kernel Test Robot

drivers/misc/cxl/flash.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/flash.c b/drivers/misc/cxl/flash.c
index cb9cca35a2263..5b93ff51d82a5 100644
--- a/drivers/misc/cxl/flash.c
+++ b/drivers/misc/cxl/flash.c
@@ -175,7 +175,7 @@ static int update_devicetree(struct cxl *adapter, s32 scope)
 	struct update_nodes_workarea *unwa;
 	u32 action, node_count;
 	int token, rc, i;
-	__be32 *data, drc_index, phandle;
+	__be32 *data, phandle;
 	char *buf;
 
 	token = rtas_token("ibm,update-nodes");
@@ -213,7 +213,7 @@ static int update_devicetree(struct cxl *adapter, s32 scope)
 					break;
 				case OPCODE_ADD:
 					/* nothing to do, just move pointer */
-					drc_index = *data++;
+					data++;
 					break;
 				}
 			}
-- 
2.25.1
