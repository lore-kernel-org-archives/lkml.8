Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8278CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FFA3206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="NLbfllHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgELQtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 12:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgELQts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:49:48 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522D0C05BD09
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 09:49:48 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id w2so11688788edx.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 09:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L9Ffz84NpTnCnWnvhpPQGRnbu7kH7Ow5AM96OZFEXgc=;
        b=NLbfllHqdbdpCk1/Bgw9FHGwnQ6s1qwV6zqVTX30/Vc1qiKrY7E4SWIGScphR3PDas
         onxHc5RRSXmFQ2oJPRscHqQWSUcN7rr/QevjRd02trYdf9sWvpbWS6K8pBmAJGBW5kHs
         sWBqkG1mvYqOYyAT301JBf4dBiJrRcbAfrcFo21dcwnvUiEQoyd8o86ye0mc5cT1JA1l
         MyVmynNsBuT9hYtlkguwsLR1HUu6ocOErsjHhxAGl7MPf/7fn7dpdsSDp+lLRLOXLZSS
         PKud6putiGCj77c6U8+X9bbXZRhxEJIgrGHctbMQjqVSrlXuk0BdwJ/NETppygW8tMK7
         TWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L9Ffz84NpTnCnWnvhpPQGRnbu7kH7Ow5AM96OZFEXgc=;
        b=VzSJaFxrh2uSoXFDoeOxcNoVEgOW9az3LWv83o7Rq4FIPwGruH8RntjqSS/O4Fg+D9
         uOlJQgjWl40F0nGx2TT92V7nvfx8ytDzopUAvSMOG6p1D2vunn0fhDx8txEo/QR/6bPV
         +tZCZt6CgkdQ1FY/KQcJAQbx0taLnLjhXLFuilf8hUXo3FxL0BOAb6XSo9L0a+umJzWT
         XYOhuC9nYRbPiXtLHPJIpaeoBeDMwMx/LsdkdB/bUeSEW5SRQ8iheyaUfv6dXgJyeBcX
         lzo7qAM29iGiXCDgU3n78ls8OEN7xUXTNP5TcPnoPFyF+S2JI8rG9Zu3jBkqRuDgpbS6
         b4ew==
X-Gm-Message-State: AOAM530tO/H8aPorUjgDzYMIyJzJ798td7VqUyc7IZfV+ciPBhH/PVc3
        6Lh7uVRZ4n+PWKcoRK674lE8p/FUnhjjRkdAEkiQVg==
X-Google-Smtp-Source: ABdhPJxyBPyUcyG95vG5k6XKpkBx1RkzwSfulZirCBwcMy89UyffhCtaK44K3VsDtBPUo0TBwo0t3aNJBGzgmn5Ub5M=
X-Received: by 2002:a50:ee04:: with SMTP id g4mr9918606eds.221.1589302186772;
 Tue, 12 May 2020 09:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200506211523.15077-1-keescook@chromium.org> <20200512131655.GE17734@linux-b0ei>
 <CA+CK2bBMUxxuTBicQ7ihKpN3jK94mMjcNCXhnAXUaODce09Wmw@mail.gmail.com> <20200512155207.GF17734@linux-b0ei>
In-Reply-To: <20200512155207.GF17734@linux-b0ei>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 12 May 2020 12:49:10 -0400
Message-ID: <CA+CK2bC0argMNHzynedpwN6ekOg8yypN03JvmAKGWQ5Aegxh+Q@mail.gmail.com>
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

On Tue, May 12, 2020 at 11:52 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Tue 2020-05-12 10:03:44, Pavel Tatashin wrote:
> > > OK, I personally see this as two separate problems:
> > >
> > >    1. Missing support to set loglevel per console.
> > >    2. Missing support to dump messages for other reasons.
> > >
> > > I would remove the paragraph about console log levels completely.
> >
> > OK, I see your point, this paragraph can be removed, however, I think
> > it makes it clear to understand the rationale for this change. As I
> > understand, the per console loglevel has been proposed but were never
> > accepted.
>
> The proposal was not accepted because there were more requirements:
>
>    + add console device into sysfs so that it can be modified there
>    + make a reasonable backward compatible behavior
>
> I guess that the sysfs interface discouraged the author to continue
> on it.
>
> Note that console loglevel handling is very complicated. There are
> already four variables, see console_printk array in
> kernel/printk/printk.c. Per console loglevel would make it even
> more complicated.
>
> It is a nighmare. And introducing max_reason parameter goes the same way.
>
> > > Now, the max_reason logic makes sense only when all the values
> > > have some ordering. Is this the case?
> > >
> > > I see it as two distinct sets:
> > >
> > >    + panic, oops, emerg: describe how critical is an error situation
> > >    + restart, halt, poweroff: describe behavior when the system goes down
> > >
> > > Let's say that panic is more critical than oops. Is restart more
> > > critical than halt?
> > >
> > > If you want the dump during restart. Does it mean that you want it
> > > also during emergency situation?
> > >
> > > My fear is that this patchset is going to introduce user interface
> > > (max_reason) with a weird logic. IMHO, max_reason is confusing even
> > > in the code and we should not spread this to users.
> > >
> > > Is there any reason why the existing printk.always_kmsg_dump option
> > > is not enough for you?
> >
> > printk.always_kmsg_dump is not working for me because ramoops has its
> > own filtering based on dump_oops boolean, and ignores everything but
> > panics and conditionally oops.
> > max_reason makes the ramoops internal logic cleaner compared to using dump_oops.
>
> I see. Just to be sure. Is the main reason to add max_reason parameter
> to keep complatibility of the deprecated dump_oops parameter? Or is
> there any real use case for this granularity?
>
> I made some arecheology. ramoops.dump_oops parameter was added in 2010 by the
> initial commit 56d611a04fb2db77334e ("char drivers: RAM oops/panic
> logger."
>
> Note that the initial implementation printed Oops reason only when
> dump_oops was set. It printed all other reasons otherwise. It seems
> that there were only the two reasons at that time.
>
> Now, printk.always_kmsg_dump parameter was added later in 2012 by
> the commit c22ab332902333f8376601 ("kmsg_dump: don't run on non-error
> paths by default").
>
> IMHO, the later commit actually fixed the default behavior of ramoops.
>
> I wonder if anyone is actually using the ramoops.dump_oops parameter
> in reality. I would personally make it deprecated and change the
> default behavior to work according to printk.always_kmsg_dump parameter.

This sounds alright to me with one slight problem. I am doing this
work for an embedded arm64 SoC, so controlling everything via device
tree is preferable compared to having some settings via device tree
and others via kernel parameters, especially because the kernel
parameters are hardcoded by firmware that we try not to update too
often for uptime reasons.

>
> IMHO, ramoops.dump_oops just increases complexity and should not have
> been introduced at all. I would try hard to avoid introducing even bigger
> complecity and mess.

I agree, amoops.dump_oops should be depricated with or without
max_reason change.

>
> I know that there is the "do not break existing userspace" rule. The
> question is if there is any user and if it is worth it.
>
> > I agree, the reasons in kmsg_dump_reason do not order well  (I
> > actually want to add another reason for kexec type reboots, and where
> > do I put it?), so how about if we change the ordering list to
> > bitfield/flags, and instead of max_reason provide: "reasons" bitset?
>
> It looks too complicated. I would really try hard to avoid the
> parameter at all.

OK. Should we remove max_reason from struct kmsg_dumper and also
remove the misleading comment about kmsg_dump_reason ordering?

Thank you,
Pasha
