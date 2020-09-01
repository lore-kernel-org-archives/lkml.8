Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20C2C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 18:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4A942078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 18:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="g0AbURRG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbgIASow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 14:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgIASou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 14:44:50 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42665C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 11:44:50 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id l29so1655528qve.18
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 11:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=lzhpqq8bzD/FsaCTfkvt8bsW4hhopaei7M9mtOQ3b7A=;
        b=g0AbURRGuByGLoi+yDQWo3qk5VT8Y8gTd1nXll8yg8pR3A+kjAmWplpHcfk0+zOGIo
         KsLMPMVlxScwnCLKfSMCqdWD8+iX8p/onFM8QmcSZH6utZKed3sd+z7uBRmLahFsIjj/
         MlTzqniO6cUe9Q3GS8H7BAbdlCo+tqw4EiHXiSbagNyyxRS9yH615tjjaORSHXIYP2LV
         VMoJMegISpjs4KPE7XAnCybNiFW/D/Wr4LYRQHqZm1we9HhO0xLOBXT3v5oP7mT9O8/U
         VJ/CprcRHopb0GP1Ftlf0jI3ZEdfiHhgTWpv+Vf1hlhQvH/aE0Kz+C5pp16/DqKIpohL
         YmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=lzhpqq8bzD/FsaCTfkvt8bsW4hhopaei7M9mtOQ3b7A=;
        b=FuEWidKiv1/1VBQRi+UA3hjaHDJytGIbRyQv2kCiacbhLU6S7vlalCa+GNNj/2Qeb0
         +DTfuxKh3ZQRLuzDAVT6M/kIl3d8DviAxnbg8ZQIe/lris0axuU709M+6P3JeTwV2y3Y
         7nanIb2jX/G8VJmwAwpfxCRF5vBOCBA+Tb5C2u1nKSz5MLfjpfmA/DDZ2I074mGHURnW
         ckir/ppKB22APlu/9ZPdj2d9n/i9cJeLWZKu5sLQHN/qHKcwPhVNy10sWTXYiv4kxS3s
         kisU9LI3wqq0KScH0YEQuhIU1zNdclY3AL35Wu0VXu5buCHN1XyX7D55KLDWL0UWMLze
         Gqvw==
X-Gm-Message-State: AOAM532u9STylfKD3F7OoYRuH7YXvWnN/XjH67Mvsjjx3i8F+YLHNdHD
        Kv0s6z2bRs2AI8IWzI0JQdAhgsEBEWVO4Jc=
X-Google-Smtp-Source: ABdhPJzh8gaRFmSXXD1HZfckYU1uQH2CHBg2Z8WbzU3UOWT8yr6hfKlXtXxkxUNQSHLtC6QtkJxinFdWAK4L6OQ=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:11:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a0c:9b89:: with SMTP id
 o9mr3313403qve.77.1598985889330; Tue, 01 Sep 2020 11:44:49 -0700 (PDT)
Date:   Tue,  1 Sep 2020 11:44:44 -0700
Message-Id: <20200901184445.1736658-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v2] driver core: Fix device_pm_lock() locking for device links
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>, linux@roeck-us.net,
        m.szyprowski@samsung.com, naresh.kamboju@linaro.org,
        Peng Fan <peng.fan@nxp.com>, Stephen Boyd <sboyd@kernel.org>,
        Dong Aisheng <dongas86@gmail.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit fixes two issues:

1. The lockdep warning reported by Dong Aisheng <dongas86@gmail.com> [1].

It is a warning about a cycle (dpm_list_mtx --> kn->active#3 --> fw_lock)
that was introduced when device-link devices were added to expose device
link information in sysfs.

The patch that "introduced" this cycle can't be reverted because it's fixes
a real SRCU issue and also ensures that the device-link device is deleted
as soon as the device-link is deleted. This is important to avoid sysfs
name collisions if the device-link is create again immediately (this can
happen a lot with deferred probing).

2. Inconsistency in grabbing device_pm_lock() during device link deletion

Some device link deletion code paths grab device_pm_lock(), while others
don't.  The device_pm_lock() is grabbed during device_link_add() because it
checks if the supplier is in the dpm_list and also reorders the dpm_list.
However, when a device link is deleted, it does not do either of those and
therefore device_pm_lock() is not necessary. Dropping the device_pm_lock()
in all the device link deletion paths removes the inconsistency in locking.

Thanks to Stephen Boyd for helping me understand the lockdep splat.

Fixes: 843e600b8a2b ("driver core: Fix sleeping in invalid context during device link deletion")
[1] - https://lore.kernel.org/lkml/CAA+hA=S4eAreb7vo69LAXSk2t5=DEKNxHaiY1wSpk4xTp9urLg@mail.gmail.com/
Reported-by: Dong Aisheng <dongas86@gmail.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
---

Cc'ing everyone from the original thread [1]

-Saravana

 drivers/base/core.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index f6f620aa9408..07e5ceb40bb1 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -807,9 +807,7 @@ static void device_link_put_kref(struct device_link *link)
 void device_link_del(struct device_link *link)
 {
 	device_links_write_lock();
-	device_pm_lock();
 	device_link_put_kref(link);
-	device_pm_unlock();
 	device_links_write_unlock();
 }
 EXPORT_SYMBOL_GPL(device_link_del);
@@ -830,7 +828,6 @@ void device_link_remove(void *consumer, struct device *supplier)
 		return;
 
 	device_links_write_lock();
-	device_pm_lock();
 
 	list_for_each_entry(link, &supplier->links.consumers, s_node) {
 		if (link->consumer == consumer) {
@@ -839,7 +836,6 @@ void device_link_remove(void *consumer, struct device *supplier)
 		}
 	}
 
-	device_pm_unlock();
 	device_links_write_unlock();
 }
 EXPORT_SYMBOL_GPL(device_link_remove);
-- 
2.28.0.402.g5ffc5be6b7-goog

