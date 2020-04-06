Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED29C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CA5206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JBipwPfX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgDFVB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:01:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55192 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726417AbgDFVB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586206915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FHleMq6gEYUibDa/C/J3JExco78nMtVdL74tcT52HVU=;
        b=JBipwPfXuCH2xO2tN1EL/SvMK5EQEYM+Bhn10vKm+o+E8EaIQzRt0r35Zy4dkBCfcgzYxk
        IFz6N/8LlF8Pd6hYylphNRw47CCrY+80fJp7Yv6jbU08Ttk0t6XPznkrHShbQBKyf5LpHf
        HhrqkdYwfOxQBVbVl64YEiWo53rwQY8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-YsKelzYXOAKqHnh6EqHOvA-1; Mon, 06 Apr 2020 17:01:53 -0400
X-MC-Unique: YsKelzYXOAKqHnh6EqHOvA-1
Received: by mail-wr1-f70.google.com with SMTP id a10so542742wra.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:01:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FHleMq6gEYUibDa/C/J3JExco78nMtVdL74tcT52HVU=;
        b=FPC8oDjPSbRAXVgUmIdvVhroPtEDfP0b4v7DghiMLwErKzgJ/f34nu9CoEsBiFShzT
         dV+hoAoRB2K2Gg9Vh0VWpQN0kJA+oYvQBwLyVF/PcwEtVzZJHkaYhHvrfGBUXhf7zp+e
         wdZh21QxD46RWWtkuMtldxChefbZwIqzOFsLS8fU5SObEvM5O8DM3nxrJVyJrKZdRupi
         BSNDqf1gd96lxNFvbSleE0dxfxaEG7H1zo215rd4zg7hTS6K/GBoYXdO27Mf7Nlo/dLk
         extgF9T6/NIOXQa0NMtOyNJdd74VHQSE6VLzzsxGaZB1AGnhrBuYf71Hzs6P+RUeNJKN
         3BZw==
X-Gm-Message-State: AGi0PuYd7uLCg001RyEQXXXvk/G4fYfrI9fiWpyoJpNMGC55AT1eHqsT
        zYLulx5UcB+AL5YHEjh9AUYB/LzrfARddmg6z5f0EvjOlolu+cEFdiUV8/JLmXjqziyzfF2USeI
        IoFnmpqlV25gC2rI/zCohznx8
X-Received: by 2002:adf:828f:: with SMTP id 15mr1162192wrc.59.1586206912166;
        Mon, 06 Apr 2020 14:01:52 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ26JCMTvoHOJS339prjMyie7WY4xBIXnYpqwkeSr+H09nCHLrKn/QkamrIw58/gMEebn7Ylg==
X-Received: by 2002:adf:828f:: with SMTP id 15mr1162175wrc.59.1586206912009;
        Mon, 06 Apr 2020 14:01:52 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id q9sm10447252wrp.61.2020.04.06.14.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:01:51 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:01:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v4 02/12] tools/virtio: make asm/barrier.h self contained
Message-ID: <20200406210108.148131-3-mst@redhat.com>
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

