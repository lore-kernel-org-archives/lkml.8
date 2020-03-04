Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5547FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 05:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E7E20870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 05:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFKr9KhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgCDFex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 00:34:53 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:32872 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgCDFex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 00:34:53 -0500
Received: by mail-pl1-f195.google.com with SMTP id ay11so511802plb.0;
        Tue, 03 Mar 2020 21:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Wx1dpYuJUZQ968LyzlAz8kJnaaQj07UX3PLKHlV1LaI=;
        b=kFKr9KhPn3K9CZa8R3L77/BxUdS107vl21eRaPc29XpDYCjbEdhHxPhDMfVrXBQ29i
         yfUomrpcr0QKwayMX/SwNXzlDUzZnfdoDGW1BXgFbDi7mwuPhb5a02Mjr88gx3/FaibY
         mlBp1Ggm1o4x5+6oy/W9SZD5ukcLKzeTBSTk9jQdgAxRSus4dciaFkPRYyo56PC9C660
         qLc5CKuVg/VJtf/1iqmtoYBoA5JzyHgX7DnefvteDZScW+zmFDJZ2CaArAQRBgppTMTB
         rhpWbzocxhEp7Qgr9Zig++zso8b2kZz65AYAa5XO8rRPV9TzzzmebYleuJoldQS2mzMa
         MF3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Wx1dpYuJUZQ968LyzlAz8kJnaaQj07UX3PLKHlV1LaI=;
        b=Mc7BOQGLYQapxneZNFGHg4Mu7YWr6GQbnpXkOYcAmTane8W0jICzqAwLyTgY2gODQW
         akV5OfizzrYKCaBFVF9XcHxR7pHx/XYN7hvKX4uVnLYS5cckveoLx90i1RQpnYvOt8A8
         f/JqJJgGC5FxI2RAiRiyqa01D1dOogaWJI1C/OJ7pjW3Cgp3K6mkLZ9ZpzJxeKq9vj7w
         B+b9q+t3TqnDxFWHln46ivbsGnR+9XPGRYc31siRSXjFLd9nO4WmL6QNg6fJH6lwM6AT
         BzRVodjoZPZKa3z7mennFM/nE+uZT/6nhCCc6x9JJPfum+zWUPbcmyFEUXKqOcCgX8t2
         lJKQ==
X-Gm-Message-State: ANhLgQ2QNiVBNqY3ATaL//0s2cg85qZiRaRXFEM64c5VUPk+xLIwDhG6
        ZI95ItvIvkiQAkhzyEyCaJ+GgNtB
X-Google-Smtp-Source: ADFU+vuTr5ChVBFGh9+VtXFo6hMIx5fXSq55X7KB2z9of5LqWuK9vT3xb1gdWe6sQXUk7+ds7fnAlQ==
X-Received: by 2002:a17:90a:c218:: with SMTP id e24mr1369787pjt.64.1583300092357;
        Tue, 03 Mar 2020 21:34:52 -0800 (PST)
Received: from localhost ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id r9sm14792585pfq.72.2020.03.03.21.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2020 21:34:51 -0800 (PST)
From:   Leon He <hexiaolong2008@gmail.com>
X-Google-Original-From: Leon He <leon.he@unisoc.com>
To:     shuah@kernel.org, sumit.semwal@linaro.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, Leon He <leon.he@unisoc.com>
Subject: [PATCH] dma-buf: heaps: bugfix for selftest failure
Date:   Wed,  4 Mar 2020 13:34:36 +0800
Message-Id: <1583300076-28392-1-git-send-email-leon.he@unisoc.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the 'name' array in check_vgem() was not initialized to null, the
value of name[4] may be random. Which will cause strcmp(name, "vgem")
failed.

Signed-off-by: Leon He <leon.he@unisoc.com>
---
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index cd5e1f6..21f3d19 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -22,7 +22,7 @@
 static int check_vgem(int fd)
 {
 	drm_version_t version = { 0 };
-	char name[5];
+	char name[5] = { 0 };
 	int ret;
 
 	version.name_len = 4;
-- 
2.7.4

