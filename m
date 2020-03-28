Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF42CC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 15:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D0A20716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 15:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JH8pKoaV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgC1PP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 11:15:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35923 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1PPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 11:15:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id g62so15980843wme.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 08:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/c3uFVYUYQl/2XwBUimjSFjQvuiMRfSeEykM9N3l/I8=;
        b=JH8pKoaVaZS2J6ZoIu6qROkA7P8WHyc9ogiGRDBk3Np3vSo3wt0gSEM0W/vx3cIN0t
         /6yWD1DRFKp2WvJmZpxp2XjwVUtdFUqXXrOjgM5rGrcSnKyj3g+75WvT6mKPO/PwMqpS
         fYH6fApK1aslfPnW8GtHi/SrKZdGQg4/VbQoLajkYpLuADKLo2YOEJtV9iJe5kJx5iTr
         Iwz/NRnjTfSwr2ZH9QHnixEgCIJF9SJ1B1yveVIVAFXvc3wCtf52rOJCmjCTicvzo2yU
         A2LrFYcmwWZgAQVD9NhvEUNau9hYi8s80G6MdgXlIpgEuCDiGSHfUZNkmDAsl4btk98I
         j10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/c3uFVYUYQl/2XwBUimjSFjQvuiMRfSeEykM9N3l/I8=;
        b=EvH5uH2nWAoSY7PAj8YN6tL0lYk0kwJ9+azkt/eQ+YEiC06urPm0n0Hsj3+jKFm5Ym
         XPbtZXzPKi7n8jn/FDSGxJeB99W++8Z2josLJQQPIqsJQj1uc8f/leg4M4T5KzXgiSu2
         Kt6S4hPRk5jWBfQSQ0INL7CFKfcZPaAd/qUxLHN+/ns3H3deixrUlf8UroC9wD+Yn4Kk
         8z8KULONh0eTqf39oY3ubuLDKiUBZ/4guIdoii/MFLU6mD4svWBo9FtCl1UBsrymsmFV
         GbjDrZ4TFd57h5moF7GGn+jIufJMbg2RjW0zUe9qh1RiXmn0rRK1ONPtsGXDlQNlvBTh
         4trw==
X-Gm-Message-State: ANhLgQ2PYqrqj3ONUNWt28TmcM9VCemVYw/OXQZmWdymXtxkeU7DTPFd
        +V5Sb4YN2Dnoz/bGZsuUIoQ=
X-Google-Smtp-Source: ADFU+vtPbs4QlSi8mM/oGtaMDDmrCshfozdELZ+oX2z1vJJhlFbjHXNTskIEua0Q9Y80pyqtygO7/A==
X-Received: by 2002:a1c:8149:: with SMTP id c70mr4277679wmd.123.1585408552450;
        Sat, 28 Mar 2020 08:15:52 -0700 (PDT)
Received: from linux.user.selfnet.de ([2001:7c7:212a:d400:d0b1:54e8:4350:d529])
        by smtp.googlemail.com with ESMTPSA id 5sm10321488wrs.20.2020.03.28.08.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 08:15:52 -0700 (PDT)
From:   SandeshKenjanaAshok <sandeshkenjanaashok@gmail.com>
Cc:     sandeshkenjanaashok@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: android: ashmem: Declared file operation with const keyword
Date:   Sat, 28 Mar 2020 16:15:23 +0100
Message-Id: <20200328151523.17516-1-sandeshkenjanaashok@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Warning found by checkpatch.pl script.

Signed-off-by: SandeshKenjanaAshok <sandeshkenjanaashok@gmail.com>
---
 drivers/staging/android/ashmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index 8044510d8ec6..fbb6ac9ba1ab 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -367,7 +367,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
 
 static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	static struct file_operations vmfile_fops;
+	static const struct file_operations vmfile_fops;
 	struct ashmem_area *asma = file->private_data;
 	int ret = 0;
 
-- 
2.17.1

