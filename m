Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86962C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 21:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 673AF20758
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 21:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="clGboMqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgEQVbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 17:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgEQVbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 17:31:02 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA654C05BD09
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 14:31:00 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id b8so3833252pgi.11
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 14:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nl1jPUv4ba/yAtewxEYF9Vx5ehHzan7FcPOetz1sGxI=;
        b=clGboMqEVH0oyyAstusWn9pLsPGuJI2qTXOqf/fLKtmNWoo8PU8U4KP2i1KZsbuaVt
         ZVGmYLRPYusSG7WQp27LnGotSSiVFtdWBjg36zFTERbOW+EMPqf6y69jWaRLHHT/vias
         cVIIdpg0UDwKIC22zDZF7idLsYnz1Rns+G0xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nl1jPUv4ba/yAtewxEYF9Vx5ehHzan7FcPOetz1sGxI=;
        b=UqhQRdOxepogutGZj+9FK+wRtrYYK6zoil+9G7FTeHO0/kePu1uONW2KWi8KJNWIhM
         YzrohQHViGVxMKG4t3mnw5APxjJD/QZIxWWZCQpJ7M45jCrL33DMZSntW71f2npYAFXa
         p7n/pMLqhHrMzsJxEbV7QHs+grJKDo3y53w1havr+ndZQaE/ZHWv6KE7CTsi9lGKs44O
         ErM8EhU+xoVQm//BTFv8ysuhQF2pmFM6XIZcbR13Wg26UQWmXrGgSIGc38EA9gq9aA13
         ojgv6cAZLluJaUe8twLvR/8haSpdNGiWXnkBV8pem4P/TrlDNlzO7EhzZHP9Zu4TqUPB
         L6LQ==
X-Gm-Message-State: AOAM533EodS41jyC24Bks2cQEeWgYvkp+a8EjG2IhHCXD72wP1dGzT1o
        hAJoV0Qxn3pifiGyJ4BwZB4lV1/dtYA=
X-Google-Smtp-Source: ABdhPJzCfFU0gNS2Aq6V0833NEvmUA1835E1WIVVA7nMgWzPKZOvAUqjmi04Tqob8alVDia22+egKA==
X-Received: by 2002:a62:6041:: with SMTP id u62mr7558083pfb.62.1589751060296;
        Sun, 17 May 2020 14:31:00 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b74sm6106085pga.31.2020.05.17.14.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 14:30:59 -0700 (PDT)
Date:   Sun, 17 May 2020 14:30:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Aleksa Sarai <asarai@suse.de>, linux-api@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] seccomp: Add group_leader pid to seccomp_notif
Message-ID: <202005171428.68F30AA0@keescook>
References: <20200515234005.32370-1-sargun@sargun.me>
 <202005162344.74A02C2D@keescook>
 <20200517104701.bbn2d2rqaplwchdw@wittgenstein>
 <20200517112156.cphs2h33hx2wfcs4@yavin.dot.cyphar.com>
 <20200517142316.GA1996744@cisco>
 <20200517143311.fmxaf3pnopuaezl4@wittgenstein>
 <20200517144603.GD1996744@cisco>
 <20200517150215.GE1996744@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200517150215.GE1996744@cisco>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 17, 2020 at 09:02:15AM -0600, Tycho Andersen wrote:
> On Sun, May 17, 2020 at 08:46:03AM -0600, Tycho Andersen wrote:
> > On Sun, May 17, 2020 at 04:33:11PM +0200, Christian Brauner wrote:
> > > struct seccomp_notif2 {
> > > 	__u32 notif_size;
> > > 	__u64 id;
> > > 	__u32 pid;
> > > 	__u32 flags;
> > > 	struct seccomp_data data;
> > > 	__u32 data_size;
> > > };
> > 
> > I guess you need to put data_size before data, otherwise old userspace
> > with a smaller struct seccomp_data will look in the wrong place.
> > 
> > But yes, that'll work if you put two sizes in, which is probably
> > reasonable since we're talking about two structs.
> 
> Well, no, it doesn't either. Suppose we add a new field first to
> struct seccomp_notif2:
> 
> struct seccomp_notif2 {
>     __u32 notif_size;
>     __u64 id;
>     __u32 pid;
>     __u32 flags;
>     struct seccomp_data data;
>     __u32 data_size;
>     __u32 new_field;
> };
> 
> And next we add a new field to struct secccomp_data. When a userspace
> compiled with just the new seccomp_notif2 field does:
> 
> seccomp_notif2.new_field = ...;
> 
> the compiler will put it in the wrong place for the kernel with the
> new seccomp_data field too.
> 
> Sort of feels like we should do:
> 
> struct seccomp_notif2 {
>     struct seccomp_notif *notif;
>     struct seccomp_data *data;
> };

I'm going read this thread more carefully tomorrow, but I just wanted to
mention that I'd *like* to extend seccomp_data for doing deep argument
inspection of the new syscalls. I think it's the least bad of many
designs, and I'll write that up in more detail. (I would *really* like
to avoid extending seccomp's BPF language, and instead allow probing
into the struct copied from userspace, etc.)

Anyway, it's very related to this, so, yeah, probably we need a v2 of the
notif API, but I'll try to get all the ideas here collected in one place.

-- 
Kees Cook
