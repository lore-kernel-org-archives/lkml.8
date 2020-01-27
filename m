Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16779C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 16:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E148C22522
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 16:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hewknFv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729780AbgA0QNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 11:13:32 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41173 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729470AbgA0QNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 11:13:31 -0500
Received: by mail-io1-f68.google.com with SMTP id m25so10586942ioo.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 08:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U5t113PHW/Vq6RO8HpYXV+qUnHp+2hvADozVVkcwYWk=;
        b=hewknFv0NpWq20dKsMjPjU4FFwhqDzoprCrng8SHxfUA/XjkMFVNRMVbHIpWm5NIC4
         PMS5K+aXU4V+t8FxEFvmZJl8V9954l9DqC2yNsdP1pdeTGVqwMgaFkXsTAIVMwmiJBt+
         2ZJ9QpQ+3R/oFLxZCnv6Z7zEX9GhY6ONDudaCzzUvdoMuCsdvIOjuF0NDCJ3u+adjwtI
         ynE30QLS1j8T9U0yfGxs9vIYZuDBAduethBELWHTO9RRxsgTtdzHpO0kQJJ6+5jc5UTL
         CGM8G26753rzhBviMbljMzMd2QKakzoNYkoSXPyhxMVxlLjCQZh2qRHlTSgbKqaUv7qn
         0IEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U5t113PHW/Vq6RO8HpYXV+qUnHp+2hvADozVVkcwYWk=;
        b=A01JRdaeYZfi6AQ4WtqryrCf48nQ35xE7GL+bQJ4J8ff/3tncaZxg3iEYkhRPa8WDl
         4RJAJx/Qh5pX3S1qEyf6X4DAfEVITt9o+iAMMFBZdGrz4/XaBMRcvXx9i86nEDkM4KBi
         HtYU+kB8stLWdKm37WlYoWjm72mdeC9JOxnuIcBKW/NoAY6JSrdHKyxi8D3KU84148Fj
         qsg9gIRAAwKsQ8P7Q0x7zP3UaoUij4XoFHoJsugN1uBK3SFoo9bK7V6IriXk3RywIQgr
         jPfrJFz4K+tr3RTDhfF2Yhox9Fq0Gl9O0K66MUqnW6z8+Jmx7t07sEoObMqEGFtNgvx7
         nNRw==
X-Gm-Message-State: APjAAAWlQZHgQH6pW/vWHiOqBpxpkBf4TjCaK8cnh/Cqwk0ZKpxRLBc5
        p0cbNbbf82X7Y3+wUc+n+brOZS1FiI7Y0umRB+wT8g==
X-Google-Smtp-Source: APXvYqwnz43ru2itb/mbS70oB09GHfBA6mE+bDUqNqwrj5GRoED72skpxDugGA9gl4SL8m9kfS/uQepFVA8gEH0+efU=
X-Received: by 2002:a5d:84d1:: with SMTP id z17mr13124921ior.169.1580141610083;
 Mon, 27 Jan 2020 08:13:30 -0800 (PST)
MIME-Version: 1.0
References: <20191226220205.128664-1-semenzato@google.com> <20191226220205.128664-2-semenzato@google.com>
 <20200106125352.GB9198@dhcp22.suse.cz> <CAA25o9S7EzQ0xcoxuWtYr2dd0WB4KSQNP4OxPb2gAeaz0EgomA@mail.gmail.com>
 <20200108114952.GR32178@dhcp22.suse.cz> <CAA25o9Q4XP8weCNcTr1ZT9N7Y3V=B90mK8mykLOyy=-4RJ_uHQ@mail.gmail.com>
 <20200127141637.GL1183@dhcp22.suse.cz>
In-Reply-To: <20200127141637.GL1183@dhcp22.suse.cz>
From:   Luigi Semenzato <semenzato@google.com>
Date:   Mon, 27 Jan 2020 08:13:21 -0800
Message-ID: <CAA25o9QuA_9EoivWo-DuJsWoHCdBm2wio3G8JYxuTfQErT42kg@mail.gmail.com>
Subject: Re: [PATCH 1/2] Documentation: clarify limitations of hibernation
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geoff Pike <gpike@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 6:16 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 24-01-20 08:37:12, Luigi Semenzato wrote:
> [...]
> > The purpose of my documentation patch was to make it clearer that
> > hibernation may fail in situations in which suspend-to-RAM works; for
> > instance, when there is no swap, and anonymous pages are over 50% of
> > total RAM.  I will send a new version of the patch which hopefully
> > makes this clearer.
>
> I was under impression that s2disk is pretty much impossible without any
> swap.

I am not sure what you mean by "swap" here.  S2disk needs a swap
partition for storing the image, but that partition is not used for
regular swap.  If there is no swap, but more than 50% of RAM is free
or reclaimable, s2disk works fine.  If anonymous is more than 50%,
hibernation can still work, but swap needs to be set up (in addition
to the space for the hibernation image).  The setup is not obvious and
I don't think that the documentation is clear on this.

> --
> Michal Hocko
> SUSE Labs
