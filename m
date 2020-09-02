Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E748C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE56207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599071292;
	bh=J4PlY6rRpkwbzfD6ImMwfCIe/YcqYI4thsAa35s0dgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zKawlpRIEGsEEkyLwEaKhAJvLdZ1w6GWu+EAP1HFn+aLBswZtw33gR2uTMCbXqH6Z
	 rgAQkuEnCe9q9INBiAD6AamgP1oEmeKNAUBDeK4yz5EacWQeJESLVxjMlDv+/iMdBw
	 lBB8ol77xwqi7Ywuau/R1HvjQ+rFXdYFo4GFNNas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgIBS2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:28:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:41662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBS2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:28:09 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2754207EA;
        Wed,  2 Sep 2020 18:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599071289;
        bh=J4PlY6rRpkwbzfD6ImMwfCIe/YcqYI4thsAa35s0dgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O6WBXSdUwE00qp1j+UJwCwePf9dtUIBDg4Ov4z9CvrWMU/OYDKMlQhbY1cjyNU6H9
         hRGONKzsEq6GW6joWkr348vBCA6iHGO290CjvthQziTAncUKXn7EMiU8Gd9PmZ6rsN
         LR0PeeEi/tScoLRDY7bbyrqh0SM6OqBVRDzvvF90=
Date:   Wed, 2 Sep 2020 21:28:05 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -rc 0/4] Protect from GCC garbage input in GCOV
Message-ID: <20200902182805.GM59010@unreal>
References: <20200902085513.748149-1-leon@kernel.org>
 <CAHk-=whURzFKdBsoHCVsy4VU-cmAKBQEhkiS8Y8TQ9nRgAbP8g@mail.gmail.com>
 <20200902175241.GL59010@unreal>
 <CAHk-=wj6Wi7MTAMDWqcnp+cpDWvT-+o5-MEbuxJjzBkFKpfpPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj6Wi7MTAMDWqcnp+cpDWvT-+o5-MEbuxJjzBkFKpfpPg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 11:24:50AM -0700, Linus Torvalds wrote:
> On Wed, Sep 2, 2020 at 10:52 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > Are you suggesting something like this?
> >
> > diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
> > index 3110c77230c7..bc0e355f64aa 100644
> > --- a/kernel/gcov/Kconfig
> > +++ b/kernel/gcov/Kconfig
> > @@ -3,7 +3,7 @@ menu "GCOV-based kernel profiling"
> >
> >  config GCOV_KERNEL
> >         bool "Enable gcov-based kernel profiling"
> > -       depends on DEBUG_FS
> > +       depends on DEBUG_FS && (GCC_VERSION >= XXX && GCC_VERSION < YYY)
> >         select CONSTRUCTORS if !UML
> >         default n
> >         help
>
> Yes. Except please don't mix it up with DEBUG_FS. Just add a new
> "depends on" line. They are separate issues.

Thanks, I'll do and resend.

>
>               Linus
