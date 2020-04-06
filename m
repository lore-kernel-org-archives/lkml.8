Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A90C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19E72078A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="autBxJp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgDFVe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:34:57 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22859 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726636AbgDFVex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586208893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g21Qo7QtPcOJEghRPDvMQfA4S9QNIdU3sAG/Fw2UsOU=;
        b=autBxJp8JxItHR1XwXnwD1OUlH/dqRavPl40y9tCVRBUp1SrND7YGW3LFyUhZ2fm+uLriQ
        xYjn+fE9+J3Q2SVmY/HDtYlrrn8/VXwM2NJ9xItD9fbHHUpsinPZ+1BiMyhjKTl1E2oRv1
        xnn5o/Cc1/OzWgREm2eCdE0txt6LA9g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-3LCrQpjLM5GCJffpgS9y1A-1; Mon, 06 Apr 2020 17:34:51 -0400
X-MC-Unique: 3LCrQpjLM5GCJffpgS9y1A-1
Received: by mail-wr1-f70.google.com with SMTP id k11so565841wrm.19
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g21Qo7QtPcOJEghRPDvMQfA4S9QNIdU3sAG/Fw2UsOU=;
        b=VqmPENyUsfxRqSpsXK27YpR7gvxrRHnOLFtG387RyW5XYe0T6jHxRxT7aHzFIRJg2Q
         QSSpX7r8AG+jzfgfWIWjedOPdJRk/Nd1Fe1psL3WKAv/kTAP4kQQVYXymRrSsL167H2K
         3ieal0zAYBPB9x50pIQbhes1nlHbclChktERgTvA02x1a+UCde/Du5XzegZdGJ9vxkmO
         tNPICTOBLF+PeS6hgqhlVR4LzZ23o0GS8TvQ87sfS9TVzbQtuuz3L9hpQbktwoo3wZxk
         oVIdbYV7uz5BiJGiOZzcUyD+CLbJLdej7AObijn0jGHmPoAJtCUSKFKxW24ggD4YXaCc
         2c3g==
X-Gm-Message-State: AGi0PuaC7hVrjEesUexCNVtJqKU5wsl30IiRT/Wp/+JEgwUvqXl1wCCK
        VUEmSqAGnuEYEuGZd8yXHqh6QUc/RfQ74S4rPKxVxqVHmwnOZN68fbTvv+nW0C5KhNT1CnNMCl/
        8qorxH6lzoH67/rzOkx4ytHy2
X-Received: by 2002:a7b:cd89:: with SMTP id y9mr1437683wmj.102.1586208890219;
        Mon, 06 Apr 2020 14:34:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypKAZJhwUAhdJ4atiej6VK/mv8hk/1Y5ETF7CybO37bXvAJPTN+IEMIUppA3nQ+/F7Q27F9Y9g==
X-Received: by 2002:a7b:cd89:: with SMTP id y9mr1437667wmj.102.1586208890008;
        Mon, 06 Apr 2020 14:34:50 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id t16sm29149843wra.17.2020.04.06.14.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:34:49 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:34:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH v4 11/12] remoteproc: switch to virtio_legacy_init/size
Message-ID: <20200406210108.148131-12-mst@redhat.com>
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
Message-ID: <20200406213448.2bmQTkrwzSPBqFR8J3OybC1EN-Jkfd95V_1XMRd0FOI@z>

These are used for legacy ring format, switch to APIs that make this
explicit.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/remoteproc/remoteproc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 097f33e4f1f3..c350a01e6c4e 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -322,7 +322,7 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 	struct rproc_mem_entry *mem;
 
 	/* actual size of vring (in bytes) */
-	size = PAGE_ALIGN(vring_size(rvring->len, rvring->align));
+	size = PAGE_ALIGN(vring_legacy_size(rvring->len, rvring->align));
 
 	rsc = (void *)rproc->table_ptr + rvdev->rsc_offset;
 
-- 
MST

