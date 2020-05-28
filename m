Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ACE2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47511207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 06:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="nSGbYcCu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgE1GlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 02:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgE1GlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 02:41:09 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E78C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:41:09 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id bg4so5814548plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 23:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JyymQUzxXUDUGDiP40j+IBmm1X5EOZ7V5M3pcfRs+Ww=;
        b=nSGbYcCuCPGVWjqWOVHQqHC7PCTc5ij0fPoq6BySG33lzDVIrRf1JPtcQIa/ivVNc9
         LNp4JStadItLWo3DkG7jtSC8S4UfDUs7Z3/FcsGVWV6j8G1HzAqO/e8E3luqMzTTBlqF
         xBwpRvvb+ZhCShoKJSNdQ06b+DZ2dTa2xGwpsrE9qGZkW1Dpa3XXHGFKnlocpHRhQB3d
         H+7baFMj3qh3tysiWMmi0SEYWLjDjy0C2hNDiC5EEwJ1DZrdS0o+0FU2eb3nVTsbjD88
         j3KIPwQtNZWYO2prsVyg73MITSout1wEnd2r6jdyIOMS6FL1QEdKlp3LmdPegSnl2tNg
         /fuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JyymQUzxXUDUGDiP40j+IBmm1X5EOZ7V5M3pcfRs+Ww=;
        b=h7MdGDWoVcZQls6/c1xCBesrIvYaxU+Er9gF5lYX5sWTwS8YDrs9nzvXRt8yIbXy5W
         pgW6yWseDlnlOCC78S/Y9ppiCeZT/HxgtAc3LGV2bizAC4p1bgo0rogt3jA3esAGx9O4
         QeoU8wTjtMX6d176BTOL8Hf5ZD2UNlDqfYRRfQDIZzz+5gvuIkdtNBBKcY75raSLtFXm
         epxRb95zYILLxKyVb8YdpWrmr2fZnb1LT8Slavr635ETG27gnhjhb6kVVDIZAtzh9vxn
         BIzGdFCN5+Fht6q8twSmN79aAlLXIPpilBeQYE1GAnRjIimV1dFphydcE7p2XpOBLS4D
         ViMQ==
X-Gm-Message-State: AOAM530X/tYKqxOZIY2N3fatWfc/f8J7OMrbf/1gSaLETzCIh+JblAcF
        F6f0DAGF65+HL8wrKZYxuSnn1g==
X-Google-Smtp-Source: ABdhPJyEpNcQ/jhi+ZpBBDbNNGSgjR2nPmE8d9un/VQNilVdrTBX0PbZyELaHSNRxRHNtd7DAiBUrA==
X-Received: by 2002:a17:90a:ac0a:: with SMTP id o10mr2080869pjq.79.1590648068965;
        Wed, 27 May 2020 23:41:08 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id q29sm3773366pfg.79.2020.05.27.23.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 23:41:08 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     greentime.hu@sifive.com, guoren@linux.alibaba.com,
        vincent.chen@sifive.com, paul.walmsley@sifive.com,
        palmerdabbelt@google.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com
Subject: [RFC PATCH v5 01/13] ptrace: Use regset_size() for dynamic regset
Date:   Thu, 28 May 2020 14:40:49 +0800
Message-Id: <e490cf0a1b57b7cb34a5ea1252e7a71109d6ffee.1590646208.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1590646208.git.greentime.hu@sifive.com>
References: <cover.1590646208.git.greentime.hu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch uses regset_size() instead of using regset->n and regset->size
directly. In this case, it will call the get_size() ported by arch
dynamically to support dynamic regset size case.

Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
---
 kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 43d6179508d6..946b2c4ec4fa 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -888,7 +888,7 @@ static int ptrace_regset(struct task_struct *task, int req, unsigned int type,
 
 	regset_no = regset - view->regsets;
 	kiov->iov_len = min(kiov->iov_len,
-			    (__kernel_size_t) (regset->n * regset->size));
+			    (__kernel_size_t) regset_size(task, regset));
 
 	if (req == PTRACE_GETREGSET)
 		return copy_regset_to_user(task, view, regset_no, 0,
-- 
2.26.2

