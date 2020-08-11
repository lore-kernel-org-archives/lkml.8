Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ECFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7135206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPcK2Kj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgHKOop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:44:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52263 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728782AbgHKOol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597157079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oBaHdbgWBei9PGc74NIX+QA+JMkdKt8VgiXEsDFjFk4=;
        b=LPcK2Kj1Id/SygidbUxdlKrF8+M1epwE1U3kxuhOFPu1eNg/wvuTa+m60nmuGQf1EmyGWM
        H29KDigXtxPTTs6P1KQE4vNwuAicaw1G+rIBJWGesd/I8fz+CeN6SC7g4J/+bJ8JB3/xYF
        d/MpRBaw5KQXrbyG9hSphSrNuSuwe+c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-uzfqQ1ImPxqdtAag7L51Ww-1; Tue, 11 Aug 2020 10:44:36 -0400
X-MC-Unique: uzfqQ1ImPxqdtAag7L51Ww-1
Received: by mail-wm1-f69.google.com with SMTP id g72so1061463wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 07:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oBaHdbgWBei9PGc74NIX+QA+JMkdKt8VgiXEsDFjFk4=;
        b=K8ugqNNebgnONMv2IWKy/d/2QrmDxhGpULFTaqviGRQzWe2ePVplJbtp5PYsLSMNx6
         W6x1alsuh55JsRpKANJi/H8pjYKogofF0jMN4ELfq9oRqsZnf0f6r7Z/91+x7t6cvm5n
         2qvA3gHvDv+dHv8uDdVJZBBmUUD565M7tXd3yujI6uM/1G2Qf8pzcgizwElLjA665UZT
         6I6UiQTZDNdvYtOMKMeWw9LwgjrRaYQ7vfGM0+8YAtxmya4LsfKY9RoMswNSdD/bYg1T
         EQFG090XfKyMlNdmkZfjy10IxC3YlmzWsPGW7XZ154uTNM88sr/aaGR7LbFcylyOyJSO
         34gw==
X-Gm-Message-State: AOAM5317RWX7iT2kErGNfRd81aGRlHT7DTyGLVkdjoXH1hnK8ei/MKxf
        rOky+52f5tJG0gfQOzNq/yKhk1XW6hzcZ/OBdGevs3Lc7k6ybjuvvdb8GujGzbt0Pr0g8wwyPkk
        EaTG9U0HQTcgMaGoRoFd661Rz
X-Received: by 2002:a7b:c5c1:: with SMTP id n1mr4034380wmk.125.1597157075123;
        Tue, 11 Aug 2020 07:44:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0PTTFxjBv2fKmGNBax++pGGY3UvTBaVwdqqwXV0cnxjCNtFxDB5PgFxhVxAtR3xQ8Kg8yRA==
X-Received: by 2002:a7b:c5c1:: with SMTP id n1mr4034367wmk.125.1597157074886;
        Tue, 11 Aug 2020 07:44:34 -0700 (PDT)
Received: from steredhat ([5.180.207.22])
        by smtp.gmail.com with ESMTPSA id h11sm22331259wrb.68.2020.08.11.07.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 07:44:34 -0700 (PDT)
Date:   Tue, 11 Aug 2020 16:44:19 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     syzbot <syzbot+996f91b6ec3812c48042@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: possible deadlock in __io_queue_deferred
Message-ID: <20200811144419.blu4wufu7t4dfqin@steredhat>
References: <00000000000035fdf505ac87b7f9@google.com>
 <76cc7c43-2ebb-180d-c2c8-912972a3f258@kernel.dk>
 <20200811140010.gigc2amchytqmrkk@steredhat>
 <504b4b08-30c1-4ca8-ab3b-c9f0b58f0cfa@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <504b4b08-30c1-4ca8-ab3b-c9f0b58f0cfa@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 08:21:12AM -0600, Jens Axboe wrote:
> On 8/11/20 8:00 AM, Stefano Garzarella wrote:
> > On Mon, Aug 10, 2020 at 09:55:17AM -0600, Jens Axboe wrote:
> >> On 8/10/20 9:36 AM, syzbot wrote:
> >>> Hello,
> >>>
> >>> syzbot found the following issue on:
> >>>
> >>> HEAD commit:    449dc8c9 Merge tag 'for-v5.9' of git://git.kernel.org/pub/..
> >>> git tree:       upstream
> >>> console output: https://syzkaller.appspot.com/x/log.txt?x=14d41e02900000
> >>> kernel config:  https://syzkaller.appspot.com/x/.config?x=9d25235bf0162fbc
> >>> dashboard link: https://syzkaller.appspot.com/bug?extid=996f91b6ec3812c48042
> >>> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> >>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133c9006900000
> >>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1191cb1a900000
> >>>
> >>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >>> Reported-by: syzbot+996f91b6ec3812c48042@syzkaller.appspotmail.com
> >>
> >> Thanks, the below should fix this one.
> > 
> > Yeah, it seems right to me, since only __io_queue_deferred() (invoked by
> > io_commit_cqring()) can be called with 'completion_lock' held.
> 
> Right
> 
> > Just out of curiosity, while exploring the code I noticed that we call
> > io_commit_cqring() always with the 'completion_lock' held, except in the
> > io_poll_* functions.
> > 
> > That's because then there can't be any concurrency?
> 
> Do you mean the iopoll functions? Because we're definitely holding it
> for the io_poll_* functions.

Right, the only one seems io_iopoll_complete().

So, IIUC, in this case we are actively polling the level below,
so there shouldn't be any asynchronous events, is it right?

Thanks,
Stefano

