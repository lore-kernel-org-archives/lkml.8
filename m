Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33E1C3B18B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B2A0222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607880;
	bh=n9qPfzZareJWROB5S1i2u8Q8pzKf0P4hrNCvkAWh3w0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ujs7cHwyezh4LBDwiu9SZrH8R1XWPb2FYMeO/9kjvNS3pIVOrObyyaBj3RClvEb7m
	 e5clzZ/WGkwm8sr4nl7pQOVpx3at/cNNDoGljIPRXMdlFy3K5W3V4Jg/QpRn7vm3bT
	 ghvQjO3FYYirKBDizkAxapfQFZ52VDQYvkTWwK4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgBMPbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:31:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387715AbgBMP1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:51 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A3F2C20661;
        Thu, 13 Feb 2020 15:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607670;
        bh=n9qPfzZareJWROB5S1i2u8Q8pzKf0P4hrNCvkAWh3w0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A09L2oHIWIql9Vo4eUcdKxAjsDyD/4cjetf+ZQQZbQ/7mD+P0KNGikhmL7hJHbFro
         0u/GFuk74f7SJJ4iJMNUxZQ5dhMKIgA618yB8R7MorvQV4dwKaNt7XDIBfEpi7esJK
         IbPmuGMF4OUK6w760CzFH/71birPIdcb1rEd0Lx4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 5.4 76/96] mtd: sharpslpart: Fix unsigned comparison to zero
Date:   Thu, 13 Feb 2020 07:21:23 -0800
Message-Id: <20200213151908.016338383@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151839.156309910@linuxfoundation.org>
References: <20200213151839.156309910@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

commit f33113b542219448fa02d77ca1c6f4265bd7f130 upstream.

The unsigned variable log_num is being assigned a return value
from the call to sharpsl_nand_get_logical_num that can return
-EINVAL.

Detected using Coccinelle:
./drivers/mtd/parsers/sharpslpart.c:207:6-13: WARNING: Unsigned expression compared with zero: log_num > 0

Fixes: 8a4580e4d298 ("mtd: sharpslpart: Add sharpslpart partition parser")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mtd/parsers/sharpslpart.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/mtd/parsers/sharpslpart.c
+++ b/drivers/mtd/parsers/sharpslpart.c
@@ -165,10 +165,10 @@ static int sharpsl_nand_get_logical_num(
 
 static int sharpsl_nand_init_ftl(struct mtd_info *mtd, struct sharpsl_ftl *ftl)
 {
-	unsigned int block_num, log_num, phymax;
+	unsigned int block_num, phymax;
+	int i, ret, log_num;
 	loff_t block_adr;
 	u8 *oob;
-	int i, ret;
 
 	oob = kzalloc(mtd->oobsize, GFP_KERNEL);
 	if (!oob)


