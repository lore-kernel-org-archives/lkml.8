Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9ACC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 22:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177012465B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 22:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pxyyG60a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgA0WUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 17:20:14 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35740 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgA0WUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 17:20:14 -0500
Received: by mail-ot1-f68.google.com with SMTP id r16so10088371otd.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 14:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uBRmgLGJ/1OiXghi/aZjiQp1GNObfLNGGUBUjy3wBJE=;
        b=pxyyG60aG7khWI+GMVIV0mt4SFPdL7Ng0iNwWu4H7ky2B/kUGB+knIzb5aMZOojgsK
         Bp4zFoo+zcPIlSvcPRmU6SctCVLtQIsjLGpznqyuqCD+n8rvexUFIPDuFAFkdJhcjAZC
         dQMhOfS8ICqNj0Ru23H/2mqs9gz5HfvADc15LXUkb0exTv+Lezo1wdRqg27ADCDnzTxU
         GWMwOAaHx8FJhQXf7hjQgJw171HTkH6adlhz9GAK/Rk4jTb+lcGG7JSXcTD9FUiPbwHd
         fYz6oQZvLdprO6dhZRumMVDhY6SsvFjoB+Ghj5B4PQIRMqE+eX0NY79/oMjeK5haGnhv
         Gj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uBRmgLGJ/1OiXghi/aZjiQp1GNObfLNGGUBUjy3wBJE=;
        b=qAVxZf4kQh+SWWfGDiTHBWy4zkVPpwi5Dv1lJSUJDUxkbd7G0wbgeKf2ZvPc1kQsUt
         /7Bq97TDSzWup0M+CEYocL1y14Iinrova4mdzqTTV+PPuh1FxKE6ygP9SK3uQf47XXkp
         wbYhngsjPqZx/MN1KMVehfwlQHHEJfBGAsZG/6/5Zh267fXUB80UBKhIebRgOZdxPRa0
         0Ibd2ADo4N6RuOOQTwlGGvvu4+Jjh/j2gtxHqIbOu63T4v1jiokpsb8uYRvaYjgjbmuR
         DWDYCbfzGEsqN0FGbY/FZCqsN1DkRJw5mOwTsMUhXNlHCP4O+d0FeSEDRo/zwJSY8hG5
         0Jkw==
X-Gm-Message-State: APjAAAXXkJuZRZ06+OHnmRLk00D8DTna8nAzUzYF4qWUUKxu1tAzMuU7
        NTWPdqu/vsC4ptRuXjl7EreAbH/lSUJEkSVJJ6wfIept
X-Google-Smtp-Source: APXvYqz/r1H0zhbnKmJ6HpRJcG11DlHwv4O6l88J52v/ddot2qKyyZzJ9Fy9w87p8wdRni38ufizZi601B+wTu8j+gk=
X-Received: by 2002:a9d:6a85:: with SMTP id l5mr11027609otq.231.1580163611412;
 Mon, 27 Jan 2020 14:20:11 -0800 (PST)
MIME-Version: 1.0
References: <20200122080352.GA15354@willie-the-truck> <20200122081205.GA2227985@kroah.com>
 <20200122135352.GA9458@kroah.com> <8d68b75c-05b8-b403-0a10-d17b94a73ba7@akamai.com>
 <20200122192940.GA88549@kroah.com> <20200122193118.GA88722@kroah.com>
 <20200123155340.GD147870@mit.edu> <20200123175536.GA1796501@kroah.com>
 <20200124060200.GG147870@mit.edu> <20200124072940.GA2909311@kroah.com>
 <20200125014231.GI147870@mit.edu> <20200125101130.449a8e4d@lwn.net>
In-Reply-To: <20200125101130.449a8e4d@lwn.net>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 27 Jan 2020 14:19:34 -0800
Message-ID: <CAGETcx86rQpS4qodSiv_v+E_8P3DUQDY9jiN_Yq07Jwh9tHQcQ@mail.gmail.com>
Subject: Re: [PATCH v3] dynamic_debug: allow to work if debugfs is disabled
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Baron <jbaron@akamai.com>, Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 9:11 AM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Fri, 24 Jan 2020 20:42:31 -0500
> "Theodore Y. Ts'o" <tytso@mit.edu> wrote:
>
> > On Fri, Jan 24, 2020 at 08:29:40AM +0100, Greg Kroah-Hartman wrote:
> > > > It's likely that people who normally use
> > > > distribution kernels where debugfs is disabled will have scripts which
> > > > are hard-coded to look in /proc, and then when they build a kernel
> > > > with debugfs enabled, the /proc entry will go **poof**, and their
> > > > script will break.
> > >
> > > **poof** they didn't test it :)
> > >
> > > Seriously, I am doing this change to make it _easier_ for those people
> > > who want debugfs disabled, yet want this type of debugging.  This is
> > > much better than having no debugging at all.
> > >
> > > Don't put extra complexity in the kernel for when it can be trivially
> > > handled in userspace, you know this :)
> >
> > It's also trivial to handle this in the kernel by potentially having
> > the control file appear in two places.  Consider what it would be like
> > to explain this in the Linux documentation --- "the control file could
> > be here, or it could be there", depending on how the kernel is
> > configured.  The complexity of documenting this, and the complexity in
> > userspace; and we have to have the code in the source code for the
> > file to be in the appear in both places *anyway*.
>
> FWIW, avoiding the need to document something like this has been a
> motivating factor behind a number of my patches over the years.
>
> Moving a control knob based on kernel configuration is a user-hostile
> feature.  Scripts can be made to cope with this kind of behavior in one
> place; if you let such things accumulate in a system, though, it gets to
> the point where it's really hard for anybody to keep track of all the
> pieces and be sure that their code will work.
>
> If dynamic debug is meant to be a feature supported on all kernels, it
> should, IMO, be lifted out of debugfs and made into a proper feature - with
> a compatibility link left behind in debugfs for as long as it's needed, of
> course.
>
> </sermon> :)

My 2 cents -- agree with what Ted and Jon have said.

-Saravana
