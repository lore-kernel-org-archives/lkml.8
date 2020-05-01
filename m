Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6DEC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3643E2054F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588341438;
	bh=9RzJxy4Upa/s9eKqiIKMjlPo8dJwUDtbafz0tltfjg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SzR5bJtFaHrD/n1ioUeY5N3JnDGlefgABsiOELewqiCEoFrvTc7u3GQYhfJVMyNTl
	 gu70zS6dA40scEhurHAIJuEggue4HI2jGOa01XVt16DdjVNTytCehqvMtsGS+XWzjd
	 JNYBHACZuWLsU1Eq00IRWuZCsLZLazEbGGDSq4uc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbgEANba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:31:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730126AbgEANb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:31:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9360208C3;
        Fri,  1 May 2020 13:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339886;
        bh=9RzJxy4Upa/s9eKqiIKMjlPo8dJwUDtbafz0tltfjg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jyVAQXJCwXm6aVfI1077hHNnQXaC80VS1yiwvwau/dev6cNLUAJ2FRLPjxkO6WXxR
         x6RHfsnSV9B/u6agCcJZIm+zeX5CGFysPcsWuYQCGB0koNLqoOnJ/NI4KP1Fdwl4+n
         2Nej2C1EvmaE++um80j5sXThnHxVxQ4CTG8LTQq8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wei Yongjun <weiyongjun1@huawei.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 006/117] crypto: mxs-dcp - make symbols sha1_null_hash and sha256_null_hash static
Date:   Fri,  1 May 2020 15:20:42 +0200
Message-Id: <20200501131546.029104312@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131544.291247695@linuxfoundation.org>
References: <20200501131544.291247695@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

commit ce4e45842de3eb54b8dd6e081765d741f5b92b56 upstream.

Fixes the following sparse warnings:

drivers/crypto/mxs-dcp.c:39:15: warning:
 symbol 'sha1_null_hash' was not declared. Should it be static?
drivers/crypto/mxs-dcp.c:43:15: warning:
 symbol 'sha256_null_hash' was not declared. Should it be static?

Fixes: c709eebaf5c5 ("crypto: mxs-dcp - Fix SHA null hashes and output length")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/mxs-dcp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -37,11 +37,11 @@
  * Null hashes to align with hw behavior on imx6sl and ull
  * these are flipped for consistency with hw output
  */
-const uint8_t sha1_null_hash[] =
+static const uint8_t sha1_null_hash[] =
 	"\x09\x07\xd8\xaf\x90\x18\x60\x95\xef\xbf"
 	"\x55\x32\x0d\x4b\x6b\x5e\xee\xa3\x39\xda";
 
-const uint8_t sha256_null_hash[] =
+static const uint8_t sha256_null_hash[] =
 	"\x55\xb8\x52\x78\x1b\x99\x95\xa4"
 	"\x4c\x93\x9b\x64\xe4\x41\xae\x27"
 	"\x24\xb9\x6f\x99\xc8\xf4\xfb\x9a"


