Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF31C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 08:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785042075B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 08:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klcKuRCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgCGIMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 03:12:19 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39524 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgCGIMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 03:12:18 -0500
Received: by mail-lj1-f193.google.com with SMTP id f10so4673576ljn.6
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 00:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IGhdkLipwKOOV+JvlxKvVpdLJ5LYrh8XAFPilMuz7l8=;
        b=klcKuRCUw2aWX0unWAvaUtNlY5k+megxTvNwvuUhwxvg15pIJ7f9YDETDzf1PBRBWy
         SNz3SInuMJKvgoAgd2zhgsTTLAkDVQZREsvmUe5Xo4ahmnzYlyZJP9B1lC2GGculR87V
         SpOb3uUih2mzK2ymAAs8MPUYN2/GhIC3sIltHZMZtDgN+6QQdf5Oaauomd5z/Xf63EOd
         4pS8YnjXiW8mGdbkZ4QXLNznBchuHuFXnmR9ch8G6h9X5eGd5MGYWIkrSMVFIPOiSMRA
         rnVOdQWAmZMMIZXkUJ5JodWC+ajIagtVjTP9wMIb/9LMiXmAfix82nF5wzojs5vf7U5C
         b9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IGhdkLipwKOOV+JvlxKvVpdLJ5LYrh8XAFPilMuz7l8=;
        b=KTupNntSTx3qsBVI0sNbFZnYR2oM6OnghhREaAqbDT0v9VRO7zJ5qty4JDqVQd0X4E
         gx+c6DLLHEMXqnPMuuiLuKscoSNk0rkGcKePbFmt8LXPA/5sq5tw0n+dTEElxTtW920h
         cP2UJasX/8WrU6WMBuxDfpn04/GhvaGeeDaQ9bIGEDV71oFYDInkgr3cHynPzZccmD6O
         S4Vdl0UqtRcW0+QSg89Ov35fQ3Ez+e5aZ0z2hGgpD7PFLkDn+VRQla1yl8PBVWzFDB2Q
         NyGONW9AXt6SRTCOgbCPvZGHFyR4gbu4Q0fHx8JKtAOEB6gqGIFByXpCgEvDhoN+RuE5
         Pkvg==
X-Gm-Message-State: ANhLgQ2MxneLXtp91+GXKntQQFB1QAwY4SqLg9mxjkre3uPbItGBid79
        LnpRSHy3wp6xirt9O9Pno0c=
X-Google-Smtp-Source: ADFU+vvk35IjYO+WwsRErqt/bbqVrFyNPzN06OjdpWUh9mrXBV6QNxKDnnqpozVwI3D2Hd8P8nXZ6w==
X-Received: by 2002:a2e:b5d9:: with SMTP id g25mr4241746ljn.170.1583568735828;
        Sat, 07 Mar 2020 00:12:15 -0800 (PST)
Received: from localhost ([46.159.134.13])
        by smtp.gmail.com with ESMTPSA id b15sm12055855ljj.100.2020.03.07.00.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2020 00:12:14 -0800 (PST)
Date:   Sat, 7 Mar 2020 00:12:08 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/bitmap: rework bitmap_cut()
Message-ID: <20200307081208.GA21695@yury-thinkpad>
References: <20200306221423.18631-1-yury.norov@gmail.com>
 <20200307001856.5181eda7@elisabeth>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307001856.5181eda7@elisabeth>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 07, 2020 at 12:18:56AM +0100, Stefano Brivio wrote:
> Hi Yuri,
> 
> I haven't reviewed the new implementation yet, just a few comments so
> far:
> 
> On Fri,  6 Mar 2020 14:14:23 -0800
> Yury Norov <yury.norov@gmail.com> wrote:
> 
> > bitmap_cut() refers src after memmove(). If dst and src overlap,
> > it may cause buggy behaviour because src may become inconsistent.
> 
> I don't see how: src is always on the opposite side of the cut compared
> to dst, and bits are copied one by one.

Consider this example:
int main()
{
	char str[] = "Xabcde";
	char *s = str+1;
	char *d = str; // overlap

	memmove(d, s, 5);
	printf("%s\n", s);
	printf("%s\n", d);
}

yury:linux$ ./a.out
bcdee
abcdee

After memmove(), s[0] == 'b', which is wrong.

In current version src is used after memmove() to set 'keep', which
may cause similar problem

> Also note that I originally designed this function for the single usage
> it has, that is, with src being the same as dst, and this is the only
> way it is used, so this case is rather well tested. Do you have any
> specific case in mind?

No. Do you have in mind a dst != src usecase?
 
> > The function complexity is of O(nbits * cut_bits), which can be
> > improved to O(nbits).
> 
> Nice, indeed.
> 
> > We can also rely on bitmap_shift_right() to do most of the work.
> 
> Also nice.
> 
> > I don't like interface of bitmap_cut(). The idea of copying of a
> > whole bitmap inside the function from src to dst doesn't look
> > useful in practice. The function is introduced a few weeks ago and
> > was most probably inspired by bitmap_shift_*. Looking at the code,
> > it's easy to see that bitmap_shift_* is usually passed with
> > dst == src. bitmap_cut() has a single user so far, and it also
> > calls it with dst == src.
> 
> I'm not fond of it either, but this wasn't just "inspired" by
> bitmap_shift_*: I wanted to maintain a consistent interface with those,
> and all the other functions of this kind taking separate dst and src.
> 
> For the current usage, performance isn't exceedingly relevant. If you
> have another use case in mind where it's relevant, by all means, I
> think it makes sense to change the interface.
> 
> Otherwise, I would still have a slight preference towards keeping the
> interface consistent.

There is no consistent interface. Bitmap_{set,clear) uses one
notaton, bitmap_{and,or,shift) - another. I think that 'unary'
operations should not copy the whole bitmap. If user wants, he
can easily do it. In practice, nobody wants.

> By the way, I don't think it's possible to do that keeping the
> memmove(), and at the same time implement the rest of this change,
> because then we might very well hit some unexpected behaviour, using
> bitmap_shift_right() later.

I think it should work. Can you elaborate?

> All in all, I don't have a strong preference against this -- but I'm
> not too convinced it makes sense either.
> 
> -- 
> Stefano
