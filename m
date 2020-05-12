Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB99C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C80320722
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="bFYBorqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbgELOEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729519AbgELOEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:04:22 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35E4C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 07:04:21 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w2so11208203edx.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 07:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ikZPDK7XBn7eFKeGkIZXS4/10/P6XjlDj25+b+s0OwY=;
        b=bFYBorqFH+N/xag4HXQG3Xhs6FfcPgBOaT2DkefxRQLmXc4eRjxZGpw8zoVFr3Eu6W
         fxhmGhNaddsasSNRtSwjH3ys4skHQcc5eRf6g6A/lvbuK/BpA9zRvS73WGSMZzCwnr7f
         MIZ/lu59RDnwLyv4wQnVDYKqEAXhAszGHgS8NI81JCyZlRmxxzWTzh6swwFQUCNbp+F5
         ++BR6Lz++mlkOgoQRzxyTo4gRG4K6LtusFOWcZUtD2nUvUFP7mu2MMX7pAZ4F1rXE/Ur
         a6aq4DIbDc/10bXvUEqhQ3/Up7m33EF7ll7XMmKKzA1EP64c1b2R1mdBqWQvZe9HkoX3
         EcYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ikZPDK7XBn7eFKeGkIZXS4/10/P6XjlDj25+b+s0OwY=;
        b=cPWX4kSVlFPb+7of6kQZy+YAFdW6Xw8ukH6LiVsuKKuoGpCqGnB4oUaaV7JDC7p3Fb
         qjSk2sd75LTlNvt//oHopuI4dh62EO800dfoVG5W0jmrB84BhOgK5nzwoh4Sa7MvS+ZZ
         8p/+CJEGl8giXSudEAzReQ+HyAXitHwnYb/YV46JiOqwlwd6i65j/Kg+hZrzE5KCs5ZL
         hS0I4PjluvlecHN98VHjUMBmw7z1QfjZG5cIJdA7EUbD43WlvMoVwIcm+JvAabG4IKPU
         L4H6iv2YflIrwPucU6sYXh6qg0HSbnqQ/XR1xmOqI9AMl6F+WUkEL2CvCyQHG1tQYKoM
         TZWA==
X-Gm-Message-State: AOAM53237aT+UdDepHpl3ZOCz9UcwcNJUeE4lEZh2nLLxovQ8zpICh4m
        TxaSGViihXoeVVVkyhgH6Bb/SADuA0lS3RSP4WBl6w==
X-Google-Smtp-Source: ABdhPJw21yX98EkZo0YMg5kI0+/UAXdggsUiHgj1VF3wDW/b41YkePhJMmMQboVKc9cHI7ZwHQp6/7sjMY2o7QTFH7U=
X-Received: by 2002:a05:6402:3044:: with SMTP id bu4mr2696109edb.342.1589292260160;
 Tue, 12 May 2020 07:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200506211523.15077-1-keescook@chromium.org> <20200512131655.GE17734@linux-b0ei>
In-Reply-To: <20200512131655.GE17734@linux-b0ei>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 12 May 2020 10:03:44 -0400
Message-ID: <CA+CK2bBMUxxuTBicQ7ihKpN3jK94mMjcNCXhnAXUaODce09Wmw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] allow ramoops to collect all kmesg_dump events
To:     Petr Mladek <pmladek@suse.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

> Alternative solution is to dump all messages using ramoops. The
> problem is that it currently works only during Oops and panic
> situation. This is solved by this patchset.
>
>
> OK, I personally see this as two separate problems:
>
>    1. Missing support to set loglevel per console.
>    2. Missing support to dump messages for other reasons.
>
> I would remove the paragraph about console log levels completely.

OK, I see your point, this paragraph can be removed, however, I think
it makes it clear to understand the rationale for this change. As I
understand, the per console loglevel has been proposed but were never
accepted.

> It is your reason to use ramoops. But it is not reason to modify
> the logic about max_reason.
>
>
> Now, the max_reason logic makes sense only when all the values
> have some ordering. Is this the case?
>
> I see it as two distinct sets:
>
>    + panic, oops, emerg: describe how critical is an error situation
>    + restart, halt, poweroff: describe behavior when the system goes down
>
> Let's say that panic is more critical than oops. Is restart more
> critical than halt?
>
> If you want the dump during restart. Does it mean that you want it
> also during emergency situation?
>
> My fear is that this patchset is going to introduce user interface
> (max_reason) with a weird logic. IMHO, max_reason is confusing even
> in the code and we should not spread this to users.
>
> Is there any reason why the existing printk.always_kmsg_dump option
> is not enough for you?

printk.always_kmsg_dump is not working for me because ramoops has its
own filtering based on dump_oops boolean, and ignores everything but
panics and conditionally oops.
max_reason makes the ramoops internal logic cleaner compared to using dump_oops.

I agree, the reasons in kmsg_dump_reason do not order well  (I
actually want to add another reason for kexec type reboots, and where
do I put it?), so how about if we change the ordering list to
bitfield/flags, and instead of max_reason provide: "reasons" bitset?

Thank you,
Pasha
