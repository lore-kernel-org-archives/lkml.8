Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A568C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1DE1206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dM013+ng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404319AbgDCRVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:21:01 -0400
Received: from mail-il1-f176.google.com ([209.85.166.176]:41140 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728066AbgDCRVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:21:00 -0400
Received: by mail-il1-f176.google.com with SMTP id t6so7987144ilj.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 10:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sac9Uo/AV73yZjiElwr8eWaCR4pb1bof561EHbRTu64=;
        b=dM013+ng78t/3X53N7v85k+s4ZNbqHcfrtirxafjWzepY8PPg0JTHflkLye5qy1deV
         nue2NGgEdV38O3280ERkwFJ9s7MMs/g6NbmoqP9corMbbjk80jcdwbOHsSu5mOjnRvWi
         SjZaqD50HXL56mZHaONcA2luuaQFeGSjSGizPcX6I9E1i6aHoPI7UnEAdY7KeOMxhQku
         zSE7DSbuUJ2sFoiXFAnLd9kev4UHIRp4UOnD0ndmRJSGGmx37vRwjsIHq3tcQOHDVcNk
         kxJHYwp+xlotwxFNK5IosKNZvGOdlig6i/epb2Qi4klqxsTFdGHQq8kjqcbq1hvN19LV
         9boQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sac9Uo/AV73yZjiElwr8eWaCR4pb1bof561EHbRTu64=;
        b=bZj6kG+P+vCqY+hJGAurzIyIX+3uP3rScaAddQVmtHgXn9MmiykCnYuRtFPfmLTM10
         GY1CO89+j6rxaRb4VHRDQnuxu7xGz1uRDq6sJmXpszKklzVLix/XBvD4Fa0uHxVPgRVc
         xaqNxNNlsjXm6vYvDK1InIxmAVFRAFWzjm8D6YT0HlGu0RNQUVIY7cv0cvmjUB8udQ3Y
         JJvtU+u1WXOhKN51tK+375Hy9q0xPn5B3K6rdiBATw+eE3JtgE53ZJ0J4KRDAZ+gYliJ
         97zc/Vk1K9k+CWARp4b0MgFv5iGndv3lsReqz3u5/iRbDkmYKvj3qZ9HG8hszyUH2299
         u64w==
X-Gm-Message-State: AGi0PubEdkjilgGCYzP4wfY6iOAl/f5JMveBvY5EBm3TD0eyzSyH+Eps
        T2jd/Z2Cr5GDXuGqgVjsSm7BnLLhefqIu12TPklvDjL7
X-Google-Smtp-Source: APiQypKhx4DmB8pyY5Du9sl19ryD9Wes6Uc6oIqTsWadyRlkNrp3V3mocbD7V7mnyTwz3JXwisn/9II8tbeobuPC230=
X-Received: by 2002:a92:912:: with SMTP id y18mr9943998ilg.299.1585934459694;
 Fri, 03 Apr 2020 10:20:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAOkhzLWMB8rr0x4KKfqruCcTLVq4dH6nZ365auMqA1arZ57J7g@mail.gmail.com>
 <CAOkhzLVvmoB0TgS4bioP4PnxwmnT_+h0LbCya2=KkcHu1UT_Zw@mail.gmail.com> <CAKb7UvgLr2A88jbx9Zvi3SjXoKbk4iZEg7LNQ4aL3VZhKVQu3A@mail.gmail.com>
In-Reply-To: <CAKb7UvgLr2A88jbx9Zvi3SjXoKbk4iZEg7LNQ4aL3VZhKVQu3A@mail.gmail.com>
From:   Zeno Davatz <zdavatz@gmail.com>
Date:   Fri, 3 Apr 2020 19:20:48 +0200
Message-ID: <CAOkhzLU+buL3J3XUbzC6JUAfbnMR-27qwS3Vm7ofrAPPCipXuw@mail.gmail.com>
Subject: Re: acr: failed to load firmware with Kernel 5.6. Kernel 5.5 works
 just fine.
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Ben Skeggs <bskeggs@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nouveau <nouveau@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 6:59 PM Ilia Mirkin <imirkin@alum.mit.edu> wrote:
>
> Ben -- probably the ACR changes in 5.6 don't fall back nicely anymore
> when there's no firmware? The load shouldn't be failed, just GR
> disabled...
>
> Zeno -- if you grab linux-firmware, it should be all better. Not sure
> if you're missing it on purpose or by accident.

Thank you, Ilia

I will try that on my Gentoo/Funtoo machine now. So far linux-firmware
was not needed with Kernel 5.5, so it was not installed on my machine.

[ please CC me ]

Best
Zeno
