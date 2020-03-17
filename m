Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9308BC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68E0420663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443647;
	bh=H0rW0vMvQM2DtkjsZ50Ys26s3AYXpZbX2s0A4tQT7rA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ImpLjuEJ5UzHbLR4CEQCpt98mOp9rZnwDb+6fgz80k82lMk45VPq8GrQj+AgPjMLZ
	 faWskPde6uvv4qL42G1PX2xett8LpDeFmQzSrRfYdNyfZ7FAs5XJcr0wRiPy8Z+oMl
	 EGvOe0pxrf7DSTPuNiJnliId7/2KQosrmRLvAI88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgCQLOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:14:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbgCQLOC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:14:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E98512071C;
        Tue, 17 Mar 2020 11:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443642;
        bh=H0rW0vMvQM2DtkjsZ50Ys26s3AYXpZbX2s0A4tQT7rA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jVo0UEUogb7xnM+u72yo5f+qzHwmsYy3dBYRy6juMNcNy0AwLOMkcoBqrXTFeiLoE
         f6Je/C5/jxXdjPhRWcD3xzKVFO31MlQkifPurshlVI+uwWDIQkltiGH5EhepAjJ3io
         uDMKXSYpHuYx2HKyTMzURndrbvY0AS0IVCprl9eg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Hamish Martin <hamish.martin@alliedtelesis.co.nz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 5.5 135/151] i2c: gpio: suppress error on probe defer
Date:   Tue, 17 Mar 2020 11:55:45 +0100
Message-Id: <20200317103336.021229669@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
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
@@ -348,7 +348,7 @@ static struct gpio_desc *i2c_gpio_get_de
 	if (ret == -ENOENT)
 		retdesc = ERR_PTR(-EPROBE_DEFER);
 
-	if (ret != -EPROBE_DEFER)
+	if (PTR_ERR(retdesc) != -EPROBE_DEFER)
 		dev_err(dev, "error trying to get descriptor: %d\n", ret);
 
 	return retdesc;


