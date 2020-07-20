Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426AAC433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DFE82070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262671;
	bh=1CVY6Ixyfc3N1iXZi/C5GQOuWmGjDONCEAmLWXAlKvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EeW0q7UWgBKarTsZq6BWuEdisbes4+9QKxVTvywbeAI5LLDHR0pHvAQ82OCDhFN6H
	 KPA8j8I8TtEc2Bwb2D7M2S7apFnc9n5bShfzQFZlWF6g6ODtpQF2KtIANLaNIuCeCQ
	 Z7xBENLnZser5feDysZ0HAu66/63dYv1FEDKVE3k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388807AbgGTQbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:31:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729978AbgGTP5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:57:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0D8E20773;
        Mon, 20 Jul 2020 15:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260652;
        bh=1CVY6Ixyfc3N1iXZi/C5GQOuWmGjDONCEAmLWXAlKvI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gw88Awx5jr0H174cEFTYblMstGnsV1k6/I93kaaUSBkQ9LRfQC66IaizbYkB6wC9X
         n+PzflibWfx84koX/UaK9mPqII5FeES1oKdUfwCj6fBFaC8smi/KnYR/+i5xM4uTqm
         JMaR2XRcpSSLsraUbM9WD0KVDT26nEN5+3dARDmw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Stable@vger.kernel.org
Subject: [PATCH 5.4 046/215] iio:magnetometer:ak8974: Fix alignment and data leak issues
Date:   Mon, 20 Jul 2020 17:35:28 +0200
Message-Id: <20200720152822.389114777@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

commit 838e00b13bfd4cac8b24df25bfc58e2eb99bcc70 upstream.

One of a class of bugs pointed out by Lars in a recent review.
iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
to the size of the timestamp (8 bytes).  This is not guaranteed in
this driver which uses an array of smaller elements on the stack.
As Lars also noted this anti pattern can involve a leak of data to
userspace and that indeed can happen here.  We close both issues by
moving to a suitable structure in the iio_priv() data.

This data is allocated with kzalloc so no data can leak appart from
previous readings.

Fixes: 7c94a8b2ee8cf ("iio: magn: add a driver for AK8974")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/magnetometer/ak8974.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -185,6 +185,11 @@ struct ak8974 {
 	bool drdy_irq;
 	struct completion drdy_complete;
 	bool drdy_active_low;
+	/* Ensure timestamp is naturally aligned */
+	struct {
+		__le16 channels[3];
+		s64 ts __aligned(8);
+	} scan;
 };
 
 static const char ak8974_reg_avdd[] = "avdd";
@@ -581,7 +586,6 @@ static void ak8974_fill_buffer(struct ii
 {
 	struct ak8974 *ak8974 = iio_priv(indio_dev);
 	int ret;
-	__le16 hw_values[8]; /* Three axes + 64bit padding */
 
 	pm_runtime_get_sync(&ak8974->i2c->dev);
 	mutex_lock(&ak8974->lock);
@@ -591,13 +595,13 @@ static void ak8974_fill_buffer(struct ii
 		dev_err(&ak8974->i2c->dev, "error triggering measure\n");
 		goto out_unlock;
 	}
-	ret = ak8974_getresult(ak8974, hw_values);
+	ret = ak8974_getresult(ak8974, ak8974->scan.channels);
 	if (ret) {
 		dev_err(&ak8974->i2c->dev, "error getting measures\n");
 		goto out_unlock;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, hw_values,
+	iio_push_to_buffers_with_timestamp(indio_dev, &ak8974->scan,
 					   iio_get_time_ns(indio_dev));
 
  out_unlock:


