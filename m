Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2424BC433F8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00EB82070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262075;
	bh=1H5+7kJO9eaqpbN5JgnI5mNMkNUZHr0WnC6h16aXQEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c1sc2sUWmJI+E4/rd+TiPTIKQp6OGgwAQHMhgoHEGSPkBJ7L1SdLqbfHkL8m2ZedA
	 oWuf+Zf4g4aD6wptM2YCGvluNixc8dESCkneTG8AqpeIjXelWsCBWiTA++W/0+tz+4
	 TjUlf/8W5zF/m9BxJ9rh+WmRn69gFtn9ljhfb9hg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733308AbgGTQIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:08:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733292AbgGTQIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:08:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8371F20672;
        Mon, 20 Jul 2020 16:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261304;
        bh=1H5+7kJO9eaqpbN5JgnI5mNMkNUZHr0WnC6h16aXQEM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OGtFQuOvzgGf6ep0ye8lVBO/Q7/Ud4xlYkEVudlagSdc1j7LtPIrHJEk7YqfvGLC+
         B52jjg7/BfYU8GmZ3/FTsdZ9v4YtUP35V1Y0X6adp8pMmsVKOPzq3ihBKqjbvSEB1s
         C0Sedmmb5gzudjgqDUqhvYNetpgCCpx327iyBuD0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Stable@vger.kernel.org
Subject: [PATCH 5.7 067/244] iio:pressure:ms5611 Fix buffer element alignment
Date:   Mon, 20 Jul 2020 17:35:38 +0200
Message-Id: <20200720152829.043924062@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

commit 8db4afe163bbdd93dca6fcefbb831ef12ecc6b4d upstream.

One of a class of bugs pointed out by Lars in a recent review.
iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
to the size of the timestamp (8 bytes).  This is not guaranteed in
this driver which uses an array of smaller elements on the stack.
Here there is no data leak possibility so use an explicit structure
on the stack to ensure alignment and nice readable fashion.

The forced alignment of ts isn't strictly necessary in this driver
as the padding will be correct anyway (there isn't any).  However
it is probably less fragile to have it there and it acts as
documentation of the requirement.

Fixes: 713bbb4efb9dc ("iio: pressure: ms5611: Add triggered buffer support")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/pressure/ms5611_core.c |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -212,16 +212,21 @@ static irqreturn_t ms5611_trigger_handle
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ms5611_state *st = iio_priv(indio_dev);
-	s32 buf[4]; /* s32 (pressure) + s32 (temp) + 2 * s32 (timestamp) */
+	/* Ensure buffer elements are naturally aligned */
+	struct {
+		s32 channels[2];
+		s64 ts __aligned(8);
+	} scan;
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = ms5611_read_temp_and_pressure(indio_dev, &buf[1], &buf[0]);
+	ret = ms5611_read_temp_and_pressure(indio_dev, &scan.channels[1],
+					    &scan.channels[0]);
 	mutex_unlock(&st->lock);
 	if (ret < 0)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buf,
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
 					   iio_get_time_ns(indio_dev));
 
 err:


