Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A8EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0208E2065E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261283;
	bh=faaFtAwdn5ulgFqYuEGAZuBize4Fl3s5R+QYmSR16Ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MQ8o/ChVYATi+ryGVH8OUF5w30QJELs30abOOkc6LAM8USfS/32u2wNMLGedpJoEj
	 k8+OSegBmvgcPTDcefMS63orU09v22xEKjr6DLET6GVUCd5WwOjtX55WU5oZist/NW
	 NBJdepQBkn85pVsZqRDmKFCfzFb+zgN+VRqFcI60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733238AbgGTQIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733224AbgGTQH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:07:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C1C02065E;
        Mon, 20 Jul 2020 16:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261276;
        bh=faaFtAwdn5ulgFqYuEGAZuBize4Fl3s5R+QYmSR16Ts=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KJ6FMO2/qmFYASjVPq+eSlLZr1emNZxoQj23D/WyDyAjUYFI0VRTJRek5bQt582f8
         HXlwEBt9J/1uLuDTu9GfHKoh+LyevvpIXwZZ8tdlNhfOu7FVhGuiFgpI7TFeAoSFMz
         peBu8G3w165ORc1dlBUNCm9rmrSVxxK6jDzAMJnY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 058/244] i2c: eg20t: Load module automatically if ID matches
Date:   Mon, 20 Jul 2020 17:35:29 +0200
Message-Id: <20200720152828.614591695@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 5f90786b31fb7d1e199a8999d46c4e3aea672e11 ]

The driver can't be loaded automatically because it misses
module alias to be provided. Add corresponding MODULE_DEVICE_TABLE()
call to the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-eg20t.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-eg20t.c b/drivers/i2c/busses/i2c-eg20t.c
index bb810dee8fb5e..73f139690e4e5 100644
--- a/drivers/i2c/busses/i2c-eg20t.c
+++ b/drivers/i2c/busses/i2c-eg20t.c
@@ -180,6 +180,7 @@ static const struct pci_device_id pch_pcidev_id[] = {
 	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7831_I2C), 1, },
 	{0,}
 };
+MODULE_DEVICE_TABLE(pci, pch_pcidev_id);
 
 static irqreturn_t pch_i2c_handler(int irq, void *pData);
 
-- 
2.25.1



