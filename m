Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65222C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 09:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 401EF20890
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 09:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcbzSCil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387486AbgE0JYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 05:24:30 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23764 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728195AbgE0JYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 05:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590571468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Mx37E6cNniRjSjP/fMQljNdSeCdaYjfQmEy+4bUkLEc=;
        b=gcbzSCilkxC+f9U/amXC4SQWsPMqXTBt2IwwbTtOW+7fKahTSdpCULLhXrcu/DTR+kpu9b
        bKiwal8Kim+/GM6oOWJW3aEoIF5C9NBJDFHL459QY8QOKFU51F8BiwnRaitYxgdXpNaVtA
        uJ1ciQgnYuAL5tH3VHFeb33hgCTHUaQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-I_gJMBF_NUKHwPezAXM6Eg-1; Wed, 27 May 2020 05:24:24 -0400
X-MC-Unique: I_gJMBF_NUKHwPezAXM6Eg-1
Received: by mail-qk1-f200.google.com with SMTP id v6so23284368qkh.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 02:24:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mx37E6cNniRjSjP/fMQljNdSeCdaYjfQmEy+4bUkLEc=;
        b=sGkRYFGSJ3ODUgyi5SFMt/DfwVxmX4mQn3Hl/H5NiB0idyT3ftoFxWUNBk05bKwMNL
         a4+Lop+/2cNXDMUM+TpsE/C+Fy36iWSMDhqY4G6gvF3dN0OSE50rLi3Wiig5NhXuB5ID
         sngAY4xOB/WNj1T6iiYwwAHi5wLa1roNNc8UyXQZWVhGY+VvgHxksPggMoiQDX3EQGhS
         FTjdcErdZ8zi1cA7X0ig3qwTQW59bSo251jpQqwLUxYNqjMfP8PZVG/JCYCxRu15NPNT
         sdoxbDCxHTL14cRhuKgWcvK9csQ5pVLcH/zop/tLyj+jAUqvmElmhxkDgXv7gKocIs46
         JCFg==
X-Gm-Message-State: AOAM532zvnZ1Vx9TgGwJCcVqG9UJR/oYa5naczCio8XmU9c4v0aDzqEn
        dWhCNoF/2h5c5gTjorLogWcs1Xk++KDUizTb4/8boO0bq3DQJzCSxhcvaU9TZ7jno1GEj6I1dIj
        zky2mbx9EI2+OHWoZE1WbfwgRHYWGT0m7HAqcowJb
X-Received: by 2002:a05:6214:1491:: with SMTP id bn17mr24839207qvb.138.1590571464479;
        Wed, 27 May 2020 02:24:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwspK0yE2v775AvHox0HoWyQ9DqUxjbJQZXQO/pyZNzgQTRrP1XaACU4Wj5RcV2L/HBvSuWKdH+D8mI4iqS4W8=
X-Received: by 2002:a05:6214:1491:: with SMTP id bn17mr24839193qvb.138.1590571464243;
 Wed, 27 May 2020 02:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200414091842.25972-1-kai.heng.feng@canonical.com>
 <nycvar.YFH.7.76.2005261023250.25812@cbobk.fhfr.pm> <CAO-hwJ+mTjVpBiY9vHXA2Y6D+cXYemixFJ++i+KwZZ25Z6LHHA@mail.gmail.com>
 <A51B9D28-88BF-42EB-9161-8E3081B128D2@canonical.com>
In-Reply-To: <A51B9D28-88BF-42EB-9161-8E3081B128D2@canonical.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 27 May 2020 11:24:13 +0200
Message-ID: <CAO-hwJJ=_2bn1BEshZ6URT813UAA6KRLaiEHt6bNPUcd9esskg@mail.gmail.com>
Subject: Re: [PATCH] HID: multitouch: Remove MT_CLS_WIN_8_DUAL
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 8:19 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
>
>
> > On May 26, 2020, at 16:43, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> >
> > On Tue, May 26, 2020 at 10:24 AM Jiri Kosina <jikos@kernel.org> wrote:
> >>
> >> On Tue, 14 Apr 2020, Kai-Heng Feng wrote:
> >>
> >>> After commit c23e2043d5f7 ("HID: multitouch: do not filter mice nodes"),
> >>> MT_CLS_WIN_8 also supports mouse nodes, hence make MT_CLS_WIN_8_DUAL
> >>> redundant.
> >>>
> >>> Remove MT_CLS_WIN_8_DUAL accordingly.
> >>
> >> Benjamin, can I get your Ack on this one please?
> >
> > Heh, funny enough I was trying to fix
> > https://bugzilla.kernel.org/show_bug.cgi?id=207235 and was pondering
> > this one too.
> >
> > To fix #207235, I'll likely need to add a new class and quirk in
> > hid-multitouch. I can't really find a generic solution for now, and we
> > better have a local quirk for the 2 devices we currently have and
> > backport those to stable. However, this patch will likely conflict
> > (trivially), with the new quirks, so I was thinking:
> > - submitting my quick and dirty quirk and mark it to stable
> > - apply this one on top of it (this one really doesn't need to go to stable)
> >
> > How does that sound?
>
> Sounds good. I'll resend this patch once your patch lands in the tree.

Great, thanks. Though I should be able to rebase it and push it
directly. I'll notify you if I can't get to it today.

Cheers,
Benjamin

>
> Kai-Heng
>
> >
> > Cheers,
> > Benjamin
> >
> >>
> >> Thanks,
> >>
> >> --
> >> Jiri Kosina
> >> SUSE Labs
> >>
> >
>

