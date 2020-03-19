Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3680C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9D821775
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624056;
	bh=ty2CbhniB1FxbwVN75rtpSaBu+7hc0x/K2UXdSRQI0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1T9gJnL194N168y3Amrdd3wj1aWCHX3QRb1hiFKQcJhPfkqzes6vlhWkmvs4VvwPV
	 TmV7c+Iqrd8uXnmvuzsj9nsqIO3tOf1F30wlOvHP00GNkiVHm4CSPV5DNh+e3qwaWe
	 hBpRNRWmLqWG4qjCPB6Lrnd8JpsCuMswkF9EC2dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730034AbgCSNUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:20:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730020AbgCSNUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:20:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2A4F2166E;
        Thu, 19 Mar 2020 13:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584624053;
        bh=ty2CbhniB1FxbwVN75rtpSaBu+7hc0x/K2UXdSRQI0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b75oI49Hmx16N5PF8u4JdhYT/nyOl3AfPiz6UuAQtBgAdqjGZld7oTXuwPTdSvKdc
         +sbZ1GizemHT3p6EY3LF3Y4yCbcZ19r+m+Ie0Huquz6KjFsqoMAzFv/+tNPILm07Jk
         ZsVfUGvtiKB216v/Y6XrI2qNI/pz/R80PBYdJNjs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH 4.19 41/48] driver core: Fix creation of device links with PM-runtime flags
Date:   Thu, 19 Mar 2020 14:04:23 +0100
Message-Id: <20200319123915.806448528@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123902.941451241@linuxfoundation.org>
References: <20200319123902.941451241@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit fb583c8eeeb1fd57e24ef41ed94c9112067aeac9 upstream.

After commit 515db266a9da ("driver core: Remove device link creation
limitation"), if PM-runtime flags are passed to device_link_add(), it
will fail (returning NULL) due to an overly restrictive flags check
introduced by that commit.

Fix this issue by extending the check in question to cover the
PM-runtime flags too.

Fixes: 515db266a9da ("driver core: Remove device link creation limitation")
Reported-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/7674989.cD04D8YV3U@kreacher
Signed-off-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/core.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -213,6 +213,9 @@ void device_pm_move_to_tail(struct devic
 			       DL_FLAG_AUTOREMOVE_SUPPLIER | \
 			       DL_FLAG_AUTOPROBE_CONSUMER)
 
+#define DL_ADD_VALID_FLAGS (DL_MANAGED_LINK_FLAGS | DL_FLAG_STATELESS | \
+			    DL_FLAG_PM_RUNTIME | DL_FLAG_RPM_ACTIVE)
+
 /**
  * device_link_add - Create a link between two devices.
  * @consumer: Consumer end of the link.
@@ -274,8 +277,7 @@ struct device_link *device_link_add(stru
 {
 	struct device_link *link;
 
-	if (!consumer || !supplier ||
-	    (flags & ~(DL_FLAG_STATELESS | DL_MANAGED_LINK_FLAGS)) ||
+	if (!consumer || !supplier || flags & ~DL_ADD_VALID_FLAGS ||
 	    (flags & DL_FLAG_STATELESS && flags & DL_MANAGED_LINK_FLAGS) ||
 	    (flags & DL_FLAG_AUTOPROBE_CONSUMER &&
 	     flags & (DL_FLAG_AUTOREMOVE_CONSUMER |


