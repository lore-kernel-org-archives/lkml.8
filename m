Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102E0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1DD12070A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgEST3c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:29:32 -0400
Received: from verein.lst.de ([213.95.11.211]:45629 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgEST3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:29:31 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3464E68B02; Tue, 19 May 2020 21:29:29 +0200 (CEST)
Date:   Tue, 19 May 2020 21:29:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Stefan Haberland <sth@linux.ibm.com>, axboe@kernel.dk,
        hoeppner@linux.ibm.com, linux-s390@vger.kernel.org,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com
Subject: Re: [PATCH 3/2] block: remove ioctl_by_bdev
Message-ID: <20200519192929.GA7920@lst.de>
References: <20200519142259.102279-1-sth@linux.ibm.com> <20200519143321.GB16127@lst.de> <20200519190333.GR23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519190333.GR23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 08:03:33PM +0100, Al Viro wrote:
> On Tue, May 19, 2020 at 04:33:21PM +0200, Christoph Hellwig wrote:
> > No callers left.
> 
> No callers left after...?  IOW, where are the patches?  There'd been
> several patchsets posted, each with more than one revision...

In Jens' for-5.8/block tree, which has all the patches to remove them
merged.

Link: https://git.kernel.dk/cgit/linux-block/log/?h=for-5.8/block
