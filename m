Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE505C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0305208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgIGIVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:21:43 -0400
Received: from verein.lst.de ([213.95.11.211]:48169 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728060AbgIGIVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:21:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 61A7168BEB; Mon,  7 Sep 2020 10:21:39 +0200 (CEST)
Date:   Mon, 7 Sep 2020 10:21:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, arnd@arndb.de,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] /dev/zero: also implement ->read
Message-ID: <20200907082139.GA23031@lst.de>
References: <20200907075143.2023440-1-hch@lst.de> <20200907082114.GA714195@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907082114.GA714195@kroah.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 10:21:14AM +0200, Greg KH wrote:
> On Mon, Sep 07, 2020 at 09:51:43AM +0200, Christoph Hellwig wrote:
> > Christophe reported a major speedup due to avoiding the iov_iter
> > overhead, so just add this trivial function.
> > 
> > Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > ---
> > 
> > Changes since v1:
> >  - fix the Suggested-by: tag
> >  - report the actually read bytes in case of a partial clear_user
> >  - remove an impossible to hit conditional
> > 
> >  drivers/char/mem.c | 28 ++++++++++++++++++++++++++++
> >  1 file changed, 28 insertions(+)
> 
> I already merged your v1 into my tree, do you want me to revert that and
> then add this, or can you send me the diff to apply instead?  I can't
> rebase my public trees.

Sure, I can send an incremental one.  I vaguely remembered you as one
of the quilt holdouts.
