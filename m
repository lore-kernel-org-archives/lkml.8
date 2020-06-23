Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97B2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5CEA20780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943677;
	bh=O2h0e8JJhnmRHw5WGM8kWa8g3uMbgKgok/1Vm7zBQzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iaWhmdisGrQlHsoIczeCSFFWdIx3SNZN/4Fbgbogt8WHJVx878hERKCLz3XuLHTmf
	 tfm1Yyvde05L70J3Dh2WgWatniVBRibg2yJ31PMM4tSJHkIaaQ30ieLizUS3PS91NU
	 ZUoP85osslthvNO+4vEsX91xeb075O30unmD8vW0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389760AbgFWUVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:21:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:38742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387771AbgFWUVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:21:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46ECE214DB;
        Tue, 23 Jun 2020 20:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943667;
        bh=O2h0e8JJhnmRHw5WGM8kWa8g3uMbgKgok/1Vm7zBQzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SORxt+ClBWltCSnofoJ2Gzh0B0yMJwDMc+VCYNToAV4woruqdLkjB+VSKK2TfgKlN
         fd8RR46dReLwwg9C2/X6uLdGNh8Je/YWDtr4O+8Z3XsBZ10VPuHVkJ2UvrMn9gSVIq
         HfVSZcmK3tzwBuVx9yuxeigCLZDXvl1CThXw4eno=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Zigotzky <chzigotzky@xenosoft.de>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.7 473/477] powerpc/64s: Fix KVM interrupt using wrong save area
Date:   Tue, 23 Jun 2020 21:57:50 +0200
Message-Id: <20200623195429.907596158@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

commit 0bdcfa182506526fbe4e088ff9ca86a31b81828d upstream.

The CTR register reload in the KVM interrupt path used the wrong save
area for SLB (and NMI) interrupts.

Fixes: 9600f261acaa ("powerpc/64s/exception: Move KVM test to common code")
Cc: stable@vger.kernel.org # v5.7+
Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200615061247.1310763-1-npiggin@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/exceptions-64s.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -270,7 +270,7 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 	.endif
 
-	ld	r10,PACA_EXGEN+EX_CTR(r13)
+	ld	r10,IAREA+EX_CTR(r13)
 	mtctr	r10
 BEGIN_FTR_SECTION
 	ld	r10,IAREA+EX_PPR(r13)
@@ -298,7 +298,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 
 	.if IKVM_SKIP
 89:	mtocrf	0x80,r9
-	ld	r10,PACA_EXGEN+EX_CTR(r13)
+	ld	r10,IAREA+EX_CTR(r13)
 	mtctr	r10
 	ld	r9,IAREA+EX_R9(r13)
 	ld	r10,IAREA+EX_R10(r13)


