Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED9CC433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE5A520737
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgH0Veh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 17:34:37 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37545 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbgH0Veh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 17:34:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id w14so8118183ljj.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 14:34:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yeLFXCCaY4tDSM1nVOReyn/vTDxc9izwnURREpocfMs=;
        b=SggvQfOGWYb5fuogIPFsdAz+O7yoBvO3j0s6rqes6E4aCHn7N+kRYS/emSCXWvvhWr
         ozVBYCB1Mom1N26HNL9rG/b13nFB/L0j0jbpDD5mTXatAH3zh2Qo+hmjMNgK6cjcWq86
         zQpF+GXmN5/TKTd1CLpJoH4MjFfdYvQoNr15sxEhu4M/xN294Q7P/Qx1zd8dyJ+ntlO6
         wIwnKIjUaqSQWcyc3X+KrEvUsG5oB/vF3owKGPEJN+GEBy9AT2AZPMPxpCZ94B2Tsk/j
         kydlJurZ6KR+Pq+L5EV71pTWdVOBntPrRSezkZ14WcblRU42izrYw3pLTP8mKmFo0z4L
         4Y1Q==
X-Gm-Message-State: AOAM533SR6/VYS5exY1y4sR39DW1ajMORC4zbXid0NN7ezvRW/vObwHh
        NJnZyhxFhJ+mOeACFmQwHtU=
X-Google-Smtp-Source: ABdhPJzJ/5FSf/FyNsDYm0BEaEjZpoeexIIo1sPjS6W/L4hUEAGH79+Jvs6RTYqrRQ0zxG7k/Yiw6g==
X-Received: by 2002:a05:651c:1291:: with SMTP id 17mr11436997ljc.366.1598564075120;
        Thu, 27 Aug 2020 14:34:35 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.111])
        by smtp.googlemail.com with ESMTPSA id f12sm486190lfj.50.2020.08.27.14.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 14:34:34 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Denis Efremov <efremov@linux.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] char: mspec: Use kvzalloc() in mspec_mmap()
Date:   Fri, 28 Aug 2020 00:34:21 +0300
Message-Id: <20200827213421.50429-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kvzalloc() in mspec_mmap() instead of open-coding it.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/char/mspec.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/char/mspec.c b/drivers/char/mspec.c
index 0fae33319d2e..f8231e2e84be 100644
--- a/drivers/char/mspec.c
+++ b/drivers/char/mspec.c
@@ -195,10 +195,7 @@ mspec_mmap(struct file *file, struct vm_area_struct *vma,
 
 	pages = vma_pages(vma);
 	vdata_size = sizeof(struct vma_data) + pages * sizeof(long);
-	if (vdata_size <= PAGE_SIZE)
-		vdata = kzalloc(vdata_size, GFP_KERNEL);
-	else
-		vdata = vzalloc(vdata_size);
+	vdata = kvzalloc(vdata_size, GFP_KERNEL);
 	if (!vdata)
 		return -ENOMEM;
 
-- 
2.26.2

