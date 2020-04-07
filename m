Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA92C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECCB2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="buXu0EFo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgDGBHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:07:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48229 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726230AbgDGBHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586221653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RVzro4XtEZaLbEft7JeQy81ssJHBlnUXRCePrLVPDZg=;
        b=buXu0EFoLbe4IXicGUkDWkDNkfWg8RnqPFFYQlCf+Z5OMsPNIvSkgNin5kl4fs7R/UB20q
        wF5+O52XT4rjsZGHH/5pRuyokTEHR8MBVynhnJlMwMWai9tEhvl3YVqOVyi1Yg7cbYf9hF
        hNhs/40d9GsIsi+dSw4joxUOVz2W1qg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-tJqdckm8MfGY4jCpulSCcg-1; Mon, 06 Apr 2020 21:07:31 -0400
X-MC-Unique: tJqdckm8MfGY4jCpulSCcg-1
Received: by mail-wr1-f72.google.com with SMTP id d4so853431wrq.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RVzro4XtEZaLbEft7JeQy81ssJHBlnUXRCePrLVPDZg=;
        b=FK9oD0IonSHzvglitqkN3xQtD0F8Y0lQww+7kJQuvmHTUR0TVgbkwOKNKfQHezBoc4
         NGLPXnlbNYBvMhHuvOk9C6NW60OSnBp1A6D8YJY7Pmd7E8DX9nCw8CIT4ZRIUCgXdXPR
         L4XgTcvNBTa2bm46lsJxRMKAa0scnZEGdx3dwRVbRrUwlLiuHUBhOnzIyingclCQMfrR
         xr6I5OqOa409q8ud/5KNHXtk0t6BR1rwTPIaePXS7uQfw44swMw7Ny51yq7Hcill7HW/
         8Uhb8KyZjTw91NgDHGAdFygLEpNjG+5X9mfjG/7YfOj51jf7bl8GEsmG4ZoQVpspakvW
         SOjw==
X-Gm-Message-State: AGi0PubJxededcOLyGNd/7YB4xDb43WWoefgkhKuK3EOxXd0sPt5KIc+
        h8ggB5aNoITqhyqo+vd9OAlvaWEAlRXsnrDEBqmrbqJ8pk10j2bCQ4+7tFu95VRgK6d78S/m2OR
        O2NyNeSgZcIHvLK2ypQ2qkfri
X-Received: by 2002:a1c:3b89:: with SMTP id i131mr1711438wma.35.1586221649906;
        Mon, 06 Apr 2020 18:07:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypKRKCipQIbm0Oc75IuaidBz2+PAGMeLuXFO4ovUk5KL+Lv7hqtVJIPPSzVzZ64HpueelPbnaw==
X-Received: by 2002:a1c:3b89:: with SMTP id i131mr1711426wma.35.1586221649698;
        Mon, 06 Apr 2020 18:07:29 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id p21sm78244wmg.34.2020.04.06.18.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:07:29 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:07:27 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v7 01/19] tools/virtio: define aligned attribute
Message-ID: <20200407010700.446571-2-mst@redhat.com>
References: <20200407010700.446571-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407010700.446571-1-mst@redhat.com>
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

