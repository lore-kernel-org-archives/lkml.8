Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B077C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E13D520781
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="cPFe1UFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbgGBCyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 22:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgGBCyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 22:54:49 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E031C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 19:54:49 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g67so11836261pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 19:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s2vaNiCstBIb+WWFV0QIyynMgzg46gv0imUofC6H27w=;
        b=cPFe1UFuVB5bSAqO8gzT0dcmEzl5dr+yPN/2vTgkw6gJ0x+9PbjI4KodzysL8Sq22w
         hUrQJeIHBpG3h8MYz3SiC41U7Ar/kzpMy7Q2lyibqJ472GyP77xLN6lU2TtbEKrg4LwQ
         aSU522rlTzkc6mfecJMBcMWQ9/2N1ry6XdjV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s2vaNiCstBIb+WWFV0QIyynMgzg46gv0imUofC6H27w=;
        b=U28MLqu8WqKrHDLhTXyUD628I1CrctzotkNmw2q1ppKv+AO06ou3ejfctKSe4IDn7Z
         G77TIhr1FsVouvu44py1l6/lfJXykm5vL3ZRsg88GI7PCofx1EpaD4Acaj3YqwOgOR5B
         PCmSdk2dbCzYMz7X0pN7CRx9fVOU5FsVTKihX1OQeYVX5TfhEMfUMwgIrAUTHUIl+JLt
         AhWB7nLkFanpFuRTvse25IteJOLSoj2hfyGndhlW+h5DRNIrjaeJix3rfKOBM0FIOhbU
         Ahut7v04hE6V0m5/1oJPUROC9mfQzBiP93aFV9udKG6F7VVG3pE70xxKxQlwc5CNdY33
         xWRQ==
X-Gm-Message-State: AOAM531QgLER0vEu77XFyUH/xofXG1ezWtyPxNiiaa2Xt/svv+soea35
        2/Ky+VecdEAvA5ODPTZVGO97HwtuEM8=
X-Google-Smtp-Source: ABdhPJyXmFA8fucYvwuXRwDdGknORYIojGHyP9C/hmb1sbVz/1EdQsOerDFGeamE2e8WgmO0U7NMKA==
X-Received: by 2002:a63:8f58:: with SMTP id r24mr21924594pgn.379.1593658488570;
        Wed, 01 Jul 2020 19:54:48 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-3c80-6152-10ca-83bc.static.ipv6.internode.on.net. [2001:44b8:1113:6700:3c80:6152:10ca:83bc])
        by smtp.gmail.com with ESMTPSA id c19sm6198267pjs.11.2020.07.01.19.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 19:54:48 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v8 3/4] powerpc/mm/kasan: rename kasan_init_32.c to init_32.c
Date:   Thu,  2 Jul 2020 12:54:31 +1000
Message-Id: <20200702025432.16912-4-dja@axtens.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702025432.16912-1-dja@axtens.net>
References: <20200702025432.16912-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kasan is already implied by the directory name, we don't need to
repeat it.

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 arch/powerpc/mm/kasan/Makefile                       | 2 +-
 arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/powerpc/mm/kasan/{kasan_init_32.c => init_32.c} (100%)

diff --git a/arch/powerpc/mm/kasan/Makefile b/arch/powerpc/mm/kasan/Makefile
index bb1a5408b86b..42fb628a44fd 100644
--- a/arch/powerpc/mm/kasan/Makefile
+++ b/arch/powerpc/mm/kasan/Makefile
@@ -2,6 +2,6 @@
 
 KASAN_SANITIZE := n
 
-obj-$(CONFIG_PPC32)           += kasan_init_32.o
+obj-$(CONFIG_PPC32)           += init_32.o
 obj-$(CONFIG_PPC_8xx)		+= 8xx.o
 obj-$(CONFIG_PPC_BOOK3S_32)	+= book3s_32.o
diff --git a/arch/powerpc/mm/kasan/kasan_init_32.c b/arch/powerpc/mm/kasan/init_32.c
similarity index 100%
rename from arch/powerpc/mm/kasan/kasan_init_32.c
rename to arch/powerpc/mm/kasan/init_32.c
-- 
2.25.1

