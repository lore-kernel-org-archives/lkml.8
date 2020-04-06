Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3909C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AAE7206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lt4cTXqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDFW0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:26:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39123 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726287AbgDFW0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586211994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RVzro4XtEZaLbEft7JeQy81ssJHBlnUXRCePrLVPDZg=;
        b=Lt4cTXqGJD1kXdNw9+jUR0FlOsvLVnP7UyFwtSaVic8jtVvZMSc15EuGcDPSakbrzWUuRj
        6rnMqM59l4RRjwRXCD3FX8cfcETEHR2+/JHemwmIFeHyHUx5e6Zd7os6RqPginVizFc2sr
        R1WpIe6AYli4aJJLs/7wu8MkWNzT0yE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-hEhSgSXOMJyrUVXk7cdbUw-1; Mon, 06 Apr 2020 18:26:33 -0400
X-MC-Unique: hEhSgSXOMJyrUVXk7cdbUw-1
Received: by mail-wr1-f70.google.com with SMTP id q9so625268wrw.22
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 15:26:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RVzro4XtEZaLbEft7JeQy81ssJHBlnUXRCePrLVPDZg=;
        b=UhEAr6MlZqCYy5EtfV4EeRz4BJkaZwrujTMjpYZZ7k85b+MoMhp9oE1Byyl8ISEJGf
         QJ+/SQsZ/O8uvBKWhQmUTe7WbyHhshB6v4QGgeYEitadoCXQ4Xqs27jNN3w/v9bzggqb
         1WTqOvrMfq7vFcPG+D9HENYPgn4/OjSHCU2zFABuP7rBa5IQX/1BVlihfZyOslzLSlOD
         qTo5PYUEUGt95+7eCOK5MikrzPcwDrwgn6XqnRSh8iD1KDPQTY7ODj9LwWtqkdJTGjvG
         cZxuZ15r8jKi8lsE9Wx5pyyGWVqtrIQTezLRGxp5bfCA4G0ivn+0v2mw6kEKzI0mpL0H
         S+EQ==
X-Gm-Message-State: AGi0PuYbZIxeLAsI/mj1pkqIjMEivSW16sVSAX/yRZLDwYIVeseJf7Qu
        vH0lFGp8zz6C/CbeZ/qARMXIJQcuZuYctxB9NB0VzDL4sKBOewttWiXc5AUIoyULio146yatwjP
        OdITBEAMylMWbLVywKg5dQgBX
X-Received: by 2002:adf:fa4f:: with SMTP id y15mr1629332wrr.118.1586211991694;
        Mon, 06 Apr 2020 15:26:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypID3vQSC8d+b7Qfd6yISzP96PUgOGeTuHuYX0knT/3rNQH8A57yKPUmPzAS5bhV68+Gd+1jBw==
X-Received: by 2002:adf:fa4f:: with SMTP id y15mr1629315wrr.118.1586211991504;
        Mon, 06 Apr 2020 15:26:31 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id a80sm1183801wme.37.2020.04.06.15.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 15:26:31 -0700 (PDT)
Date:   Mon, 6 Apr 2020 18:26:29 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v6 01/12] tools/virtio: define aligned attribute
Message-ID: <20200406222507.281867-2-mst@redhat.com>
References: <20200406222507.281867-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406222507.281867-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/linux/compiler.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
index 903dc9c4bd11..2c51bccb97bb 100644
--- a/tools/virtio/linux/compiler.h
+++ b/tools/virtio/linux/compiler.h
@@ -7,4 +7,5 @@
 
 #define READ_ONCE(var) (*((volatile typeof(var) *)(&(var))))
 
+#define __aligned(x) __attribute((__aligned__(x)))
 #endif
-- 
MST

