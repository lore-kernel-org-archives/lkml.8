Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE04C35249
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C9420838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580746815;
	bh=vqubxs6+eFD3QAHoy6krcLmtQbua3VW2Le5LmL+kMro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y9tNuazSPSzjs8edGkxbqHfI9nW5Xp3htX7jR3IYbc48ktygB9R9N1YNNmDnAvkfH
	 CcoLs/bNWNuQLQR6R7uyKTnXWItCA4OJFmKcymEFt9CKjOqhSCEJkSXMB2vTkdgzAd
	 xR/29C0iMhC+YddxrksE6ab99UKx2sAKrp+4qzGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgBCQUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:20:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728766AbgBCQUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:20:10 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F44E20CC7;
        Mon,  3 Feb 2020 16:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580746809;
        bh=vqubxs6+eFD3QAHoy6krcLmtQbua3VW2Le5LmL+kMro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K2xVCn6pploOOqFtqnsxJoOzyEehZslfoG2Jzj9BwR/BX+OHK2ftooHsg26hPm7re
         ywD+82r266/fEhypmMlTk4Fqv07aJjOljXf9khjuX+JOzfjRw/h3be0fioFK5xSKzn
         BHLjic18ftYcchLRIWe2bzzJ1R0RR01dDdew4CYw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 16/53] watchdog: rn5t618_wdt: fix module aliases
Date:   Mon,  3 Feb 2020 16:19:08 +0000
Message-Id: <20200203161906.102346850@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161902.714326084@linuxfoundation.org>
References: <20200203161902.714326084@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Kemnade <andreas@kemnade.info>

[ Upstream commit a76dfb859cd42df6e3d1910659128ffcd2fb6ba2 ]

Platform device aliases were missing so module autoloading
did not work.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20191213214802.22268-1-andreas@kemnade.info
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/watchdog/rn5t618_wdt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/watchdog/rn5t618_wdt.c b/drivers/watchdog/rn5t618_wdt.c
index d1c12278cb6a1..8b6eff26e4808 100644
--- a/drivers/watchdog/rn5t618_wdt.c
+++ b/drivers/watchdog/rn5t618_wdt.c
@@ -193,6 +193,7 @@ static struct platform_driver rn5t618_wdt_driver = {
 
 module_platform_driver(rn5t618_wdt_driver);
 
+MODULE_ALIAS("platform:rn5t618-wdt");
 MODULE_AUTHOR("Beniamino Galvani <b.galvani@gmail.com>");
 MODULE_DESCRIPTION("RN5T618 watchdog driver");
 MODULE_LICENSE("GPL v2");
-- 
2.20.1



