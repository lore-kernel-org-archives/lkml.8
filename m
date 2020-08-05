Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF22BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73579206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a5Eddpxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgHET3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:29:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31589 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728600AbgHERL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:11:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WBH1LHbCDthOlF25HB1GNrSGXvGdUkDAo8hvALVyXYI=;
        b=a5EddpxtHP7+z7ZF57sbRi26q+kBhi5brAZOh7MUltxeXQk+vceBmvs1JmbN7YVkOG+ZhP
        3cLu/AlY44F8rrllAtiHzAMzPmORhCKQaNTZmJ8ogGEEHN40P1SGY0RWcYLHRNtWWSf+KU
        NAuL2cS9wnS9fcK9eLgzJdaf/+hVCac=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-GQs2M6jdNSKNYkH-_rLlYA-1; Wed, 05 Aug 2020 09:44:49 -0400
X-MC-Unique: GQs2M6jdNSKNYkH-_rLlYA-1
Received: by mail-wr1-f69.google.com with SMTP id r14so1529621wrq.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WBH1LHbCDthOlF25HB1GNrSGXvGdUkDAo8hvALVyXYI=;
        b=Le3E5KG4eYbKqKvK0mu4Dl/njgm1m34Vv2mhxpYtwjyLeKQ/G8KSSRk2+4buU/4JGb
         hrC92s5Tuw80XEJajKOrmZVIsyWS3yuIqjS+mjV3c9SAOPHtQib0UEGFhJkeY4BfJm+I
         nr20sEZluApV0jr5jGYSarEJlkUQP8gRY7+FmKWh6S2H9Vm/ZdGCBA1/8dYHj7mR5mQn
         iONg1S+C0UMpr3hdDm5yaL+a9fb2yoKAuZ8EZWBYZyoZRm+eLCRLlf608WL0Ga/l6krC
         T50wV9sg1gYm+ITpT4Ps9sgulgx8cdv3IZwD0JlO3bE2dEYWUY4FnhJChg9/prS8T24z
         cR5w==
X-Gm-Message-State: AOAM533mX15TlS3DUQXLPZvxw4aKyYupHNGPgjfFGIwA0xFvCdgOOSOA
        Iwv8APvo9QBnGPOu3K1PQ/ouRWbTjf6fDbemAdAKrEtuiVrcyQVpKreNUQRkZUtPTyiR2zw7Y+l
        eNUVzMGLtVzYZ4NFKNvhw8Q2C
X-Received: by 2002:adf:ab0d:: with SMTP id q13mr2728305wrc.134.1596635087919;
        Wed, 05 Aug 2020 06:44:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxc8ukE7mtzF0Xw22J8QjnJI7RUP7Alfizi2qIlpwN9G61AnzGldaFn2ZneBCQ7Es9dgmyqZg==
X-Received: by 2002:adf:ab0d:: with SMTP id q13mr2728292wrc.134.1596635087769;
        Wed, 05 Aug 2020 06:44:47 -0700 (PDT)
Received: from redhat.com (bzq-79-178-123-8.red.bezeqint.net. [79.178.123.8])
        by smtp.gmail.com with ESMTPSA id n24sm2989133wmi.36.2020.08.05.06.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:44:47 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:44:45 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-nvdimm@lists.01.org
Subject: [PATCH v3 33/38] virtio_pmem: convert to LE accessors
Message-ID: <20200805134226.1106164-34-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtio pmem is modern-only. Use LE accessors for config space.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/nvdimm/virtio_pmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/virtio_pmem.c b/drivers/nvdimm/virtio_pmem.c
index 5e3d07b47e0c..726c7354d465 100644
--- a/drivers/nvdimm/virtio_pmem.c
+++ b/drivers/nvdimm/virtio_pmem.c
@@ -58,9 +58,9 @@ static int virtio_pmem_probe(struct virtio_device *vdev)
 		goto out_err;
 	}
 
-	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
+	virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
 			start, &vpmem->start);
-	virtio_cread(vpmem->vdev, struct virtio_pmem_config,
+	virtio_cread_le(vpmem->vdev, struct virtio_pmem_config,
 			size, &vpmem->size);
 
 	res.start = vpmem->start;
-- 
MST

