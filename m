Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA41FC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 01:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B91DD2074A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 01:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHcfllwj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgEABxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 21:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728025AbgEABxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 21:53:18 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F85C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 18:53:18 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id f12so6184970edn.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 18:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L/eixiBO7KCR17cAG5IpTeBZCnCmuzeLdJS3OmBcd98=;
        b=OHcfllwjxxUFVat65zUUPNoQ+blqGZIuFQY+SiYeTzQySOJAGsJaSBgC/RoNSdkGxV
         D01pDAx4vQZvw2wc/bBohb/fhhJNztvgMx0d88aD6/mO+CJBwze+BPlV1Nh2tyvDyz+2
         ClU7/DYC7B667QLAnGkXcLM+lVi19nDprnUybTb+YKrZREQ7nC6+Ni1PG7I6/z/uNQRr
         iFzzvs4QNHpUyT2P0LQ8MGq+N9ZrCAiOl289EmSCSOeK0vdHhmU5tLv9rGD76hJLNKXc
         oRLYklmIIz8z4sy3vGPSGQV+AR92ZX04nkEjVYq9WvQlmWMQyd8YfTJzWGMOLQVi3jk8
         KwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L/eixiBO7KCR17cAG5IpTeBZCnCmuzeLdJS3OmBcd98=;
        b=icVQ0QqcFg0S8fqXZEkj1BeQBLd4zj5K7CuPT21OcEw7QNeEz4cZU8c+PNRmG6jRgD
         uCkMZlO/GdBZRq86EkuVhNrMJz0EuHl3Gt0lhaddSrijHpFRNP8L2JJQA66vpWNmmR4d
         ie6Tdt/fXNL6EMcclFKYh+rgfV/DoTmHe+GedeCRzV/fdFDls5gecJbgbSbOjXyCM9ox
         5XzhqDHRJ42qNkzUihXmNYLwTMwhOoc5erXHeZEjtX6NfxJ8p/112Ev8QSomrod/ySGa
         qMxYJdeFrQvOdbCPPg6Xd8UWIMVp9OpmieExvIOfeo9waK/CimWzvXcKeb/S1Qj1NwC4
         t/YQ==
X-Gm-Message-State: AGi0PuYb7OP+3RsGcblwgyX6qM1hRELYm0g/bmyO0qiv+0fHxsvxLzJg
        +pdcQtmmgNMoRVsyIS3t25k=
X-Google-Smtp-Source: APiQypI6ocw5DBnFfrafoO2PU1kyqVt3eWL/xIIEWqyvGX1ib44xvQchsw21+chYGqWBRVj8xXX68g==
X-Received: by 2002:a05:6402:887:: with SMTP id e7mr1745347edy.178.1588297996991;
        Thu, 30 Apr 2020 18:53:16 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id g1sm170066ejs.51.2020.04.30.18.53.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Apr 2020 18:53:16 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org, ying.huang@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 3/3] mm/swapfile.c: count won't be bigger than SWAP_MAP_MAX
Date:   Fri,  1 May 2020 01:52:59 +0000
Message-Id: <20200501015259.32237-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200501015259.32237-1-richard.weiyang@gmail.com>
References: <20200501015259.32237-1-richard.weiyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the condition is true, there are two possibilities:

   1. count == SWAP_MAP_BAD
   2. count == (SWAP_MAP_MAX & COUNT_CONTINUED) == SWAP_MAP_SHMEM

The first case would be filtered by the first if in __swap_duplicate().

And the second case means this swap entry is for shmem. Since we never
do another duplication for shmem swap entry. This won't happen neither.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/swapfile.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 1a877d1d40e3..88dd2ad34aad 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3404,8 +3404,6 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
 
 		if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
 			count += usage;
-		else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
-			err = -EINVAL;
 		else if (swap_count_continued(p, offset, count))
 			count = COUNT_CONTINUED;
 		else
-- 
2.23.0

