Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F64C2BA1B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EE920768
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DItxWHo1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgDGBQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:16:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52374 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726637AbgDGBQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586222206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5TH7w/JfrvK6PO93eOn/asqSkXlWjc9e7s1Mrzet5kE=;
        b=DItxWHo1onP01S5Mn6ZFOHKDEYzkrKZVfwBN+q9NU2DPRI3ZNa6ILEpOEQ0WiuC7LDSMLo
        0CT//Gyx1k/RphJYy1/+ofjMYJzcl7N2ahyY7i0Lvk+eEBQVaP10Ig8COeEghzT3q/J4A2
        3UVI7KSTJ3uP1I5SZ9sF2eQK+6TN4+w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-DsY_-jZdPSq48Jjq6YgwgA-1; Mon, 06 Apr 2020 21:16:45 -0400
X-MC-Unique: DsY_-jZdPSq48Jjq6YgwgA-1
Received: by mail-wr1-f71.google.com with SMTP id i18so848639wrx.17
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5TH7w/JfrvK6PO93eOn/asqSkXlWjc9e7s1Mrzet5kE=;
        b=ia+Ij0d/G7QkaTm7z282xd2ys6Unzb81k6QqATd+cePydgMeFjDZyXVC/PflCG1yl5
         fGvRLEFpQGCgyFrRr6SXMfTsfW240AtggliUtoWaN+JE70a8ipDZdwCW/fHqUymHwPbT
         WL+YsFTCI3mn2I1YZ5NlPnO/KSMAHrDOhgRqVhW9wFVRXvJEGxqbEJzJSPNZ2tdpQmKu
         8cnftbvpRxyiGNSC6uFpaqJxCQ8szt6BIWoQKerlMNGsUFzKMqADF5OH/eQLZnjwC08C
         2VUKVXO2IxCDYNVfgfz+9VEI31Q+pgYhXjVFYJMeAOxscw5WkgeD75Ptx4+b0kOrD84j
         qGmA==
X-Gm-Message-State: AGi0PuYmEc0HCf2keuhT/EefXr1BzbDAhwwe4t04TJMC4yGuFNY7Ogk5
        Op+QbbOmj89Yf0DHhxKwM/yUohA4tfGpvADBj+0nWBrJmO/K4Q5p1F4bCvqqp+JFVqV7gR4G44t
        Ll1LDuZBWjPpnzd2HPIUCqpTN
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr2102831wrq.345.1586222204018;
        Mon, 06 Apr 2020 18:16:44 -0700 (PDT)
X-Google-Smtp-Source: APiQypIUKx/E68FBj3d4XOQ00hcyXYBl/67P8FPYE2YoFyXU7fFCF05zzALyhpIqvei+4TT7JQeC9g==
X-Received: by 2002:adf:f8c1:: with SMTP id f1mr2102818wrq.345.1586222203824;
        Mon, 06 Apr 2020 18:16:43 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id o67sm136301wmo.5.2020.04.06.18.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:16:43 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:16:42 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH v8 07/19] remoteproc: pull in slab.h
Message-ID: <20200407011612.478226-8-mst@redhat.com>
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
 drivers/remoteproc/remoteproc_sysfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
index 7f8536b73295..52b871327b55 100644
--- a/drivers/remoteproc/remoteproc_sysfs.c
+++ b/drivers/remoteproc/remoteproc_sysfs.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/remoteproc.h>
+#include <linux/slab.h>
 
 #include "remoteproc_internal.h"
 
-- 
MST

