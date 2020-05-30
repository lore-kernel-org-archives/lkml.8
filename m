Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6505DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 20:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C8B42074D
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 20:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbgE3Uyb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 16:54:31 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41495 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgE3Uyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 16:54:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id u16so1710398lfl.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 13:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x1LVz2RKLdTewPVi7JzuKq6wTk2wWGIzWE4uj9Rz3Oo=;
        b=DxtupwfB7ZacQZz5oqXJI4KqRKhaPRtbiWp1cYTNJI+ebvkd3crdcF9JYxpAzWE78N
         WQ+j01tD79rrpwN/LUt7725KWiEQsIbrOkl38Hdy54hTEvk26cPci1JjiwqS02HKmoE4
         GvKD7GfiPHIzYgXkx2lzZGjtvQs7EGBAizynO7fjbOSykHwpnNAzaZBAs8ktV/KgGhwt
         YriI0LL9GjpkHC7Ivn4PoTsrXZO8OE5E+2UXlhFCxLnUW73LjtP9lLrpcGw4wMKXsQqY
         8/kffhgtUIxF9K0QzRbfV7pkxBNWdkZ1IF04G6fvpHUsAL2G1xe8MqKutJgmcReMdvu0
         yPbw==
X-Gm-Message-State: AOAM533IgSMgJ2Dfm/uh8I04bnKiU8szOCCvLd2e8LIVOBlU6K0+8b+4
        oXrWG/ZuAJyxLjh5RbWWMBX1iLTU
X-Google-Smtp-Source: ABdhPJy80CEmSIpmFE4qQC/NX9BXx1VXOkCwwIEjYO9wC7axPGWRTs6T7T71Vum0XD0dGpz+JcQCFQ==
X-Received: by 2002:ac2:48a3:: with SMTP id u3mr7595076lfg.115.1590872068706;
        Sat, 30 May 2020 13:54:28 -0700 (PDT)
Received: from localhost.localdomain ([213.87.147.196])
        by smtp.googlemail.com with ESMTPSA id f6sm2816670ljn.91.2020.05.30.13.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 13:54:28 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Julia Lawall <Julia.Lawall@lip6.fr>, Joe Perches <joe@perches.com>
Cc:     Denis Efremov <efremov@linux.com>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Coccinelle: extend memdup_user transformation with GFP_USER
Date:   Sat, 30 May 2020 23:53:47 +0300
Message-Id: <20200530205348.5812-2-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200530205348.5812-1-efremov@linux.com>
References: <20200530205348.5812-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Match GFP_USER allocations with memdup_user.cocci rule.
Commit 6c2c97a24f09 ("memdup_user(): switch to GFP_USER") switched
memdup_user() from GFP_KERNEL to GFP_USER. In most cases it is still
a good idea to use memdup_user() for GFP_KERNEL allocations. The
motivation behind altering memdup_user() to GFP_USER is here:
https://lkml.org/lkml/2018/1/6/333

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 scripts/coccinelle/api/memdup_user.cocci | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/coccinelle/api/memdup_user.cocci b/scripts/coccinelle/api/memdup_user.cocci
index c809ab10bbce..49f487e6a5c8 100644
--- a/scripts/coccinelle/api/memdup_user.cocci
+++ b/scripts/coccinelle/api/memdup_user.cocci
@@ -20,7 +20,7 @@ expression from,to,size;
 identifier l1,l2;
 @@
 
--  to = \(kmalloc\|kzalloc\)(size,GFP_KERNEL);
+-  to = \(kmalloc\|kzalloc\)(size,\(GFP_KERNEL\|GFP_USER\));
 +  to = memdup_user(from,size);
    if (
 -      to==NULL
@@ -43,7 +43,7 @@ position p;
 statement S1,S2;
 @@
 
-*  to = \(kmalloc@p\|kzalloc@p\)(size,GFP_KERNEL);
+*  to = \(kmalloc@p\|kzalloc@p\)(size,\(GFP_KERNEL\|GFP_USER\));
    if (to==NULL || ...) S1
    if (copy_from_user(to, from, size) != 0)
    S2
-- 
2.26.2

