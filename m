Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7790C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB319208CA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731490AbgIARQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:16:56 -0400
Received: from verein.lst.de ([213.95.11.211]:53770 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbgIAPOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:14:23 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0183E68B05; Tue,  1 Sep 2020 17:14:21 +0200 (CEST)
Date:   Tue, 1 Sep 2020 17:14:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     hch@lst.de, viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/6] proc: use vmalloc for our kernel buffer
Message-ID: <20200901151420.GA30709@lst.de>
References: <20200813210411.905010-1-josef@toxicpanda.com> <20200813210411.905010-2-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813210411.905010-2-josef@toxicpanda.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 05:04:06PM -0400, Josef Bacik wrote:
> Since
> 
>   sysctl: pass kernel pointers to ->proc_handler
> 
> we have been pre-allocating a buffer to copy the data from the proc
> handlers into, and then copying that to userspace.  The problem is this
> just blind kmalloc()'s the buffer size passed in from the read, which in
> the case of our 'cat' binary was 64kib.  Order-4 allocations are not
> awesome, and since we can potentially allocate up to our maximum order,
> use vmalloc for these buffers.

Maybe the subject should read ".. also use vmalloc" as we still default
to kmalloc for small allocations?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
