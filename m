Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A51C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDF4E20738
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592203779;
	bh=FcwAg0ZkLADpZDIiqLF7eKTLkbJL6UdvFue4KTmGrvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yEySvRmsE64SwI366CCk+GnYQBd8r35xbB+gOGTXqDccRaI6pAYFHzt2f+KlVRap1
	 pVRuX9kXFpFWaxrITfuMH14eTQRO+7b9Sdl4m1n4qTWIqsEK1a5SAXKkQbuOlwNrRD
	 /fZ1bwZzVuC0pA+z/+T2Y26nCsSjNRiAMTW5N+yg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgFOGti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728407AbgFOGrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:47:12 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A37352076A;
        Mon, 15 Jun 2020 06:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203631;
        bh=FcwAg0ZkLADpZDIiqLF7eKTLkbJL6UdvFue4KTmGrvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=usLX2Abq+iiAPASL2bSQneycsQufGkMW8SI0aEGOL8Me7pb7f7Ej1VPQ960FxHiRf
         PoZ7OdWgpCs1xN2QPjdOlMm/66SORLKJp7K4DqwYHYXaFzysK94n4Ts/RIMs+KdLmr
         qnh2twMae0Oqr6UPCKgqnBOAAyzcVtWeahqFx9ko=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkith-009nmT-JV; Mon, 15 Jun 2020 08:47:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org
Subject: [PATCH 08/29] gpio: driver.h: fix kernel-doc markup
Date:   Mon, 15 Jun 2020 08:46:47 +0200
Message-Id: <97beeedde507eaeea189ae955c9f35ecf1563d6d.1592203542.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203542.git.mchehab+huawei@kernel.org>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is one parameter with a wrong name at kernel-doc macro:

./include/linux/gpio/driver.h:499: warning: Function parameter or member 'gc' not described in 'gpiochip_add_data'
./include/linux/gpio/driver.h:499: warning: Excess function parameter 'chip' description in 'gpiochip_add_data'

Fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/linux/gpio/driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index c4f272af7af5..c11261f3c724 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -481,7 +481,7 @@ extern int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 
 /**
  * gpiochip_add_data() - register a gpio_chip
- * @chip: the chip to register, with chip->base initialized
+ * @gc: the chip to register, with chip->base initialized
  * @data: driver-private data associated with this chip
  *
  * Context: potentially before irqs will work
-- 
2.26.2

