Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D99C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AED3F2072D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258140;
	bh=xIX9YeL29vXvcANUC/Xh4b45TVJroXBQmCPyHR5s2dk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MQoHK3ME5N4L3xpmknvn3fmaJSsW//MDPh+ZCgL02jSHazERyIUPKZ42inYKQTFyb
	 /kLERXKuvYYiSWtY4/bbXEH3dIVsQsJdlNMZ1ctR0xmurom/1kEHlNGPgRcpHn0AuZ
	 XcXdyWlNmZ+OZPr6VO4iR+YpX8vXWY6NMIt+VJ+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732747AbgCCRzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:55:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732737AbgCCRzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:55:35 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 482692072D;
        Tue,  3 Mar 2020 17:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258134;
        bh=xIX9YeL29vXvcANUC/Xh4b45TVJroXBQmCPyHR5s2dk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rjbdKwfHpMjt0RAWTd+GvFN1CuDnhTEdKCi1MHno9YU4FYD4cc8UOwFgod0Edg3le
         vx4rFuPNGm/icMShb8AQQQ1NwR9977+Z3hpChZa+9o5iaMW85kjINyEwbejGmRp2S3
         HubDjZBQqSYa136sF2u+CYc9R9/UhoYlwXb2aAfo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Orson Zhai <orson.unisoc@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 5.4 083/152] Revert "PM / devfreq: Modify the device name as devfreq(X) for sysfs"
Date:   Tue,  3 Mar 2020 18:43:01 +0100
Message-Id: <20200303174311.978079741@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174302.523080016@linuxfoundation.org>
References: <20200303174302.523080016@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Orson Zhai <orson.unisoc@gmail.com>

commit 66d0e797bf095d407479c89952d42b1d96ef0a7f upstream.

This reverts commit 4585fbcb5331fc910b7e553ad3efd0dd7b320d14.

The name changing as devfreq(X) breaks some user space applications,
such as Android HAL from Unisoc and Hikey [1].
The device name will be changed unexpectly after every boot depending
on module init sequence. It will make trouble to setup some system
configuration like selinux for Android.

So we'd like to revert it back to old naming rule before any better
way being found.

[1] https://lkml.org/lkml/2018/5/8/1042

Cc: John Stultz <john.stultz@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Signed-off-by: Orson Zhai <orson.unisoc@gmail.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/devfreq/devfreq.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -613,7 +613,6 @@ struct devfreq *devfreq_add_device(struc
 {
 	struct devfreq *devfreq;
 	struct devfreq_governor *governor;
-	static atomic_t devfreq_no = ATOMIC_INIT(-1);
 	int err = 0;
 
 	if (!dev || !profile || !governor_name) {
@@ -677,8 +676,7 @@ struct devfreq *devfreq_add_device(struc
 	devfreq->suspend_freq = dev_pm_opp_get_suspend_opp_freq(dev);
 	atomic_set(&devfreq->suspend_count, 0);
 
-	dev_set_name(&devfreq->dev, "devfreq%d",
-				atomic_inc_return(&devfreq_no));
+	dev_set_name(&devfreq->dev, "%s", dev_name(dev));
 	err = device_register(&devfreq->dev);
 	if (err) {
 		mutex_unlock(&devfreq->lock);


