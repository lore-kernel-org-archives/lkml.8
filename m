Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A2FC2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F952217D8
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607720;
	bh=G/fsmouMPqeGL+ojewb25nKuHbsV2AApGz5o0aVaTkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KKO7tz7oYmi6yRQ7XWxJDSVDrJ8SvWhOwqk8pogf4AJqz4EvKQMxaXRH1GhSOMC9R
	 8OqwdWsmEQjFu4Knqku7iz+ciTMeWQlYLblddhNpo+pirH+wVaJIwBBAnlA0OYzuz9
	 PY8jICEhtFElNGgHofeNG3JQwKIEYL0+fBGhRY7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbgDKMVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:21:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:58304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729221AbgDKMVw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:21:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C20DD20644;
        Sat, 11 Apr 2020 12:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607712;
        bh=G/fsmouMPqeGL+ojewb25nKuHbsV2AApGz5o0aVaTkg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M/I2ip3EA3M4B+SXx+GTrcQZVW7/LprBoO11nv5YfyCbg6yktv4nTWO3THRp/mMmK
         F9QRzEu1b2n+eo3oqRmlvKnEpV2s5MRlivSHGNmj2c8TF67bQdliT/LHiBPcr6El+S
         Uq7Vt0N5H1LJtvFpk13osbcRDFvkQOg773lwL0/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Saravana Kannan <saravanak@google.com>
Subject: [PATCH 5.6 38/38] driver core: Reevaluate dev->links.need_for_probe as suppliers are added
Date:   Sat, 11 Apr 2020 14:10:15 +0200
Message-Id: <20200411115503.533001557@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115459.324496182@linuxfoundation.org>
References: <20200411115459.324496182@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravana Kannan <saravanak@google.com>

commit 1745d299af5b373abad08fa29bff0d31dc6aff21 upstream.

A previous patch 03324507e66c ("driver core: Allow
fwnode_operations.add_links to differentiate errors") forgot to update
all call sites to fwnode_operations.add_links. This patch fixes that.

Legend:
-> Denotes RHS is an optional/potential supplier for LHS
=> Denotes RHS is a mandatory supplier for LHS

Example:

Device A => Device X
Device A -> Device Y

Before this patch:
1. Device A is added.
2. Device A is marked as waiting for mandatory suppliers
3. Device X is added
4. Device A is left marked as waiting for mandatory suppliers

Step 4 is wrong since all mandatory suppliers of Device A have been
added.

After this patch:
1. Device A is added.
2. Device A is marked as waiting for mandatory suppliers
3. Device X is added
4. Device A is no longer considered as waiting for mandatory suppliers

This is the correct behavior.

Fixes: 03324507e66c ("driver core: Allow fwnode_operations.add_links to differentiate errors")
Signed-off-by: Saravana Kannan <saravanak@google.com>
Link: https://lore.kernel.org/r/20200222014038.180923-2-saravanak@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/core.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -523,9 +523,13 @@ static void device_link_add_missing_supp
 
 	mutex_lock(&wfs_lock);
 	list_for_each_entry_safe(dev, tmp, &wait_for_suppliers,
-				 links.needs_suppliers)
-		if (!fwnode_call_int_op(dev->fwnode, add_links, dev))
+				 links.needs_suppliers) {
+		int ret = fwnode_call_int_op(dev->fwnode, add_links, dev);
+		if (!ret)
 			list_del_init(&dev->links.needs_suppliers);
+		else if (ret != -ENODEV)
+			dev->links.need_for_probe = false;
+	}
 	mutex_unlock(&wfs_lock);
 }
 


