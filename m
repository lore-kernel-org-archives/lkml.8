Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80565C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E2D322242
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nYkexzPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437654AbgDPPA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388235AbgDPPAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:00:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993F1C061A0C;
        Thu, 16 Apr 2020 08:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=uYntwwOxHl+eWmrggy0D1lZ6buzvACNOsmvvl0lx4SM=; b=nYkexzPURS/EEaBQzLNs6ZJPtY
        iXXeif5/EFTvuipZKQz0BouVV3czxminJPIipTRWE+1tuUi/189SxUUAIXh+sMh1wE/AMHQuQhCLa
        wFYwxEplgeD16FEvzoPHa6ClGQ9ZK/lcHBr/wKiIYTFTwBYcbWmyCjfA5wAEpmDx1hjBN4Ke48VTI
        FVSQ48dRRq+fZWRGREvz+o/oEt4q2IrPWYh1DLPvCBPJb6QlCzuSz7qQojJXH6J7j6sucJumsagVP
        9EFeSRjp/5S4kgcB43Q9ag7iqI2D9LhbhvheItZ9PTRz6xXRXnZFT6OUTM6P3MZ8wTGzfngQoVLhQ
        tywJXWRA==;
Received: from [2001:4bb8:184:4aa1:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP5zx-0001nv-Jg; Thu, 16 Apr 2020 15:00:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: MIPS ioremap cleanups v2
Date:   Thu, 16 Apr 2020 17:00:04 +0200
Message-Id: <20200416150011.820984-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

below is a bunch of cleanups for the MIPS ioremap code.  Compile tested
only.

Changes since v1:
 - don't remove cpu_has_64bit_gp_regs
 - add a new prep patch to stop txx9aclc-ac97 from poking into ioremap
   internals
