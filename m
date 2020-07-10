Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EEA4C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A64B206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjp2xMlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbgGJQUa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:20:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54486 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727916AbgGJQU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:20:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594398025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q9OBXiOBnT1mGmZ2eGcWLsQs9qpaRL+ZvL1+d8k1S8o=;
        b=gjp2xMlL82kham00+fOQkIMod7p8PBnHK0dIXP36vxyx2N+jYVuesM1mjX0XgTvxUIVYJv
        j54Q6p0aqCtl0hzNp1ufhV9dOIo+9lFvFJhsybVZwkb/63E5o0RmEbD5hpOxZzxufNn8QB
        NamVTrLHbt96WQYWB5LJwNrRUboK0vY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-gD70DAuDMf2a5hi_mlHx4A-1; Fri, 10 Jul 2020 12:20:24 -0400
X-MC-Unique: gD70DAuDMf2a5hi_mlHx4A-1
Received: by mail-wr1-f71.google.com with SMTP id e11so6537105wrs.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q9OBXiOBnT1mGmZ2eGcWLsQs9qpaRL+ZvL1+d8k1S8o=;
        b=CotTY/DBldwepIRYs2wn7zhDEZA9FbQr5Z9dPKXoUeMePMSvrcV5RBLkcqwa2antL0
         SLg/WcSAUD5m/MR86ti1seNh5DRIafrTfuGXedgKSPaZwaPETfEtv7vnuSav7AmP/9KS
         SrCk8OkZawFS6yQXOjzLr9gYXE7WwARB5m/QhR90kDsEqlK8ax/Bkm34esjIvO64sGtr
         2+HZh9bYwUSOS09bWPQIEmBLdu5+kyIpO9UdQ7ZityYsEvbV13hwp68GSCM9EUmKq2O0
         AQ5IntwLKk9BYbGRHuFaESpNT9fqd4WPSpwHCj9Cgj0YSCf7xtu3Ps7i5i0IbLMm0+EE
         kZVA==
X-Gm-Message-State: AOAM5322PjUcAs88sPUABpH8OY2DPWKHK7WXK0wztApw8y7RprDKcI+4
        fY7bsiYhtWdT8/duQDjf1VcdWlKSD+uxry/GdRPoOQiSkqWkH/m/WmQ0ENMe7q+MgDsSQ8MIHpb
        pdKjOQ2NST89q9JVxM+5xhxrA
X-Received: by 2002:a5d:630c:: with SMTP id i12mr75515899wru.158.1594398022819;
        Fri, 10 Jul 2020 09:20:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwNg29SHEj/1kCIq20X+QBQi6Vi8ell7jTihmuv4S0/ilMJ558e1BkioaTjMsJllIACTM1T8A==
X-Received: by 2002:a5d:630c:: with SMTP id i12mr75515878wru.158.1594398022605;
        Fri, 10 Jul 2020 09:20:22 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id 129sm10475853wmd.48.2020.07.10.09.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 09:20:22 -0700 (PDT)
Date:   Fri, 10 Jul 2020 18:20:17 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Sargun Dhillon <sargun@sargun.me>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Jann Horn <jannh@google.com>, Aleksa Sarai <asarai@suse.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        io-uring@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [PATCH RFC 0/3] io_uring: add restrictions to support untrusted
 applications and guests
Message-ID: <20200710162017.qdu34ermtxh3rfgl@steredhat>
References: <20200710141945.129329-1-sgarzare@redhat.com>
 <20200710153309.GA4699@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710153309.GA4699@char.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

On Fri, Jul 10, 2020 at 11:33:09AM -0400, Konrad Rzeszutek Wilk wrote:
> .snip..
> > Just to recap the proposal, the idea is to add some restrictions to the
> > operations (sqe, register, fixed file) to safely allow untrusted applications
> > or guests to use io_uring queues.
> 
> Hi!
> 
> This is neat and quite cool - but one thing that keeps nagging me is
> what how much overhead does this cut from the existing setup when you use
> virtio (with guests obviously)?

I need to do more tests, but the preliminary results that I reported on
the original proposal [1] show an overhead of ~ 4.17 uS (with iodepth=1)
when I'm using virtio ring processed in a dedicated iothread:

  - 73 kIOPS using virtio-blk + QEMU iothread + io_uring backend
  - 104 kIOPS using io_uring passthrough

>                                 That is from a high level view the
> beaty of io_uring being passed in the guest is you don't have the
> virtio ring -> io_uring processing, right?

Right, and potentially we can share the io_uring queues directly to the
guest userspace applications, cutting down the cost of Linux block
layer in the guest.

Thanks for your feedback,
Stefano

[1] https://lore.kernel.org/io-uring/20200609142406.upuwpfmgqjeji4lc@steredhat/

