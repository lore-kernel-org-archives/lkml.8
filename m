Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0C6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3724C207FC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 00:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596587259;
	bh=Gg+fNMDA2rH2/DribirD5L0L5F6Dq/Rcjnj/sfskhlU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mLcf2kEpLNGYEKr00PbX/HRTPtbb4wSAkgLpxP2xJ9RLHFhoUKMt8lf9GwqT/uk/i
	 QeYwC7HsUqctfUB3ZdOrKLrJwS0A/BRnOngZBjZ9XjGBLrf0LrfxuaJBxytNZ37pdU
	 AMHa/t/WaIP3iI1FJ+5DHW6uqCvygo1BuF8VP1qA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgHEA1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 20:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgHEA1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:27:37 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27510C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 17:27:37 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 140so23324941lfi.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 17:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aRzjxX7tMJuaWKfVtsDl4Y42/Ig7shlqkwOGQIcTSRQ=;
        b=NGY21/R4udjUWqWUuE29th5GhB21TE+LcpWje0nFGy/Uj2NwRI6Xhd319TS5xSPQXF
         2ZSqgsMO3jEEw/lseQVcH4zMTsHJNowcDgHJ4KpeDMRUymndkPdT+F38URc2amyk31ud
         rk0cIxFAdCcjGz3cdP4Bd7qvCVgTKMP1elMXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aRzjxX7tMJuaWKfVtsDl4Y42/Ig7shlqkwOGQIcTSRQ=;
        b=SVSn059KjqDLS0YVYrk/EpMKdrlMQCLwQ7roTOBRPJGrPETshP8Gt7dQAzFCApPnk+
         Ct9U8tGR7LSxYqDGMwr/wM1bMpmhQ+vSH5qoe1m23bNbIybIHM24RZ4DADXZgcqxRnDF
         oz++pjxhe2nK4SihK1SQxfi9f5ekDR3D3ONOJy3UP4pRBy6ManQ4cMVXLtAJ2WTsspkL
         6SgfkVqO81Har/b5wD6JYPAa7DRQyiOEoozdTwc/wjlYROx2no9qBqZM6sVzAyoAJSgG
         6f/V5GkLiTB9papLUFKYRM2T1sCUrMAHWCk3boTtRl/hENzw1G/kSY0qIu5mI5PDP0qQ
         VDUQ==
X-Gm-Message-State: AOAM530iNctQGbHXkJOyR8aFD9IxO8l9mEhO9aodm+2a6sF3tbnfGZ8P
        yQDUdfFt7zkRWeBuSCZUBj89sqQDFBY=
X-Google-Smtp-Source: ABdhPJztV6TawnwadhCqVpkqW7YMjQrJzG5GZ297y/DAsQjdSvFfbWICwMrvUdWpGFyA05C61Jhycg==
X-Received: by 2002:a19:7d04:: with SMTP id y4mr313530lfc.51.1596587255145;
        Tue, 04 Aug 2020 17:27:35 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id z22sm270071lfb.93.2020.08.04.17.27.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 17:27:34 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id 185so35419817ljj.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 17:27:33 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr161312ljf.285.1596587253494;
 Tue, 04 Aug 2020 17:27:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200803140726.GA752014@infradead.org>
In-Reply-To: <20200803140726.GA752014@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Aug 2020 17:27:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg1h_XfPbXvisfAUsXU-WiOeCJDUibhxZGu=x9w-VKB0A@mail.gmail.com>
Message-ID: <CAHk-=wg1h_XfPbXvisfAUsXU-WiOeCJDUibhxZGu=x9w-VKB0A@mail.gmail.com>
Subject: Re: [GIT PULL] configfs updates for 5.9
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Joel Becker <jlbec@evilplan.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 7:07 AM Christoph Hellwig <hch@infradead.org> wrote:
>
>  - propagate binary attribute errors (Lenny Szubowicz)

I pulled this, but I then unpulled again.

The commit is completely confused and wrong.

In particular, this part:

+       /* Only commit the data if no more shared refs to file */
+       if (file_count(file) > 1)
+               return 0;

is bogus and prone to races, meaning that if there are multiple
openers, *none* of them flush.

You can have two threads that close() at (roughly) the same time, both
call ->flush(), and both of those see "file_count()" being 2 and never
do anything.

They then both call "fput()" and are done, and that's when the file
count gets decremented.

The fact is, "flush()" is called for each close(), and you should
flush any pending data. Checking for some file_count() thing is bogus
and completely wrong.

So make up your mind: either you flush synchronously at *every*
close() (->flush) and you can get error notification.

Or you flush at the last close (->release), but then you absolutely
cannot get any error reporting, because the last put of the file may
be long after the last close (because other things than just
open/close can increase the refcount).

You can't try to do some middle ground, because it _will_ be buggy.
You have the above two options, not some racy third one.

             Linus
