Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B58C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB3F207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UiyNhl2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgBSO6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:58:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgBSO6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:58:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P7AWjEqJ/Ak9OsdtY3HMO+qukuBO/5fEV2Q8xzme/CY=; b=UiyNhl2LZhx2iAyLOzuKE9FY58
        87ApTFxh6+WvqaGjHcWTAbGaOUo2o4XJWIU9+md8Df1IOcHEgIMG9GmoLXnR+WZzOjkL0roG/hlq6
        wWhLp6yomuY43c7bDr8RQQH6iXXeAZuWE33KyoA4X9gNwXQgv/0RTj/L/mQQZjc1C6QUidJs5lJY5
        juVvfTghtQzXBGuZj98AJu5RhUDbLDhqWOJKblhKPVa1sA15g6I82cJqGZ71vxIczdcTqHGQrEQRb
        wzNO6rO3g1PdNeOpjWrzafhEmp7slL1irqcteKAZm8MuNqSht72KzvMdIbAM24MfbE7rradLrOnwd
        62h4ufdw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4Qnh-0001OK-0H; Wed, 19 Feb 2020 14:58:09 +0000
Date:   Wed, 19 Feb 2020 06:58:08 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Edmund Merrow-Smith <edmund@sucs.org>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] drivers: NVME: host: core.c: Fixed some coding style
 issues.
Message-ID: <20200219145808.GA5147@infradead.org>
References: <20200218230131.12135-1-edmund@sucs.org>
 <20200219000519.GB18306@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219000519.GB18306@redsun51.ssa.fujisawa.hgst.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 09:05:19AM +0900, Keith Busch wrote:
> On Tue, Feb 18, 2020 at 11:01:31PM +0000, Edmund Merrow-Smith wrote:
> > Fixed a number of style issues highlighted by scripts/checkpatch.pl.
> > Mostly whitespace issues, implied int warnings,
> > trailing semicolons and line length issues.
> 
> But checkpatch.pl is on the wrong side of the 'unsigned'/'unsigned int'
> debate! The C standard defined unsigned since forever ago, its usage is
> not at all confusing.

Nevermind all the style issues with the patch itself.  Also while I'm
all for clean code - pure cleanup patches are a complete waste of time.
Everyone feel free to clean up obvious warts arounds code that your
are touching for a real fix or feature.  But please stop sending random
cleanup patches.

> 
> _______________________________________________
> linux-nvme mailing list
> linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
---end quoted text---
