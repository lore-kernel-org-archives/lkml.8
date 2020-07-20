Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41280C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C3872065E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261314;
	bh=IReQaCQ1JzU9pd3WgkQG2WkZwI3+Cf/nWKg9g+Jb9Do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ur9NBYWWeugEd8StGTYaiHMqy24nqkB8+Ez3Ne+ETfuG8FEnJM3t4YX5nepV/NazF
	 RCDffZ83VPSdk7cOULjmMX3tH2qXw4JxcXxUyXU9i+TyyNq+Sy7y5+wgcM428yXpvW
	 fRb3TNDhAis2wWeHuE4hRssze0JhObXCynNXOjCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbgGTQId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:08:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:45902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733300AbgGTQI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:08:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 475722064B;
        Mon, 20 Jul 2020 16:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261306;
        bh=IReQaCQ1JzU9pd3WgkQG2WkZwI3+Cf/nWKg9g+Jb9Do=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tbTNluYHU7wApbjAQQ/WFls6/lFYFFK8PMbecxf8l9ZdQhGz8foRWxXiGwcbqx1e5
         RhLn5CkxjPZtqIr7jSFgpL93xQ9gFKYjMADBYCggpI0M7tihjHQxW+tK76TkBWX7WB
         HX6OMswBL77rpnbXhwxtah2Av7IwFw4WeYd7XaU8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Andrew F. Davis" <afd@ti.com>, Stable@vger.kernel.org
Subject: [PATCH 5.7 068/244] iio:health:afe4403 Fix timestamp alignment and prevent data leak.
Date:   Mon, 20 Jul 2020 17:35:39 +0200
Message-Id: <20200720152829.084625643@linuxfoundation.org>
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

commit 3f9c6d38797e9903937b007a341dad0c251765d6 upstream.

One of a class of bugs pointed out by Lars in a recent review.
iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
to the size of the timestamp (8 bytes).  This is not guaranteed in
this driver which uses a 32 byte array of smaller elements on the stack.
As Lars also noted this anti pattern can involve a leak of data to
userspace and that indeed can happen here.  We close both issues by
moving to a suitable structure in the iio_priv() data with alignment
explicitly requested.  This data is allocated with kzalloc so no
data can leak appart from previous readings.

Fixes: eec96d1e2d31 ("iio: health: Add driver for the TI AFE4403 heart monitor")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Andrew F. Davis <afd@ti.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/health/afe4403.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -63,6 +63,7 @@ static const struct reg_field afe4403_re
  * @regulator: Pointer to the regulator for the IC
  * @trig: IIO trigger for this device
  * @irq: ADC_RDY line interrupt number
+ * @buffer: Used to construct data layout to push into IIO buffer.
  */
 struct afe4403_data {
 	struct device *dev;
@@ -72,6 +73,8 @@ struct afe4403_data {
 	struct regulator *regulator;
 	struct iio_trigger *trig;
 	int irq;
+	/* Ensure suitable alignment for timestamp */
+	s32 buffer[8] __aligned(8);
 };
 
 enum afe4403_chan_id {
@@ -309,7 +312,6 @@ static irqreturn_t afe4403_trigger_handl
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct afe4403_data *afe = iio_priv(indio_dev);
 	int ret, bit, i = 0;
-	s32 buffer[8];
 	u8 tx[4] = {AFE440X_CONTROL0, 0x0, 0x0, AFE440X_CONTROL0_READ};
 	u8 rx[3];
 
@@ -326,9 +328,9 @@ static irqreturn_t afe4403_trigger_handl
 		if (ret)
 			goto err;
 
-		buffer[i++] = (rx[0] << 16) |
-				(rx[1] << 8) |
-				(rx[2]);
+		afe->buffer[i++] = (rx[0] << 16) |
+				   (rx[1] << 8) |
+				   (rx[2]);
 	}
 
 	/* Disable reading from the device */
@@ -337,7 +339,8 @@ static irqreturn_t afe4403_trigger_handl
 	if (ret)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, afe->buffer,
+					   pf->timestamp);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 


