Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEF3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A92E21556
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 10:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579860283;
	bh=BAuGnV6ApDLBskZlToVXtsrcdU/YeZu3hnzsSO+iKSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qpMvleiqna2nL4r/gVwl4XAjMKsvxTt0cj0KDo/D4dfvvfwQ82wsLqQUI3dBcDDlG
	 LX7R7a0bL07SoLtljFoiyIB47k5ahRMcEx5My3jg8sLmyb6o5pZW9gFqhqdjUIp7Ec
	 yT4zFNMgIDhTANtdRlFggJYQOm2mX2+RocHIC9Mk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389146AbgAXKEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 05:04:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730743AbgAXKEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 05:04:37 -0500
Received: from localhost (unknown [145.15.244.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F321214DB;
        Fri, 24 Jan 2020 10:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579860277;
        bh=BAuGnV6ApDLBskZlToVXtsrcdU/YeZu3hnzsSO+iKSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uSBgp08EJISKiPzCoO6D+rXLPoVjtC9AXG/5aosyPoIdZ+DQfd6Yr1UN3TOpa8r2o
         istM1eteTSPG5D5lHkxpYi3k4797EBE0WjZlWpONc1iF7fFNT0/Yo665cSj4OteM3x
         RSeqLsbVX0ooQvCQOrr0JMBK1l++GcAiovm+kSL0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Robertson <dan@dlrobertson.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 301/343] hwmon: (shtc1) fix shtc1 and shtw1 id mask
Date:   Fri, 24 Jan 2020 10:31:59 +0100
Message-Id: <20200124092959.489155447@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124092919.490687572@linuxfoundation.org>
References: <20200124092919.490687572@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Robertson <dan@dlrobertson.com>

[ Upstream commit fdc7d8e829ec755c5cfb2f5a8d8c0cdfb664f895 ]

Fix an error in the bitmaskfor the shtc1 and shtw1 bitmask used to
retrieve the chip ID from the ID register. See section 5.7 of the shtw1
or shtc1 datasheet for details.

Fixes: 1a539d372edd9832444e7a3daa710c444c014dc9 ("hwmon: add support for Sensirion SHTC1 sensor")
Signed-off-by: Dan Robertson <dan@dlrobertson.com>
Link: https://lore.kernel.org/r/20190905014554.21658-3-dan@dlrobertson.com
[groeck: Reordered to be first in series and adjusted accordingly]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/shtc1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/shtc1.c b/drivers/hwmon/shtc1.c
index decd7df995abf..2a18539591eaf 100644
--- a/drivers/hwmon/shtc1.c
+++ b/drivers/hwmon/shtc1.c
@@ -38,7 +38,7 @@ static const unsigned char shtc1_cmd_read_id_reg[]	       = { 0xef, 0xc8 };
 
 /* constants for reading the ID register */
 #define SHTC1_ID	  0x07
-#define SHTC1_ID_REG_MASK 0x1f
+#define SHTC1_ID_REG_MASK 0x3f
 
 /* delays for non-blocking i2c commands, both in us */
 #define SHTC1_NONBLOCKING_WAIT_TIME_HPM  14400
-- 
2.20.1



