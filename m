Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291EBC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0CFB2076E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585072280;
	bh=szCP8ae/BMdZYRhBOIOQJx5y/E+NJm+aMJfn2m9sUPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=idoq9/uWa6r88vKdByugdurajrD5V4Wa3hCpb9Xh9lHR9uMyxtN81d5ItWKhdE8XB
	 CjzpjpPxhb0VQT7q55EIUV6Q5tf/ybHmvFHldULJqxeULykQ8cs4d6cUcfqmfkK2+w
	 MD0wjLOfyA/CVIjuywzmS2lGUrpGSNmbtmFOtQhI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgCXRvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:51:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbgCXRvT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:51:19 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36D6E206F6;
        Tue, 24 Mar 2020 17:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585072278;
        bh=szCP8ae/BMdZYRhBOIOQJx5y/E+NJm+aMJfn2m9sUPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rHfh6nOothlmUSQknN4QBRYXBV6oTXyh+YTeQ4AbjkUxR74pyQ8iVJnBqyD3W1DAM
         nHzBWYHLVtUXChPyKsh3EDsFgd3omeAIzUa+SqjP5mg3NoiqsVx0DKHTCe8kXT/6Mx
         VUiuIWMtSW0zO0o0m1WzawcMZXQRZDBqYy7a2jc4=
Date:   Tue, 24 Mar 2020 17:51:14 +0000
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 1/4] sparc32: mm: Fix argument checking in
 __srmmu_get_nocache()
Message-ID: <20200324175113.GA16742@willie-the-truck>
References: <20200324104005.11279-1-will@kernel.org>
 <20200324104005.11279-2-will@kernel.org>
 <CAKwvOd=_v__=b6ijFYkxgDsmxakmkxwDWFG48601Gh9cyhj3PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=_v__=b6ijFYkxgDsmxakmkxwDWFG48601Gh9cyhj3PA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 10:41:52AM -0700, Nick Desaulniers wrote:
> On Tue, Mar 24, 2020 at 3:52 AM Will Deacon <will@kernel.org> wrote:
> >
> > The 'size' argument to __srmmu_get_nocache() is a number of bytes not
> > a shift value, so fix up the sanity checking to treat it properly.
> >
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  arch/sparc/mm/srmmu.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> > index f56c3c9a9793..a19863cac0c4 100644
> > --- a/arch/sparc/mm/srmmu.c
> > +++ b/arch/sparc/mm/srmmu.c
> > @@ -175,18 +175,18 @@ pte_t *pte_offset_kernel(pmd_t *dir, unsigned long address)
> >   */
> >  static void *__srmmu_get_nocache(int size, int align)
> >  {
> > -       int offset;
> > +       int offset, minsz = 1 << SRMMU_NOCACHE_BITMAP_SHIFT;
> >         unsigned long addr;
> >
> > -       if (size < SRMMU_NOCACHE_BITMAP_SHIFT) {
> > +       if (size < minsz) {
> >                 printk(KERN_ERR "Size 0x%x too small for nocache request\n",
> >                        size);
> > -               size = SRMMU_NOCACHE_BITMAP_SHIFT;
> > +               size = minsz;
> >         }
> > -       if (size & (SRMMU_NOCACHE_BITMAP_SHIFT - 1)) {
> > -               printk(KERN_ERR "Size 0x%x unaligned int nocache request\n",
> > +       if (size & (minsz - 1)) {
> > +               printk(KERN_ERR "Size 0x%x unaligned in nocache request\n",
> 
> Was modifying the printk intentional? int vs in ?

Yes, I think "int" is a typo so I just fixed it up while I was here. Do you
prefer the old way? I couldn't parse it at first, but now you mention it
I suppose the type of 'size' is int, so *maybe* it makes sense after all!

Will
