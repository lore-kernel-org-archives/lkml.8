Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1A3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACA39206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DgNA8zNj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbgFONAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729977AbgFONAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:00:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2023C061A0E;
        Mon, 15 Jun 2020 06:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=KEBwjnYUxfYhJTwez4F4fZnZA29JFLpBE55ailzCXvU=; b=DgNA8zNjg31fURBe4MXNxzAOhB
        NK3HSZHgIza8gTjAdkipWM3Ym6khB8DZ1Ua2lKEqsk4tChR51Rv6Nj5tQjHuqiwguPR1MTqqOvvVn
        ATtNL2LZr+Fd8c2w/Zj7gjJH5p4xd42seDJ5bXqk5d2VCQMt91YWdE22Y+ATPBXjMmnbBTqWS0Dd0
        WC9a5c+5d0BUckpT8EBBuMnD6ZAGG8RnlfP6N+x8oECvP3pxtIr9pT9jH+TUIZfKlbL5tKsxJA+6t
        4OnNPShuVQndS1ghp/bJMSINGJuiWu3E2lGr+9nhQG8ntYFYHPcdmIj4F16cvC9IPe1XdgSVWewgZ
        aNIELFwg==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkoj4-0007nP-Cw; Mon, 15 Jun 2020 13:00:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: properly support exec and wait with kernel pointers
Date:   Mon, 15 Jun 2020 15:00:26 +0200
Message-Id: <20200615130032.931285-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this series first cleans up the exec code and then adds proper
kernel_execveat and kernel_wait callers instead of relying on the fact
that the early init code and kernel threads implicitly run with
the address limit set to KERNEL_DS.

Note that the cleanup removes the compat execve(at) handlers (almost)
entirely, as we can handle the compat difference very nicely in a
unified codebase.  The only exception is x86 where this would list the
handlers twice in the same syscall table due to the messed up x32
design.  I had to add an extra compat handler just for that case, but
maybe someone has a better idea.
