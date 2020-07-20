Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F62C433ED
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F21F22CB1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261306;
	bh=GQhPlrQ77tWGBEB32yk6tlmCCA8mk0j/8QgPNRM3Avo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0WiN99d6ql9iNj/PvbSH8uV30G/5mciCzqYtPduOZf8xH9JDG2RQKszhHvx8qhupY
	 7TtuM85WE/V26oVxwsdJA0x8j8BvGRXCtNaUkGwof0xeltznLD+xgXzyEak1NB7d57
	 aKYD4HW4uBHibA40I2rHHDMKV8Kf9UrriIcwlumA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733294AbgGTQIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:08:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733274AbgGTQIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:08:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18CC9206E9;
        Mon, 20 Jul 2020 16:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261298;
        bh=GQhPlrQ77tWGBEB32yk6tlmCCA8mk0j/8QgPNRM3Avo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MvyZY5HIq842Hye5uhJ6nj1bHLeqtMPmbfk5zGFyDm7xcvtJ6uqMEvTLgQU02Xwcg
         V2/5hpooGtauCPIFMIp8SRAFztGOE0RGzlK1j3BxidBAxfWclxKqZp4lQvrZMTgEkh
         //AqJ55/PnFVR8v+L7F9K38PkarL/RK3Ma9AUjAE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 5.7 065/244] iio: pressure: zpa2326: handle pm_runtime_get_sync failure
Date:   Mon, 20 Jul 2020 17:35:36 +0200
Message-Id: <20200720152828.949208919@linuxfoundation.org>
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

From: Navid Emamdoost <navid.emamdoost@gmail.com>

commit d88de040e1df38414fc1e4380be9d0e997ab4d58 upstream.

Calling pm_runtime_get_sync increments the counter even in case of
failure, causing incorrect ref count. Call pm_runtime_put if
pm_runtime_get_sync fails.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Fixes: 03b262f2bbf4 ("iio:pressure: initial zpa2326 barometer support")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iio/pressure/zpa2326.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/iio/pressure/zpa2326.c
+++ b/drivers/iio/pressure/zpa2326.c
@@ -664,8 +664,10 @@ static int zpa2326_resume(const struct i
 	int err;
 
 	err = pm_runtime_get_sync(indio_dev->dev.parent);
-	if (err < 0)
+	if (err < 0) {
+		pm_runtime_put(indio_dev->dev.parent);
 		return err;
+	}
 
 	if (err > 0) {
 		/*


