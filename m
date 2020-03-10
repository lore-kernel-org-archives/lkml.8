Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DA0C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8DB24698
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844210;
	bh=h7q2nI/axaClZyGnKqmaJHLV5ikhS1D/BVJY9Jv/du4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=L1SEmEppVUbPJxYjh7twTLpfY5DTeZGkHAoRtpfo7BVeZURgW/HEIzseWqalD4tHn
	 nuBXFAymJ1W2MRzjoxbCQloJ4mz7vvmAoIFj3CjAnSIX58BrcRcjocOARUA1w7/iDj
	 B2Q7a2mhXwPmLbU3k+dXgsocP8b6OfYGLe0DQsLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgCJMn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:43:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:43778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727533AbgCJMn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:43:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9F5A24693;
        Tue, 10 Mar 2020 12:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844205;
        bh=h7q2nI/axaClZyGnKqmaJHLV5ikhS1D/BVJY9Jv/du4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a0fSpvapWcjMjr524lZQq0Yu7z+Jqg9Yfuc43kmCQUYYhZkZoHz2STz+XLs/m059W
         dLHDtMAZD/3mgRu0QbJPZFgECdiagOUAJN/0il0rE6D40xMMWXn6AUZKwFmNePgcuE
         DlETPi6BIT2aalCHVubuvRfvDx/C2VPqAPBlMw4k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Desnes A. Nunes do Rosario" <desnesn@linux.ibm.com>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.4 70/72] powerpc: fix hardware PMU exception bug on PowerVM compatibility mode systems
Date:   Tue, 10 Mar 2020 13:39:23 +0100
Message-Id: <20200310123618.939602353@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123601.053680753@linuxfoundation.org>
References: <20200310123601.053680753@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Desnes A. Nunes do Rosario <desnesn@linux.ibm.com>

commit fc37a1632d40c80c067eb1bc235139f5867a2667 upstream.

PowerVM systems running compatibility mode on a few Power8 revisions are
still vulnerable to the hardware defect that loses PMU exceptions arriving
prior to a context switch.

The software fix for this issue is enabled through the CPU_FTR_PMAO_BUG
cpu_feature bit, nevertheless this bit also needs to be set for PowerVM
compatibility mode systems.

Fixes: 68f2f0d431d9ea4 ("powerpc: Add a cpu feature CPU_FTR_PMAO_BUG")
Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.ibm.com>
Reviewed-by: Leonardo Bras <leonardo@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200227134715.9715-1-desnesn@linux.ibm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/cputable.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -2147,11 +2147,13 @@ static struct cpu_spec * __init setup_cp
 		 * oprofile_cpu_type already has a value, then we are
 		 * possibly overriding a real PVR with a logical one,
 		 * and, in that case, keep the current value for
-		 * oprofile_cpu_type.
+		 * oprofile_cpu_type. Futhermore, let's ensure that the
+		 * fix for the PMAO bug is enabled on compatibility mode.
 		 */
 		if (old.oprofile_cpu_type != NULL) {
 			t->oprofile_cpu_type = old.oprofile_cpu_type;
 			t->oprofile_type = old.oprofile_type;
+			t->cpu_features |= old.cpu_features & CPU_FTR_PMAO_BUG;
 		}
 	}
 


