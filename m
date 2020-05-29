Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E795C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB03120C56
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kW7UBzbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407517AbgE2DnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 23:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406686AbgE2DnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 23:43:03 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9CBC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:43:02 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cx22so568738pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dUM0rLjJMLBDCp4mui5XTo2X4iZFVh/+VCE0yq/m+4k=;
        b=kW7UBzbmji9y/ZcbcW0RIqSC6gFMIV97+6oQsMVyXOGZq9O+aXXY9Ec+w95AJ1XRu1
         QHabUGIn7eMxVSdblwL7AG23J8unloZtv0Fo8k50DhLgkU3cj0NBYhS+cScbMWFptaNX
         W/azwMWVwyezLWrBnmz03l613FRwyesguvgZac+icd4tHXevxkihsWrD7YG9Y6gxWKMA
         XS0+0Ldv6H8x1oajnywMuGGlpxU4y3H6+PBmCTbqENQhgSuMcVkCvcrs4u3KIEFR4MeK
         ZnMPrmF+1R21T7c0NPUzps+H7H6NLsutmQPpBpqtP55wypnGsXFusO3BFxH/dW8OhjEN
         +aDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dUM0rLjJMLBDCp4mui5XTo2X4iZFVh/+VCE0yq/m+4k=;
        b=X6PP6r18SomALZyr7qDLqVFhEOF2mrqX0M65TOFdy5C/TTZxP3WgapSpVUHwWaroC9
         omIV7l0C4Lwt8tENWpzeNroiEZ5FiiOCotKGiCJ3X849bVPWntVIcPJHaQFeHI9LrmBM
         KyrwuEgFKydP+IaL33sebkR+XFxfNI63oNxsgWv9jvbSobnHH9nPUMFIWe+sRCe1XDnn
         MHIqK9nQ0gtkS7fvdm07TlGCZwLHpOyYeCx7x2STOQ1SemE4x7SYDioOSi6yKtuKHTjT
         bvoFf3hojipfpGk4dC6I/k0Th1mO5vHm0JOUufYnNyQA7loh+52au/O51SZkC8FK1jf6
         OvcQ==
X-Gm-Message-State: AOAM531Moeo0PPHmTysuOk9CbokmsjQNRXkqfmFARxjLMGuHquoLg/2J
        i9/CJh7joTNkr2+SWSxxF66wwpIu
X-Google-Smtp-Source: ABdhPJzj6KxLAOVRnmQh4LQDtAuYiTHfTGOc9OmTbQpH0e7nl+0amngL3zCB2bfReh+xivMJpdMQZQ==
X-Received: by 2002:a17:90a:2e8a:: with SMTP id r10mr7205477pjd.33.1590723782175;
        Thu, 28 May 2020 20:43:02 -0700 (PDT)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id 25sm6620225pjk.50.2020.05.28.20.43.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 May 2020 20:43:01 -0700 (PDT)
From:   Shuai He <hexiaoshuaishuai@gmail.com>
To:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        dave.jiang@intel.com
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Shuai He <hexiaoshuaishuai@gmail.com>
Subject: [PATCH] drivers/dax/bus: Use kobj_to_dev() API
Date:   Fri, 29 May 2020 11:42:57 +0800
Message-Id: <1590723777-8718-1-git-send-email-hexiaoshuaishuai@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobj_to_dev() API instead of container_of().

Signed-off-by: Shuai He <hexiaoshuaishuai@gmail.com>
---
 drivers/dax/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index df238c8..24625d2 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -331,7 +331,7 @@ static DEVICE_ATTR_RO(numa_node);
 
 static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct dev_dax *dev_dax = to_dev_dax(dev);
 
 	if (a == &dev_attr_target_node.attr && dev_dax_target_node(dev_dax) < 0)
-- 
2.7.4

