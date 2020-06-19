Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB5BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F098A21BE5
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580634;
	bh=QN44B5NjpaGuNWBUkEo8AlBVX8FksItPDzsjMKTnT0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zjKcbDbdf4PoB1Ypok1qYIuwUgFMrMGgNwY8CPrUKXu21x6E/SMVzmpFAIWh3Wg5G
	 pwyMv99KdAcmZSMd9FqJdcjp1kMraOkZ3CjtTXPEWo+LM7xYfyaCXAVf7XV1B/iqot
	 nRjPJk6tZWfKrSF5Mi+Dfz+6v1mUSxiAl5wjbSu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393716AbgFSPa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:30:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404788AbgFSPaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:30:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F4C820771;
        Fri, 19 Jun 2020 15:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580621;
        bh=QN44B5NjpaGuNWBUkEo8AlBVX8FksItPDzsjMKTnT0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4fJThrZdc+kjJN364J93WPJgrJXlnqqKDTopOR66Z2TtusuHru6XVCTkQthEjTCO
         e/4JJ931TpSle6jQDw1qrdU+DzQZE9s2OkutfpjEzcXK+UxdQmg4z1rrktUo+sZlXl
         zSpI83G2Iw9kThbNo4IwrYzXtE2/y3nSh/TGY1u4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.7 320/376] gnss: sirf: fix error return code in sirf_probe()
Date:   Fri, 19 Jun 2020 16:33:58 +0200
Message-Id: <20200619141725.479947044@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

commit 43d7ce70ae43dd8523754b17f567417e0e75dbce upstream.

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

This avoids a use-after-free in case the driver is later unbound.

Fixes: d2efbbd18b1e ("gnss: add driver for sirfstar-based receivers")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
[ johan: amend commit message; mention potential use-after-free ]
Cc: stable <stable@vger.kernel.org>	# 4.19
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gnss/sirf.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/gnss/sirf.c
+++ b/drivers/gnss/sirf.c
@@ -439,14 +439,18 @@ static int sirf_probe(struct serdev_devi
 
 	data->on_off = devm_gpiod_get_optional(dev, "sirf,onoff",
 			GPIOD_OUT_LOW);
-	if (IS_ERR(data->on_off))
+	if (IS_ERR(data->on_off)) {
+		ret = PTR_ERR(data->on_off);
 		goto err_put_device;
+	}
 
 	if (data->on_off) {
 		data->wakeup = devm_gpiod_get_optional(dev, "sirf,wakeup",
 				GPIOD_IN);
-		if (IS_ERR(data->wakeup))
+		if (IS_ERR(data->wakeup)) {
+			ret = PTR_ERR(data->wakeup);
 			goto err_put_device;
+		}
 
 		ret = regulator_enable(data->vcc);
 		if (ret)


