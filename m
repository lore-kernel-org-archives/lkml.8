Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1EABC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A59020709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEZQ1MA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgEONTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:19:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29896 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726283AbgEONTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589548753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VVfnMaxbDJwdN3t1pb7+qmfm61G7CFVxjrzZ7nK0lKs=;
        b=iEZQ1MA6zRRxiv/TBD4Pvm9wJ9cFasGQEftC/kxnKq3nAT9Jbi81XQ8ldCor0FR+dUCzgZ
        ZXgwwYH5uRXqYZWV6ty0N8kgFB2tlmCuun4z4egxKkOy4V2Xs2RkSn6uAPiE2OGrRlsFjr
        0jS6yWvtFjqhOSDzyXHyt/oXYYaOad4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-GggsbnMGMgCTgZBiNb796A-1; Fri, 15 May 2020 09:19:11 -0400
X-MC-Unique: GggsbnMGMgCTgZBiNb796A-1
Received: by mail-qv1-f70.google.com with SMTP id w6so2575237qvj.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 06:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVfnMaxbDJwdN3t1pb7+qmfm61G7CFVxjrzZ7nK0lKs=;
        b=WMYy3A/sNKJqKKVT5PRzJzMK0M/hCsx8afxvxZqgb3CzZ4RdOQbGt5eoPGpbKl6h9I
         ucyxP6Q3VgMBZqdKk5irHEEwbBRFCjXv29gFoEHeqakfPUg9jlGyFO3OxUQePwYjFHIS
         ZyAE0e38CSrprn0Vlq+pdjlaSq/c4g+uQXrpgBVmMMTCmlBeGr5Zv21qAtmdJ0xdpTsq
         26rrWtia86QuRKbWpqMFLElpEdBlUAkHudphKMQnTQ30+gn55r0/mJE0ZrJ9ZQgvzXRB
         wuD/Fd75Hb+aTkWIG+lnm/FNs9eRpD4BgAAcWIP7XdgQLE0ghztLYlQ+pD37hjECl7pR
         T/Ug==
X-Gm-Message-State: AOAM531IS19ACx7ERn0mddvV6wduROrao70VZ0h7hUUinb8+YNSwPDoQ
        NFIerTIClJuF0ebjk7a1vjFm9MJJ3Q7vy+sp/sk/Tszpl/P9MGkrSIeYWNHSvD315I91sCSMIzq
        1/MABpam92d1kdMgUFJGLcOuIGG0zlM8UYGomC0KO
X-Received: by 2002:a37:2783:: with SMTP id n125mr2067398qkn.335.1589548751341;
        Fri, 15 May 2020 06:19:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2B+IpGj1TzoDwxhUOvlZ0BoV1h+b7uDLIOJqPAZ+BTQYyL5XS0xoOnJyMwQ5EcW6b+8bWBU1/WT/ceTDe9b8=
X-Received: by 2002:a37:2783:: with SMTP id n125mr2067373qkn.335.1589548751140;
 Fri, 15 May 2020 06:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgNAkioH1z-pVimHziWP=ZtyBgCOwoC7ekWGFwzaZ1FPYg-tA@mail.gmail.com>
 <CAOssrKeNEdpY77xCWvPg-i4vQBoKLX3Y96gvf1kL7Pe29rmq_w@mail.gmail.com>
In-Reply-To: <CAOssrKeNEdpY77xCWvPg-i4vQBoKLX3Y96gvf1kL7Pe29rmq_w@mail.gmail.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Fri, 15 May 2020 15:18:59 +0200
Message-ID: <CAOssrKeDE5XKEA62Kygiis+6AVZodOzLifsaQY=eR0jAa8Z23g@mail.gmail.com>
Subject: Re: Setting mount propagation type in new mount API
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Petr Vorel <pvorel@suse.cz>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 3:04 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> On Fri, May 15, 2020 at 1:40 PM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
> >
> > Hello David, Miklos,
> >
> > I've been looking at the new mount API (fsopen(), fsconfig(),
> > fsmount(), move_mount(), etc.) and among the details that remain
> > mysterious to me is this: how does one set the propagation type
> > (private/shared/slave/unbindable) of a new mount and change the
> > propagation type of an existing mount?
>
> Existing mount can be chaged with mount(NULL, path, NULL, MS_$(propflag), NULL).
>
> To do that with a detached mount created by fsmount(2) the
> "/proc/self/fd/$fd" trick can be used.
>
> The plan was to introduce a mount_setattr(2) syscall, but that hasn't
> happened yet...  I'm not sure we should be adding propagation flags to
> fsmount(2), since that is a less generic mechanism than
> mount_setattr(2) or just plain mount(2) as shown above.

Also note that only setting MS_SHARED makes sense on a new mount
returned by fsmount(2) because

 - MS_PRIVATE is a no op, due to mount already being private

 - same for MS_SLAVE, since it's only different from MS_PRIVATE  on
mounts receiving propagation, which a new mount by definition isn't

 - MS_UNBINDABLE just prevents move_mount(2) from working so that's
not really useful, though at least it does something

A more interesting issue is whether we'd want to control the
propagation of the target when moving into a shared tree.  I.e. should
there be a MOVE_MOUNT_DONTPROPAGATE flag for move_mount(20 that
prevents the new mount from being propagated...

Thanks,
Miklos

