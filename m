Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAFFC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610EC206CC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Smq2qw4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgBFLKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:10:47 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51857 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbgBFLKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:10:47 -0500
Received: by mail-pj1-f66.google.com with SMTP id fa20so2350408pjb.1;
        Thu, 06 Feb 2020 03:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=e5bLXiJOBz0Ase0LVV8R1Fx1vvqaJOML/0lFN7HcaZU=;
        b=Smq2qw4WUvll9A/rFWOvbkhduTCjDjPZkIJMIxhMbv3GMECgkuSbzbLxEAdvSOoq0W
         wbIvLDVwXZKPxum1LiaNn0rg5TgZyj+Ocb4BsxAvDIgIG6hivVMVMfVWDUHQKWVc2V4l
         NjlWXVxx0jX4wIJQ+sStu8ghUjoF5sPGuoUpbybI2o4lhYs3CZKpx4yqKKRCaRdthA8G
         U9tbAG8MooVaJgLv3MwIovjhRwvpEJQfq4Az9aEDWF258LQ2jJUjh8GsniWBXRfoCHXF
         H4t4q0lo04F/y5yl6XtXaPa49jXYS/uHQKTUd4I9H83GC+sIcw9eJRxKoVTrJ0qnMyOy
         MroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e5bLXiJOBz0Ase0LVV8R1Fx1vvqaJOML/0lFN7HcaZU=;
        b=pdwVYrgWX9ssxMlSZVMYdOSOwOl91QfZlbuQjgdN4R4yrnSzCIhtcfITNJUP1NVAAw
         68xXyRSqbS05m1Jw9Jpyiq78ZM6Vx82rxa58TYDAy7vH9r4Wkh2gABBtR3WiqjhXbTp2
         Y9IN/MtqFEQJWYMy+Mg1y0/9KCOmCorJ/9slEMzOiwVMpEqzxAGjjucahyJGU6JWkZuG
         VF424V35SNPagdH+6zGAX0cNEzQBT21cZ6prtR8WxH1LGYmp4MZUy3B/MYAOGbWLE0SU
         mlNWrcrMeDLdYOwSHk6NVHBom1CH/Xz+YYsuAlDl2I5dOmCZjkvc1H1egGgNY0aROkAM
         lYOg==
X-Gm-Message-State: APjAAAWZbYbaBgcAxfqNX4bwWZLz4bQbhfnSRCTErJBY8cqNVMY2sguG
        AcHSjGUIWbraU+cSdZhfQIa9u1d4
X-Google-Smtp-Source: APXvYqyu2ymfaN1fNgVOUAtbUKxh+mZ4NtTnfPCWva5qPDk6n/O/ZNGsy0OPwmuODYQngfqaNRVIaw==
X-Received: by 2002:a17:902:7b86:: with SMTP id w6mr3008916pll.317.1580987446579;
        Thu, 06 Feb 2020 03:10:46 -0800 (PST)
Received: from huyue2.ccdomain.com ([103.29.143.67])
        by smtp.gmail.com with ESMTPSA id b4sm2996287pfd.18.2020.02.06.03.10.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Feb 2020 03:10:45 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] Documentation: zram: fix the description about orig_data_size of mm_stat
Date:   Thu,  6 Feb 2020 19:10:31 +0800
Message-Id: <20200206111031.9524-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1.windows.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <zbestahu@163.com>

orig_data_size counted the same_pages by commit 51f9f82c855d ("zram:
count same page write as page_stored"), so let's fix it.

Signed-off-by: Yue Hu <zbestahu@163.com>
---
 Documentation/admin-guide/blockdev/zram.rst | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 27c77d853028..a6fd1f9b5faf 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -251,8 +251,6 @@ line of text and contains the following stats separated by whitespace:
 
  ================ =============================================================
  orig_data_size   uncompressed size of data stored in this disk.
-		  This excludes same-element-filled pages (same_pages) since
-		  no memory is allocated for them.
                   Unit: bytes
  compr_data_size  compressed size of data stored in this disk
  mem_used_total   the amount of memory allocated for this disk. This
-- 
2.11.0

