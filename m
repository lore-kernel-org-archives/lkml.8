Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37FAC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F6524685
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1cmFcTA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgBJQFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:05:10 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:46928 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgBJQFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:05:09 -0500
Received: by mail-lj1-f182.google.com with SMTP id x14so7741230ljd.13
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 08:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KviVA2W53QwSTqXBhY7yBHu/2rDUqwlHIb8/szyayMw=;
        b=F1cmFcTARR4IGsjVudr3cycA++xprsBqT1IGepDVoAY1CjLFWge8KZCMaTJR2exA98
         4kJVM2FGVjjQ3clhc9gXzR7AoiGe9vTDyG2gYp0DarKIv8Gyva0xYLqHk9PWs7riPIln
         c1rOceb9OR8Zu1T4/99mEISEO3E3Rh5vk+41AUqiaSq856zNmDol8Oh50EdMWuMvMkAk
         gG9Dd2FyySl/gLzuxuQECJjT3kN0jBgFkGH7KFjJ/PXFC/633Kthvm1wztpZ7YXIZPWW
         oErTIFdJjs4tmBf0lx/+yvWNQyiKTxvKfR9t4oAHiJwkTyFcXfEX1TqY0MMCcFoYHcS3
         02hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KviVA2W53QwSTqXBhY7yBHu/2rDUqwlHIb8/szyayMw=;
        b=Ed+wRN4XOG0P+wO+YnvVUrybyosDaZgnXkuR3Zeyxwuk3EAF02F5ihw+wLaH0kgXLM
         P9cD3w2+imU4ZfkwGI9BxPGJbWIi2Os6zSUZDYwnl+yHrXAuq8mMH+Ndk6ArRfQTNOTC
         jl7Bh30fgds3Ts4dEti9k57OBB4mP+mTv0TCZQWUKSnqUW9KYuMU6Wswoa989xg7sdOG
         dtnsJFGamjauCkpzmKeuRtVNjtTUmYq72ZMrpFkvGK7SUqBc+AXeNOXYb6aDv2x70G1V
         WAwlm2yD6eoNhuYuQKvHJNdVDw9XO5CBXR2u+NSdkzVZpHx/1kltYQG7rlTguwf0h8fg
         oD5w==
X-Gm-Message-State: APjAAAVKPrmJ3JI7YWHfaK5hcuJIE5gPXodbqhdBbPHmOPeUTPxicKht
        y2w/v7/z9GJNjmP/q3EtnU4UADx9Nw8WQX/04qqLtg8=
X-Google-Smtp-Source: APXvYqylA+tyU28zvQAckWnFkAGzEjriCOXKz9WSrPn2syaH/er+ItiFHJRSSVrg3lQsOFrFxAMubhqXTvhvhXkhkTk=
X-Received: by 2002:a2e:8755:: with SMTP id q21mr1409807ljj.156.1581350707151;
 Mon, 10 Feb 2020 08:05:07 -0800 (PST)
MIME-Version: 1.0
References: <0495d7bd-7600-1936-d923-fa3b56a654bc@xs4all.nl>
In-Reply-To: <0495d7bd-7600-1936-d923-fa3b56a654bc@xs4all.nl>
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Mon, 10 Feb 2020 17:04:41 +0100
Message-ID: <CAEJqkgir5yjgh-tnuz8dRgEG=Vpa6yU5K6hAA2oeBEmrLO7ubA@mail.gmail.com>
Subject: Re: 5.4+: PAGE FAULT crashes the system multiple times per 24h
To:     Udo van den Heuvel <udovdh@xs4all.nl>
Cc:     "linux-mm@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo., 10. Feb. 2020 um 15:39 Uhr schrieb Udo van den Heuvel
<udovdh@xs4all.nl>:
>
> Hello,

Hi,

>
> Would this be a bug in the mm area?

I don' know, possible.
Can be everything and nothing, bad OC, bad RAM, broken firmware could
be a cause too.

>
> For bug https://bugzilla.kernel.org/show_bug.cgi?id=206191 I have been
> bisecting way but now the process landed me with a kernel that cannot
> find the root fs. (with either good or bad bisect choices)
>
> Pictures of the crash that is the reason for this bisect:
> https://bugzilla.kernel.org/attachment.cgi?id=286787
> https://bugzilla.kernel.org/attachment.cgi?id=286789
> https://bugzilla.kernel.org/attachment.cgi?id=286791
> https://bugzilla.kernel.org/attachment.cgi?id=286793
>

I looked at some of your logs. I hit freeze/crashes similar to yours
with an R3 APU a while back.
That was caused by a mismatch in kernel -> Xorg driver <-> mesa code + firmware.

I think first you should try to fix your amdgpu bug which is this one:
https://gitlab.freedesktop.org/drm/amd/issues/963

And the fixes are the patchset there:
https://patchwork.freedesktop.org/series/72733/

Also, can you try booting without all these crazy options?
As an example why would you need to force ACPI on your HW?

BR,

Gabriel C.
