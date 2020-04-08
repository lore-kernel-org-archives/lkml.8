Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1DAC2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D84520820
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586360847;
	bh=QM0vWrqOsJsv4eZsnUj0jGPK7QIQ2t068vlV3vEIqVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i6byG1hfMCHDIMH8ExWTc/O7AimlSQycwBLqhr8KOlTUo18U6vzHd4gF+ZqpUaECX
	 EH0sdZXXP+xGWTkdocdYpMAMRtasz30P7OehGxKYublvOpUM3qdGt/A6mt8uXZk4Yq
	 OpaJKAWHLbIK8Op+ycG7d2f1L0Xee8Rh3Vprhm7w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729880AbgDHPr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:47:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729682AbgDHPqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:33 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2FC021D7E;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360791;
        bh=QM0vWrqOsJsv4eZsnUj0jGPK7QIQ2t068vlV3vEIqVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bgMG+zPCZqF8L2b5haE8F2fByYG1RelsbPsj82c1DXIfQrvSOkL+fh+qwvh0wHQ1v
         N2mT/AY89IsGTWjPoF0u9zgZob1jZ56n7SQtob1ZBqFrlPSbIKhux7NgtolKzIYjZ0
         xahMDL9iFmCEo1dKqLWCsYugVw0h04g1PNGZtYhU=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuL-000cC1-Tb; Wed, 08 Apr 2020 17:46:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 22/35] docs: drivers: fix some warnings at base/platform.c when building docs
Date:   Wed,  8 Apr 2020 17:46:14 +0200
Message-Id: <b3a375af07cd1bb521254f01baf176b123839d96.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currrently, two warnings are generated when building docs:

	./drivers/base/platform.c:136: WARNING: Unexpected indentation.
	./drivers/base/platform.c:214: WARNING: Unexpected indentation.

As examples are code blocks, they should use "::" markup. However,

	Example::

Is currently interpreted as a new section.

While we could fix kernel-doc to accept such new syntax, it is
easier to just replace it with:

	For Example::

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/base/platform.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 5255550b7c34..a07e28eab7d7 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -147,7 +147,8 @@ EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
  * request_irq() APIs. This is the same as platform_get_irq(), except that it
  * does not print an error message if an IRQ can not be obtained.
  *
- * Example:
+ * For example::
+ *
  *		int irq = platform_get_irq_optional(pdev, 0);
  *		if (irq < 0)
  *			return irq;
@@ -226,7 +227,8 @@ EXPORT_SYMBOL_GPL(platform_get_irq_optional);
  * IRQ fails. Device drivers should check the return value for errors so as to
  * not pass a negative integer value to the request_irq() APIs.
  *
- * Example:
+ * For example::
+ *
  *		int irq = platform_get_irq(pdev, 0);
  *		if (irq < 0)
  *			return irq;
-- 
2.25.2

