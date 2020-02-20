Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F42C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C069206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3FQHyFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgBTOIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:08:41 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51340 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728282AbgBTOIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:08:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582207719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yXw1aooGm3SizxRsc5d1sX2J/L6gkHAaW3S5VvpIZy0=;
        b=B3FQHyFpyo/FqshK32+eV/XR8KC4BZN4V0i6kq+RE8UvvFxxDniFWVRsNugCDqUG98NyfL
        2j/0efe9sR5LRDthKkhU1dg1Y5uMqfGngS6RX4kQ0EOYDGkVmK7bXBZEqyMnjma90E/SOY
        y87y8xH5UpyvtwpSW4nYGyii8F8v11k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-ABW279RfPpSRSC4vPepxUg-1; Thu, 20 Feb 2020 09:08:37 -0500
X-MC-Unique: ABW279RfPpSRSC4vPepxUg-1
Received: by mail-wm1-f71.google.com with SMTP id m4so641834wmi.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 06:08:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yXw1aooGm3SizxRsc5d1sX2J/L6gkHAaW3S5VvpIZy0=;
        b=l+7zqHHAnfHgkKmoS27f7OU5fV9kkJ77koSD8d6Y9B3Oxp/suWIuJJNeW2fY9wAZ7N
         ddFQ1I8hAv3VoKUvLj9qwsT91ULCMf0+CWKpr2gfLlNgiO7ZXpFpKmvNbgadzWwR8JJh
         CbFvWJwOs6G+9PtfVJmxfYRULmsUak7UAKZZMO28PHHChNGfAfqN+RzVshrbLqWKjutK
         zIEk59UcHSiR9/IhP0dhdn3s5gHiAmWA40Tmb2GeN+/RbkE++zq59UHBFx6D4vZZyjCZ
         JpjvhVGn0NYDJ246RJlHHud7P1ZoL/SxfqbjGVCPiop/7LNlh5xXbdc50LHG0w17g08/
         QUIA==
X-Gm-Message-State: APjAAAWF8btJHnIgHLbHpM1WeD5VW7lYBxNpeInvccpVlZbQ0QJQ3MTK
        RWQlgrsF3Ys3kDX8ZLVa6mhop/wotRhyvDbJQwfaPthMGKTpw5edQU4lPIpc5XmIWnsOSHQQxdp
        shK0n7DUP1LOnUZFxbux/G6ZL
X-Received: by 2002:a5d:5007:: with SMTP id e7mr42931438wrt.228.1582207715415;
        Thu, 20 Feb 2020 06:08:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqyw0NL4CfkVCvHhL8BV6jD0BLn6ZRb0x1FWrOTy5dsR72Hmp0fM/ZUPGXOTxrdPDBTx4bQySg==
X-Received: by 2002:a5d:5007:: with SMTP id e7mr42931423wrt.228.1582207715204;
        Thu, 20 Feb 2020 06:08:35 -0800 (PST)
Received: from steredhat.redhat.com (host209-4-dynamic.27-79-r.retail.telecomitalia.it. [79.27.4.209])
        by smtp.gmail.com with ESMTPSA id 133sm5010574wmd.5.2020.02.20.06.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 06:08:34 -0800 (PST)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH liburing] man/io_uring_setup.2: fix 'sq_thread_idle' description
Date:   Thu, 20 Feb 2020 15:08:33 +0100
Message-Id: <20200220140833.108791-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the kernel we are using msecs_to_jiffies() to convert the
'sq_thread_idle' parameter, provided by the user, in jiffies.
So, the value is interpreted in milliseconds and not microseconds.

Fixes: 59bb09c553eb ("man: add io_uring_setup.2 man page")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 man/io_uring_setup.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/io_uring_setup.2 b/man/io_uring_setup.2
index 4057e4b..20c67dc 100644
--- a/man/io_uring_setup.2
+++ b/man/io_uring_setup.2
@@ -82,7 +82,7 @@ doing a single system call.
 
 If the kernel thread is idle for more than
 .I sq_thread_idle
-microseconds, it will set the
+milliseconds, it will set the
 .B IORING_SQ_NEED_WAKEUP
 bit in the
 .I flags
-- 
2.24.1

