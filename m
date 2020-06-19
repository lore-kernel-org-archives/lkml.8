Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5CAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAA892166E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592582848;
	bh=yWzuLIfLozYcOoBM8fQyerjEmRLb21DzZp64pt8yd9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RVpR+VAWDkpZGvQOuTxlHHDqy5lEMK/PHYe64rDv4o2cWuNaYm1XIdfjV2VlNgmYI
	 DZLBd/iwOOr1ByDDVNnxo5LwOCOwZ6c9w4UWz8hH3TJjstmrsyxwqdLFWSoVH7O1Jf
	 qKLIVCAAwEEr8AqmO3wH7R9ydjwIf27sEKfWuoPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391788AbgFSPIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:08:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:38156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390914AbgFSPIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:08:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5174421974;
        Fri, 19 Jun 2020 15:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579317;
        bh=yWzuLIfLozYcOoBM8fQyerjEmRLb21DzZp64pt8yd9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H1baSBv52JrcrV/LiugS+yuS4Q08/x/mGCvmiSCJDjbgvSZ5F3j7iVx3Yb8r51MvS
         DwBbZgtNd1AKw9ioU0Ac0Fh8oMPEwvJ/hYWzysyUbe8BmiwlJe2CfSMwmylrkLlUfh
         bP8EXNhBErUdAa7SBWEU+7AjzSIgxP6b/yl12oOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 060/261] spi: Respect DataBitLength field of SpiSerialBusV2() ACPI resource
Date:   Fri, 19 Jun 2020 16:31:11 +0200
Message-Id: <20200619141652.795737704@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141649.878808811@linuxfoundation.org>
References: <20200619141649.878808811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 0dadde344d965566589cd82797893d5aa06557a3 ]

By unknown reason the commit 64bee4d28c9e
  ("spi / ACPI: add ACPI enumeration support")
missed the DataBitLength property to encounter when parse SPI slave
device data from ACPI.

Fill the gap here.

Fixes: 64bee4d28c9e ("spi / ACPI: add ACPI enumeration support")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20200413180406.1826-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 6bfbf0cfcf63..c6242f0a307f 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1950,6 +1950,7 @@ static int acpi_spi_add_resource(struct acpi_resource *ares, void *data)
 			}
 
 			lookup->max_speed_hz = sb->connection_speed;
+			lookup->bits_per_word = sb->data_bit_length;
 
 			if (sb->clock_phase == ACPI_SPI_SECOND_PHASE)
 				lookup->mode |= SPI_CPHA;
-- 
2.25.1



