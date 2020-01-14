Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CABEC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8AA2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578992779;
	bh=ktitPwpINdb7kf8coUvwzu/zTyz4WiGC9/yS2YXnWbA=;
	h=From:To:Subject:Date:List-ID:From;
	b=kgC4fFhkhPhPzbQIq7pjSkLoMwdtrKC3+vbfCM4ZLuzTFepka5U2hYdHOw9Zb4h0t
	 bhHpnXmY3DfHyTY9nYiXgLQ9T7fZ8o1xk2CzIO11kW2UfZd0TrZkpxE43h35PFTN++
	 Ish4DtStdP90c84FZybUZOl+BGJrvjJI8PBEx3bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgANJGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:06:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:45140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgANJGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:06:18 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74F3C2075B;
        Tue, 14 Jan 2020 09:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578992777;
        bh=ktitPwpINdb7kf8coUvwzu/zTyz4WiGC9/yS2YXnWbA=;
        h=From:To:Subject:Date:From;
        b=xBzALEYWggLEPVN0C0sYgPtF2g9zm2aT+4ajRu689psD1Fpn7Miyatn+JWWcFJd76
         UCD76aeyI1Er7/WfyT3IIN7vMIedcEp46TZDGAmj/Et+gPVOxrLDWwF1paWLr0VL8N
         Xn8gMPYj4/svJ2cgF7OhnevThf/l88keZrhZ4dnc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Jean Delvare <jdelvare@suse.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH v2 1/4] i2c: pmcmsp: Use proper printk format for resource_size_t
Date:   Tue, 14 Jan 2020 10:06:02 +0100
Message-Id: <1578992765-1418-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
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

Changes since v1:
1. Use %pap, not %pa[p].
---
 drivers/i2c/busses/i2c-pmcmsp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pmcmsp.c b/drivers/i2c/busses/i2c-pmcmsp.c
index 4fde74eb34a7..9a2acf09f1cf 100644
--- a/drivers/i2c/busses/i2c-pmcmsp.c
+++ b/drivers/i2c/busses/i2c-pmcmsp.c
@@ -274,8 +274,8 @@ static int pmcmsptwi_probe(struct platform_device *pldev)
 	if (!request_mem_region(res->start, resource_size(res),
 				pldev->name)) {
 		dev_err(&pldev->dev,
-			"Unable to get memory/io address region 0x%08x\n",
-			res->start);
+			"Unable to get memory/io address region %pap\n",
+			&(res->start));
 		rc = -EBUSY;
 		goto ret_err;
 	}
@@ -285,7 +285,7 @@ static int pmcmsptwi_probe(struct platform_device *pldev)
 						resource_size(res));
 	if (!pmcmsptwi_data.iobase) {
 		dev_err(&pldev->dev,
-			"Unable to ioremap address 0x%08x\n", res->start);
+			"Unable to ioremap address %pap\n", &(res->start));
 		rc = -EIO;
 		goto ret_unreserve;
 	}
-- 
2.7.4

