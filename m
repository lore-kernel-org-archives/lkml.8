Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C6CC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 502B720575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099128;
	bh=I5JzWu+lXm0BEl0LHR3wzviUjpFcxKuDsFKGE+8czS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YHR6H2NMJxHZuGtLwz/N4Bq2GneIwOSmnTtEBC2MnV9YbPqlzAl7YzrHjYM2azVsh
	 hI+BFRtf7dq87nk06J/MJXAmDKmD4eple4RJMQFIkkgahGOOtQnCQB3zvBtaj7y/XW
	 NNuEVVMF5qqAOp9XGwsqLZMp//L/yfhrjvkidGAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgD1Sir (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:38:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730296AbgD1Sio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:38:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E1912076A;
        Tue, 28 Apr 2020 18:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099124;
        bh=I5JzWu+lXm0BEl0LHR3wzviUjpFcxKuDsFKGE+8czS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HCecL0eJTSiKD/dkOtci3VQzbhwirfX3VxRvnojN1kI/xdwI2ufujZJC1yM7f/XBH
         1DQiTS/a+P8M8GQKkzIaIHjHRH4BKHZM9t1mdh75N6iPY5VZtmgqUDUG6aZmpfZI/w
         VC+9BKbWZr22Gj6i8UJYN+T1iO2UPO7huaRsqsUM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lary Gibaud <yarl-baudig@mailoo.org>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.19 078/131] iio: st_sensors: rely on odr mask to know if odr can be set
Date:   Tue, 28 Apr 2020 20:24:50 +0200
Message-Id: <20200428182234.729618613@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182224.822179290@linuxfoundation.org>
References: <20200428182224.822179290@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lary Gibaud <yarl-baudig@mailoo.org>

commit e450e07c14abae563ad13b064cbce9fdccc6bc8d upstream.

Indeed, relying on addr being not 0 cannot work because some device have
their register to set odr at address 0. As a matter of fact, if the odr
can be set, then there is a mask.

Sensors with ODR register at address 0 are: lsm303dlh, lsm303dlhc, lsm303dlm

Fixes: 7d245172675a ("iio: common: st_sensors: check odr address value in st_sensors_set_odr()")
Signed-off-by: Lary Gibaud <yarl-baudig@mailoo.org>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/common/st_sensors/st_sensors_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -93,7 +93,7 @@ int st_sensors_set_odr(struct iio_dev *i
 	struct st_sensor_odr_avl odr_out = {0, 0};
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
-	if (!sdata->sensor_settings->odr.addr)
+	if (!sdata->sensor_settings->odr.mask)
 		return 0;
 
 	err = st_sensors_match_odr(sdata->sensor_settings, odr, &odr_out);


