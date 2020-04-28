Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961E6C83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71A43206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWInyEc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgD1QBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:01:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46088 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728080AbgD1QBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588089660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V/nHrnAWjFYDEx+ooars7FfriVR6n5mahvVNAOlPkCA=;
        b=CWInyEc9RhBkQetkohvGIXbkg3GphnrOZ6NsM0dp1q0WQPBbomrjasUEDYbDMQTRb8hMzK
        pA/9zfxPfOoxh/dinN2Cv778s1D6zaZE1sP+6qpi2XeXAi/pYWaNivBwCsqFAxWA1ygtVc
        OYbNyocD7uMCQyAxjlYnmPwRP/ah6wE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-lTf2py4WP0q7Rf-TCfi6KQ-1; Tue, 28 Apr 2020 12:00:58 -0400
X-MC-Unique: lTf2py4WP0q7Rf-TCfi6KQ-1
Received: by mail-wm1-f71.google.com with SMTP id n127so1054001wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 09:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=V/nHrnAWjFYDEx+ooars7FfriVR6n5mahvVNAOlPkCA=;
        b=F9ILT1HuO/moKr4Z84QJ3pjPoDpMgBGAZa0zBLX6EsQ5wJADHWv9s8FUz/viFEzdEe
         q6xQ89+rFFsY8NlmDZN4AyV7Ai5fUFH46UFbDsi6vmXi2h+p9rpQKoKG99NOlEfzNKXT
         4kaxOx+MmzDa32iFgXDZRn/Hy3KA/dLm7OJqIooKpLo8chOZygEXD6Lh21atf0YRVGZw
         4MWLliKKSTUSUWoNwYGHJdoC6miPs2wAKiJWZQC0X/kJ8GssSPjF0jXSVrZHJiG0bZy2
         ovWTbI8mK9gQ27Ce0EqGzJbRBaeh4j0jfMLEPjyNf3oN0TjlpLsbFn+pwOiAK1DfStBH
         ykxA==
X-Gm-Message-State: AGi0PuZ6yTdsCZRY3HxL8VApOcIn7QvdPokaPOUn7eGMaoH97+TYMP0B
        Mtp5Wu23b4ZHXdRIGiCmdRc64TdAymhN4toSMvRGeBZWzjhb5TrCgSgLqo+j855Y1qbsckhp6n+
        aUMXLKnIhvc8905LO2qqB3AMF
X-Received: by 2002:adf:bb94:: with SMTP id q20mr36673127wrg.105.1588089656820;
        Tue, 28 Apr 2020 09:00:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypKIbCy5WLfJsOD2H4tVuk3XU3G9si8HV/hIhC9ID521e8b71TD3eq8vjhdxcrAKzwjnXgEZ/g==
X-Received: by 2002:adf:bb94:: with SMTP id q20mr36673001wrg.105.1588089655649;
        Tue, 28 Apr 2020 09:00:55 -0700 (PDT)
Received: from steredhat (host108-207-dynamic.49-79-r.retail.telecomitalia.it. [79.49.207.108])
        by smtp.gmail.com with ESMTPSA id i129sm4064632wmi.20.2020.04.28.09.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 09:00:54 -0700 (PDT)
Date:   Tue, 28 Apr 2020 18:00:52 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     davem@davemloft.net, Stefan Hajnoczi <stefanha@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Jorgen Hansen <jhansen@vmware.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-hyperv@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        netdev@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] vsock: support network namespace
Message-ID: <20200428160052.o3ihui4262xogyg4@steredhat>
References: <20200116172428.311437-1-sgarzare@redhat.com>
 <20200427142518.uwssa6dtasrp3bfc@steredhat>
 <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <224cdc10-1532-7ddc-f113-676d43d8f322@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 04:13:22PM +0800, Jason Wang wrote:
> 
> On 2020/4/27 下午10:25, Stefano Garzarella wrote:
> > Hi David, Michael, Stefan,
> > I'm restarting to work on this topic since Kata guys are interested to
> > have that, especially on the guest side.
> > 
> > While working on the v2 I had few doubts, and I'd like to have your
> > suggestions:
> > 
> >   1. netns assigned to the device inside the guest
> > 
> >     Currently I assigned this device to 'init_net'. Maybe it is better
> >     if we allow the user to decide which netns assign to the device
> >     or to disable this new feature to have the same behavior as before
> >     (host reachable from any netns).
> >     I think we can handle this in the vsock core and not in the single
> >     transports.
> > 
> >     The simplest way that I found, is to add a new
> >     IOCTL_VM_SOCKETS_ASSIGN_G2H_NETNS to /dev/vsock to enable the feature
> >     and assign the device to the same netns of the process that do the
> >     ioctl(), but I'm not sure it is clean enough.
> > 
> >     Maybe it is better to add new rtnetlink messages, but I'm not sure if
> >     it is feasible since we don't have a netdev device.
> > 
> >     What do you suggest?
> 
> 
> As we've discussed, it should be a netdev probably in either guest or host
> side. And it would be much simpler if we want do implement namespace then.
> No new API is needed.
> 

Thanks Jason!

It would be cool, but I don't have much experience on netdev.
Do you see any particular obstacles?

I'll take a look to understand how to do it, surely in the guest would
be very useful to have the vsock device as a netdev and maybe also in the host.

Stefano

