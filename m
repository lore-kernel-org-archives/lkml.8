Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A01C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 876EB21775
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588098767;
	bh=kOV7JqRDnFkxVT6LtsTvnIEUm78zYiAZ1wZkelLJWgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x9Kgulf3TGfblEfu8cbw5de8R0QLHyphmdqOqZiQyKADl6+HQU+ZXOf0a+pb/KTu6
	 QniCANPW/LIJrBFOy3ZNumnL++OiPIe8V8qguMK9sDcrvor1Z/CLBVMIwj5oV4rc1Q
	 7bBD9iZnjGRf2iuvwzEAWrjMYZd6atr+GbZw998E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgD1Scq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:32:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729354AbgD1Scl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:32:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C81721707;
        Tue, 28 Apr 2020 18:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588098760;
        bh=kOV7JqRDnFkxVT6LtsTvnIEUm78zYiAZ1wZkelLJWgw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zewUpDqPZ9UQhPNo/esxjpC3nD2MxnNp+ywCDhNHHuAWUoC/8wiS/mDZhsX/1l5rQ
         v3q09jnYC6roTiDDLg/dYYvvIB850/hm7g3/YPApXdPKmu6t+P2vg+UJu5amvTP7QK
         0dtCuiJZbj4fqiKAxvz3zOC1OZA5s+4n/zn8lUkk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars Engebretsen <lars@engebretsen.ch>,
        Stable@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.6 081/167] iio: core: remove extra semi-colon from devm_iio_device_register() macro
Date:   Tue, 28 Apr 2020 20:24:17 +0200
Message-Id: <20200428182235.220522218@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182225.451225420@linuxfoundation.org>
References: <20200428182225.451225420@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars Engebretsen <lars@engebretsen.ch>

commit a07479147be03d2450376ebaff9ea1a0682f25d6 upstream.

This change removes the semi-colon from the devm_iio_device_register()
macro which seems to have been added by accident.

Fixes: 63b19547cc3d9 ("iio: Use macro magic to avoid manual assign of driver_module")
Signed-off-by: Lars Engebretsen <lars@engebretsen.ch>
Cc: <Stable@vger.kernel.org>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/iio/iio.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -598,7 +598,7 @@ void iio_device_unregister(struct iio_de
  * 0 on success, negative error number on failure.
  */
 #define devm_iio_device_register(dev, indio_dev) \
-	__devm_iio_device_register((dev), (indio_dev), THIS_MODULE);
+	__devm_iio_device_register((dev), (indio_dev), THIS_MODULE)
 int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
 			       struct module *this_mod);
 void devm_iio_device_unregister(struct device *dev, struct iio_dev *indio_dev);


