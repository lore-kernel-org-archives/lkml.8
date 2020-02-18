Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86634C34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AF42464E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582055905;
	bh=sxy4tI9unjHyXjtMuYgOqv37W4y7fCByf7CdtlFP7pI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=un7w90gmGcwyBpTYcva2Eadw/NwoTPSBJ/GDEJ7iYq0RnyfAUhLwCPOOceUWf01lK
	 K4YkKwazQmg1MGz5KZCkp7/s5ojslNw52z1w4/pIY+B7ilVFlYNfBfOP29LNc9c+ZO
	 OXrIMhZJgWFYuPfmDdux4kX9d0tV8V2RKvuyTdgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgBRT6Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:58:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:35950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727637AbgBRT6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:58:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E02E24686;
        Tue, 18 Feb 2020 19:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582055899;
        bh=sxy4tI9unjHyXjtMuYgOqv37W4y7fCByf7CdtlFP7pI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=19DAutQqNRs3kFdRzGHEw631WIBIq5nbSuyUhj8Hk57Q7iaBR2pg3KYmmP/6Xxwoi
         psBdWNqjuwhNhEtgn4uSZHkfpL5lf1V3RpDMughlDUOdRcCdoNpezVlKi4o1DnHxLZ
         UtQ/zNVpbIeqC+H8wfaLgWEBEZ281HamfXusGASE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Thomas <pthomas8589@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 5.4 24/66] gpio: xilinx: Fix bug where the wrong GPIO register is written to
Date:   Tue, 18 Feb 2020 20:54:51 +0100
Message-Id: <20200218190430.318532041@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190428.035153861@linuxfoundation.org>
References: <20200218190428.035153861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Thomas <pthomas8589@gmail.com>

commit c3afa804c58e5c30ac63858b527fffadc88bce82 upstream.

Care is taken with "index", however with the current version
the actual xgpio_writereg is using index for data but
xgpio_regoffset(chip, i) for the offset. And since i is already
incremented it is incorrect. This patch fixes it so that index
is used for the offset too.

Cc: stable@vger.kernel.org
Signed-off-by: Paul Thomas <pthomas8589@gmail.com>
Link: https://lore.kernel.org/r/20200125221410.8022-1-pthomas8589@gmail.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpio-xilinx.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpio/gpio-xilinx.c
+++ b/drivers/gpio/gpio-xilinx.c
@@ -147,9 +147,10 @@ static void xgpio_set_multiple(struct gp
 	for (i = 0; i < gc->ngpio; i++) {
 		if (*mask == 0)
 			break;
+		/* Once finished with an index write it out to the register */
 		if (index !=  xgpio_index(chip, i)) {
 			xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
-				       xgpio_regoffset(chip, i),
+				       index * XGPIO_CHANNEL_OFFSET,
 				       chip->gpio_state[index]);
 			spin_unlock_irqrestore(&chip->gpio_lock[index], flags);
 			index =  xgpio_index(chip, i);
@@ -165,7 +166,7 @@ static void xgpio_set_multiple(struct gp
 	}
 
 	xgpio_writereg(chip->regs + XGPIO_DATA_OFFSET +
-		       xgpio_regoffset(chip, i), chip->gpio_state[index]);
+		       index * XGPIO_CHANNEL_OFFSET, chip->gpio_state[index]);
 
 	spin_unlock_irqrestore(&chip->gpio_lock[index], flags);
 }


