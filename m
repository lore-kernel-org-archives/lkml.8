Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94942C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FFB92065E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 07:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPQU5YAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgGXHZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 03:25:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:43452 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726638AbgGXHZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 03:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595575518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fuErLOqr2wiHuSm1n+glJqJxYG3jv4lWg3NgZEQOlPE=;
        b=fPQU5YAOHeVpb/XBWql+enb3J1xB5CBDy8DczdAQ4HtDXLrq8hROvvEqGYJd8krSqb0GtK
        6Bisi/7F3+nHql9oAOKzUp6l1c61KzJQ03Vxaod6kWTUW2DuihfXEcd+huwbjRLhTEtY1F
        EubOu984psNZZTE6mSmraAEp0snG5Mk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-IfZTPPalMxiIM2J4-pHJJQ-1; Fri, 24 Jul 2020 03:25:16 -0400
X-MC-Unique: IfZTPPalMxiIM2J4-pHJJQ-1
Received: by mail-wr1-f70.google.com with SMTP id z7so1343086wrw.21
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 00:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fuErLOqr2wiHuSm1n+glJqJxYG3jv4lWg3NgZEQOlPE=;
        b=E2OzeTEtzMpPZHlG3NGU8+Wo8a5PFruTLAGDGgHf1YafE3TgLd6xXVuU6Er6J9PGoH
         iPs5syohNFeOaF2MyU13Wm2Eqru32YvBb/AlFm1EI0fNVHALP4wSiGzqaBIm1wDayBMw
         eTvBmoMR6rg5t4azFndi8Zc1SGbjs3Hrl1Dr805mo6gGm2ajyNFgDvrwrWFhRG9E3wyQ
         RSXm6AuGbZ5KSeSdxAKCt42ojG6/1V0XvFJ9I8iyPPeHkl59qWsFjtlbyxy36A8brxwd
         TDNMKhi3NmkaSdPRedytVvFjesqd+hyM0Pvn3/7tLeulk5iJBh/4t+em81xbHBk3HpG5
         jiPg==
X-Gm-Message-State: AOAM532fTfhSclO5qM9ooB/nP5qIItUhMrzRodN6H7hOYsfAaQiJNRUH
        T0k0ozPZH3hHKtvRYNkXoBWBgVVJGjKoLJbe8o1jNwJTadrRz4WUZkUNcver1zKPUb/0JUMgO2J
        lYKmMZujJvVu+3C03moimgcCV
X-Received: by 2002:adf:bb52:: with SMTP id x18mr7081714wrg.325.1595575515197;
        Fri, 24 Jul 2020 00:25:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjC5TNOMsbWloWKiM1fPLp95PjAuhLTb70ke99fpxMRmPpCdyrTQ/Uxi1NsfB0ImOP4RPRkA==
X-Received: by 2002:adf:bb52:: with SMTP id x18mr7081693wrg.325.1595575514967;
        Fri, 24 Jul 2020 00:25:14 -0700 (PDT)
Received: from steredhat.lan ([5.171.199.112])
        by smtp.gmail.com with ESMTPSA id p25sm5864195wmg.39.2020.07.24.00.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 00:25:14 -0700 (PDT)
Date:   Fri, 24 Jul 2020 09:25:09 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Colin Walters <walters@verbum.org>
Cc:     Andy Lutomirski <luto@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Kees Cook <keescook@chromium.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        strace-devel@lists.strace.io, io-uring@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: strace of io_uring events?
Message-ID: <20200724072509.sgqlbuocpo2peian@steredhat.lan>
References: <7c09f6af-653f-db3f-2378-02dca2bc07f7@gmail.com>
 <CAJfpegt9=p4uo5U2GXqc-rwqOESzZCWAkGMRTY1r8H6fuXx96g@mail.gmail.com>
 <48cc7eea-5b28-a584-a66c-4eed3fac5e76@gmail.com>
 <202007151511.2AA7718@keescook>
 <20200716131404.bnzsaarooumrp3kx@steredhat>
 <202007160751.ED56C55@keescook>
 <20200717080157.ezxapv7pscbqykhl@steredhat.lan>
 <CALCETrXSPdiVCgh3h=q7w9RyiKnp-=8jOHoFHX=an0cWqK7bzQ@mail.gmail.com>
 <20200721155848.32xtze5ntvcmjv63@steredhat>
 <d57e169a-55a0-4fa2-a7f2-9a462a786a38@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d57e169a-55a0-4fa2-a7f2-9a462a786a38@www.fastmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 09:37:40AM -0400, Colin Walters wrote:
> On Tue, Jul 21, 2020, at 11:58 AM, Stefano Garzarella wrote:
> 
> > my use case concerns virtualization. The idea, that I described in the
> > proposal of io-uring restrictions [1], is to share io_uring CQ and SQ queues
> > with a guest VM for block operations.
> 
> Virtualization being a strong security barrier is in eternal conflict
> with maximizing performance.  All of these "let's add a special
> guest/host channel" are high risk areas.
> 
> And this effort in particular - is it *really* worth it to expose a
> brand new, fast moving Linux kernel interface (that probably hasn't
> been fuzzed as much as it needs to be) to virtual machines?
> 

It is an experiment to explore the potential of io_uring. In addition
the restrictions can also be useful for other use case, for example if
a process  wants to allow another process to use io_uring, but only allowing
a subset of operations.

> People who want maximum performance at the cost of a bit of security
> already have the choice to use Linux containers, where they can use
> io_uring natively.
> 

Thanks,
Stefano

