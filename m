Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC97C433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3380E20757
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5DdQKC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgH2OoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 10:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728115AbgH2OoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 10:44:00 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25699C061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 07:43:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id w5so1804942wrp.8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 07:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=DsPODKGYVLxFWp0yiaIHymrD/OLGDuL8C21rGLs9G9Q=;
        b=I5DdQKC7HKq0w8zSfSnleE6N7L0xlgj3r97SfzWWgUBObLyxln8+ZE2HR9TtlWv8QM
         z6GBqGgLldoau2L4HLmXR7WKp2VV54RNkFEGP4QUkEfBPdFjMeX9NQr96gwXtKzYfaV1
         9obwauAB/rECI406SkgB09Vv/sXJymT9WwJtPpe+lrUjfUvKhREn9nLIE9YuGut63t2t
         wZtpQ4tupfiC0sued9XRllaQSQgBmiyLbkF2Dr0xulj1Jy834rBrV4E2/l2/cegaxGye
         w38vZvOV3VREqFl33F6giR9uv82A0jKZ0wxqSq7r752DpnGkWrtLa6IQP5FeJHgHi+28
         04tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=DsPODKGYVLxFWp0yiaIHymrD/OLGDuL8C21rGLs9G9Q=;
        b=KdF7UQuancU2ZLPyMYofoh/4v72hVs4WBUzzdkF+2LP4pMLEGc8Ek1S9EliRAdThAA
         lWe5Vyj0hgIlhuZ6mNbidBcE+keffb0eH748mr8kAyBQ5F3hJ36SLijqwulEMX985zMA
         kIRdE3pIF65P+GnQzyLhYvQyKReXWNvOpWQrbhXmshPe+aDJy/R3sajZxJ6g9fX1i4D3
         DA5dgqhs9UViBbEyz5G9Rflnbj78XF4oZZvOq8ZPas+PxT3WSuBuegP+qUQO5IfBe+d1
         qG4uE7oHMkeR4Rmwk0Wdn+OJ5Mt2qalXABO4QBCa/pcBQfhYC9Fptc2gYryR5Lx7dlEP
         ZO+w==
X-Gm-Message-State: AOAM530kS/LMd078AaGGSMXumvlOz99Mwxd01+Yituk7P+bQ14krvImx
        cJhd5ZGX+ZXfFGnSRgWBx9aVn/zT/Ck=
X-Google-Smtp-Source: ABdhPJwjmRbCS4nMT0L2ZW8FA057xs94cdlh5bMHqUhV0EVvOBmcYfombVEZt6lkr4i6mbOvhKsc3Q==
X-Received: by 2002:a5d:5651:: with SMTP id j17mr4207247wrw.149.1598712237217;
        Sat, 29 Aug 2020 07:43:57 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id a11sm4066588wrq.0.2020.08.29.07.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 07:43:55 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH 2/3] habanalabs: clear vm_pgoff before doing the mmap
Date:   Sat, 29 Aug 2020 17:43:51 +0300
Message-Id: <20200829144352.17171-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829144352.17171-1-oded.gabbay@gmail.com>
References: <20200829144352.17171-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver use vm_pgoff to hold the CB idr handle. Before we actually call
the mapping function, we need to clear the handle so there won't be any
garbage left in vm_pgoff.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/command_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index 68dfbafe3354..6563e4dfe7b6 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -304,7 +304,11 @@ int hl_cb_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
 	u32 handle, user_cb_size;
 	int rc;
 
+	/* We use the page offset to hold the idr and thus we need to clear
+	 * it before doing the mmap itself
+	 */
 	handle = vma->vm_pgoff;
+	vma->vm_pgoff = 0;
 
 	/* reference was taken here */
 	cb = hl_cb_get(hdev, &hpriv->cb_mgr, handle);
-- 
2.17.1

