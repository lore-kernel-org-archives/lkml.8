Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB6DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F9782465A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:58:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQfAWLPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgATN6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:58:08 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54951 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726642AbgATN6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579528687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JSGrES7SvQ9BENTP8tuIq46XiUVWki3/yCQVC8wDv3E=;
        b=eQfAWLPB7WbkYcvw7akvc5muzko66Ln5Mc6sP4yeFKT9yYiCMK4TmtN5XtYPlSiBBnKC5N
        NY9AxCRY766vV1Yo0ycTpyXLw6GQKiFIYJyxoRErW++OZPrIiZMdON/+tu3aRws6A4aYHs
        GyOHFHeN9hJPmTBdGm7zaM56H1NRzHs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-tXxSaaSaO_mGem3PGUtNTQ-1; Mon, 20 Jan 2020 08:58:06 -0500
X-MC-Unique: tXxSaaSaO_mGem3PGUtNTQ-1
Received: by mail-wr1-f71.google.com with SMTP id v17so14096713wrm.17
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 05:58:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JSGrES7SvQ9BENTP8tuIq46XiUVWki3/yCQVC8wDv3E=;
        b=pE77b40ipgFkE8DjSIH9iQR37HX4JIAoa79Wa2Ce2dHV5YPWuz3mb2h4v5kuHMgbuS
         N3nQiMJosImd+gjSfnaW0bROZH4EqEc/MYoTbThfcRxiMYZ6JLCorcGoHYvS+1qfuLdC
         IAvvMOAjiVW+NbALxb9yjGrphfnUdaqLa26LPRFV38x4dLbqni7j0JQ12/MNFnVWeKTS
         Gus0I5dCbtw19iV8/kkJdqjdFSeonB+7g7J5rCa5BYRrwpzTMn05ilspABldUJaeaLh8
         AgmyBzQWxE8AFZgkCBRLLBWF/hNC0IrcJ29IjF186dvmiwEy6pKHF+rKKnu0kypdfxNf
         BtaQ==
X-Gm-Message-State: APjAAAW2Dg4HOyMka0bhkFZgFzs/iiRjoHbwR8UgVbXLvb0W6U4TjLG/
        jdXQsoaV85yCBSngnOyQn7XBp3VEx6PBdTlezK5TjIC+5zo/t4jiZcYCUznVGBH4POLilc+3nvQ
        lSoIevsFEqmoKKYr93ZS/AYyA
X-Received: by 2002:a1c:a914:: with SMTP id s20mr19813064wme.189.1579528685023;
        Mon, 20 Jan 2020 05:58:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqz6wszqOYoCEpagKH53ZUl7pwL2W60rXYY3qi8C3MZSqVyDhyOnZjTORoRt3i9V4qU4repffg==
X-Received: by 2002:a1c:a914:: with SMTP id s20mr19813038wme.189.1579528684814;
        Mon, 20 Jan 2020 05:58:04 -0800 (PST)
Received: from steredhat (host84-49-dynamic.31-79-r.retail.telecomitalia.it. [79.31.49.84])
        by smtp.gmail.com with ESMTPSA id s8sm46404753wrt.57.2020.01.20.05.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 05:58:04 -0800 (PST)
Date:   Mon, 20 Jan 2020 14:58:01 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>,
        Jason Wang <jasowang@redhat.com>, kvm <kvm@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
Message-ID: <CAGxU2F6VH8Eb5UH_9KjN6MONbZEo1D7EHAiocVVus6jW55BJDg@mail.gmail.com>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200116172428.311437-2-sgarzare@redhat.com>
 <20200120.100610.546818167633238909.davem@davemloft.net>
 <20200120101735.uyh4o64gb4njakw5@steredhat>
 <20200120060601-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120060601-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 1:03 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Jan 20, 2020 at 11:17:35AM +0100, Stefano Garzarella wrote:
> > On Mon, Jan 20, 2020 at 10:06:10AM +0100, David Miller wrote:
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > Date: Thu, 16 Jan 2020 18:24:26 +0100
> > >
> > > > This patch adds 'netns' module param to enable this new feature
> > > > (disabled by default), because it changes vsock's behavior with
> > > > network namespaces and could break existing applications.
> > >
> > > Sorry, no.
> > >
> > > I wonder if you can even design a legitimate, reasonable, use case
> > > where these netns changes could break things.
> >
> > I forgot to mention the use case.
> > I tried the RFC with Kata containers and we found that Kata shim-v1
> > doesn't work (Kata shim-v2 works as is) because there are the following
> > processes involved:
> > - kata-runtime (runs in the init_netns) opens /dev/vhost-vsock and
> >   passes it to qemu
> > - kata-shim (runs in a container) wants to talk with the guest but the
> >   vsock device is assigned to the init_netns and kata-shim runs in a
> >   different netns, so the communication is not allowed
> > But, as you said, this could be a wrong design, indeed they already
> > found a fix, but I was not sure if others could have the same issue.
> >
> > In this case, do you think it is acceptable to make this change in
> > the vsock's behavior with netns and ask the user to change the design?
>
> David's question is what would be a usecase that's broken
> (as opposed to fixed) by enabling this by default.

Yes, I got that. Thanks for clarifying.
I just reported a broken example that can be fixed with a different
design (due to the fact that before this series, vsock devices were
accessible to all netns).

>
> If it does exist, you need a way for userspace to opt-in,
> module parameter isn't that.

Okay, but I honestly can't find a case that can't be solved.
So I don't know whether to add an option (ioctl, sysfs ?) or wait for
a real case to come up.

I'll try to see better if there's any particular case where we need
to disable netns in vsock.

Thanks,
Stefano

