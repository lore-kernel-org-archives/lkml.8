Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC39FC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E0920788
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ufiy8DgI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgCXQ0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:26:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:59548 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727466AbgCXQ0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=9mvz1gMkyoGTE/uYkR0YFesaWUHN2JLoZ84hifwq/lw=; b=ufiy8DgIKA9xaBo/bkpl2ndffK
        ky1+Fm/d0pOeyFjbh0Axex/4qKGXGW7aCDBYtEKsHQozQJ3eCZNTdI43Q66a9qCRkBORxUtuUtzkS
        uvMq4C9L7bftgGTfDkexfrt2tLp776w3gZ8+gWaDFbfTB9ik8Eu98mVTRv/qnucSWdd4qGsSbv8Jr
        5i2KUfYE5cJv8ME5kXuNomm3vUh3dwiSc08wvtjgXlzKkvyeP4dSGoM5vqWk77Umq6k9cLH4JqBMx
        N8ygSvNfRXgMzVfTSHJS2h808fRNnxpZ7afE8f2Bf9AwYfNdVdkcuJfrkAWmqkbLy/+GoIEp1VEO0
        gV9lgTIw==;
Received: from [2001:4bb8:18c:2a9e:999c:283e:b14a:9189] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGmNu-0007bs-T9; Tue, 24 Mar 2020 16:26:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ioremap and dma cleanups and fixes for superh
Date:   Tue, 24 Mar 2020 17:26:23 +0100
Message-Id: <20200324162633.754714-1-hch@lst.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yoshinori and Rich,

can you take a look and possibly pick up the series below that untangles
and sorts out minor issues with the sh ioremap and dma code?
