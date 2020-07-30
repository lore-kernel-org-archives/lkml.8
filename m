Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C25B9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BF9920578
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iqxFPnhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgG3GKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 02:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgG3GKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:10:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA241C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 23:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=EJ/xSr4Slr9PDG/RHcGFIsz8YPKBZNCUcGfQ1BXp/oA=; b=iqxFPnhPx40Z+lwdPlVwACPnma
        Fj1IdmHiSCKC62LI3/tPhOSvmAO1h3Dwr+Y5bbFgka7B+e1C8dco6xUOybS/zvwQPgbezrez8wU8v
        NQMlGU4Kj65zYtALJ0BGcAY1KCgydO6J7IpXvneIZBantP34URoQ7ueOtSu2REGdRw/LJ/UAqD7N1
        Yiyv4EpqhTooDwLQoSn98ACisd1I1TwwLTcaLHGsFt9NSFhRZPxBZ6j81J+f1kO4Kz7HSeChEQkAh
        Fs6sH7xTrq34Bi85pyFhNy+XMXoBhjxMUjucvhnWhXkWhx5i6C6PqXPngqVJ6jFau1vvy2KyhjDye
        YUrCnIpw==;
Received: from 138.57.168.109.cust.ip.kpnqwest.it ([109.168.57.138] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k11ls-0007U6-Je; Thu, 30 Jul 2020 06:10:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: inherit TAINT_PROPRIETARY_MODULE v2
Date:   Thu, 30 Jul 2020 08:10:19 +0200
Message-Id: <20200730061027.29472-1-hch@lst.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jessica,

we've had a bug in our resolution of _GPL modules since day one, that
is a module can claim to be GPL licensed and use _GPL exports, while
it also depends on symbols from non-GPL modules.  This is used as a
circumvention of the _GPL exports by using a small shim module using
the _GPL exports and the other functionality.  A recent example can
be found here:

    https://lore.kernel.org/netdev/6376CA34-BC6F-45DE-9FFD-7E32664C7569@fb.com/T/#md514322fdfa212afe9f1d3eb4e5f7eaefece36eb

Changes since v1:
 - standardize on one spelling of "license"
 - fix a commit message type

Diffstat:
 include/linux/module.h |   26 +++-----------------------
 kernel/module.c        |   46 +++++++++++++++++++++++++++++-----------------
 2 files changed, 32 insertions(+), 40 deletions(-)
