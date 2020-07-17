Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF6FC433FC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2000C207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 18:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0tjdyq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgGQS5X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 14:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728270AbgGQS5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 14:57:20 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8A5C0619D2;
        Fri, 17 Jul 2020 11:57:20 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id o38so8419252qtf.6;
        Fri, 17 Jul 2020 11:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=talrzUzXemNzfVBQRxQ9IawBftj9SRWQacOH7U1o/94=;
        b=o0tjdyq7A9bSupuaW03+irDhYDRjIrlW79f0lwjaaJmR+rfEKPIf3CoT1BmbUhHsA4
         IFC1y+14CS+dd7i43gk3E32rZXIyLRliqwW7Vp3mqQCiZ4Lopl0yxELTXWdaegQFeONn
         /r06o1Xdkj0AevY9PXQtqSAtZLC8Z6va+gzVnqlCS40E2XuvRrrIsxOpsDrEkH2wh6Kw
         YbPC/2IiqOiqPUpMbh0zkkQO/XN/hMWX92tHY2mKtJh6CZzqN+p1hCxw22BZDug5UDkn
         UiycUmax1APVKLNM1fE0lDnKZUgbV+K234tqcKPh+GhN0oRFBr2MBeT6rf5i6bFNSlKf
         lBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=talrzUzXemNzfVBQRxQ9IawBftj9SRWQacOH7U1o/94=;
        b=B9lqj/RKcGgRJsbWRfXb3JDJYCtP+Eic9Q10mgNM1lHdIf3dn1T3u5yG3zsCNTqMLl
         AbnRWmuIJOvocyoSmYsfwIUTOvsOznbPGYqzVhsrOvjyBrK5elgyI9Egam2HxdoLgJOx
         4ZhOeho638pv33xPxOlv5uOeZKvSLFV61P7ZP+tkEukfZfFZAfP7W6+658OJLbeYM7SN
         new7pzNg1xtvOMAbe5DTzCGnPz5CXiiETlYSHsbAcGL/jqMkM6BUIs+5vkdbMBI2FvJY
         v42zjyGA/MxxZ3Ik5SOoBe9aihWKYlW1Y+IgLiGfKRJOLb7ovLne8PnAu3qZ8JBzgt7R
         +vFw==
X-Gm-Message-State: AOAM530m19BbEI5DppCS6UlrjoWaAcgJ68MIp3ZQEo7mO1uNnqXbgrVp
        3CI+P3MNNaMbSCPCuVs+yp8=
X-Google-Smtp-Source: ABdhPJwC99c7WJ678epmY+8oPZZ2FWd5hG26sz3LANQrmVyGk15be2lq9rEi6wl2TuG6O30B3sEcBA==
X-Received: by 2002:ac8:6f26:: with SMTP id i6mr11863228qtv.61.1595012239938;
        Fri, 17 Jul 2020 11:57:19 -0700 (PDT)
Received: from localhost.localdomain ([2804:18:7002:653c:f7ea:490a:10b0:ec39])
        by smtp.gmail.com with ESMTPSA id r6sm11380097qtt.81.2020.07.17.11.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 11:57:19 -0700 (PDT)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, mchehab@kernel.org
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/25] Documentation: vmalloc.c: fix sphinx warning
Date:   Fri, 17 Jul 2020 15:56:10 -0300
Message-Id: <20200717185624.2009393-11-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Fix the following warning:

warning: Excess function parameter 'prot' description in
'vm_map_ram'

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
---
 mm/vmalloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 3091c2ca60dfd..957a0be772702 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1862,7 +1862,6 @@ EXPORT_SYMBOL(vm_unmap_ram);
  * @pages: an array of pointers to the pages to be mapped
  * @count: number of pages
  * @node: prefer to allocate data structures on this node
- * @prot: memory protection to use. PAGE_KERNEL for regular RAM
  *
  * If you use this function for less than VMAP_MAX_ALLOC pages, it could be
  * faster than vmap so it's good.  But if you mix long-life and short-life
-- 
2.27.0

