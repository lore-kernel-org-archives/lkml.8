Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00252C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 14:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2E7821973
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 14:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRDLnidN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgDSOtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 10:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgDSOtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 10:49:02 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2145C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 07:49:02 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id r20so3650171pfh.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Apr 2020 07:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/Y9EEw8+vVKXR26VXHGaBoc+4Thx4gdgWJh52Fb86wo=;
        b=VRDLnidNIQ94FASqAA6G3i2QeT/rvVAqB5LSMEooXFenJPdZobyzHyAkBrCSTRnE26
         tqIj8It5BQWlWFcf9ixyxn7ww/1ndf9/uvD+Lj8KBGU4fNn25Mi79upymETY641UATtk
         jNFfa37BcMrfLyS9yK+wF/v9tuuWiQF4y5i+sS6NPPy8N17y6gwe5mIo8pg8cC8NxFSm
         uin61QRKfhdgPQafT/8eKYhZ3Q59CMO8RWGKhzSV1L76BT4vs78s5GtaqmV/7BAW66jc
         5qenEjmB/QdUVwWAy9zw7ozpmRoOCKPAc6v5O70zm2HolR3a7oplNaPpUgtCLLxr72sx
         1KfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/Y9EEw8+vVKXR26VXHGaBoc+4Thx4gdgWJh52Fb86wo=;
        b=ENiIIvO3dJFeY60Hf3DzMgrS8acl98539DZ2Fe1zeDuqVBvrABWQPg/RvABe0EhHPr
         dUR2S/O2r9ClrjfS53tRSK3yDZ9SaVXTfG7Zfk+pXKMvpVCZyrR3097GM7yTcyY0Dw+R
         TP+79UGV7zXNc4I+uaf+A2802k2XS5+ZNZ2ARw9XlbANBy6xL1+w46gKcNIJ+BgDRenH
         KfCnIgkOJd6uC4+qvJkCs/bvdWZHCualXA5nHFQQwvZmJnUn6ksI6Sc6RSlRDkIX6bBs
         1b7YP5CevSv/9NGkuadN3D4wUdUgxbylUCkVP2VoE3ur0sofBgVdh47iVQmlx/DElhDh
         DEPw==
X-Gm-Message-State: AGi0PuZSxxIHf+Eiss1VgxIaOsTLNUxZDZwFCCMJrsXl+2RS6vY41a6v
        UrCCTlYlVAB9aFEI5VbLH4Y=
X-Google-Smtp-Source: APiQypKXrkGJULiInhOYddfSqXGw/DiJQmKHwtfCSBWDQFR/Mwm1wJTiairEqo6yETBDP/QxRA0YhQ==
X-Received: by 2002:a63:cc:: with SMTP id 195mr11999844pga.373.1587307742128;
        Sun, 19 Apr 2020 07:49:02 -0700 (PDT)
Received: from nishad ([106.51.232.103])
        by smtp.gmail.com with ESMTPSA id f21sm11128349pfn.71.2020.04.19.07.48.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Apr 2020 07:49:01 -0700 (PDT)
Date:   Sun, 19 Apr 2020 20:18:55 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] debugfs: Use the correct style for SPDX License Identifier
Message-ID: <20200419144852.GA9206@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch corrects the SPDX License Identifier style in
header file related to debugfs File System support.
For C header files Documentation/process/license-rules.rst
mandates C-like comments (opposed to C source files where
C++ style should be used).

Changes made by using a script provided by Joe Perches here:
https://lkml.org/lkml/2019/2/7/46.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 fs/debugfs/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index f0d73d86cc1a..034e6973cead 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  *  internal.h - declarations internal to debugfs
  *
-- 
2.17.1

