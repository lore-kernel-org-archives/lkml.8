Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91512C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 01:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FDBF20707
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 01:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593222972;
	bh=J44RlSi5yOrs4ukp3eXEYnjsxqJTuPNplj0TLIojS7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i3z7EnjZ9lYRxH5I3+03KKHNI1NBbhiGYXs5DYjaX+sRTB4cqdcyV72x2Do4EzTrr
	 JAODlOdQ1fgYhw5Ka3bdDPDPxjbes6sb2h51Vyw8SH+YIsKeViSqG9ao8CL65Lo6qF
	 vgtKwQJ6qeJIbjSBX5zdJKLpvLYibGejGlQtRFX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgF0B4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 21:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgF0B4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 21:56:09 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F18C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 18:56:09 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 80so10596342qko.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 18:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eNNnys0Y38U0meAwa0qb/kXZuljehpOrnFYEkKeK5zM=;
        b=BcUIK8n+dK48nmIw5mnsxUI8YlxwS4QRtpKQq/Q8KrmLQuNZNTuKF9kFIwj4R5J4hu
         zdZUAg+EyxfD068zqhNAzfz0dhbafrjR6qe0Bj1G0e5pKco/uge99cZhWr9T+H3WWw+t
         KH2yIvISfTu4uwkO48RyVbNeHccFV5n4GkJNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eNNnys0Y38U0meAwa0qb/kXZuljehpOrnFYEkKeK5zM=;
        b=lV79SWct97BaG4GjZYoRngNc+H/d7B/vQ7PJqUgzN+GJY/dLoHosBCnpkYpe1gb3Oa
         q/5JwvGjRMgu22QWP+VYWilqbgHeo3JfKfrIkYFRe3klglBUqCu+tHY5eKOXQk7ISipR
         Maot2M2tBvQk2Y7cRWBPOBCIQeOVq0+MCLwsRUwHv7lowFGE4lDjDZwxtbCDZNydtv7M
         c3/mWJAdc0bH/Ywu5ApAb5fROPDgjQo/MhysS94wUlfyat2xoJ7xq4nzzkHiZQoXHTqD
         En8jEHa6hkylOJZ8mTMgttSqK8/wSGKi2X4wNOXnVQKQh0/hALrZyd3qEw66wMctZHiT
         oM4A==
X-Gm-Message-State: AOAM533G/FAr04zDPzRCnWP8EMQg4aQ/jvnXy03BrXtjEM40I3jx+1aN
        mZON50hzvzHC3vhk3esNt8VWJA==
X-Google-Smtp-Source: ABdhPJwiL+lwgfwror6NArFC+0VEEXmanhmjCzVgS3HLFAt4AT+Xaz/hQ7RNW2IcEyXFTsLZ+GMxmA==
X-Received: by 2002:a05:620a:14b6:: with SMTP id x22mr5350971qkj.448.1593222968270;
        Fri, 26 Jun 2020 18:56:08 -0700 (PDT)
Received: from i7.mricon.com (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id o4sm11131225qtb.17.2020.06.26.18.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 18:56:07 -0700 (PDT)
Received: by i7.mricon.com (sSMTP sendmail emulation); Fri, 26 Jun 2020 21:56:05 -0400
Date:   Fri, 26 Jun 2020 21:56:05 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the block tree
Message-ID: <20200627015605.goc2btyq6z3wwb5z@chatter.i7.local>
References: <20200627090740.683308fd@canb.auug.org.au>
 <6920f023-5909-6ebf-606c-dbf467a31c7c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6920f023-5909-6ebf-606c-dbf467a31c7c@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 07:32:15PM -0600, Jens Axboe wrote:
> On 6/26/20 5:07 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > In commit
> > 
> >   cd664b0e35cb ("io_uring: fix hanging iopoll in case of -EAGAIN")
> > 
> > Fixes tag
> > 
> >   Fixes: bbde017a32b3 ("io_uring: add memory barrier to synchronize
> > 
> > has these problem(s):
> > 
> >   - Subject has leading but no trailing parentheses
> >   - Subject has leading but no trailing quotes
> > 
> > Please do not split Fixes tags over more than one line.
> 
> Gah, that's b4 messing it up. I've actually seen this before, but
> I caught it. If you look at the actual commit, this is what the b4
> output ends up being for the fixes line:
> 
> [snip]
> io_kiocb's result and iopoll_completed")
> 
> Fixes: bbde017a32b3 ("io_uring: add memory barrier to synchronize
> 
> even though it's correct in the email. I'm guessing some issue having to
> do with the longer line?

Yeah, I'll try to see if there's something I can do here, but it's going 
to be largely guesswork. Here's the original email:

https://lore.kernel.org/lkml/22111b29e298f5f606130fcf4307bda99dbec089.1593077359.git.asml.silence@gmail.com/raw

The Fixes: footer really does get split into two. It's not that hard to 
add logic just for the Fixes tag (since it conveniently follows a set 
pattern), but finding a universal fix for split footers will be more 
difficult.

I'll see what I can do.

-K
