Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB25FC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 05:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8020020772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 05:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OFTUt7sM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731866AbgDAFjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 01:39:00 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54668 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbgDAFi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 01:38:59 -0400
Received: by mail-pj1-f67.google.com with SMTP id np9so2208801pjb.4;
        Tue, 31 Mar 2020 22:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DLKbqJKpUnRkSzVY1pMBybTaQg5JSp+IqFHB/tB3j6Q=;
        b=OFTUt7sMnDo9PVjHvWMGV2g93TvI4WrjgOVNftGO+PET/YEyfGUkF1KtJGKPHXc/ve
         IvcKa/hATLmypZ1VdEnukxEl8DvPx5zYW5buICV7XKVra3JJysoMfVo7WJFO+7NreXp9
         2DpvAvOxCK6ghQfhTgRBzFAzhtWNxnu8ef52/f51yhPzoSynAtpGCCbTtqqpM00tXoOH
         bAA9zxfsR/kik6PqTidAyi8ZhmxyK/V8mqrqrVKgiFmgC+G+Po1/hCcCLIYZFklvp9ro
         9ljC29asZxRB//6EQmX4+UWmwZjXWjXEemUHRDvV1RTZedFdH+X44lcx3J+2u7rpvNAL
         fCPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DLKbqJKpUnRkSzVY1pMBybTaQg5JSp+IqFHB/tB3j6Q=;
        b=R+XLO6QbiEOXYiykr+sdXr84JJOHp8ZsGgJ7/4vZqNkePedXnHCASjjSdhCjSo4rh2
         eleBWuBai7VEUu3hKA2mnswoYIUlrtc1BWxmA9wGcTimN9Tev2Gjp23VbJ4pAQJkGEqw
         RQVvSwOsWuqbnFCevN3BUPokq66e05ia1bBUn8FawmbKFY5Uq0AJTEP+DGwiHc4BXO1k
         WSaq0yMR++AIWHW4d4geOYP+qfsQyK+eVTCMP6cpQOc/72i8BWfM76E3zeXoSyBq+d10
         hol6vFT68y4udk+LTywkJHkVPQ7b3vmYVkdpy3ogMgy+St3nsvby0tfYTwyk/KBg+Gtq
         ZHWw==
X-Gm-Message-State: AGi0PuYEr2oNwiyuSWHvuH4YUdtnSxUPqPlFnaioH/6zG8dRixDeXViT
        x0bTeUCCziBNLHKBHIoKQDA=
X-Google-Smtp-Source: APiQypLdIo/scdmlnXQU8+xmAd9MPX1Y3Ge+IoyHgxiHJ63Kqrvu9KzFgSvX+jrxheFMfmNuxlY2Yw==
X-Received: by 2002:a17:90a:1acd:: with SMTP id p71mr2967114pjp.112.1585719538371;
        Tue, 31 Mar 2020 22:38:58 -0700 (PDT)
Received: from nickserv.localdomain (c-67-188-225-242.hsd1.ca.comcast.net. [67.188.225.242])
        by smtp.gmail.com with ESMTPSA id w69sm683077pfc.52.2020.03.31.22.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 22:38:57 -0700 (PDT)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
        linux-kbuild@vger.kernel.org, x86@kernel.org,
        gregkh@linuxfoundation.org, Petr Malat <oss@malat.biz>,
        Kees Cook <keescook@chromium.org>,
        Kernel Team <Kernel-team@fb.com>,
        Nick Terrell <nickrterrell@gmail.com>,
        Adam Borowski <kilobyte@angband.pl>,
        Patrick Williams <patrickw3@fb.com>, rmikey@fb.com,
        mingo@kernel.org, Patrick Williams <patrick@stwcx.xyz>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH v4 6/8] x86: bump ZO_z_extra_bytes margin for zstd
Date:   Tue, 31 Mar 2020 22:39:11 -0700
Message-Id: <20200401053913.216783-7-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401053913.216783-1-nickrterrell@gmail.com>
References: <20200401053913.216783-1-nickrterrell@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Terrell <terrelln@fb.com>

Bump the ZO_z_extra_bytes margin for zstd.

Zstd needs 3 bytes per 128 KB, and has a 22 byte fixed overhead.
Zstd needs to maintain 128 KB of space at all times, since that is
the maximum block size. See the comments regarding in-place
decompression added in lib/decompress_unzstd.c for details.

Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Nick Terrell <terrelln@fb.com>
---
 arch/x86/boot/header.S | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/header.S b/arch/x86/boot/header.S
index 97d9b6d6c1af..b820875c5c95 100644
--- a/arch/x86/boot/header.S
+++ b/arch/x86/boot/header.S
@@ -536,8 +536,14 @@ pref_address:		.quad LOAD_PHYSICAL_ADDR	# preferred load addr
 # the size-dependent part now grows so fast.
 #
 # extra_bytes = (uncompressed_size >> 8) + 65536
+#
+# ZSTD compressed data grows by at most 3 bytes per 128K, and only has a 22
+# byte fixed overhead but has a maximum block size of 128K, so it needs a
+# larger margin.
+#
+# extra_bytes = (uncompressed_size >> 8) + 131072
 
-#define ZO_z_extra_bytes	((ZO_z_output_len >> 8) + 65536)
+#define ZO_z_extra_bytes	((ZO_z_output_len >> 8) + 131072)
 #if ZO_z_output_len > ZO_z_input_len
 # define ZO_z_extract_offset	(ZO_z_output_len + ZO_z_extra_bytes - \
 				 ZO_z_input_len)
-- 
2.26.0

