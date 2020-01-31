Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03CF0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF01214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f51xeAjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgAaRqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 12:46:19 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41772 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgAaRqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 12:46:19 -0500
Received: by mail-yw1-f68.google.com with SMTP id l22so5497241ywc.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 09:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ITIYxvjdW6ILwWjvX2q5KM4Bzin3GdLXvp+v9lOz74=;
        b=f51xeAjbaVVP2IVpMfik9MTfen2NXpvClIXLVLIYOetotxF5htPYc8GsLV1l/I5hVp
         h0sKKB3M+TCM7FVtW72qf1cOVYbmBmDXaCwnFbym4AaJ/y/70JMvqkhcXASMoYkLRW0/
         JbFS1nKPC1Eqpl/YYUJ4B+onY7flQFuZ97rn+SBEB581DzfbKOF0CrMAsERj15kREJsW
         NIraCl9smResGaW8WxnirUxmCdDw5y3+JNUPlwY5TIuP5MSVCmMtVY7EUeX/N07K4SSF
         RTAIMP713WAlZEP30cl668OM5afd43ncdPfNTOqDv+M96mI+hDI4d432MwZ4ZnEFhLTv
         A8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3ITIYxvjdW6ILwWjvX2q5KM4Bzin3GdLXvp+v9lOz74=;
        b=SjUI0eh6wCQh6aKlJwnK7c/8xBGOIkUR79vrtzacuwSCgRS+qHfdLegHwTRmcd0dp4
         eHRcpZy22Wnf+apQwHpN3O6zmYWqnLE/5Vl02Tdlj8lSyTE90GLZTIEbnbHYjF74on36
         AmY4lS7eJFmVPFB3AZQlqy3XZhi7CfpJh6kPmrsjz0BVbAwm/rklQvHBll8AGwIRAIos
         9yUcqxIVn7p7MTHg5vr+IyKJGsAr+b07YJGOYrmBDRgodSLQZiQgt34OIgIbzhnh4hlg
         wqfj5YY5UDgZ3bI2DN/j0tEIge+jccE2LOlXEOurPfrfEg3l/4Tmc+g/DaVeCwoSsmQC
         YXuw==
X-Gm-Message-State: APjAAAXnExy8SC3G1gra3MXdTeoh87YaCePG4qYHa9eMgAu/DPa63ljc
        eWyhORcokPcEdos6PotQKEM/AkM05Kp3RaY1CcNqwQ==
X-Google-Smtp-Source: APXvYqxqvZ9Xc7xE+6WNWw3wmhWcDmQC9NooOnMpVI4gHyQgeHuUh2qykrD9sDt6rtakTAB7lfETi0K2DHa5eBJtjpc=
X-Received: by 2002:a25:d9d4:: with SMTP id q203mr1615912ybg.274.1580492777976;
 Fri, 31 Jan 2020 09:46:17 -0800 (PST)
MIME-Version: 1.0
References: <20200130191049.190569-1-edumazet@google.com> <e0a0ffa9-3721-4bac-1c8f-bcbd53d22ba1@arm.com>
 <CANn89i+fRqeSAz9eH8f2ujzBWSLUXw0eTT=tK=eNj8hL71MiFQ@mail.gmail.com>
 <f870ae85-995f-7866-ebbd-95b89ca28dc5@arm.com> <CANn89iKfA+yPHiL4R7-jkewwhDgM6jkwhW5o9H=VL9CnyBikhw@mail.gmail.com>
 <62e1ee46-ad9e-988f-a2a3-8fd217e28f24@arm.com>
In-Reply-To: <62e1ee46-ad9e-988f-a2a3-8fd217e28f24@arm.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 31 Jan 2020 09:46:06 -0800
Message-ID: <CANn89iKmFMiOStfcRdKXe=mks65dhkXPTawqevY8YwyUbfSjhg@mail.gmail.com>
Subject: Re: [PATCH] dma-debug: dynamic allocation of hash table
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 9:43 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 31/01/2020 2:42 pm, Eric Dumazet wrote:
> > On Fri, Jan 31, 2020 at 4:30 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >>
> >> ...and when that represents ~5% of the total system RAM it is a *lot*
> >> less reasonable than even 12KB. As I said, it's great to make a debug
> >> option more efficient such that what it observes is more representative
> >> of the non-debug behaviour, but it mustn't come at the cost of making
> >> the entire option unworkable for other users.
> >>
> >
> > Then I suggest you send a patch to reduce PREALLOC_DMA_DEBUG_ENTRIES
> > because having 65536 preallocated entries consume 4 MB of memory.
>
> ...unless it's overridden on the command-line ;)
>
> > Actually this whole attempt to re-implement slab allocations in this
> > file is suspect.
>
> Again that's a matter of expected usage patterns - typically the
> "reasonable default" or user-defined preallocation should still be
> enough (as it *had* to be before), and the kind of systems that can
> sustain so many live mappings as to regularly hit the dynamic expansion
> path are also likely to have enough memory not to care that later-unused
> entries never get 'properly' freed back to the kernel (plus as you've
> observed, many workloads tend to reach a steady state where entries are
> mostly only transiently free anyway). The reasoning for the exact
> implementation details is there in the commit logs.
>
> > Do not get me wrong, but if you really want to run linux on a 16MB host,
> > I guess you need to add CONFIG_BASE_SMALL all over the places,
> > not only in this kernel/dma/debug.c file.
>
> Right, nobody's suggesting that defconfig should "just work" on your
> router/watch/IoT shoelaces/whatever, I'm just saying that tuning any
> piece of common code for datacenter behemoths, for quality-of-life
> rather than functional necessity, and leaving no way to adjust it other
> than hacking the source, would represent an unnecessary degree of
> short-sightedness that we can and should avoid.
>
> Taking a closer look at the code, it appears fairly straightforward to
> make the hash size variable, and in fact making it self-adjusting
> doesn't seem too big a jump from there. I'm happy to have a go at that
> myself if you like.


Sure, go ahead, I have no plan implementing changes for 20 years old platforms.

Thanks.
