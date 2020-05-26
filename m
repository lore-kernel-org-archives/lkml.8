Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17F2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97F2B2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:43:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RlEeO+C8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbgEZInh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 04:43:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49835 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728024AbgEZIng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 04:43:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590482615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/o8L9PpT2tPsfwELAAEZex10xy71nNXmIgMtBI4kKNA=;
        b=RlEeO+C8vTVcSd/SMVw348v/uN1O+AiRKy40JOHbemFSPJDMPvAa2VhhVckG9XHaqWV5zw
        iJ++leKMlMcWVZM66tLMkHsCnFyizPd8VTsEeMGZ/AWFzf86tP3hoG1zjTpyRv2SLAELJp
        QsYQFeYxxzxhX3MOt2FbwXht6upTN0k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-wufcBrycOPaQ5ivi6OTiiQ-1; Tue, 26 May 2020 04:43:33 -0400
X-MC-Unique: wufcBrycOPaQ5ivi6OTiiQ-1
Received: by mail-qk1-f197.google.com with SMTP id g20so19612717qkl.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 01:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/o8L9PpT2tPsfwELAAEZex10xy71nNXmIgMtBI4kKNA=;
        b=aNT/07Bm1mMN390MTmSYNeMMniMpsSe1Qq+HJKxaxln0jxT7oXIlYzX1l+7Q9QlymO
         LHrsrYD0rjxGLLHUNa418YPKWiwStRcLxWvxICEToTReeNd70VsOVPdHMQHDK8isdN01
         AMFgVAml99Hh8hCuBJ/45QPtur8XRURnTI1hUXTaUaPgY70QUiujtZ+N44KxxprdoYad
         SPHYXeMbHtdCIu/ZxhO0PNJVjE/m9gRSlR/clahJdeySvOxGGdgMnD06/y6fUt3HiXBI
         Dz2qKJkpdk+aSgwu+NuUf7vw3wuCEkG1HNflPwc23wyewInmi+ZKL5ZZGjCLW4XZZSg2
         R3Qg==
X-Gm-Message-State: AOAM531QmkW1rrH1JtTToLDwYIbAGNv5OnniwKQrxygNFHndL+cZuUuo
        m+C2Ob91HEvYDxVvzwea2VTnzAognOyC4IDlNJA9qr+iVFrZTv0/4paDYJBc8qJPsZiwaAEombK
        WpbRqVJnDfGcl8KZR4/8I7/Ox9nK12wNK1U5e0bfr
X-Received: by 2002:aed:3b56:: with SMTP id q22mr205468qte.345.1590482613006;
        Tue, 26 May 2020 01:43:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyCwcKrOs606XZeMhMjzfd+m/IeRZLNp6DGq58cyir74B5vkJgKPvaaN7ku7p/ZD35bdvAPWfqpM86aYcOPdo=
X-Received: by 2002:aed:3b56:: with SMTP id q22mr205453qte.345.1590482612797;
 Tue, 26 May 2020 01:43:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200414091842.25972-1-kai.heng.feng@canonical.com> <nycvar.YFH.7.76.2005261023250.25812@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2005261023250.25812@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 26 May 2020 10:43:21 +0200
Message-ID: <CAO-hwJ+mTjVpBiY9vHXA2Y6D+cXYemixFJ++i+KwZZ25Z6LHHA@mail.gmail.com>
Subject: Re: [PATCH] HID: multitouch: Remove MT_CLS_WIN_8_DUAL
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 10:24 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Tue, 14 Apr 2020, Kai-Heng Feng wrote:
>
> > After commit c23e2043d5f7 ("HID: multitouch: do not filter mice nodes"),
> > MT_CLS_WIN_8 also supports mouse nodes, hence make MT_CLS_WIN_8_DUAL
> > redundant.
> >
> > Remove MT_CLS_WIN_8_DUAL accordingly.
>
> Benjamin, can I get your Ack on this one please?

Heh, funny enough I was trying to fix
https://bugzilla.kernel.org/show_bug.cgi?id=207235 and was pondering
this one too.

To fix #207235, I'll likely need to add a new class and quirk in
hid-multitouch. I can't really find a generic solution for now, and we
better have a local quirk for the 2 devices we currently have and
backport those to stable. However, this patch will likely conflict
(trivially), with the new quirks, so I was thinking:
- submitting my quick and dirty quirk and mark it to stable
- apply this one on top of it (this one really doesn't need to go to stable)

How does that sound?

Cheers,
Benjamin

>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

