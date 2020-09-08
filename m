Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50752C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C1622166E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="Btgln1Dz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732172AbgIHTb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731019AbgIHP6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:58:05 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC45FC061242
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 06:11:32 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id n10so11814325qtv.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 06:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hUrb8SCFg6HulXICTWjB5J3dJa3WsyRvIUrd/Gj8E1A=;
        b=Btgln1DzqOK0Ky5OmfZSVznH+IIFskFJhEUd/6L+2EzexX2xFdtpBjfG38nIjkpQK2
         pmnstu3GxKex83ZqJBTGKEoxQOsaa9ej1y1DmAcjfKwb+0/WbK2LcBN7TCMlSvkpWo6l
         4QtbYzWr29/ZV+fKFkKIj68KD1so+1Scelu9baU+Kvw3HAAudlLQf80AutQ5xanEeCsL
         R4JT/89nxaVd+kfU/AIPwxL7uteIXQwOK3LtJdgLl82r3LjSyfuC3lv9Lh8VmS1z8q7H
         +QwBvwk4vlWlHa85UZOoF69Ob9wSq9wKPzlP8O+GJkTsnX4Bf2jVdcigwybNlpnWXA/V
         MdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hUrb8SCFg6HulXICTWjB5J3dJa3WsyRvIUrd/Gj8E1A=;
        b=DvgB8FH60CmjLCIOqw1pSjFGJ7v2syPQIsx4D4XszmkZEkpegdbSUxbLpE/DNY+zNx
         k8PontGg+ArTH5REJX9Z8F++PP1p13A13wf/MN6rN/rYCCpNM4Lj/gKOzheh/5RCKpVB
         dDnwauaPL7QeU4STCNQGXgQVD9cxfiFs8WOZOjmgt8d7dftyoT8g7mjiLMBAgzo3MwAY
         Mn+rwEKjvZkWqJpv7jcVXqSF1kBpzTaUO82MYNqOze7TPZTHJoR1BDXaKTCt26CdA5ml
         pwzN8hXkL42gBD+tV3xTjyAGVeVlOUXRsWlQBJ5PgOlOjExih82uRaU2e5dISaI55uJu
         JNUw==
X-Gm-Message-State: AOAM531F/N/e6Y516k/50BkMZYCSTzENE14lT0Yborvrp6w/VfFSe/UC
        Fik11On00ELK0FhEl08aThP60Q==
X-Google-Smtp-Source: ABdhPJx3qjKvLLDxptFWyk2taGV4q+N24WetF6P4vAorl5llo7bW4K8NDUDihiwxftcYS6HUZPP72g==
X-Received: by 2002:aed:39a1:: with SMTP id m30mr25310181qte.39.1599570690288;
        Tue, 08 Sep 2020 06:11:30 -0700 (PDT)
Received: from localhost.localdomain ([147.253.86.153])
        by smtp.gmail.com with ESMTPSA id m196sm13394069qke.87.2020.09.08.06.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 06:11:29 -0700 (PDT)
From:   Jonathan Marek <jonathan@marek.ca>
To:     linux-arm-msm@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/3] misc: fastrpc: fix indentation error in uapi header
Date:   Tue,  8 Sep 2020 09:10:09 -0400
Message-Id: <20200908131013.19630-2-jonathan@marek.ca>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200908131013.19630-1-jonathan@marek.ca>
References: <20200908131013.19630-1-jonathan@marek.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use tabs instead of spaces.

Fixes: 2419e55e532d ("misc: fastrpc: add mmap/unmap support")

Signed-off-by: Jonathan Marek <jonathan@marek.ca>
---
 include/uapi/misc/fastrpc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/misc/fastrpc.h b/include/uapi/misc/fastrpc.h
index 07de2b7aac85..de31f0bd4779 100644
--- a/include/uapi/misc/fastrpc.h
+++ b/include/uapi/misc/fastrpc.h
@@ -10,8 +10,8 @@
 #define FASTRPC_IOCTL_INVOKE		_IOWR('R', 3, struct fastrpc_invoke)
 #define FASTRPC_IOCTL_INIT_ATTACH	_IO('R', 4)
 #define FASTRPC_IOCTL_INIT_CREATE	_IOWR('R', 5, struct fastrpc_init_create)
-#define FASTRPC_IOCTL_MMAP              _IOWR('R', 6, struct fastrpc_req_mmap)
-#define FASTRPC_IOCTL_MUNMAP            _IOWR('R', 7, struct fastrpc_req_munmap)
+#define FASTRPC_IOCTL_MMAP		_IOWR('R', 6, struct fastrpc_req_mmap)
+#define FASTRPC_IOCTL_MUNMAP		_IOWR('R', 7, struct fastrpc_req_munmap)
 
 struct fastrpc_invoke_args {
 	__u64 ptr;
-- 
2.26.1

