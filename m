Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D75DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B40A22453
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q5K5lGoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgGNMVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbgGNMVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:21:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F32C061755;
        Tue, 14 Jul 2020 05:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=MqcT5OB0GJk7c2MSbPZbIvjBmVD4d8+TBGDHxxxp5Zo=; b=Q5K5lGoFNNm++DuLj01MC7FbaE
        UEcONmd6dZDt1KXpmLEW80n4D+/JY4TJE0PdFaxttIHujj4RDJyQ4cniuOg0rb/N8wCiV2bg8vHlQ
        JeUItckhdr04xlsc0Ly3wHTF9X5vaHAlc+x0Miuf1fVWj9Gd4daN5Uenvod9vVEFBgLWeAa/AgMq7
        IRoxdrJJpku5Sv5LrbvdqhWYdR3YajPQsW6sfyz08Plx4DjDmvmDelRnyv7F11xn0iiYd+qhnKoNr
        hbyuouhIkR1BFdvE97mdKvXl1czefTUAaBCjcaByEbX88UXSwypOKv7wOI7BAqVHww1JVbaBJl/zx
        FcIXdIjA==;
Received: from 089144201169.atnat0010.highway.a1.net ([89.144.201.169] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvJvn-0001FP-34; Tue, 14 Jul 2020 12:21:07 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ioremap and dma cleanups and fixes for superh (2nd resend)
Date:   Tue, 14 Jul 2020 14:18:46 +0200
Message-Id: <20200714121856.955680-1-hch@lst.de>
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

I sent this out a few times, but never got an answer.  If you don't
want to pick up the series I can also take it through one of my trees
if I get ACKs.
