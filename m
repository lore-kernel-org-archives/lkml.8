Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545D9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C6D4206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGVP89oL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgA1To7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:44:59 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36415 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1To7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 14:44:59 -0500
Received: by mail-ot1-f67.google.com with SMTP id g15so13243171otp.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 11:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tB1X5GZ3lNFRYYLOCNfnT00dak9jJkkikUMx2JtvOc0=;
        b=HGVP89oL7SSzneYqHDzdZz/Zpoh17+c9v96GSV3RQTTo1hx7E+Z0TJHLbZX1hYL/Po
         u1ZTS8bAWqUtNHOmDND6QBWQQCY7x/G5z7kt+fTaqciRs8SOMeS7t1IRnb9NlTJzsbwB
         OZrdMqBzXuQH357Vb/RoiMWfOOlZb37+GG/mpyEPi840IglpwDSqZHb0tQpgduS6PmD9
         khqK06mRBtaSL5620BrakSCwp6npOvP8zVHK+vAOS8IekbgMjRJttbo8Q0taLKRyvMKS
         bj3QGUeL2CAPGM3tpJGFOdKKhzc8dgrH8WTeuJKtU3qA2LTAcZjt/hkzQHkhUfrfTcyj
         Fppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tB1X5GZ3lNFRYYLOCNfnT00dak9jJkkikUMx2JtvOc0=;
        b=Nahvi7EUbgzij2jIB61/1i7FG5xS/BnqXjIf8mMok1mBB8uC2XBJfR74UcufH/3KKZ
         K1uMZXmAclF6qbhsryUzw7hQUqnC1nRm51YGMx2cAtSclq84LD/pHqEGILPj8fEZ6xs1
         ZNMWfKTl/PCtdzOblfOMMgcg9V0+swp4HyCHXc41I9VpKR7al4oke2VIsBkOy8yHK1GA
         TGui1F/iSG4shmrGpQkWJXouJHczaD7peN22w7sBSnOoVawiv66X3gpXbQr02G7rQ79F
         5lYpmBEqf4CVlxFNTx5A4KVBqnMv68pYXdyzbC45JpUgRd0bA0ZSyA5zrPJjKXgfrGK0
         /D1Q==
X-Gm-Message-State: APjAAAVYaEBhwvlSKia9FhGeRumPfPqd620rwvlgb5SV7N5SqODoRVdQ
        pbi73JSPu5eqm6GfxMvV8bbNGzAk0cnQlqFEoYUkgXzDtY0=
X-Google-Smtp-Source: APXvYqycNX8hyGUcq8BEr10UFy/BXIYuqrwDx8M+n7cAUqFKCeosbDnRGTPWIymYdYSdoXi2d1d9j80LqP5m1ix2FgA=
X-Received: by 2002:a9d:7559:: with SMTP id b25mr1783817otl.189.1580240698297;
 Tue, 28 Jan 2020 11:44:58 -0800 (PST)
MIME-Version: 1.0
References: <CAM_iQpVN4MNhcK0TXvhmxsCdkVOqQ4gZBzkDHykLocPC6Va7LQ@mail.gmail.com>
 <20200121090048.GG29276@dhcp22.suse.cz> <CAM_iQpU0p7JLyQ4mQ==Kd7+0ugmricsEAp1ST2ShAZar2BLAWg@mail.gmail.com>
 <20200126233935.GA11536@bombadil.infradead.org> <20200127150024.GN1183@dhcp22.suse.cz>
 <20200127190653.GA8708@bombadil.infradead.org> <20200128081712.GA18145@dhcp22.suse.cz>
 <20200128083044.GB6615@bombadil.infradead.org> <20200128091352.GC18145@dhcp22.suse.cz>
 <20200128104857.GC6615@bombadil.infradead.org> <20200128113953.GA24244@dhcp22.suse.cz>
In-Reply-To: <20200128113953.GA24244@dhcp22.suse.cz>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 28 Jan 2020 11:44:47 -0800
Message-ID: <CAM_iQpVjiui0xb7wTfF2HOME=cuk7M2SCBa7O_RVebk04qMs4w@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 3:39 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 28-01-20 02:48:57, Matthew Wilcox wrote:
> > Doesn't the stack trace above indicate that we're doing migration as
> > the result of an allocation in add_to_page_cache_lru()?
>
> Which stack trace do you refer to? Because the one above doesn't show
> much more beyond mem_cgroup_iter and likewise others in this email
> thread. I do not really remember any stack with lock_page on the trace.

I think the page is locked in add_to_page_cache_lru() by
__SetPageLocked(), as the stack trace shows __add_to_page_cache_locked().
It is not yet unlocked, as it is still looping inside try_charge().

I will write a script to see if I can find the longest time spent in reclaim
as you suggested.

Thanks.
