Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815A5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:46:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57DBA20727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XPlupVEt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgENOqR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgENOpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:45:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B0BC061A0C;
        Thu, 14 May 2020 07:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=C0JBBAGMh2Gx0cshhc8L2hDMgoxO3l9OvKF0uYNu6cU=; b=XPlupVEtP9/4WQjK/Bft2etU2g
        WHs6jN/HKq3bN/5mcFIKrd23FQAbM8XycA2qeGhe03WZ5Yi3PFblmWtl3xLK2fGMZrjMKix3allNB
        TR8bhtLoZtGFK/u7lxr6sdZKldbCE7YySuMy5nNdd4+yja3sHng9MRruDiBnQjt59Ap+tqB75xp3N
        H3fxDQjB/AqZXOw67PU9d2sQG+Ah3Gx9ZNDYbonPF55zqQoODGhkTjAZpoKMTl0hjc/4wqiW4cUuq
        LCHqPqkMz5yCTEeG8DZLhKJY/2GA1MSDap4JI7aWUHhaW0Rc6yFdS9fmpYMgESWAt9ZYvi6edxbDt
        BilkmdWw==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZF7B-0004cx-8q; Thu, 14 May 2020 14:45:37 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: move the SIOCDELRT and SIOCADDRT compat_ioctl handlers
Date:   Thu, 14 May 2020 16:45:31 +0200
Message-Id: <20200514144535.3000410-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

this series moves the compat_ioctl handlers into the protocol handlers,
avoiding the need to override the address space limited as in the current
handler.
