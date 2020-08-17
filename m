Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0E1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 573F620716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597686197;
	bh=wEHEpnY21BIQiJBhHTEDRxYaJnYW3PivCC0GcHmkWe0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z/XF6PhWK2QB9J+6V0mH/A0NeuCyFvsZsr8d1TNjN9x1ytbrk2k9adMBm4qlh9bOO
	 1Hvc2rznK+ytZYIPfp5+Sigwl6d/VGtc2yGvrTnCdaYDohxVycVGxiZv1Agx9kBGZ5
	 2igEKsRT46XgGYQ9zxNY3Ny5lxQdzgoBENYetQTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387698AbgHQRnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:43:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731109AbgHQQQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:16:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBD51207DE;
        Mon, 17 Aug 2020 16:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680971;
        bh=wEHEpnY21BIQiJBhHTEDRxYaJnYW3PivCC0GcHmkWe0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZMbEvYG1WyCX8girUAWlaapbkMCdKndvDCvMCgxmCh0qu11sq0KXjLLpRPcZ/jFSR
         y3MPu9gbCG7yQvgg4qosYTPGZhZZsOl86PbMi8V/Di2zZgobhCvp9grKjPKjoRSdM/
         WRlFd0jXbsegjvMld3UDWC2XhYG2rfEShB5YK65M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sedat Dilek <sedat.dilek@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Jian Cai <caij2003@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 130/168] crypto: aesni - add compatibility with IAS
Date:   Mon, 17 Aug 2020 17:17:41 +0200
Message-Id: <20200817143740.186340708@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143733.692105228@linuxfoundation.org>
References: <20200817143733.692105228@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian Cai <caij2003@gmail.com>

[ Upstream commit 44069737ac9625a0f02f0f7f5ab96aae4cd819bc ]

Clang's integrated assembler complains "invalid reassignment of
non-absolute variable 'var_ddq_add'" while assembling
arch/x86/crypto/aes_ctrby8_avx-x86_64.S. It was because var_ddq_add was
reassigned with non-absolute values several times, which IAS did not
support. We can avoid the reassignment by replacing the uses of
var_ddq_add with its definitions accordingly to have compatilibility
with IAS.

Link: https://github.com/ClangBuiltLinux/linux/issues/1008
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Reported-by: Fangrui Song <maskray@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com> # build+boot Linux v5.7.5; clang v11.0.0-git
Signed-off-by: Jian Cai <caij2003@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/crypto/aes_ctrby8_avx-x86_64.S | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/x86/crypto/aes_ctrby8_avx-x86_64.S b/arch/x86/crypto/aes_ctrby8_avx-x86_64.S
index 5f6a5af9c489b..77043a82da510 100644
--- a/arch/x86/crypto/aes_ctrby8_avx-x86_64.S
+++ b/arch/x86/crypto/aes_ctrby8_avx-x86_64.S
@@ -127,10 +127,6 @@ ddq_add_8:
 
 /* generate a unique variable for ddq_add_x */
 
-.macro setddq n
-	var_ddq_add = ddq_add_\n
-.endm
-
 /* generate a unique variable for xmm register */
 .macro setxdata n
 	var_xdata = %xmm\n
@@ -140,9 +136,7 @@ ddq_add_8:
 
 .macro club name, id
 .altmacro
-	.if \name == DDQ_DATA
-		setddq %\id
-	.elseif \name == XDATA
+	.if \name == XDATA
 		setxdata %\id
 	.endif
 .noaltmacro
@@ -165,9 +159,8 @@ ddq_add_8:
 
 	.set i, 1
 	.rept (by - 1)
-		club DDQ_DATA, i
 		club XDATA, i
-		vpaddq	var_ddq_add(%rip), xcounter, var_xdata
+		vpaddq	(ddq_add_1 + 16 * (i - 1))(%rip), xcounter, var_xdata
 		vptest	ddq_low_msk(%rip), var_xdata
 		jnz 1f
 		vpaddq	ddq_high_add_1(%rip), var_xdata, var_xdata
@@ -180,8 +173,7 @@ ddq_add_8:
 	vmovdqa	1*16(p_keys), xkeyA
 
 	vpxor	xkey0, xdata0, xdata0
-	club DDQ_DATA, by
-	vpaddq	var_ddq_add(%rip), xcounter, xcounter
+	vpaddq	(ddq_add_1 + 16 * (by - 1))(%rip), xcounter, xcounter
 	vptest	ddq_low_msk(%rip), xcounter
 	jnz	1f
 	vpaddq	ddq_high_add_1(%rip), xcounter, xcounter
-- 
2.25.1



