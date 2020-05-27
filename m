Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61722C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E882088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bDXU2XZn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387721AbgE0SWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 14:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbgE0SWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:22:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF27C08C5C1;
        Wed, 27 May 2020 11:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=LUf7Yx/K7I5FK3axyR59J8rMx6Ue2mwNKAv4IV2euEw=; b=bDXU2XZnBc2EGs9S3bcmLm5/dH
        2voilB3Dw+aDVUfKR0aRYhc1qIFT5B8eIsKG6efu6gMljsrIAn18hkZ3IhjB28FMX/s1ZJXXg3Cuo
        gfPFSGftWI0TEqLEigtoFnaTVrX8KfKWBW7yLyIvJTJOXyxp5wTSsfKs52DdQo87b8tP//+cuYFQD
        96vTZInpDdmAh2rsp+tz1RXOnBdAgu1klAq9oPXI6q7bYjhwVHpLKQuf2WTe5MSucfE0Q9Gmewsyc
        rdjkUcQ8a7P30LyCRKprMDxGm4r75WIjtsNO9gxufjLA+iOs/RRQu0FyIt0HBo1RNxvPlzmwmHy6e
        aXkC7zpg==;
Received: from p4fdb0aaa.dip0.t-ipconnect.de ([79.219.10.170] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1je0hD-00087V-O8; Wed, 27 May 2020 18:22:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Vlad Yasevich <vyasevich@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-kernel@vger.kernel.org, cluster-devel@redhat.com,
        netdev@vger.kernel.org
Subject: remove kernel_getsockopt
Date:   Wed, 27 May 2020 20:22:27 +0200
Message-Id: <20200527182229.517794-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi dear maintainers,

this series reduces scope from the last round and just removes
kernel_getsockopt to avoid conflicting with the sctp cleanup series.
