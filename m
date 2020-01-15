Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07CCC33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A884A24679
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lctX+OwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgAOI3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 03:29:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33086 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbgAOI3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MPafXeu0m8CczGY2euGxOZpo2GzuA/fsBdgtbBJiLfk=; b=lctX+OwEGdd61wKz2mFk+BrFX
        z1zAF5aRwydgJ07mE8siK0MMh5sA7VNV/avjC2d0XcNCySywROV7Lje83cMelqBDUDd11TM+MHV02
        fulUsZoepN5Jtt8+F7oLK5R4yM5Ozc/ywn9NFz1jFv5Qf6d0NnMzTnkv2fYSqbFePl5knkt5pXes6
        4Tde+9H/h/vy3HmNrOC2f+gFId6cFcQMFTqI6WAU48YSShptPLJ5+v3Yh9giC91N9Tc0HssIuqjtu
        dCZjB3Ds+Ze8S1PiKozXS0qwDh784Q5jdTcEPBohptC0S2F39UmHNNiQIpbB9QnKcJxP0Yv9fF4th
        TdHpITBAA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ire3f-0005fN-Jm; Wed, 15 Jan 2020 08:29:47 +0000
Date:   Wed, 15 Jan 2020 00:29:47 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: remove prefetch_prev_lru_page
Message-ID: <20200115082947.GA21018@infradead.org>
References: <1579006500-127143-1-git-send-email-alex.shi@linux.alibaba.com>
 <FC618797-2F5E-4F73-A244-0DC19AA1CB74@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FC618797-2F5E-4F73-A244-0DC19AA1CB74@lca.pw>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 08:46:21AM -0500, Qian Cai wrote:
> 
> 
> > On Jan 14, 2020, at 7:55 AM, Alex Shi <alex.shi@linux.alibaba.com> wrote:
> > 
> > This macro are never used in git history. So better to remove.
> 
> When removing unused thingy, it is important to figure out which commit introduced it in the first place and Cc the relevant people in that commit.

No, it isn't.  It is at best nice to have, but for a trivial macro
really doesn't matter.
