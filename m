Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743F7C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4457F2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595263495;
	bh=WoJ9Kp9wfVkHFssvNRPNx8qVn3ktNbJH8Bpyp2GuEK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LjElJ255cTWuTSuOYnF/XFD8/eKhpI/zCQ3oN1xApx+g4HdmOC4oXEXXMsP+GcRxP
	 Kfh88D8K5ML82ZaOqWIbDv/zNpQ6ofxuf68zZXS9AQe0ZTw1cln8Lw2GbvjfsmBMat
	 y4XqdNloApTLIc/ShxuWkbzwGj0zfCQk88ctSyS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730966AbgGTQoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:44:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729192AbgGTPl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:41:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3637122CB3;
        Mon, 20 Jul 2020 15:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259686;
        bh=WoJ9Kp9wfVkHFssvNRPNx8qVn3ktNbJH8Bpyp2GuEK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GP2kgL1ND/4TiUgFOsVQMGPeB4j+JTuAEOqHEDCg/MQ5o5revYo5rlZTIP1lqsqdu
         rmKchBGVJXh3ajjBxBqyZV8ruPAC2oxm5zzQ8tGajwTTPfHIcih1hZNYka673x+vu6
         b/NYNmruSw4vL7iAJ88cIBxiqFqLxbU3wWXioWBA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Stable@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 4.9 44/86] iio: pressure: zpa2326: handle pm_runtime_get_sync failure
Date:   Mon, 20 Jul 2020 17:36:40 +0200
Message-Id: <20200720152755.387078188@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152753.138974850@linuxfoundation.org>
References: <20200720152753.138974850@linuxfoundation.org>
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
@@ -676,8 +676,10 @@ static int zpa2326_resume(const struct i
 	int err;
 
 	err = pm_runtime_get_sync(indio_dev->dev.parent);
-	if (err < 0)
+	if (err < 0) {
+		pm_runtime_put(indio_dev->dev.parent);
 		return err;
+	}
 
 	if (err > 0) {
 		/*


