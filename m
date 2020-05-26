Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CFCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B6B320776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590521204;
	bh=Ll3i88I6dH+M1vcXVswOh7ONTIPk/HSwLa9ixcVzbH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zdkmwd9o8gc0nXPYdXe1cwglpLFoffRHneLuYNAzPm4c6vDeEbzm/xyktJVaHceCv
	 6VXdAluhtxBiIN+tGzY6pobaN7RtZkYy/MjGNZkB63bHafe0QZDXlIqM+K4RjNBH39
	 aXzjic68M6H3hXPwvu1MEh9o2Ye3ilJjVJzAc0ak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391006AbgEZTFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:05:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391473AbgEZTFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:05:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE14A20849;
        Tue, 26 May 2020 19:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519913;
        bh=Ll3i88I6dH+M1vcXVswOh7ONTIPk/HSwLa9ixcVzbH0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JCCN8qb8zBMhDwJ8vdO6wjtSgiqwkkqykP/f5FsXz21c4z+M5P0yETJm4EC+435xY
         +kbBneKf0hInsU2ANCEi6533WU2zm+9dUfoK3KnamjP2SyljGssKpiqs5NgBV/fYtK
         1IHrzdBxxeZ0ixFEAo7QXDan+0jxJwZNTDcG9hrc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.19 67/81] iio: sca3000: Remove an erroneous get_device()
Date:   Tue, 26 May 2020 20:53:42 +0200
Message-Id: <20200526183934.481786762@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183923.108515292@linuxfoundation.org>
References: <20200526183923.108515292@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 928edefbc18cd8433f7df235c6e09a9306e7d580 upstream.

This looks really unusual to have a 'get_device()' hidden in a 'dev_err()'
call.
Remove it.

While at it add a missing \n at the end of the message.

Fixes: 574fb258d636 ("Staging: IIO: VTI sca3000 series accelerometer driver (spi)")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/accel/sca3000.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -982,7 +982,7 @@ static int sca3000_read_data(struct sca3
 	st->tx[0] = SCA3000_READ_REG(reg_address_high);
 	ret = spi_sync_transfer(st->us, xfer, ARRAY_SIZE(xfer));
 	if (ret) {
-		dev_err(get_device(&st->us->dev), "problem reading register");
+		dev_err(&st->us->dev, "problem reading register\n");
 		return ret;
 	}
 


