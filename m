Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80AFC3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9425424677
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607617;
	bh=s9vMX17cL/4UN/uKNxZu0qzByCTD+ZvN3gc5LxNfAN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vftkLTZTehK//v55g4NwpDfVLn2RZC2wiVo6rKEm7tEmh8+5yWL/4H67hJe8oSVmh
	 0bSL2gX91Gxb9NYtzNrlTt9lJeEV5XPxnmfsRyTHm4UytceR3K58bIkBneBXZCRgod
	 iU95Frt8Sls6TQ7Kmm0k0jQ6d34YYUbYoNWV0g/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbgBMP05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:26:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbgBMPZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:25:06 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86382246B1;
        Thu, 13 Feb 2020 15:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607505;
        bh=s9vMX17cL/4UN/uKNxZu0qzByCTD+ZvN3gc5LxNfAN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XPzuCGhk/dd3nyLd5tD4cDmq88ryvGyabec0hcIT3fk93wDPv2HpPfAMwQKAqxVKW
         gFLfnvjgaB1t4T5LhWSRP8syKbANpb1RYs5hQ4afYg1fAC/KkEMbIIui5xTzU+w/uq
         DtxAoVbIN7aaiqTC92hc/Z8n0ZLqRGfTYH6hicI4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Gary R Hook <gary.hook@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 4.14 063/173] crypto: ccp - set max RSA modulus size for v3 platform devices as well
Date:   Thu, 13 Feb 2020 07:19:26 -0800
Message-Id: <20200213151949.713565684@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

commit 11548f5a5747813ff84bed6f2ea01100053b0d8d upstream.

AMD Seattle incorporates a non-PCI version of the v3 CCP crypto
accelerator, and this version was left behind when the maximum
RSA modulus size was parameterized in order to support v5 hardware
which supports larger moduli than v3 hardware does. Due to this
oversight, RSA acceleration no longer works at all on these systems.

Fix this by setting the .rsamax property to the appropriate value
for v3 platform hardware.

Fixes: e28c190db66830c0 ("csrypto: ccp - Expand RSA support for a v5 ccp")
Cc: Gary R Hook <gary.hook@amd.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Gary R Hook <gary.hook@amd.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/ccp/ccp-dev-v3.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/crypto/ccp/ccp-dev-v3.c
+++ b/drivers/crypto/ccp/ccp-dev-v3.c
@@ -590,6 +590,7 @@ const struct ccp_vdata ccpv3_platform =
 	.setup = NULL,
 	.perform = &ccp3_actions,
 	.offset = 0,
+	.rsamax = CCP_RSA_MAX_WIDTH,
 };
 
 const struct ccp_vdata ccpv3 = {


