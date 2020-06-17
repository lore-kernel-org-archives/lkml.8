Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68685C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4477D214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:07:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NeJOrOiO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgFQNHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 09:07:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28195 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725894AbgFQNHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 09:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592399240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=leSYs5eJlF2yRHZz2VWaeaIgreSYZPQY+//144okJEI=;
        b=NeJOrOiOYwMjxPqCWfHUqMxBNeOvBSn/VbiMQHmXuh5bJJnPVKtYyXJ4raQayHQ7l5M6AR
        BC2R9cnthV1jUddIDoZN0KgnHHW74XKfR2R3JqDRKqK8GB2+gAjKcmphvSlXOyyf2URs9x
        LdkLKw584r5ulCxezg1JSzWd/ESvBH4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-8dhRNnSmMzq0RFaScPSC1Q-1; Wed, 17 Jun 2020 09:07:18 -0400
X-MC-Unique: 8dhRNnSmMzq0RFaScPSC1Q-1
Received: by mail-qt1-f199.google.com with SMTP id o11so1636020qti.23
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 06:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=leSYs5eJlF2yRHZz2VWaeaIgreSYZPQY+//144okJEI=;
        b=HC6lfpX2+wX7BTPJDv/6gyHr+3B/5Z85uG4gkYxn3o/4LlOcJTYVCZSPp3fGoGNieQ
         n7Zkt6IpnhxE/H/vcEu27N8+9940K2cESyc5P6W7URjK+49mnqAqaCVdV0SMLmx4gTiI
         2+6DJJRXdhVWg2Pg44bU8Chj8sC+WtlsqM4Uf50tCvY2g3SLC8u8rN/WoCamPJXbrCpa
         yQB9xeqXq6bbqMhCh9dAmReC5oLYErAhwafGE1oHLsKJngpvA4P4rWiJepO3xN39Q8ci
         4nDyFzkR39QdECFf1KoAfi7L/jrGwhT+44Av8zYEVyImNd4+yommYa7W90CLA7cEBQHI
         1mSA==
X-Gm-Message-State: AOAM532/XCTRdbBjFJNdHQBsGa0/UCxby8KhChvFrktXg4iZOF8XH1fA
        y/QpOIPWdkTbC/hWk3M14QtZLjq1XAW8XI/qPep7tmzDEAbZfsAU+q3lTm+M0+ocuocxSljr61u
        ymbU7+UqIbJHbw1LTDGV44o8s
X-Received: by 2002:a37:985:: with SMTP id 127mr26104716qkj.297.1592399238185;
        Wed, 17 Jun 2020 06:07:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypMQdahCFjHiWiaKUTucTI+GfdUfCkJlp/Zgqvo9GoRNi67NgD3Q/2ramjVSjXoLUG6gnrCw==
X-Received: by 2002:a37:985:: with SMTP id 127mr26104691qkj.297.1592399237920;
        Wed, 17 Jun 2020 06:07:17 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id l56sm222123qtl.33.2020.06.17.06.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 06:07:17 -0700 (PDT)
From:   trix@redhat.com
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] fs : initialize return for iter_file_splice_write
Date:   Wed, 17 Jun 2020 06:07:11 -0700
Message-Id: <20200617130711.23434-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis flags this garbarge return
fs/splice.c:786:2: warning: Undefined or garbage value returned to caller [core.uninitialized.UndefReturn]
        return ret;
        ^~~~~~~~~~

ssize_t
iter_file_splice_write( ... size_t len, ..
	sd.total_len = len

	ssize_t ret;

	while (sd.total_len) {
	      ...
	      ret =
	}

If the input len is 0, the while loop will never run and ret will
not be set.

So handle similar to splice_direct_to_actor and initialize ret to 0

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/splice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/splice.c b/fs/splice.c
index d7c8a7c4db07..f65e072bcc2c 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -691,7 +691,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 	int nbufs = pipe->max_usage;
 	struct bio_vec *array = kcalloc(nbufs, sizeof(struct bio_vec),
 					GFP_KERNEL);
-	ssize_t ret;
+	ssize_t ret = 0;
 
 	if (unlikely(!array))
 		return -ENOMEM;
-- 
2.18.1

