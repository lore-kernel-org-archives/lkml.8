Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB744C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16A02071C
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584444039;
	bh=6RgVC7PG6F38PUNRjg8qI+Jf2B32drE7YGtE2f8ELfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SEmAlR5E1h0ec3zdM1dnnOjBjyp9Be69fyXqpJOuSrt6lRLMWIKeKVmTVcB+zuS15
	 VrmikKkAtTkUacmrT4HHQ6c14ZHsYnw+MXdyk/KRaJL8cQifk1kOa98VV20Cc0x2hn
	 5zgTUfJzcRaIskCBZte4eU4p67w9aMdNQ42tvQiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgCQLUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:20:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:39520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbgCQLAV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:00:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05EEC20735;
        Tue, 17 Mar 2020 11:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442821;
        bh=6RgVC7PG6F38PUNRjg8qI+Jf2B32drE7YGtE2f8ELfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IMVGwd/S92NBbtDyUleVINeCdy3CPdcg0ARjCnGuEAy8OX4aKlKQa9zHDpjHnPtqi
         aj9DYCp4LOZS5Hl7C6OuID0Z1A+++yhHyzXLYdo8r317isUUGlGra8UI0b+6N5Ifdb
         4C7FmlXOBk8EucILWuitsVVuC46vmT/NF137RZsI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.19 74/89] i2c: gpio: suppress error on probe defer
Date:   Tue, 17 Mar 2020 11:55:23 +0100
Message-Id: <20200317103308.463712953@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103259.744774526@linuxfoundation.org>
References: <20200317103259.744774526@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hamish Martin <hamish.martin@alliedtelesis.co.nz>

commit 3747cd2efe7ecb9604972285ab3f60c96cb753a8 upstream.

If a GPIO we are trying to use is not available and we are deferring
the probe, don't output an error message.
This seems to have been the intent of commit 05c74778858d
("i2c: gpio: Add support for named gpios in DT") but the error was
still output due to not checking the updated 'retdesc'.

Fixes: 05c74778858d ("i2c: gpio: Add support for named gpios in DT")
Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-gpio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-gpio.c
+++ b/drivers/i2c/busses/i2c-gpio.c
@@ -248,7 +248,7 @@ static struct gpio_desc *i2c_gpio_get_de
 	if (ret == -ENOENT)
 		retdesc = ERR_PTR(-EPROBE_DEFER);
 
-	if (ret != -EPROBE_DEFER)
+	if (PTR_ERR(retdesc) != -EPROBE_DEFER)
 		dev_err(dev, "error trying to get descriptor: %d\n", ret);
 
 	return retdesc;


