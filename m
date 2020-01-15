Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E77C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF6822522
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579118583;
	bh=Fjhdo6tlNS+TM3exEZ1PBARDjQL/dzKue6ba+z8ZYOo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=L0ITJChQvaH2Y4wb2sL37hu+RlB7p5pc836CkMp/HgmjvfEET6FZeaYux+HIJMV0M
	 wJxM1uGo8wnfxxVAjPtRU+BUNXhk26ISSY8UN6HBNdwE3uNfGnzflJ9t45IHSuyTsj
	 CP2sXB+m5OvUQp6bR7DiKh85EgQckWwMyMHn2kHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729650AbgAOUDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:03:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:60018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgAOUDC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:03:02 -0500
Received: from localhost.localdomain (unknown [194.230.155.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58CF7222C3;
        Wed, 15 Jan 2020 20:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579118581;
        bh=Fjhdo6tlNS+TM3exEZ1PBARDjQL/dzKue6ba+z8ZYOo=;
        h=From:To:Cc:Subject:Date:From;
        b=OFIW95j6vpOtPHUV4Da+AM9JfDfFmXyWSd8Qe0zAg1LJJ1e9I9p0o6FKptZng7Ttt
         0z7cwdG3fmmy+KXQK7b2z59qzrmycXk0oS4ThcYm18a2z4TBN4kTeCmNreuOLYuo8A
         3KVwtJg+jgMx3U7faNDRY/x3uX7pgOSRvjQJwDX4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jean Delvare <jdelvare@suse.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 1/3] i2c: pmcmsp: Use proper printk format for resource_size_t
Date:   Wed, 15 Jan 2020 21:02:48 +0100
Message-Id: <20200115200250.10849-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

resource_size_t should be printed with its own size-independent format
to fix warnings when compiling on 64-bit platform (e.g. with
COMPILE_TEST):

    drivers/i2c/busses/i2c-pmcmsp.c: In function ‘pmcmsptwi_probe’:
    drivers/i2c/busses/i2c-pmcmsp.c:276:25: warning:
        format ‘%x’ expects argument of type ‘unsigned int’,
        but argument 3 has type ‘resource_size_t {aka long long unsigned int}’ [-Wformat=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. Remove parentheses around res->start.

Changes since v1:
1. Use %pap, not %pa[p].
---
 drivers/i2c/busses/i2c-pmcmsp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
index 4fde74eb34a7..5d89c7c1b3a8 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -274,8 +274,8 @@ static int pmcmsptwi_probe(struct platform_device *pldev)
 	if (!request_mem_region(res->start, resource_size(res),
 				pldev->name)) {
 		dev_err(&pldev->dev,
-			"Unable to get memory/io address region 0x%08x\n",
-			res->start);
+			"Unable to get memory/io address region %pap\n",
+			&res->start);
 		rc = -EBUSY;
 		goto ret_err;
 	}
@@ -285,7 +285,7 @@ static int pmcmsptwi_probe(struct platform_device *pldev)
 						resource_size(res));
 	if (!pmcmsptwi_data.iobase) {
 		dev_err(&pldev->dev,
-			"Unable to ioremap address 0x%08x\n", res->start);
+			"Unable to ioremap address %pap\n", &res->start);
 		rc = -EIO;
 		goto ret_unreserve;
 	}
-- 
2.17.1

