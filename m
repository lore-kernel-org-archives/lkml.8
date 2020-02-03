Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C598BC3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0B420658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 08:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KuoZ3h2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbgBCI3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 03:29:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:41010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgBCI3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 03:29:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=XmFADTVQJKR+reU0aMwRenMf//aWNZksD/ww50+yquE=; b=KuoZ3h2emqg9BdfnW3TctzXv5
        1fPL+461n24zceH8xmFtzTF0yxDjo3LpKnLwOdVH+kG+05lcI9uSwk3zgZ+1cqyK23ZCO4oEQD3dm
        M0zwAa3sjnHuKdm20jYBH1L06x6O/Das2RHBlfLFmEAhi/U1K5JO9GU7gU5fwUxyC1WH1YegQQN/M
        ecnrOvdEQg3YRk9sB8lAjDngltO8R1wauzR+Ir3Xm8014Z22I1y7XLZpOUv/y5Iwt6d5TsJEY4cur
        k7UUtcP06z4LrjYMJxmz5wb4iYAfAkbIteS8plZvUIeEb2LR31varpKyRRbqc4ecersWfAd/A876f
        wklj1h34w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iyX6w-00078q-SX; Mon, 03 Feb 2020 08:29:38 +0000
Date:   Mon, 3 Feb 2020 00:29:38 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>,
        devel@driverdev.osuosl.org,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-kernel@vger.kernel.org,
        motai.hirotaka@aj.mitsubishielectric.co.jp,
        Mori.Takahiro@ab.mitsubishielectric.co.jp,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: exfat: remove DOSNAMEs.
Message-ID: <20200203082938.GG8731@bombadil.infradead.org>
References: <20200203163118.31332-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
 <20200203080532.GF8731@bombadil.infradead.org>
 <20200203081559.GA3038628@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203081559.GA3038628@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 08:15:59AM +0000, Greg Kroah-Hartman wrote:
> On Mon, Feb 03, 2020 at 12:05:32AM -0800, Matthew Wilcox wrote:
> > On Tue, Feb 04, 2020 at 01:31:17AM +0900, Tetsuhiro Kohada wrote:
> > > remove 'dos_name','ShortName' and related definitions.
> > > 
> > > 'dos_name' and 'ShortName' are definitions before VFAT.
> > > These are never used in exFAT.
> > 
> > Why are we still seeing patches for the exfat in staging?
> 
> Because people like doing cleanup patches :)

Sure, but I think people also like to believe that their cleanup patches
are making a difference.  In this case, they're just churning code that's
only weeks away from deletion.

> > Why are people not working on the Samsung code base?
> 
> They are, see the patches on the list, hopefully they get merged after
> -rc1 is out.

I meant the cleanup people.  Obviously _some_ people are working on the
Samsung codebase.
