Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6B4C352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D742054F
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586883297;
	bh=QM0vWrqOsJsv4eZsnUj0jGPK7QIQ2t068vlV3vEIqVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sDl1/ynxiIHEO2brsVikJ9YSjA80uLySuioXRtHea0Rc2xIJ8sqnRR2yHU4UdRBwE
	 Ee+0Fc8solvAYEXvct1UHr6RIl9N0k1IdDb3YnoqeFdt9xnCGByGMPCkyZBkQyCzNL
	 VVfS57HSZbRrSh7OT4ftaICa5AfvqfofxD7P34HA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732066AbgDNQy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:54:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440302AbgDNQtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:14 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5AE3218AC;
        Tue, 14 Apr 2020 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882943;
        bh=QM0vWrqOsJsv4eZsnUj0jGPK7QIQ2t068vlV3vEIqVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aJKB8pksQl/p9ZL6QHcpoljlnSNSnV+KFbjbF1tqzZizU2vNbiVRA6RmpJvW9tqWS
         DYesERa639e9nCVNbVz5Vye6maKfFWNx/8gDDG8neVqU3hGKwIinJCkFI7lUJpiKZY
         gcDQ2HGHa/9D6Iy6HQMtU3ciZUza9G3IunRhBWXA=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk9-0068mQ-5I; Tue, 14 Apr 2020 18:49:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v2 19/33] docs: drivers: fix some warnings at base/platform.c when building docs
Date:   Tue, 14 Apr 2020 18:48:45 +0200
Message-Id: <564273815a76136fb5e453969b1012a786d99e28.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
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

