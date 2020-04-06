Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76610C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4007A206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EurRmupD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgDFVBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:01:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30889 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726331AbgDFVBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586206913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RVzro4XtEZaLbEft7JeQy81ssJHBlnUXRCePrLVPDZg=;
        b=EurRmupDo0I0LXwSNyYWafhZStv0HeSEjS8TWjWRNuhnuZirmw5n4NI84wcpk58PMMVE+w
        ZSRbeM7h27lza329tJREfqUoubOslhYWBUdZ0XLah2iwyK9jcewbdZaOmfC4sFqymy9gkd
        2XB5skP0qSCnZUH1EU6GgNvoL+gMl4k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-7TreDFz4NuyQ-7sJ1_jX9g-1; Mon, 06 Apr 2020 17:01:51 -0400
X-MC-Unique: 7TreDFz4NuyQ-7sJ1_jX9g-1
Received: by mail-wm1-f69.google.com with SMTP id f8so6991wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RVzro4XtEZaLbEft7JeQy81ssJHBlnUXRCePrLVPDZg=;
        b=mfgMSuPlkFd/SlyotlJJg/LkBeMbbMeprlXbXpdZsjwuy/C67QbFZzOXnujApLD27N
         0UrN1+RK4VGyo+nST6BUlgthwNZS/dDnErhy6ZoYsAeYFQJzzgsNupo+tVk5fH8qJrLw
         C4BEpXef6c+0VWNip7NGJ6PMg1Udew1OrkDHMeDiQSD5db1SjI3+EhqBULKEx7LiTE91
         UCbtfgaQkxfEuZG1+tOwvOFKBWom9AraosrD+h4pDXoc0W7XnWS3ztDwyV5G+qCNYwQw
         /YUrnIxxSEuDfofGJaol5nJ/ezhgbTIIvPzPHjYLh26GoixIBbSsOJbEQ7DivHWFrwWq
         0oHw==
X-Gm-Message-State: AGi0PubdDeZkD+0XRlVlAEJcD2jWmzSdBhkFR4/sSpNZKrxvX+DzkOS5
        zL/CBohkJY0FyFpuIZe+h9bqJjGc/2GUYszsQFJUeEy0YOJ5p5td8KJrWrtFQ91RVVn74WScuAt
        sFh6hCLyXgS2N/e/z/jb2Adl6
X-Received: by 2002:a7b:cfc9:: with SMTP id f9mr966450wmm.137.1586206910169;
        Mon, 06 Apr 2020 14:01:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypKF+V+023b9Mt80Qjnw/BKYHw0rugCFNMg2KpZ/RzzSTvuJGGHZP6+vFug+XfBPqFNZD9byww==
X-Received: by 2002:a7b:cfc9:: with SMTP id f9mr966428wmm.137.1586206909976;
        Mon, 06 Apr 2020 14:01:49 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id i8sm29713666wrb.41.2020.04.06.14.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:01:49 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:01:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v4 01/12] tools/virtio: define aligned attribute
Message-ID: <20200406210108.148131-2-mst@redhat.com>
References: <20200406210108.148131-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406210108.148131-1-mst@redhat.com>
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

