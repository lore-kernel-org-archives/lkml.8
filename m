Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8367AC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5935B2073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="t2BbQFap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgCFK36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:29:58 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:26700 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726010AbgCFK36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:29:58 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 026AQTcO024640;
        Fri, 6 Mar 2020 11:29:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=d2kJFrY8CzFXHctP5MzotV3MVSTRu4u2NspQoKLxu8c=;
 b=t2BbQFapflaER/nsx5RLM0jLoMxOjVl0ad6ABv5fR9+bMu3hGSYzKQI/9gyGHeur8Ydt
 wOhPZQm9gBlQC9YTFk2jeal/s5VgvScSv1kwQj3wRB9gCXq0+J11s9tS6UU+zmyS8iIT
 hXHGyy63Zgo8sAHduxrmV6rcJ6SY5ljTJyclIfafETPoU1MoVJFI5W8C2wAsoYl/+ehV
 tuqWuGIp+btBovnGste9RiOiQ4uXJCz9oddhgJfuMbqAkDxNXrDCqYQqtzF7aTqgd0Gm
 HWQFqeRH8EKgUY1BmxtJj5heIpcIq7PBnIIZpau0kGyryckvE27Lu5tVf++VWIaB4mN3 MQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yfem1efh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Mar 2020 11:29:44 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 649B9100053;
        Fri,  6 Mar 2020 11:29:42 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5897A2A76CB;
        Fri,  6 Mar 2020 11:29:42 +0100 (CET)
Received: from localhost (10.75.127.50) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 6 Mar 2020 11:29:41
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <emil.l.velikov@gmail.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH v2] drm: context: Clean up documentation
Date:   Fri, 6 Mar 2020 11:29:37 +0100
Message-ID: <20200306102937.4932-4-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200306102937.4932-1-benjamin.gaignard@st.com>
References: <20200306102937.4932-1-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-06_03:2020-03-05,2020-03-06 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel doc comments to avoid warnings when compiling with W=1.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
version 2:
- Since it is legacy interface do not fix the description but
  replace /** by /* to remove kerneldoc validation warnings

 drivers/gpu/drm/drm_context.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/drm_context.c b/drivers/gpu/drm/drm_context.c
index 1f802d8e5681..c99be950bf17 100644
--- a/drivers/gpu/drm/drm_context.c
+++ b/drivers/gpu/drm/drm_context.c
@@ -47,7 +47,7 @@ struct drm_ctx_list {
 /** \name Context bitmap support */
 /*@{*/
 
-/**
+/*
  * Free a handle from the context bitmap.
  *
  * \param dev DRM device.
@@ -68,7 +68,7 @@ void drm_legacy_ctxbitmap_free(struct drm_device * dev, int ctx_handle)
 	mutex_unlock(&dev->struct_mutex);
 }
 
-/**
+/*
  * Context bitmap allocation.
  *
  * \param dev DRM device.
@@ -88,7 +88,7 @@ static int drm_legacy_ctxbitmap_next(struct drm_device * dev)
 	return ret;
 }
 
-/**
+/*
  * Context bitmap initialization.
  *
  * \param dev DRM device.
@@ -104,7 +104,7 @@ void drm_legacy_ctxbitmap_init(struct drm_device * dev)
 	idr_init(&dev->ctx_idr);
 }
 
-/**
+/*
  * Context bitmap cleanup.
  *
  * \param dev DRM device.
@@ -163,7 +163,7 @@ void drm_legacy_ctxbitmap_flush(struct drm_device *dev, struct drm_file *file)
 /** \name Per Context SAREA Support */
 /*@{*/
 
-/**
+/*
  * Get per-context SAREA.
  *
  * \param inode device inode.
@@ -211,7 +211,7 @@ int drm_legacy_getsareactx(struct drm_device *dev, void *data,
 	return 0;
 }
 
-/**
+/*
  * Set per-context SAREA.
  *
  * \param inode device inode.
@@ -263,7 +263,7 @@ int drm_legacy_setsareactx(struct drm_device *dev, void *data,
 /** \name The actual DRM context handling routines */
 /*@{*/
 
-/**
+/*
  * Switch context.
  *
  * \param dev DRM device.
@@ -290,7 +290,7 @@ static int drm_context_switch(struct drm_device * dev, int old, int new)
 	return 0;
 }
 
-/**
+/*
  * Complete context switch.
  *
  * \param dev DRM device.
@@ -318,7 +318,7 @@ static int drm_context_switch_complete(struct drm_device *dev,
 	return 0;
 }
 
-/**
+/*
  * Reserve contexts.
  *
  * \param inode device inode.
@@ -351,7 +351,7 @@ int drm_legacy_resctx(struct drm_device *dev, void *data,
 	return 0;
 }
 
-/**
+/*
  * Add context.
  *
  * \param inode device inode.
@@ -404,7 +404,7 @@ int drm_legacy_addctx(struct drm_device *dev, void *data,
 	return 0;
 }
 
-/**
+/*
  * Get context.
  *
  * \param inode device inode.
@@ -428,7 +428,7 @@ int drm_legacy_getctx(struct drm_device *dev, void *data,
 	return 0;
 }
 
-/**
+/*
  * Switch context.
  *
  * \param inode device inode.
@@ -452,7 +452,7 @@ int drm_legacy_switchctx(struct drm_device *dev, void *data,
 	return drm_context_switch(dev, dev->last_context, ctx->handle);
 }
 
-/**
+/*
  * New context.
  *
  * \param inode device inode.
@@ -478,7 +478,7 @@ int drm_legacy_newctx(struct drm_device *dev, void *data,
 	return 0;
 }
 
-/**
+/*
  * Remove context.
  *
  * \param inode device inode.
-- 
2.15.0

