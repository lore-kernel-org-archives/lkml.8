Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F03C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E5F206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201862;
	bh=vo/6qv1xaJDDey7CJztxTkpzqd8t3nlUIJnexkrm3+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bq1VbwSt6/UB8X7LG/mCclEHvsym8+jooTYbmlGphMlNsUOQ16+lzUU3RVVA2Z3Bh
	 Hx1Mdw4idlii4yyqM+xO23BzdI77d9PeXMLutD8IDdnGuLcmQX4NriKj7HoMvZEHFE
	 ZUtP2sMuYXb1jReWYng+Ijwc9qhepFbiN8DrpPmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437417AbgAPTLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:11:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:49946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732785AbgAPRAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:00:23 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B78622525;
        Thu, 16 Jan 2020 17:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194022;
        bh=vo/6qv1xaJDDey7CJztxTkpzqd8t3nlUIJnexkrm3+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dqd6sQLCRy9Z5ZO1f3D5W+1/IH27iPOETBLs+v/m4W5xw0jFrArB0HRO4SJBRncOZ
         KEbM4vDfjuysQ8r0cHLY2DOn4EThkiSW4qVjVG2KBSNc6mts6PTbmiSCj+HE/RhXVS
         Ja0rhgk0vUigrM6n/X5VpE4SsuqSmXw5H89TrfGE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 143/671] driver core: Avoid careless re-use of existing device links
Date:   Thu, 16 Jan 2020 11:50:52 -0500
Message-Id: <20200116165940.10720-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116165940.10720-1-sashal@kernel.org>
References: <20200116165940.10720-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit f265df550a4350dce0a4d721a77c52e4b847ea40 ]

After commit ead18c23c263 ("driver core: Introduce device links
reference counting"), if there is a link between the given supplier
and the given consumer already, device_link_add() will refcount it
and return it unconditionally.  However, if the flags passed to
it on the second (or any subsequent) attempt to create a device
link between the same consumer-supplier pair are not compatible with
the existing link's flags, that is incorrect.

First off, if the existing link is stateless and the next caller of
device_link_add() for the same consumer-supplier pair wants a
stateful one, or the other way around, the existing link cannot be
returned, because it will not match the expected behavior, so make
device_link_add() dump the stack and return NULL in that case.

Moreover, if the DL_FLAG_AUTOREMOVE_CONSUMER flag is passed to
device_link_add(), its caller will expect its reference to the link
to be dropped automatically on consumer driver removal, which will
not happen if that flag is not set in the link's flags (and
analogously for DL_FLAG_AUTOREMOVE_SUPPLIER).  For this reason, make
device_link_add() update the existing link's flags accordingly
before returning it to the caller.

Fixes: ead18c23c263 ("driver core: Introduce device links reference counting")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/core.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 055132f2292a..562385c47fa4 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -221,12 +221,29 @@ struct device_link *device_link_add(struct device *consumer,
 		goto out;
 	}
 
-	list_for_each_entry(link, &supplier->links.consumers, s_node)
-		if (link->consumer == consumer) {
-			kref_get(&link->kref);
+	list_for_each_entry(link, &supplier->links.consumers, s_node) {
+		if (link->consumer != consumer)
+			continue;
+
+		/*
+		 * Don't return a stateless link if the caller wants a stateful
+		 * one and vice versa.
+		 */
+		if (WARN_ON((flags & DL_FLAG_STATELESS) != (link->flags & DL_FLAG_STATELESS))) {
+			link = NULL;
 			goto out;
 		}
 
+		if (flags & DL_FLAG_AUTOREMOVE_CONSUMER)
+			link->flags |= DL_FLAG_AUTOREMOVE_CONSUMER;
+
+		if (flags & DL_FLAG_AUTOREMOVE_SUPPLIER)
+			link->flags |= DL_FLAG_AUTOREMOVE_SUPPLIER;
+
+		kref_get(&link->kref);
+		goto out;
+	}
+
 	link = kzalloc(sizeof(*link), GFP_KERNEL);
 	if (!link)
 		goto out;
-- 
2.20.1

