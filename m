Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDA7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:43:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAC542072F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 12:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TyCgMLOD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729087AbgFHMn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 08:43:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59490 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728591AbgFHMnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 08:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591620202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=utvLOGjABWchDzVBBNcvjGgT0Uw4uVA8BCJYHrkDTYE=;
        b=TyCgMLODxX0a9jzlp75v5jJdlB/ziQNUZGG1WFR4A1VSJIXaKZL0jHDPKPxvBk36zGfPGV
        Wm68hG1vlF+FKx1KiRVln78MzBLMBXw9e1DoWFHgU0c44YVcA0QoVqCJ97sc0Dxg4+L062
        DBCepTeUpfOWILkpU7co5aKxYyNROn8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-ukr-xhMTN7ipi4Qz4t1SZQ-1; Mon, 08 Jun 2020 08:42:59 -0400
X-MC-Unique: ukr-xhMTN7ipi4Qz4t1SZQ-1
Received: by mail-wm1-f70.google.com with SMTP id b63so5340576wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 05:42:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=utvLOGjABWchDzVBBNcvjGgT0Uw4uVA8BCJYHrkDTYE=;
        b=USdGEI9IX6PQ7XEt5HitSEYKhjMsgBR8rAhz7wBSSF+yixvrVGzHi5UycX1xBkBcpE
         An/IfZNki02bWTC9GqhAJkXPLne0n7A62uuW9OKqblSbb7DzqAahm0gbxR0nSltYADGE
         OX2wRec0+K57H0DwBqN/7kYpJNzUxlucXl8uvlAy5FGmy3ehT5k12yDP3u9GJSox1hfJ
         YqE0TvpJqKlFaWmZolQC8+fbY9iy/0O/nLZP2wnUNxSk8twT4uymPIdE4OtffNZX+je+
         C3ylRYc5CRl0kxuvF9yixHvk1Ac+Kp1CuSLlV2OIfHjk525QDhkUymZ88EPxpvMedGLG
         3lfw==
X-Gm-Message-State: AOAM533168bpJwKGfyL47tnKRWiyVTLlKOfEy7KvrdgVBJyME+kos1HU
        nTvZSjg32QZmjEX0064Jmuou197JL96yeeyyyqYiXIO3ZLv9MA1X4CoUZrgRbt8rTrrRwlMK/Ae
        Hos2EcoKS/kXix/r2uQShZgtG
X-Received: by 2002:a1c:5411:: with SMTP id i17mr17027060wmb.137.1591620178248;
        Mon, 08 Jun 2020 05:42:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxHCDKaiMql4q+MgfnmT9afh3wFAhLtf//8SgAbDqi4VLnsVn3wc/xBGn3Rmk2vnzUyPWpJw==
X-Received: by 2002:a1c:5411:: with SMTP id i17mr17027042wmb.137.1591620178029;
        Mon, 08 Jun 2020 05:42:58 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id g82sm22458959wmf.1.2020.06.08.05.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 05:42:57 -0700 (PDT)
Date:   Mon, 8 Jun 2020 08:42:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: [PATCH] vhost/test: fix up after API change
Message-ID: <20200608124254.727184-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass a flag to request kernel thread use.

Fixes: 01fcb1cbc88e ("vhost: allow device that does not depend on vhost worker")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vhost/test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
index f55cb584b84a..12304eb8da15 100644
--- a/drivers/vhost/test.c
+++ b/drivers/vhost/test.c
@@ -122,7 +122,7 @@ static int vhost_test_open(struct inode *inode, struct file *f)
 	vqs[VHOST_TEST_VQ] = &n->vqs[VHOST_TEST_VQ];
 	n->vqs[VHOST_TEST_VQ].handle_kick = handle_vq_kick;
 	vhost_dev_init(dev, vqs, VHOST_TEST_VQ_MAX, UIO_MAXIOV + 64,
-		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT, NULL);
+		       VHOST_TEST_PKT_WEIGHT, VHOST_TEST_WEIGHT, true, NULL);
 
 	f->private_data = n;
 
-- 
MST

