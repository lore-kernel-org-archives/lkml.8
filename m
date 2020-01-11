Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 514B5C33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1785F2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578738523;
	bh=w1xY86k7o2X3acrxEgJ49Coa7QPmcFApXCnQ410bYkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qve//jPPPqJfxvQ+9hoM/CQkbW/OlmSnsEdCPpYBPn6FcYWc9CHVYw9tDBM0d3JRU
	 jMTWJu1dg2RGuX08hHh3me1GVTZtuVh89Dy2XwuyJv1o4SDfAtYjFR7fgFk0HscJCW
	 2++yRc1QJdxsSfdmlCNaM2bZVQjVoM68zdYzZKPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731296AbgAKK2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:28:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:36456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730755AbgAKK2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:28:37 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0AED20842;
        Sat, 11 Jan 2020 10:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578738517;
        bh=w1xY86k7o2X3acrxEgJ49Coa7QPmcFApXCnQ410bYkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aZvsHYKLkpAbWRsPX6+2cgilzf6KdD1rVLyL4ANisxEfBJrAxcrPWxP+aI8GPCiVu
         wJRkESSf4j0Ohz9A6xrp+wTV5PMVgY3RxSeuBJoyUE5sTpMQJ6otXuBb6HKS9MALJJ
         JKJai7Q3gxCooRLN/68gh6gkiuwV4+q+gqsshiEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 092/165] spi: nxp-fspi: Ensure width is respected in spi-mem operations
Date:   Sat, 11 Jan 2020 10:50:11 +0100
Message-Id: <20200111094928.896721945@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094921.347491861@linuxfoundation.org>
References: <20200111094921.347491861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

[ Upstream commit 007773e16a6f3f49d1439554078c3ba8af131998 ]

Make use of a core helper to ensure the desired width is respected
when calling spi-mem operators.

Otherwise only the SPI controller will be matched with the flash chip,
which might lead to wrong widths. Also consider the width specified by
the user in the device tree.

Fixes: a5356aef6a90 ("spi: spi-mem: Add driver for NXP FlexSPI controller")
Signed-off-by: Michael Walle <michael@walle.cc>
Link: https://lore.kernel.org/r/20191211195730.26794-1-michael@walle.cc
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-nxp-fspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 501b923f2c27..28ae5229f889 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -439,7 +439,7 @@ static bool nxp_fspi_supports_op(struct spi_mem *mem,
 	    op->data.nbytes > f->devtype_data->txfifo)
 		return false;
 
-	return true;
+	return spi_mem_default_supports_op(mem, op);
 }
 
 /* Instead of busy looping invoke readl_poll_timeout functionality. */
-- 
2.20.1



