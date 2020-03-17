Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA9BC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4258220724
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584456921;
	bh=0AuL5ik1PkjJ+CosUbhOjV9BkLKR6KOQzFJir/RXkZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UQB56qLDDkIVy21JLKybpdJPHSK7Sn1/QurY87IMcoEMMfGGc5ljeByWyTm9xf0fy
	 +Be908AJZ+9G1EE5oSPFNYIIWQ/9km/eZODf8f41B10JR2uz1BNYqU4+uz2cqwkjmc
	 1GIK5Hr4H6qxKpmeC3AaO4ynZurybt8eMR6EwIU8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgCQOzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:55:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:43612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbgCQOyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:54:31 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B232320774;
        Tue, 17 Mar 2020 14:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584456870;
        bh=0AuL5ik1PkjJ+CosUbhOjV9BkLKR6KOQzFJir/RXkZg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8ldmA9DU/iSxsfnETccdctspko9w3ZRBbUmLw54wnHXP3hLUrbXj27KYlCBcQIGu
         wPbAvFJvAaPuUKtwJqRau9wtNa4BUEE8ed5Y1Rz+z25ju6vnRvr7mAT0GHq8mh3cvX
         zK8bmMlESnTs+4IeG7gojw74UawFtBD5ikVvjA2k=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jEDbw-000AN5-Px; Tue, 17 Mar 2020 15:54:28 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org
Subject: [PATCH 12/17] gpio: gpiolib.c: fix a doc warning
Date:   Tue, 17 Mar 2020 15:54:21 +0100
Message-Id: <51197e3568f073e22c280f0584bfa20b44436708.1584456635.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584456635.git.mchehab+huawei@kernel.org>
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use a different markup for the ERR_PTR, as %FOO doesn't work
if there are parenthesis. So, use, instead:

	``ERR_PTR(-EINVAL)``

This fixes the following warning:

	./drivers/gpio/gpiolib.c:139: WARNING: Inline literal start-string without end-string.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index f31b1d46599e..74d8973025da 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -136,7 +136,7 @@ EXPORT_SYMBOL_GPL(gpio_to_desc);
  * @hwnum: hardware number of the GPIO for this chip
  *
  * Returns:
- * A pointer to the GPIO descriptor or %ERR_PTR(-EINVAL) if no GPIO exists
+ * A pointer to the GPIO descriptor or ``ERR_PTR(-EINVAL)`` if no GPIO exists
  * in the given chip for the specified hardware number.
  */
 struct gpio_desc *gpiochip_get_desc(struct gpio_chip *chip,
-- 
2.24.1

