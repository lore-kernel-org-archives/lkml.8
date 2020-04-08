Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD72CC2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11A7206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ErP5IMmi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728913AbgDHP1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:27:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgDHP1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=LInpn8T/KJEl74W1VxRKS8YDYBibxYruEcGZTH25wi0=; b=ErP5IMmiSq2uhxm4ouTry03HYg
        itLtEOkHeacirm7CffNDLhSrlZsGknNBLXk/KDgdnBc2M1Yqn91pdNedp5n2PumSufRJzD20qPa3/
        MbYI91bHSziVm8MZRTypaRiOq+uB//eaebmkHxziDu3fsHISC1tq9dClhtQ28fcyQWZhYVMvfRRA7
        6JyFTJ81Oe8yokCU0Sw5YZ4E3mTsnK7MgvdhAtcNZkugS3AZnuZilhaW5Q884g9AorcKza2OXJMj6
        gC6It46oqHhJsK+xXExm22sF5SM4KnrLKEyOb4Hgma8C2aTYs7t1+pCoJOfXo1BXQJNrOHH4/7P+y
        lQwayRbg==;
Received: from [2001:4bb8:180:5765:65b6:f11e:f109:b151] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jMCcF-0007yh-FJ; Wed, 08 Apr 2020 15:27:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: hide __pte2cachemode_tbl and __cachemode2pte_tbl
Date:   Wed,  8 Apr 2020 17:27:41 +0200
Message-Id: <20200408152745.1565832-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series avoids pointlessly exposing the cachemode to pte bit
translation tables to modules.
