Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A23C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A507C2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520635;
	bh=0JhRTEgvag1OEu05nb0upbPRKK0a6kSTjy7F/ptofaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=d80Odny7kL15r5RuMRo63W114syJ1LoVEUul8sKN12dMOomHTlp59CIUQI63NfqxZ
	 JAAvyWpNd5aExcNL9F7ERZio410AUdM2pH/Z/hIcEDaN9tZmpaoLDHNj/WF2OE5i7M
	 w8IXvvYI0zxTj+JAEwltN7KHM6fjM16aGX394/G0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392328AbgEZTRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:17:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391180AbgEZTOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:14:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD8DA20776;
        Tue, 26 May 2020 19:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520493;
        bh=0JhRTEgvag1OEu05nb0upbPRKK0a6kSTjy7F/ptofaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eUxuhWlC06adaDGNUtiYXt1VxnKCOR0/uX64z9U1Orm7+Dag03IxPCdKt6F8vDmC5
         LeRtRNilY1ze2DQ4gll7SztWXiTnh1P4wmQ5+BtkoK6//z9GAVOMtXrNS5btoS8Ext
         +yopIuyV/NptWq3+ihUxbwMXWAHEVQNGeVRNJj80=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Saravana Kannan <saravanak@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.6 100/126] driver core: Fix handling of SYNC_STATE_ONLY + STATELESS device links
Date:   Tue, 26 May 2020 20:53:57 +0200
Message-Id: <20200526183946.154498845@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saravana Kannan <saravanak@google.com>

commit 44e960490ddf868fc9135151c4a658936e771dc2 upstream.

Commit 21c27f06587d ("driver core: Fix SYNC_STATE_ONLY device link
implementation") didn't completely fix STATELESS + SYNC_STATE_ONLY
handling.

What looks like an optimization in that commit is actually a bug that
causes an if condition to always take the else path. This prevents
reordering of devices in the dpm_list when a DL_FLAG_STATELESS device
link is create on top of an existing DL_FLAG_SYNC_STATE_ONLY device
link.

Fixes: 21c27f06587d ("driver core: Fix SYNC_STATE_ONLY device link implementation")
Signed-off-by: Saravana Kannan <saravanak@google.com>
Cc: stable <stable@vger.kernel.org>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20200520043626.181820-1-saravanak@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/base/core.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -360,12 +360,14 @@ struct device_link *device_link_add(stru
 
 		if (flags & DL_FLAG_STATELESS) {
 			kref_get(&link->kref);
-			link->flags |= DL_FLAG_STATELESS;
 			if (link->flags & DL_FLAG_SYNC_STATE_ONLY &&
-			    !(link->flags & DL_FLAG_STATELESS))
+			    !(link->flags & DL_FLAG_STATELESS)) {
+				link->flags |= DL_FLAG_STATELESS;
 				goto reorder;
-			else
+			} else {
+				link->flags |= DL_FLAG_STATELESS;
 				goto out;
+			}
 		}
 
 		/*


