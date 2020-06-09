Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCDEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54478206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591725534;
	bh=PA51v+8qu5tTohf3fSlpnqr736v3GWdp8seuOgAKqAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S0nvlSq2YFnUf66DvH65ysqCwqLKpMs0Vtp6eIkxZmauLh88bqrAeukOE9mX61pjA
	 M6i1rjyImdW27nq1BTdwFC7SK/LnaZoNGWGrDTHSKwl2u7CrK/ZmivUJJn+UKX5v9A
	 uixZ7F/4fWPq7zIgSrkbHodZguN0fw3dpmqAXHvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733211AbgFIR6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:58:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733207AbgFIRzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:55:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A59120734;
        Tue,  9 Jun 2020 17:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591725314;
        bh=PA51v+8qu5tTohf3fSlpnqr736v3GWdp8seuOgAKqAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FjpFHwRdD+/O1agnz3MqcFS0RDQEc0a7JtiKIQ77fdP+a1LFHK+Eowsdm2a1zqzhe
         u/xmTSLmVuq/n1FvBv8QdOhXq0EpyP3Q4sKtDxXmb6B6+od8Bu67M/atKw14ZQ8CtU
         4ttSnoU07pxxo+ylabt8niROOaDx84uH+6HuK1f4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mathieu Othacehe <m.othacehe@gmail.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.7 07/24] iio: vcnl4000: Fix i2c swapped word reading.
Date:   Tue,  9 Jun 2020 19:45:38 +0200
Message-Id: <20200609174149.914104473@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609174149.255223112@linuxfoundation.org>
References: <20200609174149.255223112@linuxfoundation.org>
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
@@ -219,7 +219,6 @@ static int vcnl4000_measure(struct vcnl4
 				u8 rdy_mask, u8 data_reg, int *val)
 {
 	int tries = 20;
-	__be16 buf;
 	int ret;
 
 	mutex_lock(&data->vcnl4000_lock);
@@ -246,13 +245,12 @@ static int vcnl4000_measure(struct vcnl4
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
 


