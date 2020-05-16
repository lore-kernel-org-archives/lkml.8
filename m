Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB213C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 21:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7323206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 21:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="SnP/VdcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgEPVv1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 17:51:27 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:46656 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgEPVv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 17:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1589665870; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oIsUOHTqtqa7F5+gZuYIGs0fcUI70HLM4r/HBVMSNE4=;
        b=SnP/VdcTCWwehlzF6AxGZRQCTLuWnVWs/BS9LSnFHXVQLHPaC2YuH1GEIWfwNEqP9w/cMY
        vuaNQQe+1XNxJtuyzslQ3sTD5pcSZuPInly1z/qhU7uVOOQo6QvwgBIj+1XbsIhGiP61LR
        2TwnChhRIzWuT4E/EQAH2KA3rABiF9U=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     od@zcrc.me, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 03/12] component: Support binding with no matches
Date:   Sat, 16 May 2020 23:50:48 +0200
Message-Id: <20200516215057.392609-3-paul@crapouillou.net>
In-Reply-To: <20200516215057.392609-1-paul@crapouillou.net>
References: <20200516215057.392609-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Support binding the master even though no components have been
registered.

This permits to support cases where components are optional.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/base/component.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index e97704104784..a9de7ee1677f 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -100,7 +100,7 @@ static int component_devices_show(struct seq_file *s, void *data)
 
 	seq_printf(s, "%-40s %20s\n", "device name", "status");
 	seq_puts(s, "-------------------------------------------------------------\n");
-	for (i = 0; i < match->num; i++) {
+	for (i = 0; !!match && i < match->num; i++) {
 		struct component *component = match->compare[i].component;
 
 		seq_printf(s, "%-40s %20s\n",
@@ -184,6 +184,11 @@ static int find_components(struct master *master)
 	size_t i;
 	int ret = 0;
 
+	if (!match) {
+		dev_dbg(master->dev, "No components\n");
+		return 0;
+	}
+
 	/*
 	 * Scan the array of match functions and attach
 	 * any components which are found to this master.
@@ -218,10 +223,12 @@ static void remove_component(struct master *master, struct component *c)
 {
 	size_t i;
 
-	/* Detach the component from this master. */
-	for (i = 0; i < master->match->num; i++)
-		if (master->match->compare[i].component == c)
-			master->match->compare[i].component = NULL;
+	if (master->match) {
+		/* Detach the component from this master. */
+		for (i = 0; i < master->match->num; i++)
+			if (master->match->compare[i].component == c)
+				master->match->compare[i].component = NULL;
+	}
 }
 
 /*
@@ -470,10 +477,12 @@ int component_master_add_with_match(struct device *dev,
 	struct master *master;
 	int ret;
 
-	/* Reallocate the match array for its true size */
-	ret = component_match_realloc(dev, match, match->num);
-	if (ret)
-		return ret;
+	if (match) {
+		/* Reallocate the match array for its true size */
+		ret = component_match_realloc(dev, match, match->num);
+		if (ret)
+			return ret;
+	}
 
 	master = kzalloc(sizeof(*master), GFP_KERNEL);
 	if (!master)
@@ -557,6 +566,10 @@ void component_unbind_all(struct device *master_dev, void *data)
 	if (!master)
 		return;
 
+	/* No match, nothing to unbind */
+	if (!master->match)
+		return;
+
 	/* Unbind components in reverse order */
 	for (i = master->match->num; i--; )
 		if (!master->match->compare[i].duplicate) {
@@ -640,6 +653,10 @@ int component_bind_all(struct device *master_dev, void *data)
 	if (!master)
 		return -EINVAL;
 
+	/* No match, nothing to bind */
+	if (!master->match)
+		return 0;
+
 	/* Bind components in match order */
 	for (i = 0; i < master->match->num; i++)
 		if (!master->match->compare[i].duplicate) {
-- 
2.26.2

