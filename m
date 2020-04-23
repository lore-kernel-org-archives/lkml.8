Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B34C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BF6C2076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="IqBvaW2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729448AbgDWPp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729205AbgDWPpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:45:23 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1720BC09B040
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 08:45:23 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id p25so3127554pfn.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 08:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+SloOzgks90oP9C6mvgapac7rntE6LuQE/iY+UvGdqE=;
        b=IqBvaW2GJu0QG+ZWgBIXE1KXL1ya6B4MBW23tQvRqVMiJqNihLu7ElQNpdOWuKXf2D
         e7fOcA8oeZHNM3l4zTGseuDdu7cySBLdVZCmqMt5FT1XF4o5RIHje5hfbbfRfuuQIF9l
         wlt0YjK5vcwOmbln9gLApxVOyBNzdy/PZ8FPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+SloOzgks90oP9C6mvgapac7rntE6LuQE/iY+UvGdqE=;
        b=KYp3haYupuDaqZJnYYYFD5+AlcjNoxK1Fz3/itP72fNQtRsX/pwF954mMhzDJPA2Kq
         cnLNVA2KOp/5aCleXglhGnUjYWwjofhp7dI1lbolb3FCU1urHKs/8pQ45z2eO8sZ8D01
         YR4p56fPsGDxXQiuy6yXdV8MHI1jD1M6AilixEMW4mRCXdzHJeYrfIJAyPuRmrNXLhIw
         2kPfpXs88Ci+gkhyr9MrMo+p3QIZCqu41TDygswecfrjgKMMQWIrgsKiqFBDEwQatFvh
         bgsDSvaGXrz0S4KWrUECRgOLOCtQMbzAVViZBuRzTWUl5PoMITCkwhnIXgll9qrK03Uv
         aqrg==
X-Gm-Message-State: AGi0Pub2YIwl/AXZfWarsPRGGzlYd4z4YJxd8kMj/HweBkYvHp1DW2UY
        Y/aqHqLZPCsqMy9Jy5dDitMkCkZyZeU=
X-Google-Smtp-Source: APiQypI9GuOWUlHBu6sSOoBDP8OTkF209Ci68BXqNi3aY+8I1lm6ymh949tU0rIRJW1ZfPbwVMB3sQ==
X-Received: by 2002:aa7:9f0a:: with SMTP id g10mr4217244pfr.109.1587656722363;
        Thu, 23 Apr 2020 08:45:22 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-7979-720a-9390-aec6.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:7979:720a:9390:aec6])
        by smtp.gmail.com with ESMTPSA id z6sm2200624pgg.39.2020.04.23.08.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 08:45:21 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, kasan-dev@googlegroups.com
Cc:     dvyukov@google.com, christophe.leroy@c-s.fr,
        Daniel Axtens <dja@axtens.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>
Subject: [PATCH v3 3/3] kasan: initialise array in kasan_memcmp test
Date:   Fri, 24 Apr 2020 01:45:03 +1000
Message-Id: <20200423154503.5103-4-dja@axtens.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423154503.5103-1-dja@axtens.net>
References: <20200423154503.5103-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memcmp may bail out before accessing all the memory if the buffers
contain differing bytes. kasan_memcmp calls memcmp with a stack array.
Stack variables are not necessarily initialised (in the absence of a
compiler plugin, at least). Sometimes this causes the memcpy to bail
early thus fail to trigger kasan.

Make sure the array initialised to zero in the code.

No other test is dependent on the contents of an array on the stack.

Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Daniel Axtens <dja@axtens.net>
Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
---
 lib/test_kasan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index 939f395a5392..7700097842c8 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -638,7 +638,7 @@ static noinline void __init kasan_memcmp(void)
 {
 	char *ptr;
 	size_t size = 24;
-	int arr[9];
+	int arr[9] = {};
 
 	pr_info("out-of-bounds in memcmp\n");
 	ptr = kmalloc(size, GFP_KERNEL | __GFP_ZERO);
-- 
2.20.1

