Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7575C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC9720715
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 17:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IalfoObg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgBJRBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 12:01:39 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38889 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJRBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 12:01:39 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so8017994ljh.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 09:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kA/ZcVtFwt4UPPRYCxH+nQ/SqQw5fo/Na4yrhHdcy/w=;
        b=IalfoObgfCtbI4A1bjlwVeAtcQvjNw5EH2zocd7Wdns2PNJVgRfBnq8Mn2SLKcJQ4j
         GEX/CdUjjBbILfHUilX1+oQC4ylDO1nFwyo50IMfK6B7cu9SpRkJsqRhvSoPVTe0ld1S
         An6VwWMPYgTYr8DwJXIsuE9sWQh70oBIudtMlw4yAH1mG6u+0loiesJQriCObAqH/dNp
         6+yTVCMh68QlWyjCbQR2XMqfFt0E6qDJT7q+7hTdiPUbF0hT3X3pxSYb2tGtYafqaomD
         PD9dI/f0MhTFjlssRxJdEvmfLnH+wqT9HPFum+FylqLFuFuNu8e1s00zxZTTXi7QcMDG
         bPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kA/ZcVtFwt4UPPRYCxH+nQ/SqQw5fo/Na4yrhHdcy/w=;
        b=UYN3wtgUX0IkT0O/+IVnm5bqQtZx+MF5wpHhLo+n65qlF5C71qbGQJ/kHRXeFlupPT
         HsJQl8M5hRWSNwULrTmi/gJ4SViVtDeg/Hn284ZFCSPSu/O1ebMkZitAb/mScsQql8YO
         G56Oo38/wHlP/2fM/AUjc6tarRKYKFrqUxFiY2DV8CjOgOVFyRcCVk0gqiK5KGp3TvQg
         5r50DjLqfgtGJFUxjeBU90DQl9AP++QBUPJO2B63o0AGPWnt1M+3WOyLVwpvII3fMTCs
         D0pHHMil4gMsxhD90Q2XK+Ait36fYbvWO7EbKMY9Ip1JBRhUwYE7Jm4A5kGBleB4ONR4
         YKmw==
X-Gm-Message-State: APjAAAUjgJ2dLnX2hcR+2AjmrrX3f2RbolcqP+56kn/gbjMleXtgy7d3
        oM/rAVyX0qkvFty1nm5jEB9+kJHcEQNcCwmsRA==
X-Google-Smtp-Source: APXvYqzRPvALg6agpbOQvg1Y+cIkJmhdy4qxeRyrKa/px19cjk7IPqss3HWMr5vU8m/O58E4tOTlvW2V2aj/Giralgc=
X-Received: by 2002:a2e:2201:: with SMTP id i1mr1521484lji.110.1581354096476;
 Mon, 10 Feb 2020 09:01:36 -0800 (PST)
MIME-Version: 1.0
References: <0495d7bd-7600-1936-d923-fa3b56a654bc@xs4all.nl>
 <CAEJqkgir5yjgh-tnuz8dRgEG=Vpa6yU5K6hAA2oeBEmrLO7ubA@mail.gmail.com> <fbb6fd06-0dc5-923a-c01f-d0bedfb004b1@xs4all.nl>
In-Reply-To: <fbb6fd06-0dc5-923a-c01f-d0bedfb004b1@xs4all.nl>
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Mon, 10 Feb 2020 18:01:10 +0100
Message-ID: <CAEJqkgjq3pd8kJSBpv4moOjdjgXiwPS6HgoD81rVAL0X-SAGew@mail.gmail.com>
Subject: Re: 5.4+: PAGE FAULT crashes the system multiple times per 24h
To:     Udo van den Heuvel <udovdh@xs4all.nl>
Cc:     "linux-mm@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo., 10. Feb. 2020 um 17:25 Uhr schrieb Udo van den Heuvel
<udovdh@xs4all.nl>:
>
> Hello Gabriel,
>
> Thank you kindly for your rmail and teh links inthere, I will most
> certainly look into those.
>
> On 10-02-2020 17:04, Gabriel C wrote:
> > I think first you should try to fix your amdgpu bug which is this one:
> > https://gitlab.freedesktop.org/drm/amd/issues/963
> >
> > And the fixes are the patchset there:
> > https://patchwork.freedesktop.org/series/72733/
>
> Thanks, will try those on 5.5.2.
>
> > Also, can you try booting without all these crazy options?
>
> What is crazy here?
> Each one has a story.
>

Sure, I'm not saying to not use these.

But try to boot a kernel with only what you need to boot when hunting bugs.
As an example, if such a kernel works then you know for sure one of
the option or a combination causes bugs.

> > As an example why would you need to force ACPI on your HW?
>
> Force?
> Because then I can be certain it will be there, this has been there for
> quite a while.
> Or would you suggest I run my x86_64 without acpi? (I am not an expert
> in this area yet)

The force parameter is used to try to enable ACPI on HW has is OFF by
default, you don't need that.

....

> rd.luks.options=discard
>
> We want to use discard on our ssd's.

Use mount options?

> elevator=mq-deadline
>We want a different scheduler for ssd versus hdd.

If you really want that you should use udev rules for SSD/NVME/HDD/USB etc.

BR,

Gabriel C.
