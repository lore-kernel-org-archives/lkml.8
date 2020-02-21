Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FE9C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A1120722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272557;
	bh=kQoUIv0tfy2iRsWnvtbfmBow4drqLMGlrVK1WXLKfJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1ipFxpEbEzk0FOLJtIZ0UTxjA3+4mouuxRnuMn3vFf3/vO9LFipYknleKzR/bbcfq
	 Ns8gXKeuvDcNFRX6jyZPV/vyCw+dvojIfHhkfl+oLQ042ZLWsLSWc8/HCiabS/bRM+
	 GJzq7gMnXbvuc2xOirrdMerIkBgzmgP3jLwQOxNk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732327AbgBUIJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:09:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:43962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732016AbgBUIJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:09:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D595520578;
        Fri, 21 Feb 2020 08:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272550;
        bh=kQoUIv0tfy2iRsWnvtbfmBow4drqLMGlrVK1WXLKfJs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dNMPajDT1VbION31Efrtc9r63P05k6UBEW4Kjfkt5dqY/RRm6uJqX7Bfz0iHhXSKz
         sghaqPO0uRCqsvwYzcsFCGu6aGkqh4FA72O39G+TMHTQp0M2mgf+DGH1UwBTDZQoC3
         kYQe32pKyS/fhpJNoYkgcjW2VOJt4c/2UD9SPh5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 148/344] crypto: inside-secure - add unspecified HAS_IOMEM dependency
Date:   Fri, 21 Feb 2020 08:39:07 +0100
Message-Id: <20200221072402.230933250@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brendan Higgins <brendanhiggins@google.com>

[ Upstream commit 6dc0e310623fdcb27a1486eb436f0118c45e95a5 ]

Currently CONFIG_CRYPTO_DEV_SAFEXCEL=y implicitly depends on
CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
the following build error:

ld: drivers/crypto/inside-secure/safexcel.o: in function `safexcel_probe':
drivers/crypto/inside-secure/safexcel.c:1692: undefined reference to `devm_platform_ioremap_resource'

Fix the build error by adding the unspecified dependency.

Reported-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 7316312935c88..06b2b3fa5206e 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -739,7 +739,7 @@ source "drivers/crypto/stm32/Kconfig"
 
 config CRYPTO_DEV_SAFEXCEL
 	tristate "Inside Secure's SafeXcel cryptographic engine driver"
-	depends on OF || PCI || COMPILE_TEST
+	depends on (OF || PCI || COMPILE_TEST) && HAS_IOMEM
 	select CRYPTO_LIB_AES
 	select CRYPTO_AUTHENC
 	select CRYPTO_BLKCIPHER
-- 
2.20.1



