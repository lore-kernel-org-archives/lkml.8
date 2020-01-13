Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA773C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 20:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CED2187F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 20:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578948753;
	bh=a4C03n1KgrsJmIToOaMx3niqTHgt3oaYJCNoDWV3wnQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k8zXgVzXmFVvTFBFPpljwnlTnNBfq1KBgaXdy6XdjTpla1gKZD8yhiqmtJwvq1/lo
	 nmsP5ojWAARVh0dKeKqAL6njKPnmbRC7UW1vnVF4UK87sIZJBWoXbaiNNI5UX37Vcb
	 PJ2SKgfbaq8NqMijnvBmT1JJPCWkWw1K2uDECU1E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgAMUwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 15:52:32 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36910 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgAMUwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 15:52:32 -0500
Received: by mail-qt1-f194.google.com with SMTP id w47so10398532qtk.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 12:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lsWiL3UnmG1D5Zt8iTnfdynsV+4fybuDrOYr1/WPZ2U=;
        b=P+UkFriYZumuinWVUg3IK8rta0OfS1X3Hw57A/u5ZIV+AWApAv2nBYU9uWRJ/LjaJ6
         0PBxZBHdWIBCCESdPsmx3CJu5+WXZvntMP+ioTo453ZJtGZgYSPuT5DH3R/5P3TY7d1Q
         nPYGILYJnQpgvu1Mx3zY0UMYlSkl46H51PZVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lsWiL3UnmG1D5Zt8iTnfdynsV+4fybuDrOYr1/WPZ2U=;
        b=AVzPb814mYVwydVVthXg7rltCu064NENP/AZ9bqioI4LmWFoaYpA6jAhHUzXOaUwDq
         y2QCPpiXqXgi7tpMjkbuaKVeobWWdWi7Js1WcVP/HB3HpOp6NT39uSluFXOyunlbOobb
         6Xbq80ph65XpNSHZIniRS6tWJYdDo7Duq3GOGM+TM1+zTqJKAQmjAKfmI7G2J+zLfWfz
         /f0smZaIPk4yzSbghKqmc/pUHIL2brIWFx7P+ZeWQvlr5qS7cx2RyMQ7J3jMcA5YoQCo
         5cOdW8KDg/NINP7trajd0ONYOsnTzFvhKMEz3SsPoh4LB8vJ5VwNnXF7maB99TkUG+1E
         wVfw==
X-Gm-Message-State: APjAAAW2edM/yGBfG0HcOoV8vjWbVchsBsBMpVbVqAI8Oosi+dqN+vvx
        W+QJUvJaaTpoYJJ/i4RqIWnTmQ==
X-Google-Smtp-Source: APXvYqwPFOS5t92sYuJVXrtCnYFX7G+y/A7AY5AqTqa2h5nzVyoVk4ENjGQm3E7H3mIV5p8MvmVQqg==
X-Received: by 2002:aed:2906:: with SMTP id s6mr491409qtd.12.1578948751464;
        Mon, 13 Jan 2020 12:52:31 -0800 (PST)
Received: from chatter.i7.local (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id r80sm5591176qke.134.2020.01.13.12.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 12:52:30 -0800 (PST)
Date:   Mon, 13 Jan 2020 15:52:29 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [GIT PULL] mtd: Fixes for v5.5-rc6
Message-ID: <20200113205229.v5xjcsljmivcaei4@chatter.i7.local>
References: <20200110154218.0b28309f@xps13>
 <CAHk-=wg=8=nTeOYGoAbJ=VjS47Nh4-_OFK9zKsK3mK4nAi2dNA@mail.gmail.com>
 <CAHk-=whdsFSX0gTOiNkTANONgHHVY+8jUd1DmY2SJpdNOq5xJw@mail.gmail.com>
 <20200111145004.htnpdf6oaiksryxz@chatter.i7.local>
 <CAMuHMdUtk9m+BNrH1BuqGxWXR5h1DZmUasHMVKNYFxsd5wa5YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdUtk9m+BNrH1BuqGxWXR5h1DZmUasHMVKNYFxsd5wa5YA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 09:02:44AM +0100, Geert Uytterhoeven wrote:
> > Things should be unstuck now, and at least this particular bug is 
> > fixed
> > -- hopefully it'll be smooth and automatic the next time the epoch rolls
> > over to 9.git.
> 
> Are you prepared for multi-digit epochs? ;-)
> They not only contain more than one digit, but compare incorrectly
> when using lexical sorting...

I had to check, but yes -- we start from 0 and count up until we get a 
"no such dir":
https://git.kernel.org/pub/scm/linux/kernel/git/mricon/korg-helpers.git/tree/pr-tracker-bot.py#n376

Best,
-K
