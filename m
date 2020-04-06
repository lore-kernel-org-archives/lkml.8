Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8C0C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9E820753
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1L0q7/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgDFW0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:26:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26130 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726130AbgDFW0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586211996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FHleMq6gEYUibDa/C/J3JExco78nMtVdL74tcT52HVU=;
        b=h1L0q7/e2uivW3f/09H+Wlb49TCIPb2at8/Gav0TObmL9En+2bp9hodBfHCyVd+YQQt91f
        bpOvolsr/M4zIJVA7gPB1huL5txxpl4DCGd2acoX7TvvVHHXMDWUN33FBrCLZ1yevPWLq1
        IalKlm4bll4uRyCEPJI9nuzmF+NE8NY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-lZD8Os6mPh6sut10VZzMkA-1; Mon, 06 Apr 2020 18:26:35 -0400
X-MC-Unique: lZD8Os6mPh6sut10VZzMkA-1
Received: by mail-wr1-f71.google.com with SMTP id t25so641490wrb.16
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 15:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FHleMq6gEYUibDa/C/J3JExco78nMtVdL74tcT52HVU=;
        b=qaWtEqTkg+HRD/0lIMWudT46n19o+C1KwmKsMnJMvUWip/jTtJnaEET2tLlLgxM82Z
         88eF3lY+hLzg0NcZI48ufhKxcuvSPlT62o8zUxWjmpc977czxp/TkpMs8V7Cvm4hL/1E
         35Dy0rv7sI+gZKxM0q+jaTxLmvEnfQMXdeSg2q+2vJhV3AI2c3h/t9jjqfrmrReDNY1D
         HxD/gJJ+UPwrsUOpUWKMw/OEkMRPf5lDEddzGcQwyeFIF6VvCuTp7mdgtrDQzNAwneks
         3sSkuSbSIB76Pc0BMCYEvGK3LsPvcS99InmvXlTIBwUeuS/+qbDFtg1b1FHfVMTlTlPL
         h/0A==
X-Gm-Message-State: AGi0PubN64plPbAXyHEL9mJzHcnqpx5xaVM9JabX1vYPEatOKs+Da1o5
        sFZSeVHvwqth3fcHwfQf9GlO4HR6QHYbqxVkd3C5x644eQsPRTrTIEANtkPcw7qlx7UoW378ota
        7jjGvHuCnDdSWNEL/x8uyxkQg
X-Received: by 2002:a5d:5307:: with SMTP id e7mr1383115wrv.97.1586211993720;
        Mon, 06 Apr 2020 15:26:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypI/VFZ1mv4Of1g8jNAhLYrAOvgnu9l3O0APxfllxbHO3R7GakNZrAOW/S0OBpH2/Vj2EDx6Rw==
X-Received: by 2002:a5d:5307:: with SMTP id e7mr1383108wrv.97.1586211993583;
        Mon, 06 Apr 2020 15:26:33 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id z3sm1162185wma.22.2020.04.06.15.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 15:26:33 -0700 (PDT)
Date:   Mon, 6 Apr 2020 18:26:31 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v6 02/12] tools/virtio: make asm/barrier.h self contained
Message-ID: <20200406222507.281867-3-mst@redhat.com>
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

