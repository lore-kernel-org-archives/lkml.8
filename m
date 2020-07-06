Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44004C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DB9220720
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BpLIhIM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgGFNgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729290AbgGFNd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:33:59 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3E5C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:33:59 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f139so42143656wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F3N+fzezv1MWYIkYTGHlx08nxeXYi/20m77vgS5T6os=;
        b=BpLIhIM9HO9QX/91QqPb0axOZ+f3MusDB+2c/VFHx/69xTyIJRCZQeP3ZiC1KHq3cQ
         MPMyfOETWx+kDYSAp2ES8FPPerVyUzUHVoDK4ZE3kx0lHJumW3So3ckLNKz1ZjU/aRgM
         9UPBYbokmdIFpUzxdVL/M8Xe6mMwTbF2QrISRvdMpcpb/a4z6XCoUGhvmgYxiOia5lXw
         fF0G+NETlZp53qRczU0psHvtC9Do08Z+EKc5a0LRflRb6uiSioO1p6Oi7nnKQIyPsFsS
         iyd7IeCm1h4s1m2dHMRE4UnfHf2FurtJS8GyFbNTXVkCDhdfO9Xv5XIEDIGWp6x38Uyb
         stNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F3N+fzezv1MWYIkYTGHlx08nxeXYi/20m77vgS5T6os=;
        b=G/faI0z3sE29IjxClZzpLf8FikgLJPNn6epYFB+85LfZV9Tmxd9dFtuSGEBaSCltJo
         0LRMDQEDC+qdc+YBsbibQPUT3YKuNyef6Q6f4JFLmDTu8YSVa1k/RrCH5zDbnQ7zoh50
         H2FgzN4pPH8FkbpHXtCyfdggh0RncoMBsjwUFLh751GZ/tQlV21J936gcUr6OP8jpSjU
         dlvhwcYW0dtkDxd/edm4xjkwMNfK5L7icuo0RZ2UmXbrYb6oOVohfKo7d7IKs1lbohoL
         b+pJj8l5Wowe/nACbekPYJcved1BX0+rVYovr0+VxYRvPeoQRx2pmYqLSKom4SUN3aL3
         Q9Tw==
X-Gm-Message-State: AOAM531bpKpdbTfxxfM9pPB6GXm01hxdXB0v4rtA/WztqH3tjS8NPH6E
        W6Z4BxTq/dbN7AJq17JrRUrq8Q==
X-Google-Smtp-Source: ABdhPJw84chABX+3T3NQgrsvaRU3aLogEgRaFQd3ljAQ8Bw2zi12v8ZyS4JXvweac2ZKGE4NngEQgA==
X-Received: by 2002:a7b:c013:: with SMTP id c19mr48981840wmb.158.1594042438048;
        Mon, 06 Jul 2020 06:33:58 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id v18sm25416082wrv.49.2020.07.06.06.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 06:33:57 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Michal Nazarewicz <mina86@mina86.com>
Subject: [PATCH 11/32] usb: gadget: function: f_fs: Demote function header which is clearly not kerneldoc
Date:   Mon,  6 Jul 2020 14:33:20 +0100
Message-Id: <20200706133341.476881-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200706133341.476881-1-lee.jones@linaro.org>
References: <20200706133341.476881-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No attempt has been made to document the demoted function here.

Fixes the following W=1 kernel build warning(s):

 drivers/usb/gadget/function/f_fs.c:2361: warning: Function parameter or member 'type' not described in '__ffs_data_do_os_desc'
 drivers/usb/gadget/function/f_fs.c:2361: warning: Function parameter or member 'h' not described in '__ffs_data_do_os_desc'
 drivers/usb/gadget/function/f_fs.c:2361: warning: Function parameter or member 'data' not described in '__ffs_data_do_os_desc'
 drivers/usb/gadget/function/f_fs.c:2361: warning: Function parameter or member 'len' not described in '__ffs_data_do_os_desc'
 drivers/usb/gadget/function/f_fs.c:2361: warning: Function parameter or member 'priv' not described in '__ffs_data_do_os_desc'

Cc: Felipe Balbi <balbi@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Michal Nazarewicz <mina86@mina86.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/usb/gadget/function/f_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 490d353d5fdec..2d00ba0726453 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -2352,7 +2352,7 @@ static int __must_check ffs_do_os_descs(unsigned count,
 	return _len - len;
 }
 
-/**
+/*
  * Validate contents of the buffer from userspace related to OS descriptors.
  */
 static int __ffs_data_do_os_desc(enum ffs_os_desc_type type,
-- 
2.25.1

