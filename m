Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E426C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E625F20734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591725909;
	bh=qE2V6Cgh1eGvdlGwWKpA6a0xf8aeIyRAW3KWZ5PbBQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p6RCPWnlT2HqSHdzJucxwdtmx77YJ/A4z2nXRaIMRWf8/l2zKzsqvhKtOn2Kaqenx
	 WEcHCk2eQUZpiBh3tvRKzWdT+So/LMXsSVjqxeuehy8FVjpwWZ6DIMmocYyBBhikKV
	 LMWjsmFpPYv9YM/rUi7WJPW5AfLq8XKRPRBmMMdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388045AbgFISFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:05:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:41832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731636AbgFIRv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:51:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE4D720734;
        Tue,  9 Jun 2020 17:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591725118;
        bh=qE2V6Cgh1eGvdlGwWKpA6a0xf8aeIyRAW3KWZ5PbBQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qfEoGpql/mn85fbmglPOd0SES/tBA7rpZIClpAmuEi9Ff2kNt2ny5O7vrtKORACCf
         xcXW3pJXenFjZm7F6cpbW+tQAKO3T6J72LmbDBy/nxZBVBbIrsvNiEmNbRSOXDy5UM
         XYiqr7useg+e0pkyJJ6TV6TpwFQ2VwfdGZfWmMj8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathieu Othacehe <m.othacehe@gmail.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.19 11/25] iio: vcnl4000: Fix i2c swapped word reading.
Date:   Tue,  9 Jun 2020 19:45:01 +0200
Message-Id: <20200609174049.916148213@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174048.576094775@linuxfoundation.org>
References: <20200609174048.576094775@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Othacehe <m.othacehe@gmail.com>

commit 18dfb5326370991c81a6d1ed6d1aeee055cb8c05 upstream.

The bytes returned by the i2c reading need to be swapped
unconditionally. Otherwise, on be16 platforms, an incorrect value will be
returned.

Taking the slow path via next merge window as its been around a while
and we have a patch set dependent on this which would be held up.

Fixes: 62a1efb9f868 ("iio: add vcnl4000 combined ALS and proximity sensor")
Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/light/vcnl4000.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -166,7 +166,6 @@ static int vcnl4000_measure(struct vcnl4
 				u8 rdy_mask, u8 data_reg, int *val)
 {
 	int tries = 20;
-	__be16 buf;
 	int ret;
 
 	mutex_lock(&data->vcnl4000_lock);
@@ -193,13 +192,12 @@ static int vcnl4000_measure(struct vcnl4
 		goto fail;
 	}
 
-	ret = i2c_smbus_read_i2c_block_data(data->client,
-		data_reg, sizeof(buf), (u8 *) &buf);
+	ret = i2c_smbus_read_word_swapped(data->client, data_reg);
 	if (ret < 0)
 		goto fail;
 
 	mutex_unlock(&data->vcnl4000_lock);
-	*val = be16_to_cpu(buf);
+	*val = ret;
 
 	return 0;
 


