Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D35C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82F0F20734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591725719;
	bh=9QiSaFPCF+LjbweQTWvY4JtLf48Yd8AZc7D1koPx13M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a+EagxZD6ivN24U/bZrok3F3JX9OPImdk3M96QAb73chh/BPcvbWBt/WFN9Fv9wyB
	 Qj1AsK3mZ3VWMuG3Rds26rwg2+zTlDvbMe4Fb0L5DKxckECHijb1459fZPEC2yjMpx
	 G1dQ9yQ59CziiXhXwCU7CFDDDdBX3Q8VS/5a9oGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732513AbgFISB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:01:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733050AbgFIRxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:53:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3299F20734;
        Tue,  9 Jun 2020 17:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591725232;
        bh=9QiSaFPCF+LjbweQTWvY4JtLf48Yd8AZc7D1koPx13M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KTfcrRVN+Q4ElyHH+62b5l9J2IzMldIdirPp5+FZ6K+2FeD8llzJygHBAwpP1oJxa
         A9fha9y6+ihvsuOzdXV2CUZ922vzuegk9gNYk4JX1/1w3iqNDTtfcxTnOfUXwLmEPD
         8uknm97IvXwXD3ELlgLPYLBtaM7wVn/8C6iAoOfw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stable@vger.kernel.org,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>
Subject: [PATCH 5.6 23/41] iio:chemical:sps30: Fix timestamp alignment
Date:   Tue,  9 Jun 2020 19:45:25 +0200
Message-Id: <20200609174114.336417041@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174112.129412236@linuxfoundation.org>
References: <20200609174112.129412236@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

commit a5bf6fdd19c327bcfd9073a8740fa19ca4525fd4 upstream.

One of a class of bugs pointed out by Lars in a recent review.
iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
to the size of the timestamp (8 bytes).  This is not guaranteed in
this driver which uses an array of smaller elements on the stack.

Fixes: 232e0f6ddeae ("iio: chemical: add support for Sensirion SPS30 sensor")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <Stable@vger.kernel.org>
Acked-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/chemical/sps30.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- a/drivers/iio/chemical/sps30.c
+++ b/drivers/iio/chemical/sps30.c
@@ -230,15 +230,18 @@ static irqreturn_t sps30_trigger_handler
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct sps30_state *state = iio_priv(indio_dev);
 	int ret;
-	s32 data[4 + 2]; /* PM1, PM2P5, PM4, PM10, timestamp */
+	struct {
+		s32 data[4]; /* PM1, PM2P5, PM4, PM10 */
+		s64 ts;
+	} scan;
 
 	mutex_lock(&state->lock);
-	ret = sps30_do_meas(state, data, 4);
+	ret = sps30_do_meas(state, scan.data, ARRAY_SIZE(scan.data));
 	mutex_unlock(&state->lock);
 	if (ret)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data,
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
 					   iio_get_time_ns(indio_dev));
 err:
 	iio_trigger_notify_done(indio_dev->trig);


