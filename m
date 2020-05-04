Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE2BC47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26033206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="JSSYqRf7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgEDTSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725956AbgEDTST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:18:19 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A5DC061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 12:18:18 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id k22so14581625eds.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 12:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kROsHnsD9muMWEwboUG5hUj2OVBxs90xwEJKMpv4TqU=;
        b=JSSYqRf7kz1USqv9VwACVLKCxXRB4qyB6svg1s1rslPg7jHXZcr350vq//aDz2g2od
         YrZSNERm7ak33/2IuJG4au8xuXPQFwEQbFXj+L+x4EUIvztQZSki+kdKhj3zWTm6HxJI
         gbmQaiKZf75LY2xZIOAAEagt5SpP9peefxR/Rh5/r8hjTa4VVArlhpT4LqFjpsK3dN1V
         G/6ksnlX6fwRL7DLFbfn9S4CsQQ3i+8qY1/p8H3OFOPvdls+wlW5EXSjp1erhRu0GSLG
         G2xwwrAtWE9oOjg8jwxtuNErvw/V7Pad1dxG+DY/cneVyjglCqOuCdsAD43VZ85A5GAN
         SXIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kROsHnsD9muMWEwboUG5hUj2OVBxs90xwEJKMpv4TqU=;
        b=WXc6Tt3KaSgY/TbpacT4qlosjLiGIz+pQm2WSIcO1LyuptzsCIaZhJUqg3yByt63dE
         TqmraOnTIfNOAZEt1w9BSc4eM0KkuDW+GggYw4S3Uf1vPvUl8qO8E68B30UUQrCBXMFc
         dwun59sP1v7XhaSbihzjnNX5jrJlb9y+jIBjTAiGzZSwr0p7hvp+PimOgNT+IWdUO395
         gZFjWL+bTqJTRb0z4jRhGdqf5Pq5NfDXVVogdzwK6odNY+39VWXl4aRzcHa/GzhzBJCv
         Ll3rXZ26zDPUbb9PejQx/XTT9hyt8I0fKyPBFo1wvVLf4cU7sAtebVhq72fmx4QMGv/C
         SJlA==
X-Gm-Message-State: AGi0PubOWIczYeY+7GqxqqYRCAPVMqBFkGaWU9SDkwFNR0goug6kG3Pn
        y9rA2hkpv9yYXoJ7Yx+LjAiFbzNSfHgG49AiFsMYQQ==
X-Google-Smtp-Source: APiQypLAAV4FjDK1Jvxoka65plqeN9pxdUehUoxnWzxXbsHXQPalVul5W+hYrC+PRTtb7+mGD9+ACSv0F/eCwxI563Y=
X-Received: by 2002:a05:6402:14c1:: with SMTP id f1mr16188235edx.221.1588619896803;
 Mon, 04 May 2020 12:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200502143555.543636-1-pasha.tatashin@soleen.com>
 <202005041112.F3C8117F67@keescook> <CA+CK2bBDzbXdH23aDxqGzMoxPppNcVmitrYJ00tJqympMBVJOg@mail.gmail.com>
 <202005041211.040A1C65C8@keescook>
In-Reply-To: <202005041211.040A1C65C8@keescook>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Mon, 4 May 2020 15:17:40 -0400
Message-ID: <CA+CK2bAJgKR+=Tby91gU-ZKy29Juv_oJinCTFAWRaKiiro2vkg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] allow ramoops to collect all kmesg_dump events
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, anton@enomsg.org,
        ccross@android.com, Tony Luck <tony.luck@intel.com>,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 4, 2020 at 3:12 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, May 04, 2020 at 02:47:45PM -0400, Pavel Tatashin wrote:
> > > > # reboot -f
> > > >
> > > > After VM is back:
> > > >
> > > > # mount -t pstore pstore /mnt
> > > > # head /mnt/dmesg-ramoops-0
> > > > Restart#1 Part1
> > >
> > > Is there a reason that using ramoops.console_size isn't sufficient for
> > > this?
> >
> > Unfortunately, the console option is not working for us (Microsoft),
> > we have an embedded device with a serial console, and the baud rate
> > reduces the reboot performance, so we must keep the console quiet. We
> > also want to be able collect full shutdown logs from the field that
> > are collected during kexec based updates.
>
> I meant collecting console via pstore (i.e. /mnt/console-ramoops-0). Are
> you saying that's still too large for your situation?

pstore /mnt/console-ramoops-0 outputs only messages below the console
loglevel, and our console loglevel is set to 3 due to slowness of
serial console. Which means only errors and worse types of messages
are recorded. AFAIK, there is no way to have different log levels for
different consoles.

Thank you,
Pasha

>
> --
> Kees Cook
