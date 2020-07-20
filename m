Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13963C433F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D859122CBE
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260556;
	bh=ppTfgYb09TB9qxq+h+9fQ/bwVJO7A7SzJInWDp8mVuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pZzJveE0YBJpDYuI48W2XDOoIgwcCsbyDdGetkYLQpl/zcogJKysMvGMYxS6HN1sv
	 MMKSkkW5oamhnMmjXrJD/Fuza8Pex7nGBleZ3fqIvzEcaBy4HJGRGHtU7Jplq6KnoU
	 MUsRoXYIS+K4QW2nmx3urse1GqcuimYYIjtsTpmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbgGTPzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:55:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:55120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731724AbgGTPzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:55:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 240F022CBE;
        Mon, 20 Jul 2020 15:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260549;
        bh=ppTfgYb09TB9qxq+h+9fQ/bwVJO7A7SzJInWDp8mVuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=irsAUX3Ui8+Hz9nqcQ+UIFxs0c/SJf8VEAL2RvLt5olBfDwiNHH14HVrfHn03LU3p
         xej4w9o+eCqiaOxC3YBjCdftKbYKc0HPiqPNwk73ZQ6DrmX6Q1kN/A+bylAvdVrTZ9
         N2j2nJR1rR+96Gftt8RIUKP/ordYTe5XzvI3FigE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.4 001/215] crypto: atmel - Fix selection of CRYPTO_AUTHENC
Date:   Mon, 20 Jul 2020 17:34:43 +0200
Message-Id: <20200720152820.208935209@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

commit d158367682cd822aca811971e988be6a8d8f679f upstream.

The following error is raised when CONFIG_CRYPTO_DEV_ATMEL_AES=y and
CONFIG_CRYPTO_DEV_ATMEL_AUTHENC=m:
drivers/crypto/atmel-aes.o: In function `atmel_aes_authenc_setkey':
atmel-aes.c:(.text+0x9bc): undefined reference to `crypto_authenc_extractkeys'
Makefile:1094: recipe for target 'vmlinux' failed

Fix it by moving the selection of CRYPTO_AUTHENC under
config CRYPTO_DEV_ATMEL_AES.

Fixes: 89a82ef87e01 ("crypto: atmel-authenc - add support to...")
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -493,7 +493,6 @@ endif # if CRYPTO_DEV_UX500
 config CRYPTO_DEV_ATMEL_AUTHENC
 	tristate "Support for Atmel IPSEC/SSL hw accelerator"
 	depends on ARCH_AT91 || COMPILE_TEST
-	select CRYPTO_AUTHENC
 	select CRYPTO_DEV_ATMEL_AES
 	select CRYPTO_DEV_ATMEL_SHA
 	help
@@ -508,6 +507,7 @@ config CRYPTO_DEV_ATMEL_AES
 	select CRYPTO_AES
 	select CRYPTO_AEAD
 	select CRYPTO_BLKCIPHER
+	select CRYPTO_AUTHENC
 	help
 	  Some Atmel processors have AES hw accelerator.
 	  Select this if you want to use the Atmel module for


