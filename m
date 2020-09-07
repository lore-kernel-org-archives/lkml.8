Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6642C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8618821556
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599468324;
	bh=i58K+L676ZofafOdgLIgBW6pikwzbtdTo+oBnefV2d0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i0CQ42wDpByOgPpHIE8B5pJf5sh8PHol2cF0fepXmEPRN9QMj0z3ikm0FBl2Q4whi
	 A4+4YjRC3vUUQ/mJNf6TOwGa9L35f9A6W5cI/Ooh0mwn9kPgFHp1YhknBUSHIoXb0P
	 Gs0YUDKvQ7hSh2zPsuVXkchJMmXDnfr/1yjmKMmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgIGIpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:45:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbgIGIpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:45:22 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FB052145D;
        Mon,  7 Sep 2020 08:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599468321;
        bh=i58K+L676ZofafOdgLIgBW6pikwzbtdTo+oBnefV2d0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PfuDHn5F2t61WIA0CYOW2juEBOxSEfWk9kcU8UDR/3V8E4RWzfhU0iAmULuvhoxee
         sWG1lFks5K62RaLhf/NxwdIboYf+TN1199KBpdNKlOo6vlaCrZ9a5/DfV4lBqfHV9z
         sRgZ41Om1oSeGSgw69YQFtoTXmPy97QowT6f9Rq0=
Date:   Mon, 7 Sep 2020 10:45:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] /dev/zero: also implement ->read
Message-ID: <20200907084536.GA1058178@kroah.com>
References: <20200907075143.2023440-1-hch@lst.de>
 <20200907082114.GA714195@kroah.com>
 <20200907082139.GA23031@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907082139.GA23031@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 10:21:39AM +0200, Christoph Hellwig wrote:
> On Mon, Sep 07, 2020 at 10:21:14AM +0200, Greg KH wrote:
> > On Mon, Sep 07, 2020 at 09:51:43AM +0200, Christoph Hellwig wrote:
> > > Christophe reported a major speedup due to avoiding the iov_iter
> > > overhead, so just add this trivial function.
> > > 
> > > Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > > ---
> > > 
> > > Changes since v1:
> > >  - fix the Suggested-by: tag
> > >  - report the actually read bytes in case of a partial clear_user
> > >  - remove an impossible to hit conditional
> > > 
> > >  drivers/char/mem.c | 28 ++++++++++++++++++++++++++++
> > >  1 file changed, 28 insertions(+)
> > 
> > I already merged your v1 into my tree, do you want me to revert that and
> > then add this, or can you send me the diff to apply instead?  I can't
> > rebase my public trees.
> 
> Sure, I can send an incremental one.  I vaguely remembered you as one
> of the quilt holdouts.

That's only for stable tree work :)

thanks for the incremental patch, will go apply that now.

greg k-h
