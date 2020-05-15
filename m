Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B81C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA7DB20709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OwzbN6i3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgEONTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgEONTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:19:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CEBC05BD09;
        Fri, 15 May 2020 06:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=r1H8pV7yKpckO/9fj2vm7MP+Bon7Xmj4IzShbTFCnSk=; b=OwzbN6i31/onhwCUcSFOIB2cYq
        ELte35LRGCVtygq+ZAwdjAM/+vvT6Ci5+e/KTO9SUrTsozujNy/msgnPWfiQBTe2KKTWq3cFGJoWt
        5ryKqmDol+rXztsiV64Sz2GMjRxlgk33/n/q2dvYAW3tlEUcW/zjnaLa/6rqOfWCU8IFNs0hU/jeg
        uRqeijQ5Dk2vz78f6Pg+lnql90OS8d7PwqJkdMF6/ZnDwrYly5xm9NsTcW2qe25M9RuDSFU0BeDmD
        e6YjssQ1jhSzvYUmEuGAG6WY7QeW7n0czNl1sO+J8+MdPrWFgm+DTAVAC4cOr0Dj8jD2QuZsusj6y
        IGHpsRmw==;
Received: from [2001:4bb8:188:1506:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZaFL-0006Xv-6b; Fri, 15 May 2020 13:19:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org (open list)
Subject: move the SIOCDELRT and SIOCADDRT compat_ioctl handlers v2
Date:   Fri, 15 May 2020 15:19:21 +0200
Message-Id: <20200515131925.3855053-1-hch@lst.de>
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

Changes since v1:
 - reorder a bunch of variable declarations
