Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FC97C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F29020714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="WyoCIWVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgCQS2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:28:24 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42319 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgCQS2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 14:28:23 -0400
Received: by mail-qt1-f193.google.com with SMTP id g16so18337279qtp.9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 11:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hic4Hk8KyLZidH+GoF3MjbGLcDx23I/TP9F0S2+w6Wc=;
        b=WyoCIWVgihmFEbpoAgJ0WOO8oI2JXlFHp2g+7dQHXnojVh7fS+YwY+6QVnnR0YaZpK
         irURzTYescZQIVkCKA05cIYm6GESnmt0XILsrZVkmZVvGnX2cdTTsDwsrKo2SEzmu0cE
         dyOFKVIMw70DXi9B7cieoIbQn5poYi7juqZY0+My61lLrCKIq7rmYdQhNo6pvcOpsw0P
         HT0WaCmESLj3vdY1p/CXF4boWQRVTCN9SQPi2t/jPc8ki/zF8cFwxE7UJUdxQ6tngCpX
         9rYk1zQPJZW4iMUue1j+HwTks9H7+VyBdYrhJG4Eh7C6zmSDa9VpUG93FFcu299Jh/Ky
         2PVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hic4Hk8KyLZidH+GoF3MjbGLcDx23I/TP9F0S2+w6Wc=;
        b=QZGI2cGLHhGZZKk8yEb5wl3nVH2zIG0bWwggQgCjr+eKWxZSvrIW1zy0vzNUruXtN7
         adeDI1ye0oYyuU4i/l0nZsn5bC1Vqpw9MJqjXj7UsD85MCBPjtvcjFK8QJLYEEHmdhbT
         jJE4wVhoJu+9TRMAS2PUnDur81HioqesGqiumRLfPWj+XWrSUNhFLzw3wiRiRmuT3R2u
         7BfS3eCMNryYJVpgwek8+rsHCL+9++PLO4LbjkPAZpgo88ioLLvA1/O+3kxiWMh+Cy2A
         XVqtV4NHLSkY0UDgNS2+ZmtaykSHpsn29gfH/+kWfwcO3IaZ3KipdXgLhNx7jM5FM2zO
         Vdnw==
X-Gm-Message-State: ANhLgQ3X+81et5VmvL0vCMyiHPbYakrbu0ctQrYYV106umos7MJbTzIL
        E+YGRcWCy0lh41qjzNwgBVeBeQ==
X-Google-Smtp-Source: ADFU+vvkq0L39IFs6mQeUAHEO/asf3qOHGHQfRIGOzJtvereIwNA8+94oLkLBlAGiQtnpndj8tREXA==
X-Received: by 2002:ac8:4784:: with SMTP id k4mr534088qtq.78.1584469701723;
        Tue, 17 Mar 2020 11:28:21 -0700 (PDT)
Received: from ovpn-66-200.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l60sm2781281qtd.35.2020.03.17.11.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2020 11:28:21 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     elver@google.com, catalin.marinas@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/kmemleak: silence KCSAN splats in checksum
Date:   Tue, 17 Mar 2020 14:27:54 -0400
Message-Id: <20200317182754.2180-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if KCSAN is disabled for kmemleak, update_checksum() could still
call crc32() (which is outside of kmemleak.c) to dereference
object->pointer. Thus, the value of object->pointer could be accessed
concurrently as noticed by KCSAN,

 BUG: KCSAN: data-race in crc32_le_base / do_raw_spin_lock

 write to 0xffffb0ea683a7d50 of 4 bytes by task 23575 on cpu 12:
  do_raw_spin_lock+0x114/0x200
  debug_spin_lock_after at kernel/locking/spinlock_debug.c:91
  (inlined by) do_raw_spin_lock at kernel/locking/spinlock_debug.c:115
  _raw_spin_lock+0x40/0x50
  __handle_mm_fault+0xa9e/0xd00
  handle_mm_fault+0xfc/0x2f0
  do_page_fault+0x263/0x6f9
  page_fault+0x34/0x40

 read to 0xffffb0ea683a7d50 of 4 bytes by task 839 on cpu 60:
  crc32_le_base+0x67/0x350
  crc32_le_base+0x67/0x350:
  crc32_body at lib/crc32.c:106
  (inlined by) crc32_le_generic at lib/crc32.c:179
  (inlined by) crc32_le at lib/crc32.c:197
  kmemleak_scan+0x528/0xd90
  update_checksum at mm/kmemleak.c:1172
  (inlined by) kmemleak_scan at mm/kmemleak.c:1497
  kmemleak_scan_thread+0xcc/0xfa
  kthread+0x1e0/0x200
  ret_from_fork+0x27/0x50

If a shattered value was returned due to a data race, it will be
corrected in the next scan. Thus, let KCSAN ignore all reads in the
region to silence KCSAN in case the write side is non-atomic.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/kmemleak.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index e362dc3d2028..5e252d91eb14 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1169,8 +1169,10 @@ static bool update_checksum(struct kmemleak_object *object)
 	u32 old_csum = object->checksum;
 
 	kasan_disable_current();
+	kcsan_disable_current();
 	object->checksum = crc32(0, (void *)object->pointer, object->size);
 	kasan_enable_current();
+	kcsan_enable_current();
 
 	return object->checksum != old_csum;
 }
-- 
2.21.0 (Apple Git-122.2)

