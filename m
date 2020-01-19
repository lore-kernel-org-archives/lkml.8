Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5735C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 05:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 748AB2073A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 05:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lphl8NYR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgASFzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 00:55:07 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34305 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgASFzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 00:55:07 -0500
Received: by mail-ed1-f68.google.com with SMTP id l8so26398293edw.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 21:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3nHzkoKmcJ0xoUEz4Emp960Em7r3GKffoU1aogBN2B4=;
        b=lphl8NYRco23VhEHouePv/vd0G8tEh9WzrzuzOwVD2qjBnDLMvpZayvheDCG+k7d7I
         8I31tDt6IxlVKSv58QeNqBYP+AxDQnaRnwIO6wdI4G17iuYOY3/Rf/utZ2JcgXY9UVHq
         3BsZaj5R8jT0kjs10fx+2yQmziBoFhb2xaH8gbygPaYPMMhnltB6TCudwL+dgxhCiIr8
         amFsTICObqTtcLb2sGfoRuIsFxsjqgPfw1xcMIOCJNkF4PU3mAU1bCP0KazCrK8ENI3E
         cbWBCMBdR3jqZl2X/9lbgt9fiLr8V+Mj2db9A6sSom2mTvSSIoInt6MNwWVSXkiWWMV0
         vn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3nHzkoKmcJ0xoUEz4Emp960Em7r3GKffoU1aogBN2B4=;
        b=e1txTSt8r8za1I+s1KARjV6C9527h5YSa9LeXyrwu1boH9AgPkVfeKB4w8ceNuEqPL
         KvAyzNB2T+oYy8Zv/Y7c7xG9Ww0gLPfugbnQcxehSJatEmd34MNmi1IVWZQgMmJzlgc+
         vDKsZdMraOAnJdx/MWS3DHJI62prL8/ihU6ERBDOaZSw3mhZuHeRcPt+bSQRcOK7y/+E
         0If196Ca8tm2P2CuuWxBZyRbSkS9flf5WQ1gwSo39wG7TlCgY2+MAcizdrEh0CL2I2zH
         Z71HusXQMf8Xp9hax3NJUH6kA7ISBiriWfk0XbZhw1/QkZcDwmIHXttktFXzvHBrhTOl
         SNSA==
X-Gm-Message-State: APjAAAXYT8xCzNKKxHPrmUornvbQqppc8x+GmRfHzMBh+puGqAHMxhPF
        zShROw1FDhc3g9/+Ro7+jdZyfTuEfOJ3xbHD/uve7A==
X-Google-Smtp-Source: APXvYqxMaXdwKQcM3sm2Fg8/vuYfCsqLFo09AhtI86+6Pet/yPwW1gBWp4IAUMSrJXUFMwAPm/1CVEWKA42NR+A/ihE=
X-Received: by 2002:a05:6402:30ba:: with SMTP id df26mr11374806edb.256.1579413305371;
 Sat, 18 Jan 2020 21:55:05 -0800 (PST)
MIME-Version: 1.0
References: <20200117074534.25324-1-richardw.yang@linux.intel.com>
 <20200117222740.GB29229@richard> <CAHbLzkoYH1_JHH99pnopj_v=Wb=UEGMS9dJs1J6GZn0=6F4SJw@mail.gmail.com>
 <20200117234829.GA2844@richard> <CAHbLzko_UC47Y0gBsRRK0oJS5fvhJ80EpvrjTsFi8+PuTCHGEQ@mail.gmail.com>
 <20200119024124.GF9745@richard>
In-Reply-To: <20200119024124.GF9745@richard>
From:   Yang Shi <shy828301@gmail.com>
Date:   Sat, 18 Jan 2020 21:54:50 -0800
Message-ID: <CAHbLzkrE8Ff9=JZpASyeR_KPs35Z_94YJm7+u4igBbVbg1ErGQ@mail.gmail.com>
Subject: Re: [PATCH] mm/migrate.c: also overwrite error when it is bigger than zero
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 18, 2020 at 6:41 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
>
> On Fri, Jan 17, 2020 at 08:56:27PM -0800, Yang Shi wrote:
> >On Fri, Jan 17, 2020 at 3:48 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
> >>
> >> On Fri, Jan 17, 2020 at 03:30:18PM -0800, Yang Shi wrote:
> >> >On Fri, Jan 17, 2020 at 2:27 PM Wei Yang <richardw.yang@linux.intel.com> wrote:
> >> >>
> >> >> On Fri, Jan 17, 2020 at 03:45:34PM +0800, Wei Yang wrote:
> >> >> >If we get here after successfully adding page to list, err would be
> >> >> >the number of pages in the list.
> >> >> >
> >> >> >Current code has two problems:
> >> >> >
> >> >> >  * on success, 0 is not returned
> >> >> >  * on error, the real error code is not returned
> >> >> >
> >> >>
> >> >> Well, this breaks the user interface. User would receive 1 even the migration
> >> >> succeed.
> >> >>
> >> >> The change is introduced by e0153fc2c760 ("mm: move_pages: return valid node
> >> >> id in status if the page is already on the target node").
> >> >
> >> >Yes, it may return a value which is > 0. But, it seems do_pages_move()
> >> >could return > 0 value even before this commit.
> >> >
> >> >For example, if I read the code correctly, it would do:
> >> >
> >> >If we already have some pages on the queue then
> >> >add_page_for_migration() return error, then do_move_pages_to_node() is
> >> >called, but it may return > 0 value (the number of pages that were
> >> >*not* migrated by migrate_pages()), then the code flow would just jump
> >> >to "out" and return the value. And, it may happen to be 1.
> >> >
> >>
> >> This is another point I think current code is not working well. And actually,
> >> the behavior is not well defined or our kernel is broken for a while.
> >
> >Yes, we already spotted a few mismatches, inconsistencies and edge
> >cases in these NUMA APIs.
> >
> >>
> >> When you look at the man page, it says:
> >>
> >>     RETURN VALUE
> >>            On success move_pages() returns zero.  On error, it returns -1, and sets errno to indicate the error
> >>
> >> So per my understanding, the design is to return -1 on error instead of the
> >> pages not managed to move.
> >
> >So do I.
> >
> >>
> >> For the user interface, if original code check 0 for success, your change
> >> breaks it. Because your code would return 1 instead of 0. Suppose most user
> >> just read the man page for programming instead of reading the kernel source
> >> code. I believe we need to fix it.
> >
> >Yes, I definitely agree we need fix it. But the commit log looks
> >confusing, particularly "on error, the real error code is not
> >returned". If the error is returned by add_page_for_migration() then
> >it will not be returned to userspace instead of reporting via status.
> >Do you mean this?
> >
>
> Sorry for the confusion.
>
> Here I mean, if add_page_for_migratioin() return 1, and the following err1
> from do_move_pages_to_node() is set, the err1 is not returned.
>
> The reason is err is not 0 at this point.

Yes, I see your point. Please elaborate this in the commit log.

>
> --
> Wei Yang
> Help you, Help me
