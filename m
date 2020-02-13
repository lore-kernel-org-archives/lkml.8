Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79018C47409
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AED320675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608545;
	bh=vNPMprNZO85pdHOgUqQWKIPreakOIp/WAWMve8AOrFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UpmMfruLiXpxw08Y/DbQkaJyH3uuu+9C/ZRCJVRHgaTbEoP99+7jHzrcqPkNRl+8Q
	 atqFR0LyydsKPNTHdbbvtjMpf5U3uFXHl5hhuQKrvDzHdvhF4k2ScjeK1Ie6F5CT73
	 x8QuqDrKpf+5W27sNmWxxa4YKKYCcmYJapcgFzAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbgBMP2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:28:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:42402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729074AbgBMPZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:25:48 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73D4824690;
        Thu, 13 Feb 2020 15:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607547;
        bh=vNPMprNZO85pdHOgUqQWKIPreakOIp/WAWMve8AOrFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qN8ZLqmAq72TM4lG6AZ+77NXLtGPDt6dXdCqRPDRMWzPqer7fNYumy2sRo0ALeME7
         i7FLCj1ZuVOK+0zeKdwCnQ4ex8bUmgoSJnGZV/pVvZXlFn46vDHdnQf53Hvyn81tsK
         NoUItGZBfYzwLnabjNxUWk+GKAjtZSmXe6zBmLXw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.14 110/173] mfd: da9062: Fix watchdog compatible string
Date:   Thu, 13 Feb 2020 07:20:13 -0800
Message-Id: <20200213152000.320557764@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Felsch <m.felsch@pengutronix.de>

commit 1112ba02ff1190ca9c15a912f9269e54b46d2d82 upstream.

The watchdog driver compatible is "dlg,da9062-watchdog" and not
"dlg,da9062-wdt". Therefore the mfd-core can't populate the of_node and
fwnode. As result the watchdog driver can't parse the devicetree.

Fixes: 9b40b030c4ad ("mfd: da9062: Supply core driver")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mfd/da9062-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -257,7 +257,7 @@ static const struct mfd_cell da9062_devs
 		.name		= "da9062-watchdog",
 		.num_resources	= ARRAY_SIZE(da9062_wdt_resources),
 		.resources	= da9062_wdt_resources,
-		.of_compatible  = "dlg,da9062-wdt",
+		.of_compatible  = "dlg,da9062-watchdog",
 	},
 	{
 		.name		= "da9062-thermal",


