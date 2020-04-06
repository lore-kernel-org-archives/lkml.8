Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215D0C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8658206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WWI4wQsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgDFVec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:34:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24589 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725933AbgDFVeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:34:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586208870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RVzro4XtEZaLbEft7JeQy81ssJHBlnUXRCePrLVPDZg=;
        b=WWI4wQsBFRZWBvG7KySF91Ap2evDFgs3EpZQAuE/wTQUMoeqMEm3WVqcHewsGq/ZnCGaHJ
        /8kUHQnV4EJ+5FT6itoy+87I1lHd6y1g4+C17fRVdWjxXcGYgs9ah0NWnAfOvXOqpbqP30
        GMgQ8h9ccw5+IwbZuFBJ0SGnYUx/AoE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-Tyrg0rtvO8CKznqU2fuptg-1; Mon, 06 Apr 2020 17:34:29 -0400
X-MC-Unique: Tyrg0rtvO8CKznqU2fuptg-1
Received: by mail-wr1-f71.google.com with SMTP id h95so570268wrh.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:34:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RVzro4XtEZaLbEft7JeQy81ssJHBlnUXRCePrLVPDZg=;
        b=e6rM/9vOBM94xJClY8QODneDGJB6RwGI4Y1OpiHqPMx03yy5zmxjpn4dgfVjSKYBu2
         yn4ao2xBm7WTTDBKDJPdamXryvmzg7H2oWZzJr4MsPtSmnc140j8cQJOFs+z+U3kPEvt
         QaykkRDiZaAhW6Jh50WVizNesEu7kUolvIspgZa8lcASK2LLsNro+5BLDYpNoo2bzvPt
         F29v9xfjpax9fBrUvlqgS+eFERBoCZFRLyJBzC0GL+m4exUfgeO0rXHh0TvL0MIKB+VP
         exOxYYpZ5x/DpspT8W542cKlT5Y84yLYyLHb7tszdt1s+DyyLQFQB9/UAHNZKhv14ouu
         BVew==
X-Gm-Message-State: AGi0PuaGRiRiAtPx7tB5QHuUsEwnVWfLaqUHkkYfxkesVRP+omkzPoEV
        e9hu5u66gXwm+I+F56Kifeh9Qxw1rRjgI4tRPC7Um60B2CbELD12RXnSl9TXGc9J08qoZTRg4fu
        NuoUdV9egnLfd9COR+TRLVS/f
X-Received: by 2002:a05:6000:114f:: with SMTP id d15mr1365288wrx.143.1586208868472;
        Mon, 06 Apr 2020 14:34:28 -0700 (PDT)
X-Google-Smtp-Source: APiQypJe1ynXEfR0D8AoRMCthmTYYN49hldiZJCK3rhyOo8SLO63KDBiOBd6vs5GGxz/vmOhazUDXA==
X-Received: by 2002:a05:6000:114f:: with SMTP id d15mr1365275wrx.143.1586208868311;
        Mon, 06 Apr 2020 14:34:28 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id a15sm1046768wme.17.2020.04.06.14.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:34:27 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:34:26 -0400
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
Message-ID: <20200406213426.jDb7lUR4EdGUQ-cf81M76QOkz7iVcL1mTz1t1vhCxzY@z>

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

