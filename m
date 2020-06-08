Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46908C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16A44206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEXOx45K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbgFHMzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:55:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46278 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729873AbgFHMzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591620904;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=94nJdUycanNanCZe+2t27kRR21T+ISEyAQyR3Es+4pA=;
        b=XEXOx45KRe+/oP7Rv3WH8e37OJ8Q2IFgnPBfU7gq4iPGshcbUqAxm5e8/oiEyO9P+GnDd4
        V2VJ9JfEhK6BVd7D1YIkY4db7tvBZykgjWJ05DiAZbKWfApp34BCLEAXlY1TPIfRw3y+B0
        RUe+zJs+CgvNO6JsKOG8XtAAzcNdACg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-XvxIkHfIMQyzoyfcU0QO0g-1; Mon, 08 Jun 2020 08:54:58 -0400
X-MC-Unique: XvxIkHfIMQyzoyfcU0QO0g-1
Received: by mail-qt1-f200.google.com with SMTP id y7so15368369qti.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 05:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=94nJdUycanNanCZe+2t27kRR21T+ISEyAQyR3Es+4pA=;
        b=ZOXn+PcBRrshjFiyejUb9QJcnTtLTFSPeuEoexDHz21qDS1yhzzU+ZBBnOwzqLjlJ8
         70VTXQVbrmQvB2JpijDoNv4L6Q5XmK/LRfXn3ceR4AlwAsAtQWVlqrr/0ktWx7aobB2C
         eF9GxjNKg6tIWpMSeFxJgsllx2opWVkUJPq2qQicbdUk9pENvNINDm+f+2xBArYpUfZq
         6Ff0LgxKOdXdfCUebq6jhAWotQ2dC9N5kt4kTkzwFKICQdS+kTKjoEkAOCEQ9KQNX4z8
         FTB12MuhJygvaPuMB7CZVVg7jZzDdTR2Tp+2974+gqaK3PC8Q96jD8ulGBj3oQR2bMpu
         TjZA==
X-Gm-Message-State: AOAM5339MKJuMnIHY7EJv51k3DBid8uxwCV+h6AlLwkNwXoA6WSpAevT
        0qA1NMF5j9DM+e6uch1wUscOVzX9GrQyXHwXS67SvQDgaopYy0UMDhBzHdFK7lFd8OCYKKE3FXT
        52TZLpJ1X9HmuGcgAaVpe8Htc
X-Received: by 2002:ac8:6882:: with SMTP id m2mr22888054qtq.231.1591620897779;
        Mon, 08 Jun 2020 05:54:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwP3YB11T91nyIrlQME0Zb6Gnr2YlMqwkDqVq5/W1h1DTMqeGm+8O+nE1LzuskYtdUwSzpNFw==
X-Received: by 2002:ac8:6882:: with SMTP id m2mr22888042qtq.231.1591620897574;
        Mon, 08 Jun 2020 05:54:57 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id y54sm7750628qtj.28.2020.06.08.05.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 05:54:56 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2 2/2] fpga: Fix dead store in fpga-bridge.c
Date:   Mon,  8 Jun 2020 05:54:46 -0700
Message-Id: <20200608125446.23311-3-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200608125446.23311-1-trix@redhat.com>
References: <20200608125446.23311-1-trix@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Using clang's scan-build/view this issue was flagged
a dead store issue in fpga-bridge.c

warning: Value stored to 'ret' is never read [deadcode.DeadStores]
                  ret = id;

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-bridge.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
index 4bab9028940a..2deccacc3aa7 100644
--- a/drivers/fpga/fpga-bridge.c
+++ b/drivers/fpga/fpga-bridge.c
@@ -328,7 +328,7 @@ struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
 				       void *priv)
 {
 	struct fpga_bridge *bridge;
-	int id, ret = 0;
+	int id, ret;
 
 	if (!name || !strlen(name)) {
 		dev_err(dev, "Attempt to register with no name!\n");
@@ -340,10 +340,8 @@ struct fpga_bridge *fpga_bridge_create(struct device *dev, const char *name,
 		return NULL;
 
 	id = ida_simple_get(&fpga_bridge_ida, 0, 0, GFP_KERNEL);
-	if (id < 0) {
-		ret = id;
+	if (id < 0)
 		goto error_kfree;
-	}
 
 	mutex_init(&bridge->mutex);
 	INIT_LIST_HEAD(&bridge->node);
-- 
2.18.2

