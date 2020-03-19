Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0490C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E5320409
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584624846;
	bh=MNISfiGq26FrWPxt9X9i15XovzbjQzDF8bZvT5s9xpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lHheDr7eryuSYLjdpr0xJ946GejrNtlLkbs69G3NkCpxlx9c9uB9B91Y5wjBAl+aq
	 ugYQjLSJq8JDDgv7CBMVqbqb1RLy78FLS2EWsvBzSVeb5vhDuINvfbvCgPsPPOevP+
	 FSixZoZGeD6N7t8OheC1TaR7314kH0RXls1gsYas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728553AbgCSNNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:13:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbgCSNNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:13:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6C8221841;
        Thu, 19 Mar 2020 13:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623581;
        bh=MNISfiGq26FrWPxt9X9i15XovzbjQzDF8bZvT5s9xpc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=edOhnWkXRnGoDHigGLejfCiWPgScHwXC9cvigATEqnr63Xz87hwlaaLR27cX1XXai
         l5+Cj24MyODrhnLP1MdAEnwB2TsR0Ve62jhp1mukSeMUJG0jYjJgnahokam1Uu4F2h
         xeRmSN7ntdpCwWFsY3Ca9DaRj96K2TmdhsS9gwA4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sven Eckelmann <sven.eckelmann@openmesh.com>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 4.9 58/90] batman-adv: Avoid spurious warnings from bat_v neigh_cmp implementation
Date:   Thu, 19 Mar 2020 14:00:20 +0100
Message-Id: <20200319123946.481092472@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123928.635114118@linuxfoundation.org>
References: <20200319123928.635114118@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Eckelmann <sven.eckelmann@openmesh.com>

commit 6a4bc44b012cbc29c9d824be2c7ab9eac8ee6b6f upstream.

The neighbor compare API implementation for B.A.T.M.A.N. V checks whether
the neigh_ifinfo for this neighbor on a specific interface exists. A
warning is printed when it isn't found.

But it is not called inside a lock which would prevent that this
information is lost right before batadv_neigh_ifinfo_get. It must therefore
be expected that batadv_v_neigh_(cmp|is_sob) might not be able to get the
requested neigh_ifinfo.

A WARN_ON for such a situation seems not to be appropriate because this
will only flood the kernel logs. The warnings must therefore be removed.

Signed-off-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/bat_v.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/net/batman-adv/bat_v.c
+++ b/net/batman-adv/bat_v.c
@@ -19,7 +19,6 @@
 #include "main.h"
 
 #include <linux/atomic.h>
-#include <linux/bug.h>
 #include <linux/cache.h>
 #include <linux/errno.h>
 #include <linux/if_ether.h>
@@ -623,11 +622,11 @@ static int batadv_v_neigh_cmp(struct bat
 	int ret = 0;
 
 	ifinfo1 = batadv_neigh_ifinfo_get(neigh1, if_outgoing1);
-	if (WARN_ON(!ifinfo1))
+	if (!ifinfo1)
 		goto err_ifinfo1;
 
 	ifinfo2 = batadv_neigh_ifinfo_get(neigh2, if_outgoing2);
-	if (WARN_ON(!ifinfo2))
+	if (!ifinfo2)
 		goto err_ifinfo2;
 
 	ret = ifinfo1->bat_v.throughput - ifinfo2->bat_v.throughput;
@@ -649,11 +648,11 @@ static bool batadv_v_neigh_is_sob(struct
 	bool ret = false;
 
 	ifinfo1 = batadv_neigh_ifinfo_get(neigh1, if_outgoing1);
-	if (WARN_ON(!ifinfo1))
+	if (!ifinfo1)
 		goto err_ifinfo1;
 
 	ifinfo2 = batadv_neigh_ifinfo_get(neigh2, if_outgoing2);
-	if (WARN_ON(!ifinfo2))
+	if (!ifinfo2)
 		goto err_ifinfo2;
 
 	threshold = ifinfo1->bat_v.throughput / 4;


