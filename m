Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59ED2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3964F207FB
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BYmhvu/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgGOPHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgGOPGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:06:55 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F93C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:06:54 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f7so3119340wrw.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=St/xAyCtrmRBWfYYcSn7juPr5Poh/NZ3n2rNrUrY394=;
        b=BYmhvu/PhXomekAXRVNla/c/6EiDYkDyIEEP+MnOTHWaO96GdMvSUBbWJS2c9+d7Jk
         VRcp05/uXtkltdnBCD3P4U/6uWXmTugA1wexZ81oTwI5iXU7B5eDg18v1fmgG2gpnKrY
         it07272+neTo2ZgSdaMpbMxWIRl/CJYkeFY2bH2Qc3ma0Q8+h02ZtLTMWgAnGuztvZYn
         ugk+ds7CLMSz5QoMkAHIgg+y7QLjfsXOlV07N2pPDjgbpagdKNJ8+SYYTPvMc5djiWwH
         5awGcZaMqjxnB/PtmoiA5Wx4+EdazDc9VX+/311LH/1OaZcHs/cKfKmw2aCAutzqfQJB
         lAvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=St/xAyCtrmRBWfYYcSn7juPr5Poh/NZ3n2rNrUrY394=;
        b=mxQDGWEVJtsO4GELCK0kMXhgWY2RcAsuFnMnmj/G2OEL5C7pv+5ez5oKh8mK3pTlns
         Y4q80SlFzfo589ED3fDfldnR2Vyx2tKIhtPQ8oUCBsqEeVcX63ypcYAb4BoJ0azsURIM
         XU8Al/v3GPE+u1ClqMn3haJB3tGtKwmo8np/xbpNthMpu5t50bhy/P8tOZ20727jUiNE
         5Uj0Jwib6W4hNg6crwVf29bbVa9rHM3JOTS9imb0HhtoDAwgJT3giI42p2BX/MtXpMPK
         UpF6nSJzhmxXe8uf6um1P2oEAF6LWL2vVjoCteKs5IR65mqEYApWkhh03E32hL/TurRC
         laxA==
X-Gm-Message-State: AOAM531hqV7/1ff6EPh2i5/aNIfwrWACKJntkh5xljscbiBSFQuQpyRX
        YH9H5IE9AkwcNaiAbMTPhWjrFw==
X-Google-Smtp-Source: ABdhPJzKOkWoJ5Xd1No49tmC7h+p+Lj1YSarlHghqR0fzO+t7pGvO0lAkoOgf54GCL5hcHwEPQMssg==
X-Received: by 2002:adf:f6cb:: with SMTP id y11mr11810561wrp.100.1594825613486;
        Wed, 15 Jul 2020 08:06:53 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id w2sm3906140wrs.77.2020.07.15.08.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 08:06:52 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH 14/14] spi: spi-amd: Do not define 'struct acpi_device_id' when
Date:   Wed, 15 Jul 2020 16:06:32 +0100
Message-Id: <20200715150632.409077-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715150632.409077-1-lee.jones@linaro.org>
References: <20200715150632.409077-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ACPI_PTR() is used to NULLify the value when !CONFIG_ACPI,
struct 'spi_acpi_match' becomes defined but unused.

Fixes the following W=1 kernel build warning(s):

 drivers/spi/spi-amd.c:297:36: warning: ‘spi_acpi_match’ defined but not used [-Wunused-const-variable=]
 297 | static const struct acpi_device_id spi_acpi_match[] = {
 | ^~~~~~~~~~~~~~

Cc: Sanjay R Mehta <sanju.mehta@amd.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/spi/spi-amd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index d0aacd4de1b9e..7f629544060db 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -294,11 +294,13 @@ static int amd_spi_probe(struct platform_device *pdev)
 	return err;
 }
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id spi_acpi_match[] = {
 	{ "AMDI0061", 0 },
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, spi_acpi_match);
+#endif
 
 static struct platform_driver amd_spi_driver = {
 	.driver = {
-- 
2.25.1

