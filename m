Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2555C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810852072B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217627;
	bh=XtUxArYcFeUdl5X81sZByu8VjAPzL60+UBOOD1iDiAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=C5YrdjgqF9AkqfjcNSf7+GPKNNVLbmjWvSsqhanZF1PyU87+rjbDuuYrW4HLrIgb9
	 MZLETI/Vh7SQHHgJsJ0WoI3OOOE7/fmrebRy1vId3VInfGq0bbgfEfQEvsAutodV6a
	 9/QUuPxUAReqo4W70RVWD2SAraTdeCt15Yr87Rh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404430AbgAPXdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:33:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:44400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404414AbgAPXdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:33:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0CB820684;
        Thu, 16 Jan 2020 23:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217622;
        bh=XtUxArYcFeUdl5X81sZByu8VjAPzL60+UBOOD1iDiAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xULWM72h+ENBOCFJBw9nX+u9j/ekymrgoxSfmaAIRIEBVagwGiW0cn25cRd9oSuXA
         CTmgpzXgPFESKDg1C16QoelU0imcQ0EovlfSxxZzBo6FJ/nVTMZeNMkpR4UNRNusYB
         YfBFVB2hObbSOLcPvpLiL3ffaKuwatuT4CkM+pMc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: [PATCH 4.14 57/71] mtd: spi-nor: fix silent truncation in spi_nor_read_raw()
Date:   Fri, 17 Jan 2020 00:18:55 +0100
Message-Id: <20200116231717.409223087@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231709.377772748@linuxfoundation.org>
References: <20200116231709.377772748@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

commit 3d63ee5deb466fd66ed6ffb164a87ce36425cf36 upstream.

spi_nor_read_raw() assigns the result of 'ssize_t spi_nor_read_data()'
to the 'int ret' variable, while 'ssize_t' is a 64-bit type and *int*
is a 32-bit type on the 64-bit machines. This silent truncation isn't
really valid, so fix up the variable's type.

Fixes: f384b352cbf0 ("mtd: spi-nor: parse Serial Flash Discoverable Parameters (SFDP) tables")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/spi-nor/spi-nor.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1445,7 +1445,7 @@ static int macronix_quad_enable(struct s
  */
 static int write_sr_cr(struct spi_nor *nor, u8 *sr_cr)
 {
-	int ret;
+	ssize_t ret;
 
 	write_enable(nor);
 


