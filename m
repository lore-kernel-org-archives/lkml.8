Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311FEC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06BE220719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S8rr+ljh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgDGBHt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:07:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29264 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726582AbgDGBHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586221665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jXqTQsUO9YVhjrcDRdxdoA1nJXOlF582i9eQgnD+YFc=;
        b=S8rr+ljhJNGprvWC73XtxxyWK92hrfxtUkxPjUoy0GJDl3bDfr+2Vtjk8nfh2AjB9AdKlB
        PznXQ7PUqwTgq+haElXdDbk9gFoXM5xtMV9KND99+VjvN6J67WCkkmf1FwA551MIhceZXE
        5/C0MU82JitBvSXQlJmLzP+a/ZeO+Js=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-sV9uXe5IN4CFksfgDMcCLA-1; Mon, 06 Apr 2020 21:07:42 -0400
X-MC-Unique: sV9uXe5IN4CFksfgDMcCLA-1
Received: by mail-wr1-f71.google.com with SMTP id d4so853639wrq.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jXqTQsUO9YVhjrcDRdxdoA1nJXOlF582i9eQgnD+YFc=;
        b=hxBL3Kj+1zsXbUOJyYpATsAlHhS5Fk8U2Vbo2Ba8oOfKND1m0YipuPUW9umYdPCbTp
         V94D+Pf6DJQ5wylYz5MGTpBCiZNe/DNqYDOQ7SXC2hy3mTNXR8YxTxtj1PQUkbjsWvEj
         2MuwMb7RoW3VlV9UZ0tGrs0sfq55IAXjlsLI+/QgSxauEJT0sNF5Rqb5SOwtIQb1jnfM
         rXcHDxNwQ97uSeiutGQ7ruI/whhSGihrJ2FvGHDI6QeVTo2MOE+7ycrvOmPikO7iFW7Q
         QpFhzlE93zFNMhrETvHyc8gJFsFoUCKjOxL6QRLD2E0+8JmkVMNN2KGI++Zd//ExemCh
         ARLQ==
X-Gm-Message-State: AGi0PubBTlF3cc4/ibaoUqNwn6gANzhJDxxe4EfejBMeW9ZmgYY0Siwz
        K7xW62ozNSvpQEUQjy4cyctHiVknC/8Y1MbsZSXSQ5HsDWp5zPH3YYCQrrg93ZCQ1LUN2xSD3NN
        0Ny0K+xLoji2yGEEH8fCH2+LH
X-Received: by 2002:a5d:6a47:: with SMTP id t7mr1956340wrw.131.1586221660768;
        Mon, 06 Apr 2020 18:07:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypLi++G08KSxRhS85KgN5Q3h/2wGkqBja4GHXhB9IEHoUEJizYJP56tBhmaJBFrG8QKxZifQnw==
X-Received: by 2002:a5d:6a47:: with SMTP id t7mr1956327wrw.131.1586221660622;
        Mon, 06 Apr 2020 18:07:40 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id k184sm103051wma.13.2020.04.06.18.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:07:40 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:07:38 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-crypto@vger.kernel.org
Subject: [PATCH v7 06/19] virtio-rng: pull in slab.h
Message-ID: <20200407010700.446571-7-mst@redhat.com>
References: <20200407010700.446571-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407010700.446571-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to virtio header changes, include slab.h directly as
this module is using it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/char/hw_random/virtio-rng.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index 718d8c087650..79a6e47b5fbc 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -11,6 +11,7 @@
 #include <linux/virtio.h>
 #include <linux/virtio_rng.h>
 #include <linux/module.h>
+#include <linux/slab.h>
 
 static DEFINE_IDA(rng_index_ida);
 
-- 
MST

