Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FF8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F0220709
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MJd2/JiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgHJMXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgHJMXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:23:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02802C061756;
        Mon, 10 Aug 2020 05:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RpHsDEoBgZyB4iL60mEOdGbBS3lToAiAaQspGBz+oX0=; b=MJd2/JiPFY9y8P+PtdTuwvbtxB
        xKIJ7iXtu5078zysLT/kZ94uQK8TtXsLqyGrQHymVzqMioaYc7iWwqsIor8hw17AzeUsbyE02Ifn8
        3uWGQbnDQzuIT06SVAvAdfliC4c6O5B40OQMfZCaZofZwGIx9s32je10KCrZwTqnhjsaLBepiIUS5
        zgSYR3Vs19J6EeimFxolTvuSYiDilZmuQcPCfMg7VuA3CsN6Zf5HlviZrwnjF85nM2HXdj4HX8uxF
        u0HbaGmn5OrqIq2QjB3FVdC8g4NsuHByfIblvX9wnyw32kA1r+sLarwJsFbTjyMerZ6SZJWoOxJBK
        2II5Wu6A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k56pk-0005hK-VR; Mon, 10 Aug 2020 12:23:21 +0000
Date:   Mon, 10 Aug 2020 13:23:20 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Skeggs <bskeggs@redhat.com>, Lyude Paul <lyude@redhat.com>,
        linux-spdx@vger.kernel.org
Subject: Re: [git pull] drm next for 5.9-rc1
Message-ID: <20200810122320.GA20549@infradead.org>
References: <CAPM=9ty8hOY0m2+RJdRiRADY5Li-hs3ZaDEK-DTf6rgFewar7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9ty8hOY0m2+RJdRiRADY5Li-hs3ZaDEK-DTf6rgFewar7g@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 11:07:02AM +1000, Dave Airlie wrote:
> nouveau:
> - add CRC support
> - start using NVIDIA published class header files

Where does Nvdia provide them?  I looked into the commits and the
Nouveau mailing list archives and could not find anything.

Note that various new files with a MIT boilerplate instead of
an SPDX tag.
