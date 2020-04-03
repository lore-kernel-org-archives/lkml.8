Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14571C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA618206E9
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NiAxwjQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404017AbgDCQKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:10:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26581 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728351AbgDCQKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585930230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=76aKhajDR0T7D/XTJvFEAkRCCS80psmLCweRITxyQxw=;
        b=NiAxwjQ0iRu0S8nIhgjWLYV0A98sjSiWhf5XN0X6oQ8eY/M10hSnOoMd5W6MJWA9BiMgHE
        Rts+qYbqQt/nf5iKd+esyw+8oexaKuzv2fsdrQ3blOmNkIdueC9SK4OYT8WCPGK0qK8lQG
        RLRG7FM0xGfC4ALBnKoYKV7PnCa/gO0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-9P0C90NBN_e69IA-c4yOtQ-1; Fri, 03 Apr 2020 12:10:28 -0400
X-MC-Unique: 9P0C90NBN_e69IA-c4yOtQ-1
Received: by mail-wr1-f71.google.com with SMTP id m15so3338754wrb.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 09:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=76aKhajDR0T7D/XTJvFEAkRCCS80psmLCweRITxyQxw=;
        b=npYJbzSc5Y0mRzPnCK08fVOCEgQ+uOKg516BPNIq/1nCsuStpIVakpSCokCl1Q86FJ
         CsLrv3VkHS50ijn1ZgOxkfrxaN4AnZ+wLbcMhcRnjslapscuSosYMA3ERUCWfxU1i/ns
         /IRw9nzYxJT4Uot/GKkr6qkA7c62FdFOoA+MU+kYn/Iw9CrLUsmt0SyrDwNLxZ+VS76C
         ARCc1HnwKdWtWw6pjdyox/ltaE+xBf3teMwGqT3yoAgSerhKjBlJ25PNGzDBLVwRJpCi
         g7bzkCyAjMHnLuHjci4NaUtjU6glMWD9OTA9C5GGwTXxzXv0rRxIb35mtNN7piXKx1Tr
         xWnQ==
X-Gm-Message-State: AGi0PuYaJPxpNgyaqIcb3Cj//meoefQoq9Gyl4SFPhknj5ZMxYKfrY40
        277T03IH+ZpulzrTyb0gDGrHYL26qS1nRGK0ru8KUX4fGtNNRSVwt4wU/hh0TILl7O+inGC28Wa
        AYZMM6CIgh6Tw0PfN/R6aan1S
X-Received: by 2002:adf:9244:: with SMTP id 62mr7905190wrj.411.1585930226635;
        Fri, 03 Apr 2020 09:10:26 -0700 (PDT)
X-Google-Smtp-Source: APiQypIZuxKlsV49dPVkm/RvK2IsvRTEB/4Nx7blNRnWWxo+A18j6xuTpb+ArR6WAljmjWFLEKW4Ug==
X-Received: by 2002:adf:9244:: with SMTP id 62mr7905173wrj.411.1585930226400;
        Fri, 03 Apr 2020 09:10:26 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id s11sm12322985wrw.58.2020.04.03.09.10.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 09:10:25 -0700 (PDT)
Date:   Fri, 3 Apr 2020 12:10:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] vhost (repost): vringh IOTLB fixes
Message-ID: <20200403161011.13046-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a respost of the two patches as a series,
to help kbuild test robot test them.
Applies on top of my vhost.git linux-next branch.

Michael S. Tsirkin (2):
  virtio/test: fix up after IOTLB changes
  vhost: drop vring dependency on iotlb

 drivers/vdpa/Kconfig              | 1 +
 drivers/vhost/Kconfig             | 3 ++-
 drivers/vhost/test.c              | 4 ++--
 drivers/vhost/vringh.c            | 5 +++++
 include/linux/vringh.h            | 6 ++++++
 tools/virtio/Makefile             | 5 +++--
 tools/virtio/generated/autoconf.h | 0
 7 files changed, 19 insertions(+), 5 deletions(-)
 create mode 100644 tools/virtio/generated/autoconf.h

-- 
MST

