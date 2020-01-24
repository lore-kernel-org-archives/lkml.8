Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2035AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93F92070A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858782;
	bh=0VjX7Tl7Gtvn+Pu7lF365Xuvd6DrlJp11IbqYsPWP/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qtb7VyEv7zdZyGXxQYUTxjnujwciMhyBKexfkyXcJQEI0Tg2IiGcI2SoolrXHd70B
	 lL7cnG4lCpJjccRZnPqnfV2wrxudJcu/SVXdRm8Sp1ip5NoF/zczi1xaStT4O+Jpds
	 hmbfyWkx9iMEiwlezV26N1+NEQ9KlLiLbXDMR42s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbgAXJjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:39:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:36762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731650AbgAXJjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:39:37 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A09C20838;
        Fri, 24 Jan 2020 09:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858777;
        bh=0VjX7Tl7Gtvn+Pu7lF365Xuvd6DrlJp11IbqYsPWP/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZnwI/XIN97PTMSxCBLV3L0nq/7gqktHFxoO8xmFWkcwqfm0hOJaUVWkDBwl8SJlq7
         mbdVzGCDr73REve7UOw65/7ejAa/gMGS8NpE06O0OqGQ3FMMQtqeMp3NOZbMW9R/qY
         Hficqd5doSB2XuqtosYpCa6PIzgjQEUzHJuY6Dc8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.4 037/102] crypto: amcc - restore CRYPTO_AES dependency
Date:   Fri, 24 Jan 2020 10:30:38 +0100
Message-Id: <20200124092811.862631711@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092806.004582306@linuxfoundation.org>
References: <20200124092806.004582306@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Lamparter <chunkeey@gmail.com>

commit 298b4c604008025b134bc6fccbc4018449945d60 upstream.

This patch restores the CRYPTO_AES dependency. This is
necessary since some of the crypto4xx driver provided
modes need functioning software fallbacks for
AES-CTR/CCM and GCM.

Fixes: da3e7a9715ea ("crypto: amcc - switch to AES library for GCM key derivation")
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -333,6 +333,7 @@ config CRYPTO_DEV_PPC4XX
 	depends on PPC && 4xx
 	select CRYPTO_HASH
 	select CRYPTO_AEAD
+	select CRYPTO_AES
 	select CRYPTO_LIB_AES
 	select CRYPTO_CCM
 	select CRYPTO_CTR


