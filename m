Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D313DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28512467E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgA1TD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:03:58 -0500
Received: from smtprelay0097.hostedemail.com ([216.40.44.97]:51522 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726234AbgA1TD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 14:03:58 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 9CFE5247F;
        Tue, 28 Jan 2020 19:03:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fish97_224a391ab8e4c
X-Filterd-Recvd-Size: 1907
Received: from XPS-9350.home (unknown [47.151.135.224])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Jan 2020 19:03:55 +0000 (UTC)
Message-ID: <2dd59a9ea0ed9029caf1b91fb6758ecc7f1dd695.camel@perches.com>
Subject: [PATCH] net: drop_monitor: Use kstrdup
From:   Joe Perches <joe@perches.com>
To:     Neil Horman <nhorman@tuxdriver.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jan 2020 11:02:50 -0800
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the equivalent but rather odd uses of kmemdup with
__GFP_ZERO to the more common kstrdup and avoid unnecessary
zeroing of copied over memory.

Signed-off-by: Joe Perches <joe@perches.com>
---
 net/core/drop_monitor.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 536e032..ea46fc 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -802,16 +802,12 @@ net_dm_hw_metadata_clone(const struct net_dm_hw_metadata *hw_metadata)
 	if (!n_hw_metadata)
 		return NULL;
 
-	trap_group_name = kmemdup(hw_metadata->trap_group_name,
-				  strlen(hw_metadata->trap_group_name) + 1,
-				  GFP_ATOMIC | __GFP_ZERO);
+	trap_group_name = kstrdup(hw_metadata->trap_group_name, GFP_ATOMIC);
 	if (!trap_group_name)
 		goto free_hw_metadata;
 	n_hw_metadata->trap_group_name = trap_group_name;
 
-	trap_name = kmemdup(hw_metadata->trap_name,
-			    strlen(hw_metadata->trap_name) + 1,
-			    GFP_ATOMIC | __GFP_ZERO);
+	trap_name = kstrdup(hw_metadata->trap_name, GFP_ATOMIC);
 	if (!trap_name)
 		goto free_trap_group;
 	n_hw_metadata->trap_name = trap_name;


