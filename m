Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6003CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EE3D20657
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIRb6dp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgE0MPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 08:15:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32875 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725900AbgE0MPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:15:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590581740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pLaVnDwpTclVIWI/rgksOsILd2LuGC5m7xWEfTbOfv0=;
        b=NIRb6dp5jFFGAY1/wKKtauuxGjsL81PNuNAEPAF0/o9pY3ntyuV8w5tYXJ5W9D37Ga2d/L
        j7R2kwK2bojbHrzZHLdYJ5U0XnC8Py2cOFTT8m2c+H1QNwayUjpEnxVFQ3WtSArGI3uJD6
        brxkMqqBfQR7xMxmw4eH0ION56D1bLE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-D-fdg9yXODKcmLohEEJn6g-1; Wed, 27 May 2020 08:15:39 -0400
X-MC-Unique: D-fdg9yXODKcmLohEEJn6g-1
Received: by mail-qt1-f197.google.com with SMTP id o11so9343328qtm.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 05:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pLaVnDwpTclVIWI/rgksOsILd2LuGC5m7xWEfTbOfv0=;
        b=L/8D8GB+Yt2o1JzeHwQTDcZyA7/Mqf577vndcLhopAeWsxFnsh8DTQr5UkY/Ct1qW2
         fw45yqkPmzKxIsAE/OCvwiBpEg6aA01S8s6tZNDjTNdlngVPUjr/cGEUAUF6LAQD6L/Z
         w/tN0IZsu617FSn1WHDfeWMlJAISFnRTHuHPZCLqKZnpvPFDdrwunvU1qx1H6BnbhM7t
         6iHFUcbJaCnv97f5xscw7GR84RXoaF4mYjRY62OQWZbhVjx1Em6qaIR5Ztal/0HsRu12
         3C9/vx/Y6IhcFh5twIPB4E1oIaPBcuXk7TGvjydQdijRPQNPyRyuwb53pt6UB31BqrGx
         La3w==
X-Gm-Message-State: AOAM531TSbjQajVLdHBQkPHRU4zXuX55MQXhuGykE5nvh7jp5qpkskTf
        6w9ZoKCiALjy8llXT969T1Q3dzvoAFuEysjuO+pQYNqN9BMBsRk0KSpo1gY/G0rR423uPHpMmjp
        3foSYVQK8dGcMw7VMNFpVAuFrls7UeUn/bpVuj+Wm
X-Received: by 2002:a37:dc6:: with SMTP id 189mr3364746qkn.170.1590581738408;
        Wed, 27 May 2020 05:15:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+Ji08UDQyFXWdNpXtC/ZkjAzg125KVXNODa+psxX/r+DgVOPG5+j7SrMwt1aWWPoduOX3HOFR+lsLLBOmAUs=
X-Received: by 2002:a37:dc6:: with SMTP id 189mr3364722qkn.170.1590581738123;
 Wed, 27 May 2020 05:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200414091842.25972-1-kai.heng.feng@canonical.com>
 <nycvar.YFH.7.76.2005261023250.25812@cbobk.fhfr.pm> <CAO-hwJ+mTjVpBiY9vHXA2Y6D+cXYemixFJ++i+KwZZ25Z6LHHA@mail.gmail.com>
 <A51B9D28-88BF-42EB-9161-8E3081B128D2@canonical.com> <CAO-hwJJ=_2bn1BEshZ6URT813UAA6KRLaiEHt6bNPUcd9esskg@mail.gmail.com>
In-Reply-To: <CAO-hwJJ=_2bn1BEshZ6URT813UAA6KRLaiEHt6bNPUcd9esskg@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 27 May 2020 14:15:27 +0200
Message-ID: <CAO-hwJJCQbGV3cYjHNmiEi7rgoC5U9uq2ugkNJtRv=Z0wHsuag@mail.gmail.com>
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

On Wed, May 27, 2020 at 11:24 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Wed, May 27, 2020 at 8:19 AM Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
> >
> >
> >
> > > On May 26, 2020, at 16:43, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> > >
> > > On Tue, May 26, 2020 at 10:24 AM Jiri Kosina <jikos@kernel.org> wrote:
> > >>
> > >> On Tue, 14 Apr 2020, Kai-Heng Feng wrote:
> > >>
> > >>> After commit c23e2043d5f7 ("HID: multitouch: do not filter mice nodes"),
> > >>> MT_CLS_WIN_8 also supports mouse nodes, hence make MT_CLS_WIN_8_DUAL
> > >>> redundant.
> > >>>
> > >>> Remove MT_CLS_WIN_8_DUAL accordingly.
> > >>
> > >> Benjamin, can I get your Ack on this one please?
> > >
> > > Heh, funny enough I was trying to fix
> > > https://bugzilla.kernel.org/show_bug.cgi?id=207235 and was pondering
> > > this one too.
> > >
> > > To fix #207235, I'll likely need to add a new class and quirk in
> > > hid-multitouch. I can't really find a generic solution for now, and we
> > > better have a local quirk for the 2 devices we currently have and
> > > backport those to stable. However, this patch will likely conflict
> > > (trivially), with the new quirks, so I was thinking:
> > > - submitting my quick and dirty quirk and mark it to stable
> > > - apply this one on top of it (this one really doesn't need to go to stable)
> > >
> > > How does that sound?
> >
> > Sounds good. I'll resend this patch once your patch lands in the tree.
>
> Great, thanks. Though I should be able to rebase it and push it
> directly. I'll notify you if I can't get to it today.

Alright, rebased and pushed to for-5.8/multitouch.

Thanks a lot.

Cheers,
Benjamin

>
> Cheers,
> Benjamin
>
> >
> > Kai-Heng
> >
> > >
> > > Cheers,
> > > Benjamin
> > >
> > >>
> > >> Thanks,
> > >>
> > >> --
> > >> Jiri Kosina
> > >> SUSE Labs
> > >>
> > >
> >

