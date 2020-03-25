Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB39C2D0E8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0690B20714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585178234;
	bh=b8CQymbseyEzBPQOfhZ2WJ1uNrvtBHzb4WZjVAHTtlU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GfzGUzaJByjHgsjC9NuvhBhk0ENnT1hwrj4DFpiMxAV4A9m0W4Hpr/xKVSocO17QD
	 91I6Ge1kM9At8u8a11qdVaXNuxfHtSKEQz1b1Q29FAC0Z2zPt1+P151rWMKr7EYA+d
	 sO39m3QGkfItAHEJKJyOY7TJsNnqyCjCV9yxcMEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgCYXRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:17:13 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:43790 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgCYXRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 19:17:12 -0400
Received: by mail-il1-f193.google.com with SMTP id g15so3612915ilj.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 16:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DrUjt8nDVmnXm/gavjIg5JPRcKfLAZSvtSkkEAXua/k=;
        b=RjmhVQsRoIu+fugIXEphOWQXXwrbR0U7o8lWymDH+s3khbIY7/LRMZ3OThF3LwAhei
         xgCmL4z4GqTUpxho/VqGuDeNXpMKRGxOqt7/iC/LlY1tvimZ1oWmTfj91db8mb5fHNhC
         +5JBygqDvynJlE7L5rcaTMaLAflMzw/o4zAsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DrUjt8nDVmnXm/gavjIg5JPRcKfLAZSvtSkkEAXua/k=;
        b=Uvt1KU4HzMIXqgOGyLkwSumi8SDqcThVuIVDMfHh04pEBVMBxZ5ovYOWndtlgdvxfa
         EupZO7E7XXSjRQ8TyAyVpqSk6dLUUoBkRKEaQT7AvukApqWvr7v+eX5FEvaiKIlUT+C5
         hpKL/r4rEChCEIwc/u9T1Zj5itZsrDF1332ywrGxNNtHjv9QXY4y4RY1iIaUbD+m93Nn
         U2rD5JL/xSaOO6jHjW9TZzUsfosqaXV5H2rVhZ4dSkhWBF8b3wgv6lgGGvYAlw2U55/P
         8JTCvAf+WpXgwh2S3LcyEBOcyeVlUYcFab4wpelWBSmzqU7s96WNz18E5+6vFanNTSFP
         OFZg==
X-Gm-Message-State: ANhLgQ3+PlKiBCCfVG4fyJnG4cYKBnNKBDEMKhFcEc7Rm1973+rY8Htl
        fvuxfjGdB5A+MKfN8YS8gwIxtQ==
X-Google-Smtp-Source: ADFU+vsV0uKQgaC+DPxZJsuvX3hDBs66N7APb5XhYFy3EkxbDbwMY/ueRcdGw4a/l8TKdfdP3HG7nw==
X-Received: by 2002:a92:8741:: with SMTP id d1mr6251924ilm.167.1585178231660;
        Wed, 25 Mar 2020 16:17:11 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id s69sm202636ild.70.2020.03.25.16.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 16:17:11 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: Fix memfd to support relocatable build (O=objdir)
Date:   Wed, 25 Mar 2020 17:17:09 -0600
Message-Id: <20200325231709.13122-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix memfd to support relocatable build (O=objdir). This calls out
source files necessary to build tests and simplfies the dependency
enforcement.

Tested the following:

Note that cross-build for fuse_mnt has dependency on -lfuse.

make all
make clean
make kselftest-install O=/arm64_build/ ARCH=arm64 HOSTCC=gcc \
CROSS_COMPILE=aarch64-linux-gnu- TARGETS=memfd

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/memfd/Makefile | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/memfd/Makefile b/tools/testing/selftests/memfd/Makefile
index 53a848109f7b..0a15f9e23431 100644
--- a/tools/testing/selftests/memfd/Makefile
+++ b/tools/testing/selftests/memfd/Makefile
@@ -4,9 +4,8 @@ CFLAGS += -I../../../../include/uapi/
 CFLAGS += -I../../../../include/
 CFLAGS += -I../../../../usr/include/
 
-TEST_GEN_PROGS := memfd_test
+TEST_GEN_PROGS := memfd_test fuse_test fuse_mnt
 TEST_PROGS := run_fuse_test.sh run_hugetlbfs_test.sh
-TEST_GEN_FILES := fuse_mnt fuse_test
 
 fuse_mnt.o: CFLAGS += $(shell pkg-config fuse --cflags)
 
@@ -14,7 +13,7 @@ include ../lib.mk
 
 $(OUTPUT)/fuse_mnt: LDLIBS += $(shell pkg-config fuse --libs)
 
-$(OUTPUT)/memfd_test: memfd_test.c common.o
-$(OUTPUT)/fuse_test: fuse_test.c common.o
+$(OUTPUT)/memfd_test: memfd_test.c common.c
+$(OUTPUT)/fuse_test: fuse_test.c common.c
 
-EXTRA_CLEAN = common.o
+EXTRA_CLEAN = $(OUTPUT)/common.o
-- 
2.20.1

