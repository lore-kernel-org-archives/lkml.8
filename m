Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E918C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF0872073E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592552643;
	bh=G9lBmeDxHh2VeTZymUbF1CdX0re/3uaKH5q60zlt4gY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=B3GMj8vK73gRm7/b+XG+QNMQYLrBk7lBrNORXpHyhHGaZRFh948/gAEGb/KD6ODMU
	 VbSFLt65yhwONWGlozkbInI5JcHB2TQZjoRsTPXmavKVLpzpeduQMfKrg5PhaSH6o1
	 F1wEHLW+dzRQiN6msieKggf0X4OMuAsdQlxEGwA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731039AbgFSHoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:44:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730955AbgFSHoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:44:00 -0400
Received: from localhost.localdomain (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F16F32073E;
        Fri, 19 Jun 2020 07:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592552640;
        bh=G9lBmeDxHh2VeTZymUbF1CdX0re/3uaKH5q60zlt4gY=;
        h=From:To:Cc:Subject:Date:From;
        b=Jr0YrytKVOh9yPMdnZtTHUIndZk8WAzweXTFVG3Ktp/df/K6Mvu0eRFsBQt9uI4oO
         966xh614vJSnAP5XdHlHE+Gw+NUQeyGhDVgvXxDbjAZvTjsquBkZoFsHI+TqfRl8IK
         OzEjg9UwNEJmULmxV0z4XYHCNbzPOLV8YrWGRVQo=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        mani@kernel.org
Subject: [PATCH] spi: spidev: fix missing octal defines
Date:   Fri, 19 Jun 2020 13:13:45 +0530
Message-Id: <20200619074345.4041673-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 896fa735084e ("spi: spidev_test: Add support for Octal mode data
transfers") adds support for octal mode but failed to update userspace
header with octal defines causing build error for the spidev tool

spidev_test.c: In function ‘transfer’:
spidev_test.c:131:13: error: ‘SPI_TX_OCTAL’ undeclared (first use in this function); did you mean ‘SPI_TX_DUAL’?
  if (mode & SPI_TX_OCTAL)
...

Update the header with octal values.

Fixes: 896fa735084e ("spi: spidev_test: Add support for Octal mode data transfers")
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 include/uapi/linux/spi/spidev.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/linux/spi/spidev.h b/include/uapi/linux/spi/spidev.h
index ee0f2460bff6..f0c95f5cc719 100644
--- a/include/uapi/linux/spi/spidev.h
+++ b/include/uapi/linux/spi/spidev.h
@@ -48,6 +48,8 @@
 #define SPI_TX_QUAD		0x200
 #define SPI_RX_DUAL		0x400
 #define SPI_RX_QUAD		0x800
+#define SPI_TX_OCTAL		0x2000
+#define SPI_RX_OCTAL		0x4000
 
 /*---------------------------------------------------------------------------*/
 
-- 
2.26.2

