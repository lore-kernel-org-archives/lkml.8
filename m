Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5C0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96BA420738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593022848;
	bh=aKoUFKrH5O7BLdgh2NGrLmk3cLjNfkXIlHLWQWndzGY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=E0HRNnaud2nhWAxu7dt/T79K4JMon5TSaQVOqFbHWKU0BprUXDEFjzeWHF9uW6UNs
	 ylZ0uwT3dNz19B+BMU0La+NBvDGc7zyL8K6YROwkOecVK72eNy2ZPddmyUc/1pafIh
	 QqTC/TWUp9XSogQXHreBL339ASYSiorMDPZCzSMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406029AbgFXSUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405969AbgFXSUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:20:46 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE1EC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:20:46 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id g139so1784433lfd.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XimJzMILNab/U2O86DvGdgMSVqfmt24O53XaiquNzaw=;
        b=L7dvV468TVxudpkNjmIRlLmBHK2l5b48IN4xUNH3aPEtkp1XT90rStcv+QUsXusvih
         KeRXgDNYrhAcX2vKUzDkxiPSqnGiGnHAQ0jBNRlLYQvbj2AURCzWYOjdNtogRaldMDPw
         0aU+0lz1SHvCoYW/zOH0AcY+lBWGDLMzZDupI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XimJzMILNab/U2O86DvGdgMSVqfmt24O53XaiquNzaw=;
        b=l5aobnNq6td4ebhfe3J6qB3QidIfpr8hxd/nqc4YVp+hZ0atPANEMYO+QnKRqLUAtE
         jZzS4E6taZDwsbpOCav179MFrpY6W8DBKb8UlgPx3oL7RuH2UKNoH9OcgVhPTy7Kb2f3
         ao+vrEWimaPorVHgQ8bFD5sUIA0rFSziGMp7BExw1tMRuwIh8AHo6haY+AsUQTDcx+PH
         F1RVd0jvskXKMKK+gPrxUbl70ZuHlLvJfo2Q8lwMPXKDCaQ6UJ1stKbPB4jbcR1BcmEy
         iYLSlx+dmV9VTdZk0eiX82J59XCe1yT0o9rAbuoLUQK8iaQzveCCB2HVpMVbRTDf8U1h
         72Iw==
X-Gm-Message-State: AOAM530EDOY6jdl4o6LztS9XALJ2EOkjyF4H0bYyX6DjmRT7ZWTlIpe2
        6k/maD20sgesPNlM7f2Qu2BQIAS7Fuc=
X-Google-Smtp-Source: ABdhPJyPHruhaTEMZ4bO6tWmTFBMjhDk8ZViql81OafVTcimXeoV/60DLWL3Sl3sz/33HjTg765D1g==
X-Received: by 2002:a05:6512:3107:: with SMTP id n7mr16548150lfb.63.1593022844181;
        Wed, 24 Jun 2020 11:20:44 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id u8sm5389022lff.38.2020.06.24.11.20.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 11:20:43 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id b25so31773ljp.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:20:43 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr13749439ljn.70.1593022842794;
 Wed, 24 Jun 2020 11:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200624162901.1814136-1-hch@lst.de> <20200624162901.1814136-4-hch@lst.de>
 <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com>
 <20200624175548.GA25939@lst.de> <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com>
 <20200624181437.GA26277@lst.de>
In-Reply-To: <20200624181437.GA26277@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Jun 2020 11:20:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgC4a9rKrKLTHbH5cA5dyaqqy4Hnsr+re144AiJuNwv9Q@mail.gmail.com>
Message-ID: <CAHk-=wgC4a9rKrKLTHbH5cA5dyaqqy4Hnsr+re144AiJuNwv9Q@mail.gmail.com>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file operations
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 11:14 AM Christoph Hellwig <hch@lst.de> wrote:
>
> So we'd need new user copy functions for just those cases

No. We'd open-code them. They'd look at "oh, I'm supposed to use a
kernel pointer" and just use those.

IOW, basically IN THE CODE that cares (and the whole argument is that
this code is one or two special cases) you do

    /* This has not been converted to the new world order */
    if (get_fs() == KERNEL_DS) memcpy(..) else copy_from_user();

You're overdesigning things. You're making them more complex than they
need to be.

Basically, I do *NOT* want to pollute the VFS layer with new
interfaces that shouldn't exist in the long run. I'd much rather make
the eventual goal be to get rid of 'read/write' entirely in favour of
the 'iter' things, but what I absolutely do *NOT* want to see is to
make a _third_ interface for reading and writing. Quite the reverse.
We should strive to make it a _single_ interface, not add a new one.

And I'd rather have a couple of ugly code details in odd places (that
we can hopefully fix up later) than have new VFS infrastructure that
will then hang around forever more.

                Linus
