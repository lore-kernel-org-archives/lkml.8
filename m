Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC2AC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC41120714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339277;
	bh=9Sl9JUJekRdZMRB1FyI7vJki+XqxXk0x+zns+DiSHyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rs8MBC5N0esoN+F8fPtQqnROkPwQDzgu7a4ZNM3eONgQ7Xaa+DTIBFRU1fIuLIXXj
	 zaHqZujtakUxYPxkOxM/DlRLb4GMGyAZ919YMkoT6T7U7z2rAssCE4PdvhtEaPk4LZ
	 3cQbnSgnq1h879Fp5QfJNiLnnFnkYBAM302Nmzk4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbgBJMl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:41:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:35748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729284AbgBJMi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:38:59 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEF4820733;
        Mon, 10 Feb 2020 12:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338338;
        bh=9Sl9JUJekRdZMRB1FyI7vJki+XqxXk0x+zns+DiSHyk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jeLgYQb6Pja6NcNBqI1xzocJRzubeT89x1/GkVlJaTmFD9EP3wmZbuhimY3+/ZeDO
         Oyhm81HuofGDxSNgfDlUQk0ygtfLKQGXZap/2GPpw80YFFVEmQEZGra5Vt+aBlddXM
         ifThw1ipyMoq6X2V9SuYF7w/VrwWA1C3AAsW3pro=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 5.4 288/309] mfd: da9062: Fix watchdog compatible string
Date:   Mon, 10 Feb 2020 04:34:04 -0800
Message-Id: <20200210122434.329253436@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
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
@@ -248,7 +248,7 @@ static const struct mfd_cell da9062_devs
 		.name		= "da9062-watchdog",
 		.num_resources	= ARRAY_SIZE(da9062_wdt_resources),
 		.resources	= da9062_wdt_resources,
-		.of_compatible  = "dlg,da9062-wdt",
+		.of_compatible  = "dlg,da9062-watchdog",
 	},
 	{
 		.name		= "da9062-thermal",


