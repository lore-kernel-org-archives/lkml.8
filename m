Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4914CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 00:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22BE2206C0
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 00:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GYkSt1nq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbgHPAnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 20:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgHPAnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 20:43:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C90AC061786;
        Sat, 15 Aug 2020 17:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o+wfFvyLhA+em4AovIaNYnXy15NfLyZt8dI3Gf4MNPg=; b=GYkSt1nq2R2qXTgU+gByKs4Lmx
        /SVnvwplK1CMF+zm7WNQ78W1OnoUzIj+m9UxcYpdOMpsLTelQoy4tOPuhVwdMDTpm5NLrq1H4LhLW
        ffeOhEKwlV0aXDKLRSKFR+Y+5c9b4o7Wn9zz0q/KZLSIZRB3P2aw3F+kkc1vq/FCCBwTxgle4AdqC
        jzdl5pJUCqfjjo5pfOIxpyskQ9bxtBmrZ8rGZogeHbSS0yrPF4twuJU6SenahkylKb5hRltAKaCn9
        46R5WCHQjGsi19+pQA1RfqMgCoHSx1x6P2fcQdwsTlC2uRlx2LArhzZ6HZgejUwVERWuh4mZlhgmY
        M74Fi/0g==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k76lH-0008J5-CY; Sun, 16 Aug 2020 00:42:59 +0000
Date:   Sun, 16 Aug 2020 01:42:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     dsterba@suse.cz,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] fs: NTFS read-write driver GPL implementation by Paragon
 Software.
Message-ID: <20200816004259.GD17456@casper.infradead.org>
References: <2911ac5cd20b46e397be506268718d74@paragon-software.com>
 <20200815190642.GZ2026@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815190642.GZ2026@twin.jikos.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 09:06:42PM +0200, David Sterba wrote:
> There's maybe more I missed, but hopefully HTH.

One thing you missed is adding support to fstests
git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git

If it passes that torture test, I think we can have confidence that
this is a really good implementation of a filesystem.

