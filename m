Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4549CC2BA1B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182E520719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3RE7Evh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgDGBHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:07:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60312 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726403AbgDGBHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586221655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FHleMq6gEYUibDa/C/J3JExco78nMtVdL74tcT52HVU=;
        b=I3RE7EvhVU+IlNEsodsUF2DjNNtEr/PBw4P4MYrnyif33ksstIe0Di7tLu7C+eaS7TsTNU
        /eUuflBOiPb0wFmoSGLq22Kjr+YWLzBT9+P6ljm0rr2RNC6lL7KbFvXrRztUmAzc1dqxtu
        hCl2rB12yOkD/mHVD8+OIv+CyQ2TE8s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-HVdP8GZYPtO3OYzeczzZHg-1; Mon, 06 Apr 2020 21:07:33 -0400
X-MC-Unique: HVdP8GZYPtO3OYzeczzZHg-1
Received: by mail-wm1-f69.google.com with SMTP id f81so37452wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FHleMq6gEYUibDa/C/J3JExco78nMtVdL74tcT52HVU=;
        b=PLWxUCvCoZpjF00B5E25znpYbp78ZcNZ7TvsWPylXtltBEAd6Z2rYptGXDCNODzKYA
         sPWbROD5awxXBSSyZI5wWswurj/O0+fcyXYgG3ZkpTRMjhm25A1IaNO7lrwLIJy4JynX
         w/dwwi7OK5cCqHXFl8snRvQaIfYEgf3DFxpgZJNfr4IjysgGBwxlKHnyFbQ/QmwlJo8R
         VSadfW0k0rm3xnj0BuyrdyFV1TbrpjHTigfCuPnT8Xnl+altNvnycviYRQPQapI32t0N
         ENaLLoRDoLuuufHPnCPQNs5wRZJdbomHXR2VDuHZ7ypqXC2lMdPLDsKIgvZi5FV4bjli
         Rgig==
X-Gm-Message-State: AGi0PuaDBodoaaH0/bSwQfk+onIB9GT0iBdeWC8teNn3dsr/NkODFEcS
        WnUZlMLyptF3cgfPT5kH9MAg7MQYiP9cKrMomN5X+l9fF+/3TvcrnC7qaewAbR863wS3dbytRlz
        NFt1wsTLQZJrq2DZSFsWLabBq
X-Received: by 2002:a5d:4988:: with SMTP id r8mr1994153wrq.248.1586221652056;
        Mon, 06 Apr 2020 18:07:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypJtivYsg0cY33d8RdMzgiJx/R309eSMZK4FZ+i/kU2AyobBthaWz8wAQQB8wP7V80tAuPpK5Q==
X-Received: by 2002:a5d:4988:: with SMTP id r8mr1994141wrq.248.1586221651849;
        Mon, 06 Apr 2020 18:07:31 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id z17sm18521513wru.39.2020.04.06.18.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:07:31 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:07:30 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v7 02/19] tools/virtio: make asm/barrier.h self contained
Message-ID: <20200407010700.446571-3-mst@redhat.com>
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

We are using abort() so let's include stdlib.h

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tools/virtio/asm/barrier.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/virtio/asm/barrier.h b/tools/virtio/asm/barrier.h
index d0351f83aebe..04d563fc9b95 100644
--- a/tools/virtio/asm/barrier.h
+++ b/tools/virtio/asm/barrier.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <stdlib.h>
 #if defined(__i386__) || defined(__x86_64__)
 #define barrier() asm volatile("" ::: "memory")
 #define virt_mb() __sync_synchronize()
-- 
MST

