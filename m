Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FDDC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 398F020738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597926373;
	bh=Ioa8RekqZZPooY2b/9Qub7r0er0Y5L/4+KS2IvOM9s8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MoUaU0LdjxrXmlO2Kudh8FWgvilNEPms4eJ5LNpgbrDghkOIbhinvyTgLJvJDOg9W
	 pKkdJl1Iyd7xICJkEDoqKN3nSrmuAX4mbD0c3zRE6IytY8cyuTMPrjyS0iv1FkGsAz
	 gLORw+sc+Wzg+T4OQobe4DWvd4DB/SI3IyIz0vZM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbgHTM0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:26:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729474AbgHTJxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:53:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEC422067C;
        Thu, 20 Aug 2020 09:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917183;
        bh=Ioa8RekqZZPooY2b/9Qub7r0er0Y5L/4+KS2IvOM9s8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xrvSMPRTdzXFhFbNmEHffdgVyW6go/+4hOiCYys8bod0bZPAwN56zkWRo7zZVszPB
         V+KxU3Sh0wLTSgEMjlLspOEIN8kKOTW6qVNXKcbLJwrHnJdrI1X6WtBbUEYuTCDBV+
         GaOnSxTvNMLPaafLH9C70goVJgmkQG7FJMaspu+4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
Subject: [PATCH 4.19 32/92] driver core: Avoid binding drivers to dead devices
Date:   Thu, 20 Aug 2020 11:21:17 +0200
Message-Id: <20200820091539.256776256@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091537.490965042@linuxfoundation.org>
References: <20200820091537.490965042@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

commit 654888327e9f655a9d55ad477a9583e90e8c9b5c upstream.

Commit 3451a495ef24 ("driver core: Establish order of operations for
device_add and device_del via bitflag") sought to prevent asynchronous
driver binding to a device which is being removed.  It added a
per-device "dead" flag which is checked in the following code paths:

* asynchronous binding in __driver_attach_async_helper()
*  synchronous binding in device_driver_attach()
* asynchronous binding in __device_attach_async_helper()

It did *not* check the flag upon:

*  synchronous binding in __device_attach()

However __device_attach() may also be called asynchronously from:

deferred_probe_work_func()
  bus_probe_device()
    device_initial_probe()
      __device_attach()

So if the commit's intention was to check the "dead" flag in all
asynchronous code paths, then a check is also necessary in
__device_attach().  Add the missing check.

Fixes: 3451a495ef24 ("driver core: Establish order of operations for device_add and device_del via bitflag")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v5.1+
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Link: https://lore.kernel.org/r/de88a23a6fe0ef70f7cfd13c8aea9ab51b4edab6.1594214103.git.lukas@wunner.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/dd.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -792,7 +792,9 @@ static int __device_attach(struct device
 	int ret = 0;
 
 	device_lock(dev);
-	if (dev->driver) {
+	if (dev->p->dead) {
+		goto out_unlock;
+	} else if (dev->driver) {
 		if (device_is_bound(dev)) {
 			ret = 1;
 			goto out_unlock;


