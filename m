Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D2DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18E54206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgGQGGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:06:23 -0400
Received: from verein.lst.de ([213.95.11.211]:37283 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgGQGGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:06:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E319668BEB; Fri, 17 Jul 2020 08:06:18 +0200 (CEST)
Date:   Fri, 17 Jul 2020 08:06:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: clean up address limit helpers v2
Message-ID: <20200717060618.GA9842@lst.de>
References: <20200714105505.935079-1-hch@lst.de> <20200716164924.15e373f4dbb3071e9d4ee37c@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716164924.15e373f4dbb3071e9d4ee37c@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 04:49:24PM -0700, Andrew Morton wrote:
> On Tue, 14 Jul 2020 12:54:59 +0200 Christoph Hellwig <hch@lst.de> wrote:
> 
> > Hi all,
> > 
> > in preparation for eventually phasing out direct use of set_fs(), this
> > series removes the segment_eq() arch helper that is only used to
> > implement or duplicate the uaccess_kernel() API, and then adds
> > descriptive helpers to force the kernel address limit.
> > 
> > 
> > Changes since v1:
> >  - drop to incorrect hunks
> >  - fix a commit log typo
> 
> I think this *is* v1.  I can't find any differences in the patches and I
> was unable to eyeball any changelog alterations?

No, this actuall is v2.

"[PATCH 5/6] uaccess: add force_uaccess_{begin,end} helpers" dropped
two incorrect hunks in the m68k and sh arch code, and lost and "er"
in the commit log.
