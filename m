Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC28C2BA1B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9EE2076E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:16:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IxnA8N2I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgDGBQf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:16:35 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47489 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726407AbgDGBQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:16:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586222193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RVzro4XtEZaLbEft7JeQy81ssJHBlnUXRCePrLVPDZg=;
        b=IxnA8N2InNEgm/19vFJdUAeM3Mr5KGSVCZfFgbhgMCMoogbLALxglH13PEi/tTTm2HSfus
        PyZeENV24DOFyR3Xl/xyBtS2XZyGw7oykZ3Bz/Nw5vzoV5gkuJoS4f7XOMyf29bM5jVU5p
        63xRcps8MODEhshnlngwx0+o/Rq+6yM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-N9wNGUtaPtqtj0no_6KTxg-1; Mon, 06 Apr 2020 21:16:32 -0400
X-MC-Unique: N9wNGUtaPtqtj0no_6KTxg-1
Received: by mail-wr1-f72.google.com with SMTP id 91so873551wro.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RVzro4XtEZaLbEft7JeQy81ssJHBlnUXRCePrLVPDZg=;
        b=aQzxkMcBV42SEkCUVKsAEU7L2xyEcEzGj2NK8B9ffJu3WVDaNTRdls6oUh6dVA+JnT
         mUIdNjliWvgFFepxwvUYlAHzFFJG2cALa+YYku68bHVV9X8D8CGFkCYCOlhiqS3S5xv9
         2xu76N2B6dGKsDEjmzRanv68gKGlni2eaHaPSCNLeSfBKiW6yPkpJaBedEExMBxo4O0L
         tu+T+9UASOitgWI2KeE3sl0FWv1KkvKvUn7vwbvm5KLbQH4AaamZPNDO+eZ4d1HYv4Cu
         d5dsfpfPxOuh3nvhNso0znDyucpj6u8NjojsFX3bZxJ3cyVC8ndEODiB81gh3mH8xI9D
         jqhA==
X-Gm-Message-State: AGi0PuatdwXy4L1SjeqP6UjUhCxTSYSDANilasAFCi6owYC1lVrx8Qy1
        r/lpC9OexWclwBnX+ZSGoCFgWqE0NShlTIjViQ10rp5+frY1nsv5ZRkcBl0VkeSy/IPZSucWBtX
        Pa0SDJuQ1KPY0AmGutwnVPIz5
X-Received: by 2002:adf:f3c1:: with SMTP id g1mr2187527wrp.90.1586222190935;
        Mon, 06 Apr 2020 18:16:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ7P/kPvw3paHovkMWNa/u3ENAVx5JqKqcOIuiBi1V5YrTfZ/ZU9piHeuzwqlHFaAyT1Zp0HQ==
X-Received: by 2002:adf:f3c1:: with SMTP id g1mr2187520wrp.90.1586222190813;
        Mon, 06 Apr 2020 18:16:30 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id h26sm117645wmb.19.2020.04.06.18.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:16:30 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:16:29 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v8 01/19] tools/virtio: define aligned attribute
Message-ID: <20200407011612.478226-2-mst@redhat.com>
References: <20200407011612.478226-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407011612.478226-1-mst@redhat.com>
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

