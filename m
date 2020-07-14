Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A612C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F13F2076D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgGNHKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:10:00 -0400
Received: from verein.lst.de ([213.95.11.211]:53012 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgGNHJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:09:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C6A0468CFE; Tue, 14 Jul 2020 09:09:55 +0200 (CEST)
Date:   Tue, 14 Jul 2020 09:09:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-riscv@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: clean up address limit helpers
Message-ID: <20200714070955.GB776@lst.de>
References: <20200710135706.537715-1-hch@lst.de> <CAHk-=wjGjwtgYJvLOd5aO2dWyPsC-6ED2Hthoxm1Eerf-Ahd-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjGjwtgYJvLOd5aO2dWyPsC-6ED2Hthoxm1Eerf-Ahd-w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 08:25:35AM -0700, Linus Torvalds wrote:
> On Fri, Jul 10, 2020 at 6:57 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > in preparation for eventually phasing out direct use of set_fs(), this
> > series removes the segment_eq() arch helper that is only used to
> > implement or duplicate the uaccess_kernel() API, and then adds
> > descriptive helpers to force the kernel address limit.
> 
> Ack. All the patches looked like no-ops to me, but with better naming
> and clarity.

Is that a formal Acked-by?
