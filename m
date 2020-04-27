Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96D6C55199
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B13DD2064C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 15:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfZ0IZhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgD0PVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 11:21:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20595 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727768AbgD0PVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 11:21:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588000870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t0zUuDSHC2LYYJLNAsloYEAAqSEOkEn10YRd/wXdi+k=;
        b=SfZ0IZheyMg6ghHTswOQGdrY+Rpys1Mi/KkEVLlbxCDRtBaItNqwp/1tLm81F1R0dUNVwE
        vZ7R8h9VNwMlVmM/DrOIszdygHdadb3hcjGsOpvO71bnsyupfDTxgC8IYYkElvOa5CiaO/
        +RFALVW2+XmKzEB6dGNJY7orxCdqWy4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-J_d3VEOKM5ir-kRT5Ibnew-1; Mon, 27 Apr 2020 11:21:08 -0400
X-MC-Unique: J_d3VEOKM5ir-kRT5Ibnew-1
Received: by mail-wr1-f69.google.com with SMTP id m5so10645633wru.15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 08:21:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t0zUuDSHC2LYYJLNAsloYEAAqSEOkEn10YRd/wXdi+k=;
        b=O+uVF3WJVPac43qIH+46tddB+QMFcD3WgKL3YYeZwmPM4y5aGCc41rPBCxo6OqCv5p
         cTeZPCAbu0/lDA1Y38679vjuKZ7DqnBHo1Np25lJxn/VIlAuSmAx6chuoi0uGe0gBXOd
         hsoUZEIOWgJd9vIXDeuNU9wH+DhF1ckXEPlgaaJRkBAWdnLhEhjdcgyGQL1bdSthWOqK
         m8YBWF0qa7zuCunCl3G9hWHvUtzrStcmk4xaW5OEyTV28sSiL2Slk8GUb37gvWqJOTdH
         CBzZFIZDHpsHST6vlmD2NJU9bIwaCqWhiBBhumxRPQwMPKr/k5lB80T6SBAxuyYPsdrV
         2ezA==
X-Gm-Message-State: AGi0PuaJ2bTEQvbEIkilsj0mzj3wtMcQYevfAfgvCrbRU5fvyob1tFV1
        MU0mx0FlNI+uUalzGyZX5lROorCQ0LKczghmr/Ktxl5HElPLVV1YQgCEQpXY6RdA1Thgf9YThpr
        zF4DhdyzsniB9fmZZMj0Epjf7
X-Received: by 2002:a1c:b445:: with SMTP id d66mr38649wmf.187.1588000867454;
        Mon, 27 Apr 2020 08:21:07 -0700 (PDT)
X-Google-Smtp-Source: APiQypIZ5/J/wN/0wkBkOIE/TjfFJ5VeKIYdPSnC6DlZr/llDxsorbTrSb9AdWnEjmL3w4GukHw2OQ==
X-Received: by 2002:a1c:b445:: with SMTP id d66mr38611wmf.187.1588000867197;
        Mon, 27 Apr 2020 08:21:07 -0700 (PDT)
Received: from steredhat (host108-207-dynamic.49-79-r.retail.telecomitalia.it. [79.49.207.108])
        by smtp.gmail.com with ESMTPSA id r3sm22637536wrx.72.2020.04.27.08.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 08:21:06 -0700 (PDT)
Date:   Mon, 27 Apr 2020 17:21:03 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     davem@davemloft.net, Stefan Hajnoczi <stefanha@redhat.com>,
        linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>,
        Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
Message-ID: <20200427152103.r65new4r342crfs6@steredhat>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <20200427102828-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427102828-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 10:31:57AM -0400, Michael S. Tsirkin wrote:
> On Mon, Apr 27, 2020 at 04:25:18PM +0200, Stefano Garzarella wrote:
> > Hi David, Michael, Stefan,
> > I'm restarting to work on this topic since Kata guys are interested to
> > have that, especially on the guest side.
> > 
> > While working on the v2 I had few doubts, and I'd like to have your
> > suggestions:
> > 
> >  1. netns assigned to the device inside the guest
> > 
> >    Currently I assigned this device to 'init_net'. Maybe it is better
> >    if we allow the user to decide which netns assign to the device
> >    or to disable this new feature to have the same behavior as before
> >    (host reachable from any netns).
> >    I think we can handle this in the vsock core and not in the single
> >    transports.
> > 
> >    The simplest way that I found, is to add a new
> >    IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS to /dev/vsock to enable the feature
> >    and assign the device to the same netns of the process that do the
> >    ioctl(), but I'm not sure it is clean enough.
> > 
> >    Maybe it is better to add new rtnetlink messages, but I'm not sure if
> >    it is feasible since we don't have a netdev device.
> > 
> >    What do you suggest?
> 
> Maybe /dev/vsock-netns here too, like in the host?
> 

I'm not sure I get it.

In the guest, /dev/vsock is only used to get the CID assigned to the
guest through an ioctl().

In the virtio-vsock case, the guest transport is loaded when it is discovered
on the PCI bus, so we need a way to "move" it to a netns or to specify
which netns should be used when it is probed.

> 
> > 
> >  2. netns assigned in the host
> > 
> >     As Michael suggested, I added a new /dev/vhost-vsock-netns to allow
> >     userspace application to use this new feature, leaving to
> >     /dev/vhost-vsock the previous behavior (guest reachable from any
> >     netns).
> > 
> >     I like this approach, but I had these doubts:
> > 
> >     - I need to allocate a new minor for that device (e.g.
> >       VHOST_VSOCK_NETNS_MINOR) or is there an alternative way that I can
> >       use?
> 
> Not that I see. I agree it's a bit annoying. I'll think about it a bit.
> 

Thanks for that!
An idea that I had, was to add a new ioctl to /dev/vhost-vsock to enable
the netns support, but I'm not sure it is a clean approach.

> >     - It is vhost-vsock specific, should we provide something handled in
> >       the vsock core, maybe centralizing the CID allocation and adding a
> >       new IOCTL or rtnetlink message like for the guest side?
> >       (maybe it could be a second step, and for now we can continue with
> >       the new device)
> > 

Thanks,
Stefano

