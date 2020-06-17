Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF2FBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7B5720853
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GZwm92pS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgFQHiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgFQHh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:37:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A635C061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 00:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=b39CAYhwMpo9sgm7/c6psQNhGg1FitCwBRySVYcVQvc=; b=GZwm92pSh89KT6htczdPpVbVFr
        ENIYetaesVvI5DGpt+YQB5k4WNYJ8csIu6nUgLLa99xY5jVNWcIcDffYEBV1eeWhXPEV6U5tC3lI1
        /4wa65yBQRgQ/AhqvsztE3tDoS73nk+2jFdn6Lq0XbofY49nFFS8inpfyA43AImIJbQ7ee+TsaVTR
        qJ/sA4xg0Env1KEl19rKjGdcXbTrcM2MWniU8YyxIxZY2QyKdps/irFnRBX5eI5s4R+f5Z0s/KAPX
        wtaJ3Co8b1DXMqDiZIZsCin3zsnChYUQjXNdSNhcomCY2RULkPball3AB8slYWZCU0JmhaoKJiRA7
        aKZOlrAg==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlSdx-0001XL-KM; Wed, 17 Jun 2020 07:37:58 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: rename probe_kernel_* and probe_user_*
Date:   Wed, 17 Jun 2020 09:37:52 +0200
Message-Id: <20200617073755.8068-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Andrew and I decided to drop the patches implementing your suggested
rename of the probe_kernel_* and probe_user_* helpers from -mm as there
were way to many conflicts.  After -rc1 might be a good time for this as
all the conflicts are resolved now.

Feel free to directly apply these patches.
