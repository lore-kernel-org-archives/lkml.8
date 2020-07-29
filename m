Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F98AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 17:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A9D02075D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 17:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgG2RGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 13:06:22 -0400
Received: from verein.lst.de ([213.95.11.211]:52987 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbgG2RGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 13:06:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C594968AFE; Wed, 29 Jul 2020 19:06:19 +0200 (CEST)
Date:   Wed, 29 Jul 2020 19:06:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jessica Yu <jeyu@kernel.org>, Christoph Hellwig <hch@lst.de>,
        open list <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org
Subject: Re: [PATCH 2/7] modules: mark find_symbol static
Message-ID: <20200729170619.GA2279@lst.de>
References: <20200729062711.13016-1-hch@lst.de> <20200729062711.13016-3-hch@lst.de> <20200729161318.GA30898@linux-8ccs> <20200729162435.GB3664300@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729162435.GB3664300@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 06:24:35PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 29, 2020 at 06:13:18PM +0200, Jessica Yu wrote:
> > +++ Christoph Hellwig [29/07/20 08:27 +0200]:
> > > find_symbol is only used in module.c.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > 
> > CCing the livepatching ML, as this may or may not impact its users.
> > 
> > AFAIK, the out-of-tree kpatch module had used find_symbol() in the
> > past, I am not sure what its current status is. I suspect all of its
> > functionality has been migrated to upstream livepatch already.
> 
> We still have symbol_get(), which is what I thought they were using.

And even if it didn't out of tree modules really don't matter.
