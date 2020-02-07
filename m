Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F181C352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 00:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 448AF2192A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 00:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="cJvTqNLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgBGAhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 19:37:24 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44665 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgBGAhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 19:37:24 -0500
Received: by mail-qk1-f196.google.com with SMTP id v195so554809qkb.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 16:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PAJE+DlL3J3weFiTT/dGK70Va5HXR4vcbYkwDmRWC30=;
        b=cJvTqNLZ0AMzq5U1O950eoSCqVb9WfhhgOAsQdBpb+zVT5LhQiI37ydX+zQtbKywCc
         EE/sDD1N4boctWZzA824rrM42hfmLrtS0xNXKUjvjYKW6Jd6ArG8xFUK7IOhPkWiboNx
         1O7IFVpGpuTDk+vD/hqj7Av+v+02QhgprecgCtvbHzME5ZBDYxSkztvfLKH6uWpCM71R
         HMq9cCtGxHN5WZiBvX5EhpsomFXMSU2PB8X9n8gOQBgBJxsigtiApnNK4QMnTrwzPe/1
         LI4uide8Y/xf1E6IBmP6ceUNZrRciPrtGyoftyEsMVaWEFuNcquLmBHbd6s3pQmEVp/Y
         6Jjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PAJE+DlL3J3weFiTT/dGK70Va5HXR4vcbYkwDmRWC30=;
        b=BdSKY/Se+9rVKu7DqITw3SKr4ebxooOUIwKI0MSCs+72Wlwm7easi3jIjuUPd+urJa
         BMRH4EiPi19qBaKBkO3yWDcSmYNtM+qJCrEwbW/+RrxWOWk8gkEM421A6eRf/75TBHkU
         tK6yfn7jUjOhsPC9t27WHLU8j1T0nvD8Xuj01KPyILWXSghQFNJ45hZXlRYm4xmLR96B
         1HGF7VgmqbcGZTFWHdOi7CfTrHuDXDSJorx9KXBlghj484xq4EfA41lUq9pfWf773ezW
         xTWbxyOKJFNxryT8AFqeaJtguCam0ST6v0g4kKUNk1i+vHX+46pK+I9WjTcZZKnO5SVU
         K13w==
X-Gm-Message-State: APjAAAXZEZvZ+45S9WCKsOijGHK5uQza1OL4dhrpl9nIgkwTGbBo/N0i
        NnvhQzwjmSb6LH+9skYoyAlOzQ==
X-Google-Smtp-Source: APXvYqxIdlGbl8B/TbcF+soFldxIqLnKB7JRKjKC3trg6IbRVPP9H21xj9JXy/wF5hcEXXV0u2jTLA==
X-Received: by 2002:a37:4a51:: with SMTP id x78mr4721626qka.445.1581035843100;
        Thu, 06 Feb 2020 16:37:23 -0800 (PST)
Received: from ovpn-121-126.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z8sm534584qth.16.2020.02.06.16.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Feb 2020 16:37:22 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     elver@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/swap_state: mark various intentional data races
Date:   Thu,  6 Feb 2020 19:37:15 -0500
Message-Id: <20200207003715.1578-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

swap_cache_info.* could be accessed concurrently as noticed by
KCSAN,

 BUG: KCSAN: data-race in lookup_swap_cache / lookup_swap_cache

 write to 0xffffffff85517318 of 8 bytes by task 94138 on cpu 101:
  lookup_swap_cache+0x12e/0x460
  lookup_swap_cache at mm/swap_state.c:322
  do_swap_page+0x112/0xeb0
  __handle_mm_fault+0xc7a/0xd00
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

 read to 0xffffffff85517318 of 8 bytes by task 91655 on cpu 100:
  lookup_swap_cache+0x117/0x460
  lookup_swap_cache at mm/swap_state.c:322
  shmem_swapin_page+0xc7/0x9e0
  shmem_getpage_gfp+0x2ca/0x16c0
  shmem_fault+0xef/0x3c0
  __do_fault+0x9e/0x220
  do_fault+0x4a0/0x920
  __handle_mm_fault+0xc69/0xd00
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

 Reported by Kernel Concurrency Sanitizer on:
 CPU: 100 PID: 91655 Comm: systemd-journal Tainted: G        W  O L 5.5.0-next-20200204+ #6
 Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019

 write to 0xffffffff8d717308 of 8 bytes by task 11365 on cpu 87:
   __delete_from_swap_cache+0x681/0x8b0
   __delete_from_swap_cache at mm/swap_state.c:178

 read to 0xffffffff8d717308 of 8 bytes by task 11275 on cpu 53:
   __delete_from_swap_cache+0x66e/0x8b0
   __delete_from_swap_cache at mm/swap_state.c:178

Both the read and write are done as lockless. Since swap_cache_info.*
are only used to print out counter information, even if any of them
missed a few incremental due to data races, it will be harmless, so just
mark it as an intentional data race using the data_race() macro.

While at it, fix a checkpatch.pl warning,

WARNING: Single statement macros should not use a do {} while (0) loop

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/swap_state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 8e7ce9a9bc5e..c0fcae432bdf 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -58,8 +58,8 @@ static bool enable_vma_readahead __read_mostly = true;
 #define GET_SWAP_RA_VAL(vma)					\
 	(atomic_long_read(&(vma)->swap_readahead_info) ? : 4)
 
-#define INC_CACHE_INFO(x)	do { swap_cache_info.x++; } while (0)
-#define ADD_CACHE_INFO(x, nr)	do { swap_cache_info.x += (nr); } while (0)
+#define INC_CACHE_INFO(x)	data_race(swap_cache_info.x++)
+#define ADD_CACHE_INFO(x, nr)	data_race(swap_cache_info.x += (nr))
 
 static struct {
 	unsigned long add_total;
-- 
2.21.0 (Apple Git-122.2)

