Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60352C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A515206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3jbwCwI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbgFHMzE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:55:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37904 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729873AbgFHMy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591620898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=V0bHFV3loTq46ks0PZDncVrsS74x60RNv6LFRDVPSL0=;
        b=U3jbwCwIj/HUUzi8rqjeNVW2e0YzmxEf5ZHU63ekWdSoxa37q78HhpKogHpWc/e4PvXWbU
        6iPUeQDEi+KDxRX5NYAZjaUjGr6jrv9kT6ziWOI9eaH1dI97i1sel6/foYFsn6+QbYRL7s
        4H+YIR+TpE82Ti2XfoArp3nU+cNeRfU=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-s5xJoGHQPp6ApruyfkGNLg-1; Mon, 08 Jun 2020 08:54:56 -0400
X-MC-Unique: s5xJoGHQPp6ApruyfkGNLg-1
Received: by mail-qt1-f198.google.com with SMTP id o11so15371319qtm.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 05:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V0bHFV3loTq46ks0PZDncVrsS74x60RNv6LFRDVPSL0=;
        b=bOKTZVg0twlHmMGn7FjnalLWXDQ5nTVbhW4W6fElafob4Lo1W74g1Nr1YhABHvMemN
         TbLzg7tZWKap/h7p3mgmD631Q7HD2RqUIvja2F6FL1GSkvSKOLyfTfsp2iQLpxDPGycc
         IP1q6rV5aeLzHCRkrzBbTjKbgUQfx0AbasZUkBCi5sTuEs6ri4hnFcSvYBVvHol2GOLs
         gCaREUz/BSJiW9rRT3E2v0L4fpUfKCosuAcEIxpht+lrTYtRj1KE3vp8nDdLrSECrKP3
         Z1KxxyRLkFVpwGAlb+wdFi2oZP8VZLpUNvl3f7Hxy4zdjE1QlfzL8T2CFNRy1rwW4rop
         DVbQ==
X-Gm-Message-State: AOAM532EmtgE0EORGr9ngiRdLmu6FVCEJC7z/M4fk67iW8fG5PjDN8jQ
        OWrS2HNuyaDoR9s5Faa/st1aSvtH3K68LTIm9Saxtw/Kwlrt0Yzx/hE6JGuS1LAqX7Mo/J6aGGG
        OdipBZfoNB3dvLTW9fd6s3Ibl
X-Received: by 2002:a37:a210:: with SMTP id l16mr22564941qke.213.1591620895376;
        Mon, 08 Jun 2020 05:54:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztS/xAlUYqSPPtL8j22b2Uu64X9c9LuNcyK8DjxfEZaxHffE4fVO6REb1jIXn60l0bFUdEHg==
X-Received: by 2002:a37:a210:: with SMTP id l16mr22564916qke.213.1591620895143;
        Mon, 08 Jun 2020 05:54:55 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id y54sm7750628qtj.28.2020.06.08.05.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 05:54:54 -0700 (PDT)
From:   trix@redhat.com
To:     mdf@kernel.org
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH v2 1/2] fpga: Fix dead store fpga-mgr.c
Date:   Mon,  8 Jun 2020 05:54:45 -0700
Message-Id: <20200608125446.23311-2-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200608125446.23311-1-trix@redhat.com>
References: <20200608125446.23311-1-trix@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Using clang's scan-build/view this issue was flagged in fpga-mgr.c

  drivers/fpga/fpga-mgr.c:585:3: warning: Value stored to 'ret' is never read [deadcode.DeadStores]
                  ret = id;

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/fpga-mgr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
index e05104f5e40c..f38bab01432e 100644
--- a/drivers/fpga/fpga-mgr.c
+++ b/drivers/fpga/fpga-mgr.c
@@ -581,10 +581,8 @@ struct fpga_manager *fpga_mgr_create(struct device *dev, const char *name,
 		return NULL;
 
 	id = ida_simple_get(&fpga_mgr_ida, 0, 0, GFP_KERNEL);
-	if (id < 0) {
-		ret = id;
+	if (id < 0)
 		goto error_kfree;
-	}
 
 	mutex_init(&mgr->ref_mutex);
 
-- 
2.18.2

