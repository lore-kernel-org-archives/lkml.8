Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCF6C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 771F92076E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQdkvhEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgFVT6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbgFVT6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:58:36 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05FDC0617BB
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:58:34 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i27so20740482ljb.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nHSFCQ5+cQ8OGh51wncqKzKnMeiEdXuW0XPalgJJm0s=;
        b=WQdkvhEcVZnm+GQQuLrVNL+AlI4jUEwnJ7v0hmSqrLb34OLYuQqujv78GPwIWmwdal
         8YSY4XbjIGiccH5xGfzU9dv+BtI13WXalpqseoHo9kl9WqU1Eo9Q2PxdF4UVEnVstsKa
         34Jn8j+9WBQf38ZGaxFVI1Fm3JUp6tHgsqsvzQSJcD7JROpW9sbh13AFnN1WIFPHT3Y7
         rRj6Oc3AqvXAdXjOz9P1jb7piKLrambsacW1gG5EJjoeWzz/6dtEiLwqkzxEf1rbl4yz
         bWNIe6Z1mrDcTOHT5z9+0lwvyhrqxLY/o/bYGFQ7MCIqyULdnNm1wTIfxm6d8xUVJSS3
         5ZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nHSFCQ5+cQ8OGh51wncqKzKnMeiEdXuW0XPalgJJm0s=;
        b=aVC5UzaQOoDjQg6ArtF+0rE1YJdLkznnxrCXJy4QjhwMClg+JoATT2cmU6VMc4D0GA
         eoXF8HajsdHTuhSp/zG/HFv1j+acifqqMCVzowDTvfukgrmbLCkn8D2vcBgK8TSZFD25
         e+ox+b+S01klpTdXw8fuRJqf+8kztVtSqpOJmz3AOJ50cRbWu3Th66PYrUyF8XrOSaxL
         fEAv+/fFp7HLUUqQj+HWVOIRxCP9C+eXSWV/wuTt3bO/bqpYFsGXZozu/wcCDbU3WgNW
         sdfbS0lO8a+plSAnbELAsQeYJXc3lrB3ipzn160vK2xzou3qCXBc2UjR6nLEuB2+zF8w
         obaQ==
X-Gm-Message-State: AOAM531RcBx6EXAr1HouqWz6sIbKHBk5vMEgLuYnRq8LMTRz3JFRBD76
        NCWHTp2x5SKdjzNixQv1uaU=
X-Google-Smtp-Source: ABdhPJy8lJXP0jTFUAshbb+9yLIxUhZnDctLlz+GdGwCHouL8FWtsrqxWEUjVRhoAMHuPRgeWRzfqA==
X-Received: by 2002:a2e:9049:: with SMTP id n9mr8719266ljg.118.1592855913450;
        Mon, 22 Jun 2020 12:58:33 -0700 (PDT)
Received: from pc636.lan (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id f24sm2864472ljk.125.2020.06.22.12.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 12:58:31 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH 1/1] mm/vmalloc: update the header about KVA rework
Date:   Mon, 22 Jun 2020 21:58:21 +0200
Message-Id: <20200622195821.4796-1-urezki@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reflect an information about an author, date
and year when the KVA rework has been done.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 1e94497b7388..3c3b6ec26f9c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -7,6 +7,7 @@
  *  SMP-safe vmalloc/vfree/ioremap, Tigran Aivazian <tigran@veritas.com>, May 2000
  *  Major rework to support vmap/vunmap, Christoph Hellwig, SGI, August 2002
  *  Numa awareness, Christoph Lameter, SGI, June 2005
+ *  Improving global KVA allocator, Uladzislau Rezki, Sony, May 2019
  */
 
 #include <linux/vmalloc.h>
-- 
2.20.1

