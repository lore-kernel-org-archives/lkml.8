Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD46C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 19:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD088208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 19:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595187273;
	bh=R1UXRHTwM8Zx9NbZ4PSmOXer/srICcLrUQzdI0mdCY4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wQ7fd3B2XpkNBcAzucYaMmh4DV/IPTVbjPK4Ct97I159BnHLeXDc64b/ucOnnDabU
	 9LP8dVoO+iyhR5TetfuIdWaT844yeN9qJZWWgB8FMFlfQDAKVEPTQ2uk1E8sGtPC0b
	 +c7AlzQY4/HZlV3D42LULX7Drj0Owat8Dcvvn2WU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgGSTec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 15:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgGSTea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 15:34:30 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2B4C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 12:34:29 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id g2so8627288lfb.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 12:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4iaAa1pJ3/vUXL+G0FL5XOVaOaVeIOdKQBxEAvPWUk=;
        b=hUj5SJIJp5WpT8tiJdx2CMecsKcJEqVlqdlhW6MORlAWnybeCPezD07typEeY2pzH4
         /ZktAwoD/GooFQ3xUbb7QJ97bNKTNjYZ7xG6wQxdrZPzrm5qDk9TlDrmtLv7I80qPdDB
         t+i7Jg3uGh63h0eUENt4UYDEoycbXbz0ouzRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4iaAa1pJ3/vUXL+G0FL5XOVaOaVeIOdKQBxEAvPWUk=;
        b=NWBQcfFLnKzA2CXKtFgQOYshmQV/a3Z1m2XuQS3yyNz1vOR9hJp3/vz382YEoo72ja
         jgYgi1OVX92bCY1Y5XbtYK7JwiemneOWQHBiu3vOeEdZGhq+xNDnHAVLfvHo6JtoNR5W
         PVSw+WtINoV5tHWSyjuZN4puYYpBNn6Sq5GsDZ7/0K/pRRlPePRZlyKhrITAEUUN23v9
         Sl9Rl537pFhLI0wiNjSxfjpJkNs8WU9a2KRxszzw1ncUGi0fxWNPeHl/72j2qoGDoifx
         fQYhHRzxrR6tFP19SAB4NWun0RoTNlknQr3f1q22S5RNOCWwhA0gxOvPt1+kyHmkBQ8g
         duLw==
X-Gm-Message-State: AOAM532Tw0HKoa7nGn9GChtN1R3TdfJ1zCGXRgiG1TT0gyhQzXDv5q5p
        ZAk+DoJi/fzpN4THxPVZe9QT2WOSt7A=
X-Google-Smtp-Source: ABdhPJzmOg/kdm8tB+/n5R1CDu/e0RrpADIAmjdmYLWPP8ZLCLCWIh2xSm+nFWLIl7jx4aLTO/6eRA==
X-Received: by 2002:a19:4a90:: with SMTP id x138mr4054315lfa.68.1595187268033;
        Sun, 19 Jul 2020 12:34:28 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id a17sm3307950lfo.73.2020.07.19.12.34.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jul 2020 12:34:27 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id h22so17970755lji.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 12:34:27 -0700 (PDT)
X-Received: by 2002:a2e:991:: with SMTP id 139mr8453344ljj.314.1595187266940;
 Sun, 19 Jul 2020 12:34:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200719031733.GI2786714@ZenIV.linux.org.uk> <CAHk-=wi7f5vG+s=aFsskzcTRs+f7MVHK9yJFZtUEfndy6ScKRQ@mail.gmail.com>
In-Reply-To: <CAHk-=wi7f5vG+s=aFsskzcTRs+f7MVHK9yJFZtUEfndy6ScKRQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Jul 2020 12:34:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wirA7zJJB17KJPCE-V9pKwn8VKxXTeiaM+F+Sa1Xd2SWA@mail.gmail.com>
Message-ID: <CAHk-=wirA7zJJB17KJPCE-V9pKwn8VKxXTeiaM+F+Sa1Xd2SWA@mail.gmail.com>
Subject: Re: [RFC] raw_copy_from_user() semantics
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 12:28 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think we should try to get rid of the exact semantics.

Side note: I think one of the historical reasons for the exact
semantics was that we used to do things like the mount option copying
with a "copy_from_user()" iirc.

And that could take a fault at the end of the stack etc, because
"copy_mount_options()" is nasty and doesn't get a size, and just
copies "up to 4kB" of data.

It's a mistake in the interface, but it is what it is. But we've
always handled the inexact count there anyway by originally doing byte
accesses, and at some point you optimized it to just look at where
page boundaries might be..

I think that was the only truly _valid_ case of "we actually copy data
from user space, and we might need to handle a partial case", and
exactly because of that, it had already long avoided the whole "assume
copy_from_user gives us byte-accurate data before the fault".

              Linus
