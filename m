Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBD2C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E864120767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598977022;
	bh=kSE9ZyHZgrC5O8JA6ZoprRdJzM38r2e6uDO8v8/zApo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0TDLUMVEn6h89XUUKW5tKZwz1kOSNR5/Cd1NLOIOwIqUKK4gimCgzvHlLU9w0/R0x
	 zy77chZwUD6zcwCo3zmH4xU4lSAgEzgiU0aQFrIvBId0FFukfBO6BiPVnRa9VpBpAn
	 Z4HSYun29D0Kz0NtlcZKkTv7hCEmUSmnk0q34i0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgIAQRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:17:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728242AbgIAPeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:34:00 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEAC021534;
        Tue,  1 Sep 2020 15:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974439;
        bh=kSE9ZyHZgrC5O8JA6ZoprRdJzM38r2e6uDO8v8/zApo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FSHNfjftbd5YqHAz5wpL7DD7pYK2R94ge+WgxgF9PMFStiUNcwrHpB4XSnzzNxgHy
         8gSSUTn5107P9txZaOtQYoexqbq3EFrQgY4jHynXioxpZTbdJeibtN8m47/I6OuVDU
         3m1b9s3oIhyAMALo0LqcH+lSSdf/nZKkMAiA/xEw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.4 177/214] device property: Fix the secondary firmware node handling in set_primary_fwnode()
Date:   Tue,  1 Sep 2020 17:10:57 +0200
Message-Id: <20200901151001.455550067@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit c15e1bdda4365a5f17cdadf22bf1c1df13884a9e upstream.

When the primary firmware node pointer is removed from a
device (set to NULL) the secondary firmware node pointer,
when it exists, is made the primary node for the device.
However, the secondary firmware node pointer of the original
primary firmware node is never cleared (set to NULL).

To avoid situation where the secondary firmware node pointer
is pointing to a non-existing object, clearing it properly
when the primary node is removed from a device in
set_primary_fwnode().

Fixes: 97badf873ab6 ("device property: Make it possible to use secondary firmware nodes")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/core.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -3400,9 +3400,9 @@ static inline bool fwnode_is_primary(str
  */
 void set_primary_fwnode(struct device *dev, struct fwnode_handle *fwnode)
 {
-	if (fwnode) {
-		struct fwnode_handle *fn = dev->fwnode;
+	struct fwnode_handle *fn = dev->fwnode;
 
+	if (fwnode) {
 		if (fwnode_is_primary(fn))
 			fn = fn->secondary;
 
@@ -3412,8 +3412,12 @@ void set_primary_fwnode(struct device *d
 		}
 		dev->fwnode = fwnode;
 	} else {
-		dev->fwnode = fwnode_is_primary(dev->fwnode) ?
-			dev->fwnode->secondary : NULL;
+		if (fwnode_is_primary(fn)) {
+			dev->fwnode = fn->secondary;
+			fn->secondary = NULL;
+		} else {
+			dev->fwnode = NULL;
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(set_primary_fwnode);


