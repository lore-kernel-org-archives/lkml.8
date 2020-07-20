Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89280C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FFC122CB2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259559;
	bh=UFQESJFHqzaPnmS+Dqahl5WTHWoKJlV7XIsLTqYVWEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DdauCdIMwUj6JtYSyzllo3FwzBqYeWZu0uav8yVBJKYDn6ZYJPJO5fQ5xCqIgGzR+
	 mLwIF+FKejYvA6nOni18mbZT2W7vCwWWyLTCPf/fMUXHs937ThITRTYdZrtDUU+M8L
	 9mjce/nu1u+eqbrr6vyz7p98nMpm1xL5a6TBEvww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgGTPjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:39:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:58216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729363AbgGTPjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:39:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3002822CAF;
        Mon, 20 Jul 2020 15:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259553;
        bh=UFQESJFHqzaPnmS+Dqahl5WTHWoKJlV7XIsLTqYVWEE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C1f+qEk9sRofEab34rv+WOMFIYQhsdvdVSiWyK5bf3uqC6CwyMml5+UezBQsTzbL0
         gD1hFGdC2lJ2rvPCpsjEXWVO2HXqElpkax/M8OJwZCTN+alX7Xnw6P/Qabs/lgJuLU
         JUuwt9zr35MCTZwyhGhwZm+lntDS13i1+rMl2ZNs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 4.4 51/58] mei: bus: dont clean driver pointer
Date:   Mon, 20 Jul 2020 17:37:07 +0200
Message-Id: <20200720152749.814682798@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152747.127988571@linuxfoundation.org>
References: <20200720152747.127988571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

commit e852c2c251ed9c23ae6e3efebc5ec49adb504207 upstream.

It's not needed to set driver to NULL in mei_cl_device_remove()
which is bus_type remove() handler as this is done anyway
in __device_release_driver().

Actually this is causing an endless loop in driver_detach()
on ubuntu patched kernel, while removing (rmmod) the mei_hdcp module.
The reason list_empty(&drv->p->klist_devices.k_list) is always not-empty.
as the check is always true in  __device_release_driver()
	if (dev->driver != drv)
		return;

The non upstream patch is causing this behavior, titled:
'vfio -- release device lock before userspace requests'

Nevertheless the fix is correct also for the upstream.

Link: https://patchwork.ozlabs.org/project/ubuntu-kernel/patch/20180912085046.3401-2-apw@canonical.com/
Cc: <stable@vger.kernel.org>
Cc: Andy Whitcroft <apw@canonical.com>
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Link: https://lore.kernel.org/r/20200628225359.2185929-1-tomas.winkler@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/mei/bus.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -626,9 +626,8 @@ static int mei_cl_device_remove(struct d
 		ret = cldrv->remove(cldev);
 
 	module_put(THIS_MODULE);
-	dev->driver = NULL;
-	return ret;
 
+	return ret;
 }
 
 static ssize_t name_show(struct device *dev, struct device_attribute *a,


