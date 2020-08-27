Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C910C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E032054F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598540300;
	bh=US6B5uc+zGUz3cqdCuABlRgDweW1qyTBY8615Hnz5oY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RkYWwLJ0AXpAukVGNYWWRKe1Okt3vtpu64usncr2aysAj1c6EEfpn1weyRl3qG/WT
	 sRAeT9nHEZxkJkNTF6QLGDCh5OWoydijxG/OYZb5Cv9ia3z/eXK75+H32Hwe1R4CeM
	 0qbEk0RVWmt+DYxSM5vj43QDHeRQf25/v7ZyIKdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgH0O5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:57:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729019AbgH0MZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:25:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F3B222CAE;
        Thu, 27 Aug 2020 12:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598530768;
        bh=US6B5uc+zGUz3cqdCuABlRgDweW1qyTBY8615Hnz5oY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rce3B+tWvgfEgfvlMb5RmczGZT5J+fmgYyXymlnc6GLeWD+Z+5o3wcnw9+f5ze47H
         a1HnkQDaZSznaaSYu/8jIl+xXvbUoZreIJQpuAmqL8VS4Wihzjqb5KrTYMYjhZcCSQ
         lQbt8IWlAGdz3aSFJB1+IPax4S3OvUbimej4p1S0=
Date:   Thu, 27 Aug 2020 14:19:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Allen Pais <allen.lkml@gmail.com>, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] linux/kernel.h: add container_from()
Message-ID: <20200827121941.GC420527@kroah.com>
References: <20200827013636.149307-1-allen.lkml@gmail.com>
 <202008261929.A50D0DB3E8@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008261929.A50D0DB3E8@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 07:31:40PM -0700, Kees Cook wrote:
> On Thu, Aug 27, 2020 at 07:06:36AM +0530, Allen Pais wrote:
> > Introduce container_from() as a generic helper instead of
> > sub-systems defining a private from_* API
> > (Eg: from_tasklets recently introduced in
> > 12cc923f1ccc: Tasklet: Introduce new initialization API)
> > 
> > The helper is similar to container_of() in argument order
> > with the difference of naming the containing structure instead
> > of having to specify its type.
> > 
> > Suggested-by: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Suggested-by: Jens Axboe <axboe@kernel.dk>
> > Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> Who can carry this so it can get used by multiple trees? Should I keep a
> git branch folks should merge when taking Allen's conversion patches?

I can put it in my driver core tree, and give everyone a stable, signed,
tag to pull it from so that it can get propagated everywhere, if that
makes it easy for others to use it now.

thanks,

greg k-h
