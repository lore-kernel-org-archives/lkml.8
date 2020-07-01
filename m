Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CB3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C359120702
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:47:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Igf8FH8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730725AbgGAMrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730680AbgGAMrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:47:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D93AC03E97B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 05:47:24 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so23600909wrj.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/gJoWFYQiS/u+V7Ey4cmwChdFCLsRE9Rx9263Z1oots=;
        b=Igf8FH8P6hdkKsVgk8CXs7RoyZeMUEAvTEJYQNZTp+t1LZgNAkLAKn1BdcIPG5ZX+l
         rscNT7GY/DyCGgRlpTTWOdkLo4LYCl5AlyBQlbjLGBfXsj67ylvJikQahonpLj2+TQha
         uGBfi+wjKp90MOfhsiMWYRykE3LoUQTwgn6t/1qoYt3cyVOAexgadrj38SqB/FGtO1gQ
         QoQcTgXLOTl8lEbQsPCii0mmEt4TA4/XesunG6isjLxX+Zwy2Y4t4fkNu8Nky1qAxPK7
         BJZG7JB8EMZX6mj1Wi0VDor+x6Cg/whhx+TytTWoqbboaEQAa91Ca+0mUl4Dapdbwzu0
         Tj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/gJoWFYQiS/u+V7Ey4cmwChdFCLsRE9Rx9263Z1oots=;
        b=oiSKHVIhuaXmF45PUN9X+YO7mLND8zATw4VZSjon+LuxzgVlP8Jz1Ul8Q18OUWQr4c
         6O5RqMvmJacuQfHWzYND6kXaBqZxA4ulkBMzjdhkDbaBxHskfTEUQrbatxQMhdYJ+H2O
         XAsgEHYCk7kPySpvOyA91AQpvNt4mK2cAGbbA2DPIc4C3vseLBxYFvTDlDHo5fDCQOzM
         5V45xNd1z4LNPOANre7ogfWjSeKlNIFFomMhkhxolGcJBRPoFPUb09HTbqZaimtFFQi2
         I0T5Ge8Aj4MLZBpYTJAVus/DOxoqA35cHijqaVUi4OuANICLiDvBjRwoezX3s6atb7Lc
         uraA==
X-Gm-Message-State: AOAM533PVb8jy9RjLYxqok6VopeHgPtwSbEW3tym69EApZyBYjA0pDzu
        fMgjma9FyWMR4xzrV4IsAD2SeA==
X-Google-Smtp-Source: ABdhPJxRDPkGlJlU4XJGQ/sleeyke1ZZuspWu101J6VUjlcK6F+a1bbhWf8+qWg+jb+I/TlCTyJOJA==
X-Received: by 2002:a5d:6846:: with SMTP id o6mr26809049wrw.370.1593607643127;
        Wed, 01 Jul 2020 05:47:23 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id o29sm7817862wra.5.2020.07.01.05.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 05:47:22 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>
Subject: [PATCH 14/15] mmc: host: cqhci: Demote faux kerneldoc header down to basic comment block
Date:   Wed,  1 Jul 2020 13:47:01 +0100
Message-Id: <20200701124702.908713-15-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701124702.908713-1-lee.jones@linaro.org>
References: <20200701124702.908713-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cqhci_host_alloc_tdl()'s function header is the only one in
kerneldoc format.  Which seems odd as it's not part of an
external API and isn't referenced anywhere else.  Seeing as
there has also been no attempt to describe the expected
function arguments either, we're going to assume that this is
not actually a bona fide kerneldoc use-case.

Fixes the following W=1 kernel build warning:

 drivers/mmc/host/cqhci.c:163: warning: Function parameter or member 'cq_host' not described in 'cqhci_host_alloc_tdl'

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ritesh Harjani <riteshh@codeaurora.org>
Cc: Asutosh Das <asutoshd@codeaurora.org>
Cc: Venkat Gopalakrishnan <venkatg@codeaurora.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mmc/host/cqhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index 75934f3c117eb..8cc277b4ffe9e 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -144,7 +144,7 @@ static void cqhci_dumpregs(struct cqhci_host *cq_host)
 		CQHCI_DUMP(": ===========================================\n");
 }
 
-/**
+/*
  * The allocated descriptor table for task, link & transfer descritors
  * looks like:
  * |----------|
-- 
2.25.1

