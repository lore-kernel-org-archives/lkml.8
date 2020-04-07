Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85820C2BB54
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C2A2074F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 10:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586255224;
	bh=P7iouULCpIAHpWLOd6Wjrgm7dXrqA8tQoL3jEOu3ql4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oLcm8V4x2+CGvN7gL3HytqRlFydT7RYeXamFF2J0Gkw50f8qcFKGSos+6JVZFFQJD
	 kIuIDFvqeS/Fv0NXyzmyzlea+tFeHdC9w24fH+gNKhsko/XsuBECkN8X09AtGs0V5J
	 KbJK13aU73zHgDxW/bGLAONAODQxPUyPeI3uK9pI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729274AbgDGK1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 06:27:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729256AbgDGK1B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:27:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C53E20644;
        Tue,  7 Apr 2020 10:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586255219;
        bh=P7iouULCpIAHpWLOd6Wjrgm7dXrqA8tQoL3jEOu3ql4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JIh2c307cG7sLRuJmaQVWfsXuS9mdJripg8tX7hDuqujFtYenes7bG8DsM7MQuiKW
         wS9++TRMhr/niLKy/vbpwDcAlWc2MdcW6dqXW9qQ4yyLaEFP0aga7zjVpUU2KkAiPj
         6tK176Tzw7hWdBnJgVG9CH0hUs3uobRPTHYUroVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-crypto@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 09/29] padata: fix uninitialized return value in padata_replace()
Date:   Tue,  7 Apr 2020 12:22:06 +0200
Message-Id: <20200407101453.138259293@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200407101452.046058399@linuxfoundation.org>
References: <20200407101452.046058399@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Jordan <daniel.m.jordan@oracle.com>

[ Upstream commit 41ccdbfd5427bbbf3ed58b16750113b38fad1780 ]

According to Geert's report[0],

  kernel/padata.c: warning: 'err' may be used uninitialized in this
    function [-Wuninitialized]:  => 539:2

Warning is seen only with older compilers on certain archs.  The
runtime effect is potentially returning garbage down the stack when
padata's cpumasks are modified before any pcrypt requests have run.

Simplest fix is to initialize err to the success value.

[0] http://lkml.kernel.org/r/20200210135506.11536-1-geert@linux-m68k.org

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: bbefa1dd6a6d ("crypto: pcrypt - Avoid deadlock by using per-instance padata queues")
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Steffen Klassert <steffen.klassert@secunet.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/padata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index 72777c10bb9cb..62082597d4a2a 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -512,7 +512,7 @@ static int padata_replace_one(struct padata_shell *ps)
 static int padata_replace(struct padata_instance *pinst)
 {
 	struct padata_shell *ps;
-	int err;
+	int err = 0;
 
 	pinst->flags |= PADATA_RESET;
 
-- 
2.20.1



