Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3353C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACFA21D7E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlMShFZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgATQxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:53:46 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31118 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726642AbgATQxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579539224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z9t8MR+UrzdM1k7Ra8u+CTe/uTutPMJ8BLRkLhrkm60=;
        b=OlMShFZjn2OfXDDhDiN0YwT11+bjeuwmNaCW5eQOQBP+mlpcjXI8gmzAs9NI6Bz4BU60Mv
        jG2ZCcg5RKkZ2HoTXapx/s5spK3hPmJqnxe+BGgp4Zt9A93PlPxoDv206xUVHQHBzlZHP9
        0GTVDfgPlNCA/YphFGxLYPlwBwZn5u0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-B4D5idR2OQeNjOKctV0GFw-1; Mon, 20 Jan 2020 11:53:43 -0500
X-MC-Unique: B4D5idR2OQeNjOKctV0GFw-1
Received: by mail-wr1-f71.google.com with SMTP id c17so61192wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 08:53:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z9t8MR+UrzdM1k7Ra8u+CTe/uTutPMJ8BLRkLhrkm60=;
        b=dTV3UZ0IDnjcU4OZm/rfZOTlkM3gNKnygcC4a5CohWC+qJnZW41KbNl5oOB/i0wYou
         OpkmrCPnyhwYCd+frwiooKpFMJzXcqE76JX5C+pAvsw+Rbzt2UnykI07V5LxKZuvhaDG
         +GnDvn7NmbrCO8iognxzFxqMX7GJHgcjjEJI513f0dxcr8IdIKsqdlEuWh0fus3hJjxX
         n2tz4NeoYjLInhBOGwoi3SKvcFb8wEkrKhR917iJFS6UMmEFiUUXk5wIOEIshxxCXNjd
         GO4hwLnyj+KdT64QyWAuLARoGg7ZW083GUfXLRVLiWdupPCil2mxfoH/vQrPNyTm9Cmu
         8iqw==
X-Gm-Message-State: APjAAAU95h9JYXC77osvgLkLHak9KC/h00VB2J5NojVor8I2ZpIY14uN
        gKPWqWNv4xzoBpJegNv663DSDhJu6Vl9lHp69SIhnJiik0pymwewz2SHsFaG5PlfU42cAGKtQOv
        fONJDmh8vRHEBZNxVLmHlIymE
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr440742wrm.324.1579539222680;
        Mon, 20 Jan 2020 08:53:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqyNW66fPRfK7FwpLegFkuWKTwV9qDnkpodkOYc0ad9mcsdyNY8eyfpyGVBQ2vBixbwS4shXCg==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr440720wrm.324.1579539222372;
        Mon, 20 Jan 2020 08:53:42 -0800 (PST)
Received: from steredhat (host84-49-dynamic.31-79-r.retail.telecomitalia.it. [79.31.49.84])
        by smtp.gmail.com with ESMTPSA id c2sm48389367wrp.46.2020.01.20.08.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 08:53:41 -0800 (PST)
Date:   Mon, 20 Jan 2020 17:53:39 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>,
        Jason Wang <jasowang@redhat.com>, kvm <kvm@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH net-next 1/3] vsock: add network namespace support
Message-ID: <CAGxU2F5=DQJ56sH4BUqp_7rvaXSF9bFHp4QkpLApJQK0bmd4MA@mail.gmail.com>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200116172428.311437-2-sgarzare@redhat.com>
 <20200120.100610.546818167633238909.davem@davemloft.net>
 <20200120101735.uyh4o64gb4njakw5@steredhat>
 <20200120060601-mutt-send-email-mst@kernel.org>
 <CAGxU2F6VH8Eb5UH_9KjN6MONbZEo1D7EHAiocVVus6jW55BJDg@mail.gmail.com>
 <20200120110319-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120110319-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 5:04 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Jan 20, 2020 at 02:58:01PM +0100, Stefano Garzarella wrote:
> > On Mon, Jan 20, 2020 at 1:03 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > On Mon, Jan 20, 2020 at 11:17:35AM +0100, Stefano Garzarella wrote:
> > > > On Mon, Jan 20, 2020 at 10:06:10AM +0100, David Miller wrote:
> > > > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > > > Date: Thu, 16 Jan 2020 18:24:26 +0100
> > > > >
> > > > > > This patch adds 'netns' module param to enable this new feature
> > > > > > (disabled by default), because it changes vsock's behavior with
> > > > > > network namespaces and could break existing applications.
> > > > >
> > > > > Sorry, no.
> > > > >
> > > > > I wonder if you can even design a legitimate, reasonable, use case
> > > > > where these netns changes could break things.
> > > >
> > > > I forgot to mention the use case.
> > > > I tried the RFC with Kata containers and we found that Kata shim-v1
> > > > doesn't work (Kata shim-v2 works as is) because there are the following
> > > > processes involved:
> > > > - kata-runtime (runs in the init_netns) opens /dev/vhost-vsock and
> > > >   passes it to qemu
> > > > - kata-shim (runs in a container) wants to talk with the guest but the
> > > >   vsock device is assigned to the init_netns and kata-shim runs in a
> > > >   different netns, so the communication is not allowed
> > > > But, as you said, this could be a wrong design, indeed they already
> > > > found a fix, but I was not sure if others could have the same issue.
> > > >
> > > > In this case, do you think it is acceptable to make this change in
> > > > the vsock's behavior with netns and ask the user to change the design?
> > >
> > > David's question is what would be a usecase that's broken
> > > (as opposed to fixed) by enabling this by default.
> >
> > Yes, I got that. Thanks for clarifying.
> > I just reported a broken example that can be fixed with a different
> > design (due to the fact that before this series, vsock devices were
> > accessible to all netns).
> >
> > >
> > > If it does exist, you need a way for userspace to opt-in,
> > > module parameter isn't that.
> >
> > Okay, but I honestly can't find a case that can't be solved.
> > So I don't know whether to add an option (ioctl, sysfs ?) or wait for
> > a real case to come up.
> >
> > I'll try to see better if there's any particular case where we need
> > to disable netns in vsock.
> >
> > Thanks,
> > Stefano
>
> Me neither. so what did you have in mind when you wrote:
> "could break existing applications"?

I had in mind:
1. the Kata case. It is fixable (the fix is not merged on kata), but
   older versions will not work with newer Linux.

2. a single process running on init_netns that wants to communicate with
   VMs handled by VMMs running in different netns, but this case can be
   solved opening the /dev/vhost-vsock in the same netns of the process
   that wants to communicate with the VMs (init_netns in this case), and
   passig it to the VMM.

These cases can work with vsock+netns, but they require changes because
I'm modifying the vsock behavior with netns.

