Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3062AC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0425222522
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579118589;
	bh=9g6+dZpdTD4bqzARd0MbhKZ9rSsEMK9QC14qdMzDSzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=itBhWihpoRh95K8aIxeooV6VD0bJmJ3mJ3US6kHnOjxzaCw/HrZg2HzoqmnoYSdN7
	 TfzPE0ksN1iA8fJ7vDADNoVStCTHDfnPmgWuVbexwUk17SVRWW+dQJw/CQ3SRtCGCT
	 FDsCIHjX9Yecq/IwQZn9wusVI+KW21w9NydXmQU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbgAOUDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:03:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:60126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgAOUDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:03:07 -0500
Received: from localhost.localdomain (unknown [194.230.155.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEF4E2465A;
        Wed, 15 Jan 2020 20:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579118587;
        bh=9g6+dZpdTD4bqzARd0MbhKZ9rSsEMK9QC14qdMzDSzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AVhGUWuiAfSORCjGMfcuZ8sZjSjgQ/qarkNsPAhLbxzLEvxzoj7FeIDFQ2AWZJl9o
         Gc/Wbz4LROqMns6yBmLJ8sY4z5CkOxsBNkyLxiCoqJALQwPUMvc4IoI5hV8R6xCsuT
         JzPoyuYaleAzxQslbf4QWQWLDhchd6kbAI4YlIvA=
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
Subject: [PATCH v3 2/3] i2c: pnx: Use proper printk format for resource_size_t
Date:   Wed, 15 Jan 2020 21:02:49 +0100
Message-Id: <20200115200250.10849-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200115200250.10849-1-krzk@kernel.org>
References: <20200115200250.10849-1-krzk@kernel.org>
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

    drivers/i2c/busses/i2c-pnx.c: In function ‘i2c_pnx_probe’:
    drivers/i2c/busses/i2c-pnx.c:737:47: warning:
        format ‘%x’ expects argument of type ‘unsigned int’,
        but argument 5 has type ‘resource_size_t {aka long long unsigned int}’ [-Wformat=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v2:
1. Remove parentheses around res->start.

Changes since v1:
1. Use %pap, not %pa[p].
---
 drivers/i2c/busses/i2c-pnx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 6e0e546ef83f..686c06f31625 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -734,8 +734,8 @@ static int i2c_pnx_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto out_clock;
 
-	dev_dbg(&pdev->dev, "%s: Master at %#8x, irq %d.\n",
-		alg_data->adapter.name, res->start, alg_data->irq);
+	dev_dbg(&pdev->dev, "%s: Master at %pap, irq %d.\n",
+		alg_data->adapter.name, &res->start, alg_data->irq);
 
 	return 0;
 
-- 
2.17.1

