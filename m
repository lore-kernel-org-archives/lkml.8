Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50344C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9E9206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584623773;
	bh=BHl61XVaYiiLrL3vc3daOyenv1prkPnf9dqKV9w6+nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tqzjU08yjtPDJg4bnVzNG3ij6UdN6vf8QzgeVY/fv9AaXhKegNKl6cL7QzNnMOb81
	 E1gmGPMw2KqyvmyWMklz7ykYpKet8f/9pDwEYcj45XjrkbdHoGnHM5mm6YMSFDP+Sg
	 +V+ORh2T50BQN3i6TifUIp/uuwAUCIetKI9VCASQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbgCSNQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:16:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729483AbgCSNQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:16:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E6ED21556;
        Thu, 19 Mar 2020 13:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584623769;
        bh=BHl61XVaYiiLrL3vc3daOyenv1prkPnf9dqKV9w6+nc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a1AC4md+KPb57nEWofEr6ozcOiKT9mlae3dyIgskrlUR1IOgReognaGolAVw6cPYM
         SJnodjuY8mOIOhJiITY1Qc3Do8LdFAlrBAxAMaIhsvXw9Yvj3M6yu0caHZYqtT2ESv
         Z/UKFWvlDZnCDVAfapyKcF10cZFcIdN1TAf/IHKk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 4.14 48/99] ARC: define __ALIGN_STR and __ALIGN symbols for ARC
Date:   Thu, 19 Mar 2020 14:03:26 +0100
Message-Id: <20200319123956.481702270@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200319123941.630731708@linuxfoundation.org>
References: <20200319123941.630731708@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>

commit 8d92e992a785f35d23f845206cf8c6cafbc264e0 upstream.

The default defintions use fill pattern 0x90 for padding which for ARC
generates unintended "ldh_s r12,[r0,0x20]" corresponding to opcode 0x9090

So use ".align 4" which insert a "nop_s" instruction instead.

Cc: stable@vger.kernel.org
Acked-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arc/include/asm/linkage.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arc/include/asm/linkage.h
+++ b/arch/arc/include/asm/linkage.h
@@ -14,6 +14,8 @@
 #ifdef __ASSEMBLY__
 
 #define ASM_NL		 `	/* use '`' to mark new line in macro */
+#define __ALIGN		.align 4
+#define __ALIGN_STR	__stringify(__ALIGN)
 
 /* annotation for data we want in DCCM - if enabled in .config */
 .macro ARCFP_DATA nm


