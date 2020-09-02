Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148D7C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C602071B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599068767;
	bh=dQfeSH9/3D4Fw7dc4c6EHH61Lfy1xqHV+cPUMjWvzpY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PeRe9XJvbYKxsUwsy2vVbXjh+JqxRzWkQ2YHcgb/bPP9lcBAA989YuFGMwVSyE6M+
	 Umch/Pejt9M26/sgdBMuZpSOmAx03jKbc4PXjrjIwcOkCRn/mpSs31XQrcA0uyeHJK
	 vqNeolViwOnPUxIZc3WhHd3JLY9i8P2DrFCzkQ7A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgIBRqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:46:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgIBRqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:46:05 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B654C2071B;
        Wed,  2 Sep 2020 17:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599068764;
        bh=dQfeSH9/3D4Fw7dc4c6EHH61Lfy1xqHV+cPUMjWvzpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AA9Y6oFf/CF0xKwL6jw2HYolcPLLKopjRauU5YDHgSHXf/sFkJn/JXQ9ii6uS2mur
         bGdkp22QFbG8vZhk74otc8DdSVpYk5iLRajsmX9ftIJ/11ILvKElfv8DrzvxwwQFCJ
         2Ka2hA2JO/Ct80LcR5xPZJmHBEk8PVeXBecjcoek=
Date:   Wed, 2 Sep 2020 20:46:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH rdma-next 1/4] gcov: Open-code kmemdup() to work
 correctly with kernel and user space pointers
Message-ID: <20200902174600.GK59010@unreal>
References: <20200902085513.748149-1-leon@kernel.org>
 <20200902085513.748149-2-leon@kernel.org>
 <CAHk-=wiOJ4H=YFO8+EumOcrciQgeKXY1Z92jdqY8OQdprPXkbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiOJ4H=YFO8+EumOcrciQgeKXY1Z92jdqY8OQdprPXkbg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 10:38:20AM -0700, Linus Torvalds wrote:
> On Wed, Sep 2, 2020 at 1:55 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > The kernel with KASAN and GCOV enabled generates the following splat
> > due to the situation that gcov_info can be both user and kernel pointer.
>
> I can't parse the above explanation..
>
> > It is triggered by the memcpy() inside kmemdup(), so as a possible solution
> > let's copy fields manually.
>
> .. and I don't see why copying the fields manually makes a difference.
>
> Can you explain more?

Definitely my explanation is wrong, but it was my interpretation of
"BUG: KASAN: global-out-of-bounds in kmemdup+0x43/0x70" line. I saw
that the failure was in memcpy() inside of kmemdup(), so I changed
from memcpy to be copy_from_user() and it solved the KASAN warning.

This is why I wrote "both user and kernel pointer".

Thanks

>
>              Linus
