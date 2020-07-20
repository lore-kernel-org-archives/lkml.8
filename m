Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F95DC433FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B68F2064B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260321;
	bh=4hKcacuzSJxqP6yYZUginvZpXGohejSQrLJwU190vW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DAk7rjjM6MVCXarnEm5O2jsTYf5CQ4gVjROVEM04T6R039VezjTHhygWfNfebAGpm
	 FptKnHlPJsGKCtxuj/IFgbi7srNEMqRtphkBTJqdt3cZdxOHLWopdnuaQg24DSiYYM
	 +Ltd6JYDB7SqvY5ObN49bZNwyqy8UrGd11zlwQqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731301AbgGTPv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:51:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730999AbgGTPv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:51:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF0EF2065E;
        Mon, 20 Jul 2020 15:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260316;
        bh=4hKcacuzSJxqP6yYZUginvZpXGohejSQrLJwU190vW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lmX8lAGVUttjKBJhxfbr78/aW3eGFuBCYh1JndhQvDRtSGNVxwLFVPw1xoCXUpgDH
         O7ucC0g3/bEB2kPh24zjXiDdyarWN4bgbUL0lo22vJMA8g2DdZSg3aWGb929rMN92d
         iuiVAvIW21Td5S8hUj4/GPCzrn4HTbhkl1tp/+Sg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Andrew F. Davis" <afd@ti.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 058/133] iio:health:afe4404 Fix timestamp alignment and prevent data leak.
Date:   Mon, 20 Jul 2020 17:36:45 +0200
Message-Id: <20200720152806.530074469@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152803.732195882@linuxfoundation.org>
References: <20200720152803.732195882@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[ Upstream commit f88ecccac4be348bbcc6d056bdbc622a8955c04d ]

One of a class of bugs pointed out by Lars in a recent review.
iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
to the size of the timestamp (8 bytes).  This is not guaranteed in
this driver which uses a 40 byte array of smaller elements on the stack.
As Lars also noted this anti pattern can involve a leak of data to
userspace and that indeed can happen here.  We close both issues by
moving to a suitable structure in the iio_priv() data with alignment
explicitly requested.  This data is allocated with kzalloc so no
data can leak appart from previous readings.

Fixes: 87aec56e27ef ("iio: health: Add driver for the TI AFE4404 heart monitor")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/health/afe4404.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 11910922e6556..23e1ac6501a1a 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -91,6 +91,7 @@ static const struct reg_field afe4404_reg_fields[] = {
  * @regulator: Pointer to the regulator for the IC
  * @trig: IIO trigger for this device
  * @irq: ADC_RDY line interrupt number
+ * @buffer: Used to construct a scan to push to the iio buffer.
  */
 struct afe4404_data {
 	struct device *dev;
@@ -99,6 +100,7 @@ struct afe4404_data {
 	struct regulator *regulator;
 	struct iio_trigger *trig;
 	int irq;
+	s32 buffer[10] __aligned(8);
 };
 
 enum afe4404_chan_id {
@@ -336,17 +338,17 @@ static irqreturn_t afe4404_trigger_handler(int irq, void *private)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct afe4404_data *afe = iio_priv(indio_dev);
 	int ret, bit, i = 0;
-	s32 buffer[10];
 
 	for_each_set_bit(bit, indio_dev->active_scan_mask,
 			 indio_dev->masklength) {
 		ret = regmap_read(afe->regmap, afe4404_channel_values[bit],
-				  &buffer[i++]);
+				  &afe->buffer[i++]);
 		if (ret)
 			goto err;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, afe->buffer,
+					   pf->timestamp);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.25.1



