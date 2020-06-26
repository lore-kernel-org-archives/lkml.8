Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76790C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54A5F208B6
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XrsF4PUO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgFZIHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728938AbgFZIHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:07:38 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E3FC08C5C1;
        Fri, 26 Jun 2020 01:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=9mvz1gMkyoGTE/uYkR0YFesaWUHN2JLoZ84hifwq/lw=; b=XrsF4PUOiNc1/K70Sby6ULuuPl
        D69FsD9p3dOeXatDf+wL1o0s61FBVwayNyPukRevjXKRSdiPN5fKDsDYxG3IA4Q1qZAguM71tLMUW
        7uBuYKKd/mOFCl9Urp/0pRpnikmuNwGVC4kfU1ChIugfkINn8H3cQJZ1ZmhcfODK7D8FtGtvEBYka
        zBSkHePCl4ccNzClschPrGj/QawszWGQSWz1X7xXHf8G0EV487d4s8GGR2fEiYoKWHjdcGTsszpKd
        pKqekbzYpGTSnqYbGnqIPZ2F97F7qAU0TUmOyFUtBMPwcE4RQrbBpuRTCB3WU17EwkANINQQ2H2pY
        RLAN+e2A==;
Received: from [2001:4bb8:184:76e3:2b32:1123:bea8:6121] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jojOI-0007sx-5g; Fri, 26 Jun 2020 08:07:18 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ioremap and dma cleanups and fixes for superh (resend)
Date:   Fri, 26 Jun 2020 10:07:07 +0200
Message-Id: <20200626080717.1999041-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yoshinori and Rich,

can you take a look and possibly pick up the series below that untangles
and sorts out minor issues with the sh ioremap and dma code?
