Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D53BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71292207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:07:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HKN5cKwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgETRH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 13:07:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51110 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726838AbgETRHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589994441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=enl1W2uIu4fZuLT8iyT7NS/nMICLBarNGTfzsJ5XBJ0=;
        b=HKN5cKwh2Q8JRPbGvTBX6T8Ec1ueBvnd//Saf8QnSci31tzVqX5024kpF9nE17SqNypXWm
        YCEHMefFUy1LPf1V0cST1jC9dghDweDL/yjb5KvgspKqYkjd4u/H9vrzNg/iHhG0+ylZ7s
        7UKqC1WSN9KEABMqPjvrFGBiboCfwy0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-KrfpwmQAMUaURuS7YLryMQ-1; Wed, 20 May 2020 13:07:19 -0400
X-MC-Unique: KrfpwmQAMUaURuS7YLryMQ-1
Received: by mail-wm1-f70.google.com with SMTP id e15so227136wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 10:07:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=enl1W2uIu4fZuLT8iyT7NS/nMICLBarNGTfzsJ5XBJ0=;
        b=gARuq338wA8XorRccqE33eXC/5oRqSYdPXsGxe0E/2wI0WdCgJMak0VCdxC/yc1L0E
         VTiZy6wDaKE/mxMj7dsOhuzSJ6yo0Exm00vS1Mx6zbJDf7tyc2t6R+O99tHd2Ju7Yh0E
         RBT/234xhNg1OEFuRFh5RhcolufeBUdwlnufg8KXK3aGOKbCi7zQu69EL11HSopCQ9SD
         KSVmCjcKSHjMV3+nqlQZdK/tuOnKS/TGO9CIe+eIguqMqRvLzAHqYDn/HX2BfjzDOkv5
         /UWff308m3uMz8UT3fISVNqdzVAJyHSlKPzHAlxCjVMph2UBIpfCpj2pduyLc6zm6HF+
         w8ZQ==
X-Gm-Message-State: AOAM532odrB6i4YCcKGWo+K1464MdmP/P689a/9n7vtKr5lTRb8wCo3k
        i4X0PfKcHU8BJDOIW9Dfova3YTnQXodpdF1X8PmTO8o4rnwfLSNybP7gIKWTvpTamcIA/caqU46
        TYMPRRafmQ3BooPnfPpFioMeA
X-Received: by 2002:a05:6000:4:: with SMTP id h4mr4863656wrx.36.1589994438801;
        Wed, 20 May 2020 10:07:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/oL0fpnDNlWDRl/DQpqVURE2ukinpGD7z7G2S6eeKrBlnPSAq1QGG74sJXqhvE+E43M0SYg==
X-Received: by 2002:a05:6000:4:: with SMTP id h4mr4863645wrx.36.1589994438575;
        Wed, 20 May 2020 10:07:18 -0700 (PDT)
Received: from steredhat.redhat.com ([79.49.207.108])
        by smtp.gmail.com with ESMTPSA id u74sm3768614wmu.13.2020.05.20.10.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 10:07:17 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Subject: [PATCH liburing v2 2/5] man/io_uring_setup.2: add 'flags' field in the struct io_cqring_offsets
Date:   Wed, 20 May 2020 19:07:11 +0200
Message-Id: <20200520170714.68156-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200520170714.68156-1-sgarzare@redhat.com>
References: <20200520170714.68156-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 man/io_uring_setup.2 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/man/io_uring_setup.2 b/man/io_uring_setup.2
index d48bb32..c929cb7 100644
--- a/man/io_uring_setup.2
+++ b/man/io_uring_setup.2
@@ -325,7 +325,8 @@ struct io_cqring_offsets {
     __u32 ring_entries;
     __u32 overflow;
     __u32 cqes;
-    __u32 resv[4];
+    __u32 flags;
+    __u32 resv[3];
 };
 .EE
 .in
-- 
2.25.4

