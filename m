Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B4BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A999206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:27:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMnIT0OP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgHET1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:27:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36008 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728648AbgHERNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Cgzc7fKo8GoNarTDetAApPhaV9xAvssaIfGNymLUTzM=;
        b=EMnIT0OPC4DkFuKA/ZyWIOSSBnYVr+oRZo4QuerpLTqd4W8/j0TZj/nlyIf/lCmfGYvYE2
        LRuon5P33QP33Jn7MiZbr80KwUcNwvJEZblfnAISCZsX3/ZR+JeVYSGNhqW8LrwHhms71D
        CN+w00Rs74fiLtpI6sedwq/2r6Zc4Sk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-bT8RRy36OLSBF3bxAViCxg-1; Wed, 05 Aug 2020 09:44:00 -0400
X-MC-Unique: bT8RRy36OLSBF3bxAViCxg-1
Received: by mail-wm1-f70.google.com with SMTP id v8so2471856wma.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:44:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cgzc7fKo8GoNarTDetAApPhaV9xAvssaIfGNymLUTzM=;
        b=ZWxMp5k0fK8rFzhqrdIVE9Vr2zR+4l/D8AhU7BRa37S7PXJs3qC8K9ldEASRy3i2GJ
         ezWKDPT2uQ7QaO7SqL6W1S5+4cil73/zEUExNDYTFmjieJq0T6fl3ffHrGu/rR6MAfMy
         wDeDllMZvL7VJmlMJ5Kf3xGitV/5B3nYZCx8El041WgAHubiLGc7twaTiXuNKH/M+jub
         +nAYZjBOzUEQjXYfdGaLVJZ5HPthxX3Q34i/6goFeUlWs62NBK2l10r2ez5V7J7ZcxeG
         cKJ6FZ3+f5qcIkeEA5HASg1XHdX54xB9KftYOkRU6oXyZw3Erb7LgRKYuospwd7zIi2w
         wzIw==
X-Gm-Message-State: AOAM5307y60Z1tgYFnaZjE5AB2mUAjT5fPIzc5Ayu0K3GZ+Y5TFBTFha
        IgWAzxwiRouKuGx8Hr2oJD8iCpsfC6mKXXx6up1BUNpdtI7Mw/5eTzwS8vXekUh8f+dL4N91lf9
        7EP2W5tcfDXDTJv/20Gx2UlfA
X-Received: by 2002:adf:f847:: with SMTP id d7mr2742207wrq.328.1596635039290;
        Wed, 05 Aug 2020 06:43:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRqO12QcUwDk9o3YsfPdSGZy8iXhCreHkQXWrlBGFyjkXszT12U4qC7xxUD0DhWva5Aj2v4Q==
X-Received: by 2002:adf:f847:: with SMTP id d7mr2742192wrq.328.1596635039093;
        Wed, 05 Aug 2020 06:43:59 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id p8sm3005021wrq.9.2020.08.05.06.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:43:58 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:43:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 15/38] virtio_pmem: correct tags for config space fields
Message-ID: <20200805134226.1106164-16-mst@redhat.com>
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

Since this is a modern-only device,
tag config space fields as having little endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 include/uapi/linux/virtio_pmem.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/virtio_pmem.h b/include/uapi/linux/virtio_pmem.h
index b022787ffb94..d676b3620383 100644
--- a/include/uapi/linux/virtio_pmem.h
+++ b/include/uapi/linux/virtio_pmem.h
@@ -15,8 +15,8 @@
 #include <linux/virtio_config.h>
 
 struct virtio_pmem_config {
-	__u64 start;
-	__u64 size;
+	__le64 start;
+	__le64 size;
 };
 
 #define VIRTIO_PMEM_REQ_TYPE_FLUSH      0
-- 
MST

