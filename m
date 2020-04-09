Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B621AC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 21:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C6F92072F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 21:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPX2S6Eq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgDIV6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 17:58:09 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54392 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726638AbgDIV6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 17:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586469488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9YlJfp8gcnULlH0Iw/uIfxlGLQ2jILFfQLjgtpxox2c=;
        b=CPX2S6EqgkVyDWNZ3jyqJ7RQZsj2iauzpmEzVv6UiGzcZOVKL46ok2zVvx6NNGeVxs3ii+
        cZOIF690nZaz0qPnNVIzWm8FwIBWZwnj+m45OSXUvZ6+4yqfAz6AXm2EG+NcBuhx9mSOVk
        U0Ls71+H+We7ripdttU8XPwzHYj0TS4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-5Zx9rBwVPSm3qVpSfrjlqg-1; Thu, 09 Apr 2020 17:58:04 -0400
X-MC-Unique: 5Zx9rBwVPSm3qVpSfrjlqg-1
Received: by mail-qk1-f198.google.com with SMTP id a67so463685qke.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 14:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9YlJfp8gcnULlH0Iw/uIfxlGLQ2jILFfQLjgtpxox2c=;
        b=suMcxAU5npu8ti2rTEOY2Wu6CyW2vwT1IKstyGtokZPst49p5X+fkxsNSGBz7SV7ad
         RgXAtIEdd14az0x3FGtV+cBve6IOPl/PcfKNQyp+FJk3rAkkivBdWPbHjGiQB0TJVsb/
         V9QQa+Q8UXLtG1VChdjfFmaFRH9eTn4rYz7BXhFrsKrzfMalHPzqQr+2iPoDSGbA+jEj
         Q5lyxSgV13IQAkPayNON0kidD/lNkGU+g1yvo+S3LbUGI2KIN8N2cqUOalV9gxgZj+k1
         0bjB9F6bk/8AdMtTR4kuBk5U4+wXFt5GLRoIikU75edwP+6LfEou+fu1Lu6q6Ptz08FK
         fWhQ==
X-Gm-Message-State: AGi0PuZreYHmn7QXKGzF/rGkRNI4uNTDs4eATmlf1fux4KKIxx69rq1y
        n/BPaQZwrMzjuaKXrve6BLJggEhK0K07jM/l3WCnk7+yhwYZn1oSrVI2vMTQw7T6LsnUZxUvN1u
        UqA+xhv7OoCdW2OMLwhfoQ4/L
X-Received: by 2002:ae9:e8c1:: with SMTP id a184mr988562qkg.242.1586469484034;
        Thu, 09 Apr 2020 14:58:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypKLmS8XXUNIiGvZvCrKQlsPyUcVaCnI5PoZiI1hPytd9AWi1VwgIeqBvXPZH/X8OoxSv8t7aw==
X-Received: by 2002:ae9:e8c1:: with SMTP id a184mr988543qkg.242.1586469483726;
        Thu, 09 Apr 2020 14:58:03 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id m11sm103828qkg.130.2020.04.09.14.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 14:58:03 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nitesh Narayan Lal <nitesh@redhat.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] Documentation: hugetlb: Update hugetlb options
Date:   Thu,  9 Apr 2020 17:58:00 -0400
Message-Id: <20200409215800.8967-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hugepage options are not documented clearly.

Firstly, default_hugepagesz= should always be specified after the
declaration of the same type of huge page using hugepagesz=.  For
example, if we boot a x86_64 system with kernel cmdline
"default_hugepagesz=2M", we'll get a very funny error message:

"HugeTLB: unsupported default_hugepagesz 2097152. Reverting to 2097152"

It's understandable from code-wise because when hugetlb_init() we
didn't have the 2M page hstate registered, so it's unsupported.
However 2M is actually the default huge page size on x86_64, so we'll
register it right after the error message.  However it's very
confusing if without these knowledges.

Secondly, hugepages= option must be used _after_ another hugepagesz=.
The word "interleave" is fine but it didn't declare the fact that
each of the hugepages= option will be applied to the previous parsed
hugepagesz= option.

State all these clear.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 .../admin-guide/kernel-parameters.txt         | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 86aae1fa099a..2a77b2b01e5e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -839,7 +839,8 @@
 			the legacy /proc/ hugepages APIs, used for SHM, and
 			default size when mounting hugetlbfs filesystems.
 			Defaults to the default architecture's huge page size
-			if not specified.
+			if not specified.  This option can only be used with a
+			pre-defined "hugepagesz=" of the same size.
 
 	deferred_probe_timeout=
 			[KNL] Debugging option to set a timeout in seconds for
@@ -1475,13 +1476,17 @@
 	hpet_mmap=	[X86, HPET_MMAP] Allow userspace to mmap HPET
 			registers.  Default set by CONFIG_HPET_MMAP_DEFAULT.
 
+	hugepagesz=	[HW,IA-64,PPC,X86-64] Declare one type of HugeTLB pages
+			with the size specified.  Valid pages sizes on x86-64
+			are 2M (when the CPU supports "pse") and 1G (when the
+			CPU supports the "pdpe1gb" cpuinfo flag).
+
 	hugepages=	[HW,X86-32,IA-64] HugeTLB pages to allocate at boot.
-	hugepagesz=	[HW,IA-64,PPC,X86-64] The size of the HugeTLB pages.
-			On x86-64 and powerpc, this option can be specified
-			multiple times interleaved with hugepages= to reserve
-			huge pages of different sizes. Valid pages sizes on
-			x86-64 are 2M (when the CPU supports "pse") and 1G
-			(when the CPU supports the "pdpe1gb" cpuinfo flag).
+			On x86-64 and powerpc, this option must be used after
+			one hugepagesz= to allocate huge pages of that specific
+			size.  This option can also be used multiple times
+			pairing with hugepagesz= to allocate huge pages for
+			different sizes.
 
 	hung_task_panic=
 			[KNL] Should the hung task detector generate panics.
-- 
2.24.1

