Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD827C28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 07:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85ABD20836
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 07:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588492051;
	bh=dFV2e4YWFSavsf0eXpuyLOj5IEY9P9HmvZlhRFbJusM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=c/ahcKmai/xuU3PbxXnqSTVoLA188MnUDC9BOa9TTi7uc6IJgjHRsMnoPs2BystOl
	 LutnyBYd48DenMZMC4Hg5qB2vFuf+Q5voH5yLFD+tGI2zU2n4+WUvTBPQ8Hq7NT9v0
	 C4JBZj3slAtfEU5InDKq6Iza8TRIMvOve0Xmwzlc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgECHra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 03:47:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbgECHr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 03:47:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 132492078E;
        Sun,  3 May 2020 07:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588492047;
        bh=dFV2e4YWFSavsf0eXpuyLOj5IEY9P9HmvZlhRFbJusM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cmWdjcWmqB5orlckKy6/wpOZpiYxX44UDsCoKYHqEQXDwrM5wOJBL3A+n48FhAeci
         Fq0da8AyvouA1ntX+V5+fdppYTv3sPhehD/L08sVrELUwlnaK/fowNKi6BlFLOGdmp
         O9eE3bQ5uwTFBKvhAv5yd6hWtGB4L24IuPiGSpxQ=
Date:   Sun, 3 May 2020 09:47:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Richard Yeh <rcy@google.com>
Cc:     Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>,
        Ben Chan <benchan@chromium.org>,
        Oscar Carter <oscar.carter@gmx.com>,
        Simon Que <sque@chromium.org>,
        John Joseph <jnjoseph@google.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gasket: Check the return value of
 gasket_get_bar_index()
Message-ID: <20200503074725.GC536697@kroah.com>
References: <20200501155118.13380-1-oscar.carter@gmx.com>
 <CANJCoRvCUFkRuSSM0egkMuAd5+kzve4CWvhQ3KkppZBSM8PGkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANJCoRvCUFkRuSSM0egkMuAd5+kzve4CWvhQ3KkppZBSM8PGkw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 05:59:18PM -0400, Richard Yeh wrote:
> Hi, as a new maintainer, I thought I would try to handle this one.

Great, as a start:

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

> This patch looks good to me. This new check properly protects against using
> a negative return value from gasket_get_bar_index() to index into a
> pointer. The gasket_get_bar_index function is called in two other places
> (old lines 845 and 1044) and both other places check the bar_index return
> value for negative values and return error values.
> 
> What is the next step in the process? How do I test the patch? Does Greg
> K-H take these patches directly, or is there something else I should do
> (looking at
> https://github.com/gregkh/presentation-linux-maintainer/blob/master/maintainer.pdf
> page
> 5: clone from
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git, ...)?

Just send a "Reviewed-by:" to the patch and I can take it from there.
Also, I strongly suggest going and talking to your co-maintainers for
exactly how to do this, normally at this point in the process you
already know this as it is usually an experienced developer doing the
maintaining.

thanks,

greg k-h
