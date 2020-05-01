Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2C8C47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5A620708
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PQMcoMIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729721AbgEAPYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729537AbgEAPYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:24:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272FFC061A0E;
        Fri,  1 May 2020 08:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=4jZBUar+kwlxf2npvTvVYY+2uyA6OkDur+ekCP/I/n4=; b=PQMcoMIXaHBSFdreh0e0CE+EW1
        UkgeqGCLPbD6ya0kmRq4nvF5UKcqFJlWSKj1Iybj0oSkquznHqiNMWWTdEWcC4Zd1VqgyaYa1GlJ8
        0ajMqmspKHSSPaqYW7aPqJvye/Sb234VuoDxCdBlPp+HGu35lV3Fro7YMeLsuXQJ4+uAJokq7bWPy
        6j4Jg/Ib+gmOUEh6pzhl61DwVwAJm7sdK18+9sV7+EHUngupKzFzenyzy5XgNTEzWUe6StL6poqq0
        iPoTnYmX/SKM8sEdEWd+hSzi1WlPz4nVImfTimXZUvdlNXzpkwiadDRN6COCYCHcg0g3Fm9KDbg7f
        A0ellLFg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUXVu-0002Bt-Ap; Fri, 01 May 2020 15:23:42 +0000
Date:   Fri, 1 May 2020 08:23:42 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     "Karstens, Nate" <Nate.Karstens@garmin.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Changli Gao <xiaosuo@gmail.com>
Subject: Re: [PATCH 1/4] fs: Implement close-on-fork
Message-ID: <20200501152342.GA29705@bombadil.infradead.org>
References: <20200420071548.62112-1-nate.karstens@garmin.com>
 <20200420071548.62112-2-nate.karstens@garmin.com>
 <36dce9b4-a0bf-0015-f6bc-1006938545b1@gmail.com>
 <0e884704c25740df8e652d50431facff@garmin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e884704c25740df8e652d50431facff@garmin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 02:45:16PM +0000, Karstens, Nate wrote:
> Others -- I will respond to feedback outside of implementation details in a separate message.

FWIW, I'm opposed to the entire feature.  Improving the implementation
will not change that.
