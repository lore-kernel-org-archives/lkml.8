Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915B9C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 22:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6659F22525
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 22:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWsGDa59"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgATWCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 17:02:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20173 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726843AbgATWCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 17:02:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579557732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aqEmL/GgShVVHjMvVQbxK02T5LT7/TkxslI85eRWNwQ=;
        b=eWsGDa59mHum5hI/jOThilkE/ISXlZ4P7JeR+pEcd/U+oIjC9/fpfAfVh8GSv+e3Sk1loq
        yMp4ElNct65g2cmC9qOEDynoA7gDkniwK8sMELCp+JZBKIsPQATnkpuyYVEsU16S1l/NIQ
        s2pCMN9Fa651QOD8TtAZybBTDFKCRAQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-244-MbKygxYwML6723A9YiO-Mg-1; Mon, 20 Jan 2020 17:02:10 -0500
X-MC-Unique: MbKygxYwML6723A9YiO-Mg-1
Received: by mail-qt1-f197.google.com with SMTP id d18so655361qtp.16
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 14:02:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aqEmL/GgShVVHjMvVQbxK02T5LT7/TkxslI85eRWNwQ=;
        b=soAu0miooz0jw3dvNW4RMMxzKd27w5itKlen0h6cZJ1NbQdhq0s4eHf8Dq1i1zreyo
         KWwAv6aNUfCdazYEeIx6BnHMLnQgzLKBPayRELNA+BQ9BU0Abe1zEDwfjx41J+pOxbUG
         ARrDbhxM/c36uYJvlJMGoIizO5FY9EzugT135ql4zNsYP9BSCknS9FAdp4vh6PVgZwZJ
         +VlCBiFYOp3ATbrH1ZcKTWoOT7DSIbAwIBNpgFjxM+7EeQPUZSJ5V9FCP86njGD0Gg8g
         Gean7MkMJZpOKSmvHuLOc2fAzjPICsto9lr7VIhV0ZgKCN8M/oU7BiQUPLdOM+H9ZEiC
         XN2g==
X-Gm-Message-State: APjAAAXKWMoNbDTukH34cM4/FB2y5APok6nzllNduCE+KrEj8rgfF3Se
        BZdlTgOuX4i6i2TbJ5n+39WrhUkA/iRi8HfZu7MpIE7OP14FSQ0W7IPiYExyp/ErnI3K9YDo+Aj
        b2wzybMzqrtIIZiWDLsGit0bd
X-Received: by 2002:ac8:34b4:: with SMTP id w49mr1592061qtb.24.1579557730122;
        Mon, 20 Jan 2020 14:02:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqymqhWHdBCdsG0obySehjwIz92dnU8ErB6tNKIxW2hEWyp5GKWcYVwAyPzD6sgL2fT0CICj9w==
X-Received: by 2002:ac8:34b4:: with SMTP id w49mr1592040qtb.24.1579557729868;
        Mon, 20 Jan 2020 14:02:09 -0800 (PST)
Received: from redhat.com (bzq-79-179-85-180.red.bezeqint.net. [79.179.85.180])
        by smtp.gmail.com with ESMTPSA id s26sm16735731qkj.24.2020.01.20.14.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 14:02:08 -0800 (PST)
Date:   Mon, 20 Jan 2020 17:02:03 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>,
        Jason Wang <jasowang@redhat.com>, kvm <kvm@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
Message-ID: <20200120170120-mutt-send-email-mst@kernel.org>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200116172428.311437-2-sgarzare@redhat.com>
 <20200120.100610.546818167633238909.davem@davemloft.net>
 <20200120101735.uyh4o64gb4njakw5@steredhat>
 <20200120060601-mutt-send-email-mst@kernel.org>
 <CAGxU2F6VH8Eb5UH_9KjN6MONbZEo1D7EHAiocVVus6jW55BJDg@mail.gmail.com>
 <20200120110319-mutt-send-email-mst@kernel.org>
 <CAGxU2F5=DQJ56sH4BUqp_7rvaXSF9bFHp4QkpLApJQK0bmd4MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F5=DQJ56sH4BUqp_7rvaXSF9bFHp4QkpLApJQK0bmd4MA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 05:53:39PM +0100, Stefano Garzarella wrote:
> On Mon, Jan 20, 2020 at 5:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > On Mon, Jan 20, 2020 at 02:58:01PM +0100, Stefano Garzarella wrote:
> > > On Mon, Jan 20, 2020 at 1:03 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > On Mon, Jan 20, 2020 at 11:17:35AM +0100, Stefano Garzarella wrote:
> > > > > On Mon, Jan 20, 2020 at 10:06:10AM +0100, David Miller wrote:
> > > > > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > > > > Date: Thu, 16 Jan 2020 18:24:26 +0100
> > > > > >
> > > > > > > This patch adds 'netns' module param to enable this new feature
> > > > > > > (disabled by default), because it changes vsock's behavior with
> > > > > > > network namespaces and could break existing applications.
> > > > > >
> > > > > > Sorry, no.
> > > > > >
> > > > > > I wonder if you can even design a legitimate, reasonable, use case
> > > > > > where these netns changes could break things.
> > > > >
> > > > > I forgot to mention the use case.
> > > > > I tried the RFC with Kata containers and we found that Kata shim-v1
> > > > > doesn't work (Kata shim-v2 works as is) because there are the following
> > > > > processes involved:
> > > > > - kata-runtime (runs in the init_netns) opens /dev/vhost-vsock and
> > > > >   passes it to qemu
> > > > > - kata-shim (runs in a container) wants to talk with the guest but the
> > > > >   vsock device is assigned to the init_netns and kata-shim runs in a
> > > > >   different netns, so the communication is not allowed
> > > > > But, as you said, this could be a wrong design, indeed they already
> > > > > found a fix, but I was not sure if others could have the same issue.
> > > > >
> > > > > In this case, do you think it is acceptable to make this change in
> > > > > the vsock's behavior with netns and ask the user to change the design?
> > > >
> > > > David's question is what would be a usecase that's broken
> > > > (as opposed to fixed) by enabling this by default.
> > >
> > > Yes, I got that. Thanks for clarifying.
> > > I just reported a broken example that can be fixed with a different
> > > design (due to the fact that before this series, vsock devices were
> > > accessible to all netns).
> > >
> > > >
> > > > If it does exist, you need a way for userspace to opt-in,
> > > > module parameter isn't that.
> > >
> > > Okay, but I honestly can't find a case that can't be solved.
> > > So I don't know whether to add an option (ioctl, sysfs ?) or wait for
> > > a real case to come up.
> > >
> > > I'll try to see better if there's any particular case where we need
> > > to disable netns in vsock.
> > >
> > > Thanks,
> > > Stefano
> >
> > Me neither. so what did you have in mind when you wrote:
> > "could break existing applications"?
> 
> I had in mind:
> 1. the Kata case. It is fixable (the fix is not merged on kata), but
>    older versions will not work with newer Linux.

meaning they will keep not working, right?

> 2. a single process running on init_netns that wants to communicate with
>    VMs handled by VMMs running in different netns, but this case can be
>    solved opening the /dev/vhost-vsock in the same netns of the process
>    that wants to communicate with the VMs (init_netns in this case), and
>    passig it to the VMM.

again right now they just don't work, right?

> These cases can work with vsock+netns, but they require changes because
> I'm modifying the vsock behavior with netns.

