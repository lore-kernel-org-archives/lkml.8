Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD79C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 18:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33F624681
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 18:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f+QICMbo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgA0S2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 13:28:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50509 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725893AbgA0S2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 13:28:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580149718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3mbZcV8yWaTIA/hbNkPjAEycEkSir2saWg6RR3kS4nA=;
        b=f+QICMbocZVuJ9IbFAjsZ/e+Mj6iv7ZVq1ycT8E7SS0uUbYxCzKa7geA4vvsh1ioCuMAaU
        iJD2b/qLC1PFWbruXKLf/FGFuN7zLHPuLQl1tcK+dWNfQT5kIRb/pjemyuIRKjHHJB86Lx
        4WB659rs4+2sNjklY4Mj78H8WdBpxLc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-zWqPINwLNge1Lp-XhbGwbQ-1; Mon, 27 Jan 2020 13:28:36 -0500
X-MC-Unique: zWqPINwLNge1Lp-XhbGwbQ-1
Received: by mail-wr1-f70.google.com with SMTP id c17so6590921wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 10:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3mbZcV8yWaTIA/hbNkPjAEycEkSir2saWg6RR3kS4nA=;
        b=kd8lHvgZz5ZozlV0/QXrFRAfhcPkp89ZpYYjSX9kMbPS9qbt1/MdsCu70AUaJQudm7
         sCplQuXodLhrohX/vB5/ZjgkV4hI8vgRcFtOWLVlVD081akQI5NOrE5TcHOsM+TY+Cne
         0ZXNMF6DO/IPotYbn2wJFon+lZDSvN9XSCPcAnSd3I3etWtgLp6589A1wlqja4+DhBJt
         6O1PpNmkzQcPsUpzfTYj/qVBb1TBAEYTXgphfxhiNkjQKPfGK3yo8x7MlYVQNQiwefMI
         FmCU4fPjMxHNHnz4yPhVogcuJ3MSJBW9c9sQClHm8aXR4c/ZwamRMBFOg8C5Byb50nHz
         /lBg==
X-Gm-Message-State: APjAAAXBV4CL0HqWUYpi1hZ0b3i13as7AdnSCntiKgdsxiVLYTvKg6dO
        D9WMlZle9hhtsNtyrnF+6dB+rxaBwLbjjc1DFI9hsLefLAA8q1hkpkLJtobx74kJYIcbcjKJ6Xo
        Sc/zdhVJKSgbqHnGgmCLAaWX+
X-Received: by 2002:adf:f802:: with SMTP id s2mr24664204wrp.201.1580149715505;
        Mon, 27 Jan 2020 10:28:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqxljkmgJFrEsrK67bdzBVCvvZYAffQfauHWWhtfrHKAHuMm7FaRUGU2gtvbM7bw0rJ21gT52A==
X-Received: by 2002:adf:f802:: with SMTP id s2mr24664178wrp.201.1580149715279;
        Mon, 27 Jan 2020 10:28:35 -0800 (PST)
Received: from steredhat ([80.188.125.198])
        by smtp.gmail.com with ESMTPSA id t10sm10472778wmi.40.2020.01.27.10.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 10:28:34 -0800 (PST)
Date:   Mon, 27 Jan 2020 19:28:32 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH liburing 0/1] test: add epoll test case
Message-ID: <20200127182832.hashyy6wi75ca4cg@steredhat>
References: <20200127161701.153625-1-sgarzare@redhat.com>
 <d409ad33-2122-9500-51f4-37e9748f1d73@kernel.dk>
 <20200127180028.f7s5xhhizii3dsnr@steredhat>
 <52df8d77-1cb4-b8d5-d03d-5a8cabaeddb6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52df8d77-1cb4-b8d5-d03d-5a8cabaeddb6@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 11:07:41AM -0700, Jens Axboe wrote:
> On 1/27/20 11:00 AM, Stefano Garzarella wrote:
> > On Mon, Jan 27, 2020 at 09:26:41AM -0700, Jens Axboe wrote:
> >> On 1/27/20 9:17 AM, Stefano Garzarella wrote:
> >>> Hi Jens,
> >>> I wrote the test case for epoll.
> >>>
> >>> Since it fails also without sqpoll (Linux 5.4.13-201.fc31.x86_64),
> >>> can you take a look to understand if the test is wrong?
> >>>
> >>> Tomorrow I'll travel, but on Wednesday I'll try this test with the patch
> >>> that I sent and also with the upstream kernel.
> >>
> >> I'll take a look, but your patches are coming through garbled and don't
> >> apply.
> > 
> > Weird, I'm using git-publish as usual. I tried to download the patch
> > received from the ML, and I tried to reapply and it seams to work here.
> > 
> > Which kind of issue do you have? (just to fix my setup)
> 
> First I grabbed it from email, and I get the usual =3D (instead of =)
> and =20 instead of a space. Longer lines also broken up, with an = at
> the end.
> 
> Then I grabbed it from the lore io-uring archive, but it was the exact
> same thing.

I saw! I'll try to fix my setup.
The strange thing is that my git (v2.24.1) is able to apply that
malformed patch!

> 
> > Anyway I pushed my tree here:
> >     https://github.com/stefano-garzarella/liburing.git epoll
> 
> As per other email, I think you're having some coordination issues
> with the reaping and submitting side being separated. If the reaper
> isn't keeping up, you'll get the -EBUSY problem I saw. I'm assuming
> that's the failure case you are also seeing, you didn't actually
> mention how it fails for you?

My fault, I sent more information on the issue that I'm seeing.

Thanks,
Stefano

