Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D9CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FB922173E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597916220;
	bh=yr1SDa0zPqE6iEOJH7QLxriE/fB8TR/45ppC0A2ud4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fgufrnbEi5LoLglfrG2PoIjTorYInCbv3BIU5TJpqtFZjr/RYzRqr4xBVXYYJjmBm
	 DkmNj/GQYXEIW0iMjsPC3fZBX1kzJUAG7GyD3vcp8nn+rIAkd91lRdup13nu09VCpx
	 6mJE+DaFN9gQ79/12V+YBBGQNp9YUo3hMmyJfyIk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgHTJg7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:36:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbgHTJgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:36:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3460C20724;
        Thu, 20 Aug 2020 09:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916210;
        bh=yr1SDa0zPqE6iEOJH7QLxriE/fB8TR/45ppC0A2ud4M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0NcFRaKundLr+/TaSIdmq5lGxExpTRf4Z1XF3utNEBou0XUtuZH2ambsQ299/B2Em
         wtnNoMxh2PztMNRJ+0PfOkdlTuRDsN3usIHYQjRr0ooK5j0hMUE3+oQ2NZTUuBivtD
         76l2TgjTAwGBgKbCZF7sYEw5K7EiO7FvsZUD8GcE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Jo=C3=A3o=20Henrique?= <johnnyonflame@hotmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5.7 048/204] pinctrl: ingenic: Properly detect GPIO direction when configured for IRQ
Date:   Thu, 20 Aug 2020 11:19:05 +0200
Message-Id: <20200820091608.677634018@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

commit 84e7a946da71f678affacea301f6d5cb4d9784e8 upstream.

The PAT1 register contains information about the IRQ type (edge/level)
for input GPIOs with IRQ enabled, and the direction for non-IRQ GPIOs.
So it makes sense to read it only if the GPIO has no interrupt
configured, otherwise input GPIOs configured for level IRQs are
misdetected as output GPIOs.

Fixes: ebd6651418b6 ("pinctrl: ingenic: Implement .get_direction for GPIO chips")
Reported-by: João Henrique <johnnyonflame@hotmail.com>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200622214548.265417-2-paul@crapouillou.net
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/pinctrl-ingenic.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/pinctrl/pinctrl-ingenic.c
+++ b/drivers/pinctrl/pinctrl-ingenic.c
@@ -1955,7 +1955,8 @@ static int ingenic_gpio_get_direction(st
 	unsigned int pin = gc->base + offset;
 
 	if (jzpc->info->version >= ID_JZ4760) {
-		if (ingenic_get_pin_config(jzpc, pin, JZ4760_GPIO_PAT1))
+		if (ingenic_get_pin_config(jzpc, pin, JZ4760_GPIO_INT) ||
+		    ingenic_get_pin_config(jzpc, pin, JZ4760_GPIO_PAT1))
 			return GPIO_LINE_DIRECTION_IN;
 		return GPIO_LINE_DIRECTION_OUT;
 	}


