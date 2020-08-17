Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B410C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 676F7206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597684471;
	bh=yH+DAPdtU3IVv54d4VVXWRQgzC7pzyB7IRbaGehowlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hy+R/SolcopfebKNynnohTndF8WZyajSYbzkPlXd7kUaJI2U+9eZSnGSFWcAu3xo7
	 rcDCnKjLgcdwqBDbwYHmFlsYAX91NmaJIP9vTQgF8I4T+oe9pNhRQ3ribAJ2Tj+p/C
	 DsSTzZZa0RBxZLSb2Yyed+hwUimyVCh72yI7efAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389510AbgHQRNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:42256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388669AbgHQQMJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:12:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47BE720760;
        Mon, 17 Aug 2020 16:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680729;
        bh=yH+DAPdtU3IVv54d4VVXWRQgzC7pzyB7IRbaGehowlw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QWjaQVeCNEMeRuH2m0hUozb+MCmUVocsAXNRKHDP9cH9zJ4cUpNsIccAp4R/caG3E
         p7dnpJztfEYKQSb2PhcMxyMiJT9jngb2YPRYgL4remMNow5x45/Sm+3wLPN5PwhU5i
         KRYkY4PyW8ttJtlcCQwP6Bpq0smU7WUdwVocg3NY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhenzhong Duan <zhenzhong.duan@gmail.com>,
        Borislav Petkov <bp@suse.de>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 004/168] x86/mce/inject: Fix a wrong assignment of i_mce.status
Date:   Mon, 17 Aug 2020 17:15:35 +0200
Message-Id: <20200817143733.928530433@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143733.692105228@linuxfoundation.org>
References: <20200817143733.692105228@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenzhong Duan <zhenzhong.duan@gmail.com>

[ Upstream commit 5d7f7d1d5e01c22894dee7c9c9266500478dca99 ]

The original code is a nop as i_mce.status is or'ed with part of itself,
fix it.

Fixes: a1300e505297 ("x86/ras/mce_amd_inj: Trigger deferred and thresholding errors interrupts")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Yazen Ghannam <yazen.ghannam@amd.com>
Link: https://lkml.kernel.org/r/20200611023238.3830-1-zhenzhong.duan@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/mcheck/mce-inject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mcheck/mce-inject.c b/arch/x86/kernel/cpu/mcheck/mce-inject.c
index 1ceccc4a5472c..9cc524be3c949 100644
--- a/arch/x86/kernel/cpu/mcheck/mce-inject.c
+++ b/arch/x86/kernel/cpu/mcheck/mce-inject.c
@@ -518,7 +518,7 @@ static void do_inject(void)
 	 */
 	if (inj_type == DFR_INT_INJ) {
 		i_mce.status |= MCI_STATUS_DEFERRED;
-		i_mce.status |= (i_mce.status & ~MCI_STATUS_UC);
+		i_mce.status &= ~MCI_STATUS_UC;
 	}
 
 	/*
-- 
2.25.1



