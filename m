Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2899CC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00C782076A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099175;
	bh=9k/FokKsItlcC8TX5V0v7MIKCzs80FLIquJdVEOPSF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fJgeq84J6cspbOSCBRJ8E/J/giTIFgJZQwAWAK7lfwd/21I9DFH7OlyN/PEFm9e1c
	 IhiSAVl+jYJi9MIZllTx6wpUmEpmd2AwG5TyojAslER+Hc88gEMIRtuF8n7fLLwMs9
	 iLSe3Yu17yGjyICqtHrYeFiRb40cMvxGinAeparA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730738AbgD1Sje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:39:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730866AbgD1Sja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:39:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D058E2076A;
        Tue, 28 Apr 2020 18:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099170;
        bh=9k/FokKsItlcC8TX5V0v7MIKCzs80FLIquJdVEOPSF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UsBGJsHW8TV3eTlVCat7qbGDqGphtNw4QQePidLlzNWVdx9S3WDH7TVlQw5gWMLZM
         TZXtBw6qkEagh14iiinZG9KwQ8XL43sSXNOZ3GebGw0WgVHvTvP18nL5+ZiByUURaR
         Ke0OYQsAESz8QqEzsQJYpOWM6znDkinu3+AeK5wc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 5.6 165/167] powerpc/kuap: PPC_KUAP_DEBUG should depend on PPC_KUAP
Date:   Tue, 28 Apr 2020 20:25:41 +0200
Message-Id: <20200428182246.485806480@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182225.451225420@linuxfoundation.org>
References: <20200428182225.451225420@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Ellerman <mpe@ellerman.id.au>

commit 61da50b76b62fd815aa82d853bf82bf4f69568f5 upstream.

Currently you can enable PPC_KUAP_DEBUG when PPC_KUAP is disabled,
even though the former has not effect without the latter.

Fix it so that PPC_KUAP_DEBUG can only be enabled when PPC_KUAP is
enabled, not when the platform could support KUAP (PPC_HAVE_KUAP).

Fixes: 890274c2dc4c ("powerpc/64s: Implement KUAP for Radix MMU")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200301111738.22497-1-mpe@ellerman.id.au
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/Kconfig.cputype |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -397,7 +397,7 @@ config PPC_KUAP
 
 config PPC_KUAP_DEBUG
 	bool "Extra debugging for Kernel Userspace Access Protection"
-	depends on PPC_HAVE_KUAP && (PPC_RADIX_MMU || PPC_32)
+	depends on PPC_KUAP && (PPC_RADIX_MMU || PPC_32)
 	help
 	  Add extra debugging for Kernel Userspace Access Protection (KUAP)
 	  If you're unsure, say N.


