Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D85C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7EAF22BF3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596489056;
	bh=Zntgb1IKBKruUSqK5NDfCgopJUFSeU3A1wK1R69Of68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dg9nUMckypJlVrTVUlPTyuwyFz6oQuRNF8VencCyKFw/uue14/BZ74rZMW17Bthi9
	 Pc7kBaxE897PMaTqnrcQMGkrjxtleWdRMl/NQZZdT6UH9z8kmyBN1IYaGYxmGCCZ+C
	 K9aa+sO0yNGDply9ClMYFZ0uzT9Ea1rZM4xEkpcQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgHCVKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgHCVKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:10:55 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A0B9C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 14:10:55 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id e5so15346517qth.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=crxxw8rThRklFBNXR7vpbUEyywjHEaTiMUtvnHuY1yc=;
        b=TsnxLlOKfC5W3tP760pOKGzK2aJTE0DxwhHZchzQAVeTO33l63LCzeuir04zRUZ3M5
         wDNBEPRrwgPTeplKvBpxlRJjEkBu8eJswiXJ9+GSCtDPmYZYl95UzbYMyDCNRWstQVuR
         xLXeRRw8YMvy2f+ID/iQ95v7IZAqvw9mApRVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=crxxw8rThRklFBNXR7vpbUEyywjHEaTiMUtvnHuY1yc=;
        b=MXyD6EytiRUoeSwLQW+c957WxI4vi8YIOrxjBBSbdBwzgckv/ApCSpBkDshF8LKAQy
         XVqxTLV/GlAlptE0KODdqE1cHP5lK33WfPgxBSptK2cdNbzgCvz/OHM/kJe8Z1+S+mWA
         jYk4XqZTdeXa3Jz2A0DVeVDZZqjnxFYpp/aTj5syCcv2blu0JSqVgKOThowxNrjCYevT
         bKxOOefIXnmDWysEVbRA6Us/HkUw7FtlFDpVHU+fz7GCWRkM94hq5im/2OZdPg3reTaE
         RuIm1M/FbuCGjaWTHiIIA1faBMwf/V77zbSasT9CAQIm4VaJOAgVF9ZAC2rwcaqUOg7J
         tLKw==
X-Gm-Message-State: AOAM5316ddqK49F+d/JSGxNBXIyfQfUQOIAAyYY8z90dlWttn9JK4QWn
        rpmwj2PsfA8lex/ayJGnFo+OtWyAt+o=
X-Google-Smtp-Source: ABdhPJx0FSvnnuJJ0t3/OEm3KNmXk091dowACULZGY4A0SuNrYsVDLzoiHzLzNWnGAoxe2OMjjaZdg==
X-Received: by 2002:ac8:4e28:: with SMTP id d8mr18623709qtw.134.1596489054039;
        Mon, 03 Aug 2020 14:10:54 -0700 (PDT)
Received: from chatter.i7.local ([87.101.92.156])
        by smtp.gmail.com with ESMTPSA id o25sm1806541qkm.42.2020.08.03.14.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:10:53 -0700 (PDT)
Date:   Mon, 3 Aug 2020 17:10:50 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] io_uring changes for 5.9-rc1
Message-ID: <20200803211050.ib2km76lch5abnjb@chatter.i7.local>
References: <50466810-9148-e245-7c1e-e7435b753582@kernel.dk>
 <CAHk-=wgaxWMA7DVTQq+KxqaWHPDrXDuScX9orzRgxdi7SBfmoA@mail.gmail.com>
 <CAHk-=wjztm0K9e_62KZj9vJXhmid-=euv-pOHg97LUbHyPKwzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjztm0K9e_62KZj9vJXhmid-=euv-pOHg97LUbHyPKwzA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 01:53:12PM -0700, Linus Torvalds wrote:
> On Mon, Aug 3, 2020 at 1:48 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I've pushed out my merge of this thing [..]
> 
> It seems I'm not the only one unhappy with the pull request.
> 
> For some reason I also don't see pr-tracker-bot being all happy and
> excited about it. I wonder why.

My guess it's because the body consists of two text/plain MIME-parts and 
Python returned the merge.txt part first, where we didn't find what we 
were looking for.

I'll see if I can teach it to walk all text/plain parts looking for 
magic git pull strings instead of giving up after the first one.

-K
