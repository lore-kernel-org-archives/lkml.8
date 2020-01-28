Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2945DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3D1424696
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220756;
	bh=BWXwgTC96yH7/4lNOVVuyOOwuCEhDNyxq4OtgQUKj9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mV0ipq17SFlZJG8+Z0tXMZa/5oGk6kEnhNz1iNOB96h6lzdLJbNg6ll10Lg8Diz+t
	 v7tIdGKhNAsg/QJvsx1aQ8gzjowvQsVyP9RedULuiXUmsPwzslrbNpPQ0tLCDi3XCy
	 0gieQIOI51gtpo1BQIxx8B9rmjtyvF6eCLK/uzN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgA1OMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:12:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:33862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727345AbgA1OMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:12:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 540932468D;
        Tue, 28 Jan 2020 14:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220750;
        bh=BWXwgTC96yH7/4lNOVVuyOOwuCEhDNyxq4OtgQUKj9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k+hhK53KsIwsDp1jeZrOjd1EMzdJ5r0yueraTVxw7pxwMFF8TZjwWKrvaippp/zr8
         W+lr5l2HqTbQRdrRu6SRkHkMyNBAbcr+P2B9NKDKorV5l2kF+3ONlBx143hg5RXnx3
         TdKEcSKiTxpp832S3VoEfijMl8cp0+nDbj0WRhBQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 132/183] iio: dac: ad5380: fix incorrect assignment to val
Date:   Tue, 28 Jan 2020 15:05:51 +0100
Message-Id: <20200128135843.006986780@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit b1e18768ef1214c0a8048327918a182cabe09f9d ]

Currently the pointer val is being incorrectly incremented
instead of the value pointed to by val. Fix this by adding
in the missing * indirection operator.

Addresses-Coverity: ("Unused value")
Fixes: c03f2c536818 ("staging:iio:dac: Add AD5380 driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/dac/ad5380.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5380.c b/drivers/iio/dac/ad5380.c
index 97d2c5111f438..8bf7fc626a9d4 100644
--- a/drivers/iio/dac/ad5380.c
+++ b/drivers/iio/dac/ad5380.c
@@ -221,7 +221,7 @@ static int ad5380_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 		*val >>= chan->scan_type.shift;
-		val -= (1 << chan->scan_type.realbits) / 2;
+		*val -= (1 << chan->scan_type.realbits) / 2;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 2 * st->vref;
-- 
2.20.1



