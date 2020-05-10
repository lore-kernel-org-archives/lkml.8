Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BFFC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 22:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E8320720
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 22:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgEJWZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 18:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728932AbgEJWZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 18:25:45 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7807EC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 15:25:45 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id DA7F12C8; Mon, 11 May 2020 00:25:42 +0200 (CEST)
Date:   Mon, 11 May 2020 00:25:41 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>
Subject: Re: [git pull] IOMMU Fixes for Linux v5.7-rc4
Message-ID: <20200510222540.GF18353@8bytes.org>
References: <20200510122634.GA32616@8bytes.org>
 <CAHk-=wht3yDtJ6zka=DNaB8Nymh-zmUMZhGaC8yFz29nuW-EsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wht3yDtJ6zka=DNaB8Nymh-zmUMZhGaC8yFz29nuW-EsA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 10, 2020 at 11:34:49AM -0700, Linus Torvalds wrote:
> On Sun, May 10, 2020 at 5:26 AM Joerg Roedel <joro@8bytes.org> wrote:
> >
> >            The first race condition was around
> >           the non-atomic update of the domain page-table root pointer
> >           and the variable containing the page-table depth (called
> >           mode). This is fixed now be merging page-table root and mode
> >           into one 64-bit field which is read/written atomically.
> 
> This seems a bit odd.
> 
> The pointer part is always page-aligned, and the "mode" is just three bits.
> 
> Why isn't it just encoded as one pointer with the low three bits being the mode?
> 
> The thing is, the 64-bit atomic reads/writes are very expensive on
> 32-bit x86. If it was just a native pointer, it would be much cheaper
> than an "atomic64_t".

Yeah, when I think about it again, you are right. I think I used
atomic64_t just to be on the safe side with memory odering and all. But
in this case it doesn't really matter when a reader observes the
update, it is only important that the reader does not observe one field
updated while the other is not. And that should already be fullfilled
with 64-bit writes on x86-64, like a native pointer write.

I'll send a patch to Qian to test this, just to be sure I am not missing
anything.

Thanks,

	Joerg
