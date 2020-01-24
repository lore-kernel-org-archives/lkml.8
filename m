Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FF9C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A4E21569
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579858825;
	bh=TWoRDpwZvRipbJUFqnEf8OEHQIHpv21Q8sPzcDoVIz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=M0CXy8p8AjIU6YvkRdB9IKRSvc81+LTw5hYvSMrtNsHaTcRM6MMVoOW0cG8CdegXJ
	 QHbxE2N33OvlYorH8ruQS+MkUB4ouwW+8N7VLQGewHChmWnDsTWvJnoOX59FUll1rg
	 TYV77/iSES+WWhBHC+tnd0K0Ji/3GDFclJPadSkc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732428AbgAXJkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:40:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:37714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731041AbgAXJkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:40:21 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D9742087E;
        Fri, 24 Jan 2020 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579858820;
        bh=TWoRDpwZvRipbJUFqnEf8OEHQIHpv21Q8sPzcDoVIz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DG1ZPmpx3UAKx/fLDtfGFkhDCaQh01AnZG48VXNRA3VQPibGZ4E7tfnnlRFY14dRT
         VQCW+kz8tyOZQgSMzBB00DTN4zOuSsUyOboNxCRLdrnqCqi5NPWV6b0br7LKa3oRrF
         Fir2OVU5bjyOpuhxXwZYTQUEpEVU8S0FVIuokyCM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 065/102] power: supply: bd70528: Add MODULE_ALIAS to allow module auto loading
Date:   Fri, 24 Jan 2020 10:31:06 +0100
Message-Id: <20200124092816.197109313@linuxfoundation.org>
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

From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

[ Upstream commit 9480029fe5c24d482efad38dc631bd555fc7afe2 ]

The bd70528 charger driver is probed by MFD driver. Add MODULE_ALIAS
in order to allow udev to load the module when MFD sub-device cell for
charger is added.

Fixes: f8c7f7ddd8ef0 ("power: supply: Initial support for ROHM BD70528 PMIC charger block")
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/bd70528-charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/bd70528-charger.c b/drivers/power/supply/bd70528-charger.c
index 1bb32b7226d74..b8e1ec106627f 100644
--- a/drivers/power/supply/bd70528-charger.c
+++ b/drivers/power/supply/bd70528-charger.c
@@ -741,3 +741,4 @@ module_platform_driver(bd70528_power);
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
 MODULE_DESCRIPTION("BD70528 power-supply driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:bd70528-power");
-- 
2.20.1



