Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11C5C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9838D21D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587050175;
	bh=VZ39YWwP05qYCay5b0xukEXzfT7EKSUhftLU/x7SAco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dkMUfIfzZ+UogLMTbIXpR45nHkVCe2YtOu75MeBztBzh2sFxvilMaw9utaTEgi26a
	 x2tEfMLGtelpR2zmgdYL5pnjmI8N2Dv07oVJUZbHefZoK9MTmyQZT7ZZiTeMX8QcJU
	 kRAqSwWanMYdx2ECkln5f9amKgOf0fU4IXLX+NBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440592AbgDPPQO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:16:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441511AbgDPNuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:50:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F6BE2223D;
        Thu, 16 Apr 2020 13:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044955;
        bh=VZ39YWwP05qYCay5b0xukEXzfT7EKSUhftLU/x7SAco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ixc+HDT3AkBDAzyzI2ZYsPsWZpRyp501fARtxlwDXBt4gjn4HV1Ah8YgPMmkT5dwr
         h4d6p2DBUJVEWJwzNDM/zeZ4EidYMLyOEthD3loMOGtJnzxmiExF6gBivLTJZZvpA7
         /n0mYyXl89qTXvE1fTAL9WkBnKrV1G4UEPYITZok=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrei Botila <andrei.botila@nxp.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.4 169/232] crypto: caam - update xts sector size for large input length
Date:   Thu, 16 Apr 2020 15:24:23 +0200
Message-Id: <20200416131336.149713965@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131316.640996080@linuxfoundation.org>
References: <20200416131316.640996080@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Botila <andrei.botila@nxp.com>

commit 3f142b6a7b573bde6cff926f246da05652c61eb4 upstream.

Since in the software implementation of XTS-AES there is
no notion of sector every input length is processed the same way.
CAAM implementation has the notion of sector which causes different
results between the software implementation and the one in CAAM
for input lengths bigger than 512 bytes.
Increase sector size to maximum value on 16 bits.

Fixes: c6415a6016bf ("crypto: caam - add support for acipher xts(aes)")
Cc: <stable@vger.kernel.org> # v4.12+
Signed-off-by: Andrei Botila <andrei.botila@nxp.com>
Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/crypto/caam/caamalg_desc.c |   16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

--- a/drivers/crypto/caam/caamalg_desc.c
+++ b/drivers/crypto/caam/caamalg_desc.c
@@ -1524,7 +1524,13 @@ EXPORT_SYMBOL(cnstr_shdsc_skcipher_decap
  */
 void cnstr_shdsc_xts_skcipher_encap(u32 * const desc, struct alginfo *cdata)
 {
-	__be64 sector_size = cpu_to_be64(512);
+	/*
+	 * Set sector size to a big value, practically disabling
+	 * sector size segmentation in xts implementation. We cannot
+	 * take full advantage of this HW feature with existing
+	 * crypto API / dm-crypt SW architecture.
+	 */
+	__be64 sector_size = cpu_to_be64(BIT(15));
 	u32 *key_jump_cmd;
 
 	init_sh_desc(desc, HDR_SHARE_SERIAL | HDR_SAVECTX);
@@ -1577,7 +1583,13 @@ EXPORT_SYMBOL(cnstr_shdsc_xts_skcipher_e
  */
 void cnstr_shdsc_xts_skcipher_decap(u32 * const desc, struct alginfo *cdata)
 {
-	__be64 sector_size = cpu_to_be64(512);
+	/*
+	 * Set sector size to a big value, practically disabling
+	 * sector size segmentation in xts implementation. We cannot
+	 * take full advantage of this HW feature with existing
+	 * crypto API / dm-crypt SW architecture.
+	 */
+	__be64 sector_size = cpu_to_be64(BIT(15));
 	u32 *key_jump_cmd;
 
 	init_sh_desc(desc, HDR_SHARE_SERIAL | HDR_SAVECTX);


