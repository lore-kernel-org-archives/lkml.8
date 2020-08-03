Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51CDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDBA722CB1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8dvCP3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgHCU7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:59:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55444 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728605AbgHCU7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596488350;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i84PP3Re6PfoQrMXF63OXd7sE+dx3f/0IwVj5uJOuRY=;
        b=C8dvCP3NAQCbUZ34s83daZUeUJBZPhtBv/4/6EMivE6iFSQVfAk0dE9K0saU3VPr0Jrp0y
        OZYcYnuLwRI4NL/yTqiphLJzO9i65ZEPyNZ4MW0q+p4nztL0Rn7q8hsB39J5s2hXx0VB5k
        /ZfaCL9HpH+OSKzJxzzkD8pa5UnWmZo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-AVkE7VM_P828604qissRuw-1; Mon, 03 Aug 2020 16:59:09 -0400
X-MC-Unique: AVkE7VM_P828604qissRuw-1
Received: by mail-qv1-f72.google.com with SMTP id d19so5479714qvm.23
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i84PP3Re6PfoQrMXF63OXd7sE+dx3f/0IwVj5uJOuRY=;
        b=NvwkoFa5XLsTAQST+6RcefdPFVpFgYJn0HR8gSJf0tYRBi7B98UnOsYI12DjOayiRs
         t14wtysCUPCo2rbckE49O/lbKRksM/fsAIwxNKcUWp1w3dozKa/z34XTQJrz+lErs6GA
         Zbz8gtDzgDMtQ4k5HceaYfHsbHYWPPMx0RtCFnqBD8JapG0E9/zbbITwrdzUZLsyf2+r
         KU5zySzvKXuTl0am9qMLWDNOth+Hb8kZPv4ota9nrA4bqxUOhgmF/kaGYdaWXv1M1oNC
         uqvBEVWhluMhuYjJlzmO+lMUAL32liwphQQEAgR4Ij5efDicQcMk29iOOMuAthlESgEV
         4W8w==
X-Gm-Message-State: AOAM532B2Qt/ibEVzw72DgoABHQx7JDowqFcUJ8i50nqQaj6pieNAQyl
        07rL/D1A3DPlgg6k3NcAEy8PZlXbzYSAW3wD+gO1mGk4T2G1t+90dtaSyCac5E0hb9yLq2woTGH
        wo8tBYbY3as11WZjOqACzjJmi
X-Received: by 2002:ad4:42cc:: with SMTP id f12mr19042820qvr.89.1596488348830;
        Mon, 03 Aug 2020 13:59:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz262h1J0muCLAurrrG0els/b63+CoBKe7x5909bPvHViTN2G1SB1XsG8FwJY6r+RwaqGESuA==
X-Received: by 2002:ad4:42cc:: with SMTP id f12mr19042808qvr.89.1596488348608;
        Mon, 03 Aug 2020 13:59:08 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net. [79.177.102.128])
        by smtp.gmail.com with ESMTPSA id c22sm20470842qke.2.2020.08.03.13.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:59:07 -0700 (PDT)
Date:   Mon, 3 Aug 2020 16:59:04 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>, Amit Shah <amit@kernel.org>
Subject: [PATCH v2 07/24] virtio_console: correct tags for config space fields
Message-ID: <20200803205814.540410-8-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tag config space fields as having virtio endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_console.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/virtio_console.h b/include/uapi/linux/virtio_console.h
index b7fb108c9310..7e6ec2ff0560 100644
--- a/include/uapi/linux/virtio_console.h
+++ b/include/uapi/linux/virtio_console.h
@@ -45,13 +45,13 @@
 
 struct virtio_console_config {
 	/* colums of the screens */
-	__u16 cols;
+	__virtio16 cols;
 	/* rows of the screens */
-	__u16 rows;
+	__virtio16 rows;
 	/* max. number of ports this device can hold */
-	__u32 max_nr_ports;
+	__virtio32 max_nr_ports;
 	/* emergency write register */
-	__u32 emerg_wr;
+	__virtio32 emerg_wr;
 } __attribute__((packed));
 
 /*
-- 
MST

