Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EB9C2BA16
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 06:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2113120747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 06:15:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WKF4y97u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgDHGPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 02:15:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50032 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgDHGPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 02:15:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NFKXv7QsXR7iUPXlkUIYwrc537WG8/WzEf7Z9zVWV9k=; b=WKF4y97u3LTKHRZq0DGkRn/4Kf
        muiDgpvEnxcQfnnHzcq9p5lLS/amGd9J/2jjjFDN/IYC0PRfbyzsiYIsdtygsbI/18gl/fXlO270K
        EwCss3rDBRMvhoRI+ZiB/1lk7zyFJsFAdGAaygcZsz3p6S/blHYFFwYoFQYYOpzChplWRZ5E6QYWq
        i7J9kpPvLq8LEJyuL1W9b3dyjY+1Et59BMCiZzjjsdHuuHa8+XCtoIslIovyk0Le80ANK7SYBUaGe
        lOx2/UK2q9Mjd2mk58tLnZlM5LaV6ZC5+oCKX5cHQfL2MtE16wgjBx+q52vz31Vriun1/uVyk6Gon
        FDRomUIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jM404-00059U-3A; Wed, 08 Apr 2020 06:15:48 +0000
Date:   Tue, 7 Apr 2020 23:15:48 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mbus: export mvebu_mbus_{add,del}_window for modules
Message-ID: <20200408061548.GA19756@infradead.org>
References: <20200324190623.26482-1-vadym.kochan@plvision.eu>
 <20200325135801.GA29951@infradead.org>
 <20200407151219.GB25149@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407151219.GB25149@plvision.eu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 06:12:19PM +0300, Vadym Kochan wrote:
> Hi Christoph,
> 
> On Wed, Mar 25, 2020 at 06:58:01AM -0700, Christoph Hellwig wrote:
> > On Tue, Mar 24, 2020 at 09:06:23PM +0200, Vadym Kochan wrote:
> > > Allow to add/del remap window by external modules at runtime.
> > 
> > Please send this together with your driver submission.
> 
> The driver itself is just servicing user process to configure io
> windows via ioctl, so I think it is not so useful ?

If you want the export in mainline your driver needs to be as well.
