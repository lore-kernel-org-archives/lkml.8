Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAE5C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 166B82467A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjmhZB8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729293AbgAUJHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:07:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44599 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728816AbgAUJHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579597636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aBt9kA8Q3sfLDPWSB6WPSmED3batQYaL6AuEX7S5BEo=;
        b=gjmhZB8VfzkQCPcB6tXhmtc0C3ToCJfn0qP/12MYn+L+sf360/xHslzZ3HmK8M6zqVUDcY
        AeMghAzd9q9gynjiLyIeXEyvNJ2E6XQJGuscM+jgi9MqeaaGTQQ1YPSUEbKkotLxKFP8Z6
        Nj995UiXUQ2C2CBsL7BGdBDBg1Rvc2Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-7Uhwf49HOVycELEcAWsyNw-1; Tue, 21 Jan 2020 04:07:11 -0500
X-MC-Unique: 7Uhwf49HOVycELEcAWsyNw-1
Received: by mail-wr1-f70.google.com with SMTP id y7so1032618wrm.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 01:07:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aBt9kA8Q3sfLDPWSB6WPSmED3batQYaL6AuEX7S5BEo=;
        b=XdCIu/3tUuuOe0L1vchKzpSV2wuc9tmHl9JQVfgPEdy6xyyWBxwl6p6oVQ0MBbhnsd
         avoFZE3CjXF0tFdtgyzt9/cp8tcNN1lnOEi87K2JmMWEc0uPdw3zotMEXP3axHmaDxDf
         ogilFbARyu4H2XBElKvJi5kjOMwYKyyPgl+17WkwNyoUmqnSSl7AdeIkw2EfhzKc+N3G
         vRCkjF4mCp/0yleeWLppTALP4qUVpek1rVYmiA1IoKEoofZj+X1+Wpjqr0rVQNpeKVKU
         lPmo9ShQwOmq9iavn6aRnvopXT8TwdGH9DauvOfZD6oT9rq+E41F18abFmgDeyEIUMW5
         PSRw==
X-Gm-Message-State: APjAAAVBycqGYzhWhf3d+JuNWiNn9iyDshivSAxD72nVMtbo5G3JW+Mr
        KF1A1uIfW1s9k+DwAfRCr1INhnMTXDHCyzZOh8m8G9lycW+GJJUEtvcsOGmeeA3bz614F3RNs47
        Hon2bNKvC+bXD6MxXY6GgJG3w
X-Received: by 2002:adf:ebc3:: with SMTP id v3mr4130258wrn.280.1579597630114;
        Tue, 21 Jan 2020 01:07:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqxU92Hbv50qsDxzXuliKOZgW+eihOR7bXFm+gNzrAyGGjKZoJ+jAUcQspYmZ2eK0Tb6M8FNyA==
X-Received: by 2002:adf:ebc3:: with SMTP id v3mr4130222wrn.280.1579597629862;
        Tue, 21 Jan 2020 01:07:09 -0800 (PST)
Received: from steredhat (host84-49-dynamic.31-79-r.retail.telecomitalia.it. [79.31.49.84])
        by smtp.gmail.com with ESMTPSA id r68sm2990217wmr.43.2020.01.21.01.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 01:07:09 -0800 (PST)
Date:   Tue, 21 Jan 2020 10:07:06 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>,
        Jason Wang <jasowang@redhat.com>, kvm <kvm@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
Message-ID: <CAGxU2F4uW7FNe5xC0sb3Xxr_GABSXuu1Z9n5M=Ntq==T7MaaVw@mail.gmail.com>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200116172428.311437-2-sgarzare@redhat.com>
 <20200120.100610.546818167633238909.davem@davemloft.net>
 <20200120101735.uyh4o64gb4njakw5@steredhat>
 <20200120060601-mutt-send-email-mst@kernel.org>
 <CAGxU2F6VH8Eb5UH_9KjN6MONbZEo1D7EHAiocVVus6jW55BJDg@mail.gmail.com>
 <20200120110319-mutt-send-email-mst@kernel.org>
 <CAGxU2F5=DQJ56sH4BUqp_7rvaXSF9bFHp4QkpLApJQK0bmd4MA@mail.gmail.com>
 <20200120170120-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120170120-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 11:02 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Jan 20, 2020 at 05:53:39PM +0100, Stefano Garzarella wrote:
> > On Mon, Jan 20, 2020 at 5:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > On Mon, Jan 20, 2020 at 02:58:01PM +0100, Stefano Garzarella wrote:
> > > > On Mon, Jan 20, 2020 at 1:03 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > On Mon, Jan 20, 2020 at 11:17:35AM +0100, Stefano Garzarella wrote:
> > > > > > On Mon, Jan 20, 2020 at 10:06:10AM +0100, David Miller wrote:
> > > > > > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > > > > > Date: Thu, 16 Jan 2020 18:24:26 +0100
> > > > > > >
> > > > > > > > This patch adds 'netns' module param to enable this new feature
> > > > > > > > (disabled by default), because it changes vsock's behavior with
> > > > > > > > network namespaces and could break existing applications.
> > > > > > >
> > > > > > > Sorry, no.
> > > > > > >
> > > > > > > I wonder if you can even design a legitimate, reasonable, use case
> > > > > > > where these netns changes could break things.
> > > > > >
> > > > > > I forgot to mention the use case.
> > > > > > I tried the RFC with Kata containers and we found that Kata shim-v1
> > > > > > doesn't work (Kata shim-v2 works as is) because there are the following
> > > > > > processes involved:
> > > > > > - kata-runtime (runs in the init_netns) opens /dev/vhost-vsock and
> > > > > >   passes it to qemu
> > > > > > - kata-shim (runs in a container) wants to talk with the guest but the
> > > > > >   vsock device is assigned to the init_netns and kata-shim runs in a
> > > > > >   different netns, so the communication is not allowed
> > > > > > But, as you said, this could be a wrong design, indeed they already
> > > > > > found a fix, but I was not sure if others could have the same issue.
> > > > > >
> > > > > > In this case, do you think it is acceptable to make this change in
> > > > > > the vsock's behavior with netns and ask the user to change the design?
> > > > >
> > > > > David's question is what would be a usecase that's broken
> > > > > (as opposed to fixed) by enabling this by default.
> > > >
> > > > Yes, I got that. Thanks for clarifying.
> > > > I just reported a broken example that can be fixed with a different
> > > > design (due to the fact that before this series, vsock devices were
> > > > accessible to all netns).
> > > >
> > > > >
> > > > > If it does exist, you need a way for userspace to opt-in,
> > > > > module parameter isn't that.
> > > >
> > > > Okay, but I honestly can't find a case that can't be solved.
> > > > So I don't know whether to add an option (ioctl, sysfs ?) or wait for
> > > > a real case to come up.
> > > >
> > > > I'll try to see better if there's any particular case where we need
> > > > to disable netns in vsock.
> > > >
> > > > Thanks,
> > > > Stefano
> > >
> > > Me neither. so what did you have in mind when you wrote:
> > > "could break existing applications"?
> >
> > I had in mind:
> > 1. the Kata case. It is fixable (the fix is not merged on kata), but
> >    older versions will not work with newer Linux.
>
> meaning they will keep not working, right?

Right, I mean without this series they work, with this series they work
only if the netns support is disabled or with a patch proposed but not
merged in kata.

>
> > 2. a single process running on init_netns that wants to communicate with
> >    VMs handled by VMMs running in different netns, but this case can be
> >    solved opening the /dev/vhost-vsock in the same netns of the process
> >    that wants to communicate with the VMs (init_netns in this case), and
> >    passig it to the VMM.
>
> again right now they just don't work, right?

Right, as above.

What do you recommend I do?

Thanks,
Stefano

