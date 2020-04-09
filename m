Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEDAC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 21:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E574F2072F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 21:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZlixh5l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgDIVLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 17:11:05 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57601 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727001AbgDIVLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 17:11:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586466664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=RtBDKwbJtd92jp7E6LtBd9yu+eRXqfVPRMTN3swQKxo=;
        b=HZlixh5lvjbWfiRuBxNPxpVOpoDcU71IjrqB4IhTunt7Z8oPHO/8iCpOkJFWe5KJ9RR/Ix
        UDDmpRtrhVaGIW/Os6JwVlQ9hJUWEGS/YV4YezX43pwIXCpyoB369aFUaMMYN2+bZTuBIn
        FkzNtybjgv10H6QS1pVWNizN6Ho6XFM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-jS-cE2WZO6qDZxv6TKmkzg-1; Thu, 09 Apr 2020 17:11:00 -0400
X-MC-Unique: jS-cE2WZO6qDZxv6TKmkzg-1
Received: by mail-wr1-f71.google.com with SMTP id j12so7290935wrr.18
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 14:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=RtBDKwbJtd92jp7E6LtBd9yu+eRXqfVPRMTN3swQKxo=;
        b=YL2x0Ab94xfZr2nledm+UXvu4kwWclPpwTSWsbeGcCGFfoBD8k24xROX0e7kY86rFc
         igXJgYXr6wPchwllyiM9A4fgp4rePNLDQf3jkwT+EsqK0YoJyOOYrtexrtehrjV5yifh
         3kIV8Q2rWHtf7nr5IY//zbWe+bGP5uygAYUoyfv4bsOlwPG+Ih7xY3NjSipesOfTvAjl
         dd/MSrHZ9TXtgIxbVms6hE7YJ9gy1h1BAIqhziAehYC2bcyTMwYDVYRV7tCT4LWZ3UfL
         /ula02S9O51LIr6ad4WexZfQcw3UOzGbTON2n0dHgC4W6uYKIc1r1ph4J1IF8VsOENxX
         mDXg==
X-Gm-Message-State: AGi0PubcFhVGwkWRv4D+/zegYA9M3k3lelui0C/+I3zsmbTKbTBepp6+
        NlChyOh9BxWiDxEvIWLpP9OeqCHUpMY86xjWVydKsJ4SR0hpn5kJJnmOpwBWiN7vr5ZFHF9pR4s
        PXm4rckClQ2SdErTh4NiVCqRy
X-Received: by 2002:a5d:4011:: with SMTP id n17mr1132448wrp.104.1586466658691;
        Thu, 09 Apr 2020 14:10:58 -0700 (PDT)
X-Google-Smtp-Source: APiQypJabTxDz0WDx3biZbaja84PLZF34ZKZYgpYhxA8C4IQqw2wzmtgimWKqtv+yfhnsaBo2HvboA==
X-Received: by 2002:a5d:4011:: with SMTP id n17mr1132435wrp.104.1586466658564;
        Thu, 09 Apr 2020 14:10:58 -0700 (PDT)
Received: from redhat.com (bzq-109-67-97-76.red.bezeqint.net. [109.67.97.76])
        by smtp.gmail.com with ESMTPSA id o67sm5411345wmo.5.2020.04.09.14.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 14:10:58 -0700 (PDT)
Date:   Thu, 9 Apr 2020 17:10:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] remoteproc: pull in slab.h
Message-ID: <20200409211054.12091-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
 drivers/remoteproc/stm32_rproc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index a18f88044111..7ef931e9605c 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -19,6 +19,7 @@
 #include <linux/regmap.h>
 #include <linux/remoteproc.h>
 #include <linux/reset.h>
+#include <linux/slab.h>
 #include <linux/workqueue.h>
 
 #include "remoteproc_internal.h"
-- 
MST

