Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B006C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05EDF2065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O3RcdCC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbgGOIsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbgGOIsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:48:10 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557C6C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:48:10 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x8so2102217plm.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qnhFJ16AfACROoupr0uxF/NZlSmJRV5Jft/zULE7Grs=;
        b=O3RcdCC88GcY5PgG/zjp9j2CcHjun8IZ9uMwrKE6MWEOzk230IMFzETWYRcSKfTV5A
         85TsDtwcOJ7PCfxQyoQmHOLjNxvwcxG+ExC6FOhjh/+ql/QocaUIWanPqkmld2yJ6Iid
         BeR6Ib1B07VjOljCk4b1zGEg8poa+4oE/d/9A7aHkZySar42854CbnvFXDZWOCi21uV5
         3/QWaOP3Ubt4K/FfPG7QuEUL3lBP8ehxxFh8l40P5VihCHWv7DnFBfHcQy3q1+nkiUnL
         CUeEZ5a/i3HfuzB6rPkB2o5gEJcgF+56XJ6jeO2ZSZbDiG2Z1i+eczsy1CBEKWTYvJiD
         mdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qnhFJ16AfACROoupr0uxF/NZlSmJRV5Jft/zULE7Grs=;
        b=BuSewW6lN4LFGBEonVUvlkAADkucad+4lWmhzHpiu+0w5IYTp+v0oF8t+ECTNDyJHv
         EdGcialx9Z1T8ljnMUQKrXgBgEY2SN2bPyZXMPHB3sT9Q3e68VG5Pcz0ueSzoln9csV5
         nHA5VDkBF53oe05WRd2IR1EO2ACywSb0ApfQJX/31G1TduODpWPvHmFFM6oLTMX4JFH8
         v3yiXt008az0DUhgIBJwNFJ8kQIAkR7KaqsriSaaen8ZwLIX6sA7Tth3tqmUmT5pDp4c
         RN/c4nm3wAqGtuCLWApbB6ONOR5tdCUUitwSF8nMh8FSNP5zlxGoUpZkIrN87qKZc1mv
         epCA==
X-Gm-Message-State: AOAM530f8RSPv6I/xJITm1x3YMKO8Nw9oWMWw2cZK5gajmjsa9F6yTow
        xD/+IkcPQxtcnYaV4RadSM3AQOUbdvnf3XxN2DEf6A==
X-Google-Smtp-Source: ABdhPJw5R4cBnytLiHdmHwQG46XxUk2XZbBfEfz2tLVcCRJCRBBkJN2wVHhhhxfv4yMNwTMYljTgJPlOgjfSqFOWIZA=
X-Received: by 2002:a17:90a:cc03:: with SMTP id b3mr8285727pju.80.1594802889678;
 Wed, 15 Jul 2020 01:48:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200704085213.444645-1-ignat@cloudflare.com> <20200704085213.444645-3-ignat@cloudflare.com>
 <8b168d8c-f526-42b4-7cec-ec7c26c64122@cambridgegreys.com> <CALrw=nFaeMPH9GbMWwiT4rV32=uLKa3ZOYpmnkKTA3bvMiyXYg@mail.gmail.com>
 <72b84dca-e285-bb1f-1b69-5b29c70806d8@cambridgegreys.com> <54c5ffb6416bf59f2f287762820ce84d8ad9b495.camel@sipsolutions.net>
In-Reply-To: <54c5ffb6416bf59f2f287762820ce84d8ad9b495.camel@sipsolutions.net>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 15 Jul 2020 01:47:58 -0700
Message-ID: <CAFd5g47ZOpxjmFGnq+EXrnbT4HEziH3WVZGoFtaqBPBNN+gdWA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] um: some fixes to build UML with musl
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Ignat Korchagin <ignat@cloudflare.com>,
        kernel-team <kernel-team@cloudflare.com>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 9:02 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Tue, 2020-07-14 at 11:43 +0100, Anton Ivanov wrote:
>
> > Patch is OK with me, should not read patches before the 3rd double espresso next time.
> >
> > I will +1 it, Richard, Johannes, what do you think?
>
> I got dropped off the list in "The Great Infradead Purge" but I see it
> in patchwork ;)
>
> Not sure we should modify cc-can-link.sh without at least CC'ing
> Masahiro Yamada?
>
> But yeah, looks fine to me. Not that I have any interest in static
> linking.

Yeah, looks good to me as well, but I think the others here know the
drivers here better than I.
