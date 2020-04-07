Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F51BC2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750D52082D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ga1WPGqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgDGBQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:16:53 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22582 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726651AbgDGBQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:16:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586222208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cpBCN9COwU5b1SJmxmkerQbIPy9Gv4aGbfqwyHnqUyE=;
        b=Ga1WPGqAyrZjAkdDu9C5i3pOECZAXxLMm7GoMkMsYgXI7ltPuC2nCwofQKMpb5+4Fjk9Ti
        AEZrBGwX8e5HqyToNNp0EcYKaIeX9zm1MZSvGID/Kt5569Gv08lKs5Dvi7jo6jMJVyzggH
        /lpXqIPgvRPvshHMUqgf1AkqmXMT5pE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-xQjstrbGMJKVV3E67wO-SA-1; Mon, 06 Apr 2020 21:16:47 -0400
X-MC-Unique: xQjstrbGMJKVV3E67wO-SA-1
Received: by mail-wr1-f71.google.com with SMTP id d1so856708wru.15
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cpBCN9COwU5b1SJmxmkerQbIPy9Gv4aGbfqwyHnqUyE=;
        b=lKVUIE7UDdv0tjPbH+nZgf7l0C8mIJDxXVqJTC0X15LiehhD00nFbCNmghuYPm2B4A
         u9O3tet9eCTTSmeYGg2JgRL8rUItLCwaO9v9W1J1RuheDUaz0+jhjkCgn8Z0MRBQ7a4U
         spTSDORPJYkdP8vgq2Hl4icSNw5VpjfWq1HiKlIxmBQF0QBwLO6OEYDEtP5SBaGHuSd7
         ftZZZl6R9RVzOJHWYcLn1mrSCWciLSfB9iD+n1335yc3ngUkpA/oZESLU/Yzu0RSRVBD
         TszTzjd58PIjMMWGzNHYCtjgn1wTRwMT1ZwFyVhhse7n/Htu34AkdY3Bu4jyRU78vL6D
         vB0Q==
X-Gm-Message-State: AGi0PuYPAsOR1zELXrzDBN8LZNoFd5XhAw7MYPbeS53//cMJvE9nsphQ
        qSyPnSznjX1IzFqRJINiO4hog89MMo7BQuqEAj2lGOQ7Aw2eMA7r3GGuRswDbVetxfA3QNE1pFF
        nSddu+0N9CRiMrkeVm+kjbX/S
X-Received: by 2002:a05:600c:20c6:: with SMTP id y6mr673325wmm.131.1586222206035;
        Mon, 06 Apr 2020 18:16:46 -0700 (PDT)
X-Google-Smtp-Source: APiQypKsYIs3Qr5PkXmap2E0hCjkxv5++0RLSpqWIlZfkMmuv1j2DVhSfHZ98voqjkQnNwsmVYs5Tg==
X-Received: by 2002:a05:600c:20c6:: with SMTP id y6mr673314wmm.131.1586222205877;
        Mon, 06 Apr 2020 18:16:45 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id s66sm98326wme.40.2020.04.06.18.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:16:45 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:16:44 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v8 08/19] virtio_input: pull in slab.h
Message-ID: <20200407011612.478226-9-mst@redhat.com>
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

In preparation to virtio header changes, include slab.h directly as
this module is using it.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/virtio/virtio_input.c b/drivers/virtio/virtio_input.c
index 5ae529671b3d..efaf65b0f42d 100644
--- a/drivers/virtio/virtio_input.c
+++ b/drivers/virtio/virtio_input.c
@@ -3,6 +3,7 @@
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
 #include <linux/input.h>
+#include <linux/slab.h>
 
 #include <uapi/linux/virtio_ids.h>
 #include <uapi/linux/virtio_input.h>
-- 
MST

