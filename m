Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFB2C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CD50222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581607605;
	bh=p+lZsTl40XZIe1QI/pgvsj5qXEmMVhKP7TvLVH8ZpJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l0d9wN45h8kmE/NYvK6Enap/TTl1/RJI6u6mB43vIKmS30oQ5Uk9sb20UdmIRRmo7
	 8jsR2wBg/aE56AMvJ7EL15xjYrJXT3v38hl1V2oJTxVCKAfmsCQ9ueKt9caq29YRMo
	 /b+R1a3VsYn9I245xJbqFaxI+Re/DPCrlTqCaZrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgBMP0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:26:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:39674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727936AbgBMPY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:24:59 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76F4424689;
        Thu, 13 Feb 2020 15:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607498;
        bh=p+lZsTl40XZIe1QI/pgvsj5qXEmMVhKP7TvLVH8ZpJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GkA2en3uXR+g4OPUJ+RBkEVfOr1pH9qVFHzTs0Tqw05auuOFfDZQGajkC2lMgh796
         TDP+wyYoqGrwbHlKoa7NJGUp0IFyEcsqI2IBv6eHzEE/i729PDTLrhVOVR/Av+1X0h
         h1AGXLC1vDcU5sldLRm/lZJJWIV9Wbnhzt0W99eo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sukadev Bhattiprolu <sukadev@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 034/173] powerpc/xmon: dont access ASDR in VMs
Date:   Thu, 13 Feb 2020 07:18:57 -0800
Message-Id: <20200213151942.203062597@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151931.677980430@linuxfoundation.org>
References: <20200213151931.677980430@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sukadev Bhattiprolu <sukadev@linux.ibm.com>

commit c2a20711fc181e7f22ee5c16c28cb9578af84729 upstream.

ASDR is HV-privileged and must only be accessed in HV-mode.
Fixes a Program Check (0x700) when xmon in a VM dumps SPRs.

Fixes: d1e1b351f50f ("powerpc/xmon: Add ISA v3.0 SPRs to SPR dump")
Cc: stable@vger.kernel.org # v4.14+
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.ibm.com>
Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200107021633.GB29843@us.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/xmon/xmon.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1830,15 +1830,14 @@ static void dump_300_sprs(void)
 
 	printf("pidr   = %.16lx  tidr  = %.16lx\n",
 		mfspr(SPRN_PID), mfspr(SPRN_TIDR));
-	printf("asdr   = %.16lx  psscr = %.16lx\n",
-		mfspr(SPRN_ASDR), hv ? mfspr(SPRN_PSSCR)
-					: mfspr(SPRN_PSSCR_PR));
+	printf("psscr  = %.16lx\n",
+		hv ? mfspr(SPRN_PSSCR) : mfspr(SPRN_PSSCR_PR));
 
 	if (!hv)
 		return;
 
-	printf("ptcr   = %.16lx\n",
-		mfspr(SPRN_PTCR));
+	printf("ptcr   = %.16lx  asdr  = %.16lx\n",
+		mfspr(SPRN_PTCR), mfspr(SPRN_ASDR));
 #endif
 }
 


