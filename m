Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D98C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B80C207C4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="B9rIyvpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgERG21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 02:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgERG2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 02:28:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F10C061A0C;
        Sun, 17 May 2020 23:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=gJIIBufWybdq+3fw2XO4nHQNH5jFvjDWdjZ3a2t3luU=; b=B9rIyvpqb+swxOztbr4iwmyK0+
        OBft2/YRNCRKhhW0jtBIlXv48oy9h9TYZTTu6CSFSLkBfxUQXf5+y7rtvmO2/LZCmb7X5GMjMri82
        rJP6osiCXezxx0CZw4dJCXyGTg8la95D77zUpsQdRIKy5d4mNyGxoJ5ufjDQqGsvrOIuC4pKHV2RF
        eDyvgYMLRz5BCZv/VGuIAEjMuZWmb/UuBrzozvy6tUvEE4umCmbcJQnE5+KxyAvg2GOMMhKrFf67a
        DvMy4Lu82MeqLqpK6cgaB9jK9ViML9o8/bSSJX/wO4XW2qrTRtH5vpjggBBygydY4a8bmlpgasx+p
        49M2Zrqg==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jaZFz-0002ZK-Ol; Mon, 18 May 2020 06:28:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: move the SIOCDELRT and SIOCADDRT compat_ioctl handlers v3
Date:   Mon, 18 May 2020 08:28:04 +0200
Message-Id: <20200518062808.756610-1-hch@lst.de>
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

Changes since v3:
 - moar variable reordering

Changes since v1:
 - reorder a bunch of variable declarations
