Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21BDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA3692068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z5iVu6TR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgFOXTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:19:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35123 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726313AbgFOXTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592263161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I1KNOxcQ0qqYSlRio7jZscN2pXxgFAfVqBfMLcPoOnc=;
        b=Z5iVu6TRIUUyT0rFptMET+OM13Rm1a8beC+LleKAOpgEx9Mdw5qMyDsJjR0itKW7Kn9GkS
        ZKxCodbr1TWpIulG5O0D7uSdugTH8V0Zo6Xk5xnQtV4HAyRm8d4BoUBv8JTuhk49VzC723
        Uv+M5JVmlVTcI4parzdmGgocyB/9Lbk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-qCTOZNNVNtSASZjvEAUy3A-1; Mon, 15 Jun 2020 19:19:20 -0400
X-MC-Unique: qCTOZNNVNtSASZjvEAUy3A-1
Received: by mail-qv1-f70.google.com with SMTP id v1so14220534qvx.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 16:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I1KNOxcQ0qqYSlRio7jZscN2pXxgFAfVqBfMLcPoOnc=;
        b=pGhNPri7a4XgKAU6jusHrJahz6QbL444xjwAVPpb1VW+KKBoHuK+Ie0AxBMd2RsTnp
         NcTnMBrS7Pk5Xjux13jTCS6oMnyf4QJ6xsUz6TWns0RNigG3Q2BZVOQdS3pVNXtbrgs5
         EC0cvVZiHE6N+DMUHmnI9HMPUgFp7LUaOE5Db8zHJY7TVvlGjYwiYF4azwG0f+yRW/ct
         uT0e68mASjkhJ9zqDk0H5Q5/AoY46rM1sqp8F09t4MHTUFCpYmdeCgCSRk0jZZT8btb0
         5/oez/ImtZFREPDHviTX09xGe5E8gq5fc43o9EF1X6i7p/hhD/4yBnqem/uIWmMjhn9e
         WJTA==
X-Gm-Message-State: AOAM532VLyfXBCX1Mddi4/AOcX2ckoD2rGF61IsEshbokxQbSMbesgU+
        aXeu+M6vmej7NU21kcoJy4MB3KXfayaQmDUGbjIth1N4Lrz2+5+X/sXJbh+eggSFikPM7cDxO2X
        lk2YjIZCQiGv4OsuHZvZ1+ZUo
X-Received: by 2002:a37:4753:: with SMTP id u80mr17430222qka.178.1592263159485;
        Mon, 15 Jun 2020 16:19:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIWF2yERjbTMsKnmdkICYDe+u35MHII6GwvHr//31ozLgOpPP0ktTYlVsaYcYaq8F5SQOSdQ==
X-Received: by 2002:a37:4753:: with SMTP id u80mr17430204qka.178.1592263159179;
        Mon, 15 Jun 2020 16:19:19 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id s15sm14057084qtc.95.2020.06.15.16.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 16:19:18 -0700 (PDT)
Date:   Mon, 15 Jun 2020 19:19:17 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH 02/25] mm: Introduce mm_fault_accounting()
Message-ID: <20200615231917.GA6307@xz-x1>
References: <20200615221607.7764-1-peterx@redhat.com>
 <20200615221607.7764-3-peterx@redhat.com>
 <CAHk-=wh3KYWKMPWYcyu9c-UPAwCXMcN86Wr5xyivCumWxEi7AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wh3KYWKMPWYcyu9c-UPAwCXMcN86Wr5xyivCumWxEi7AQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 03:32:40PM -0700, Linus Torvalds wrote:
> On Mon, Jun 15, 2020 at 3:16 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > Provide this helper for doing memory page fault accounting across archs.  It
> > can be defined unconditionally because perf_sw_event() is always defined, and
> > perf_sw_event() will be a no-op if !CONFIG_PERF_EVENTS.
> 
> Well, the downside is that now it forces a separate I$ miss and all
> those extra arguments because it's a out-of-line function and the
> compiler won't see that they all go away.
> 
> Yeah, maybe some day maybe we'll have LTO and these kinds of things
> will not matter. And maybe they already don't. But it seems kind of
> sad to basically force non-optimal code generation from this series.

I tried to make it static inline firstly in linux/mm.h, however it'll need to
have linux/mm.h include linux/perf_event.h which seems to have created a loop
dependency of headers.  I verified current code will at least generate inlined
functions too for x86 (no mm_fault_accounting() in "objdump -t vmlinux") with
gcc10.

Another alternative is to make it a macro, it's just that I feel the function
definition is a bit cleaner.  Any further suggestions welcomed too.

> 
> Why would you export the symbol, btw? Page fault handling is never a module.

I followed handle_mm_fault() which is exported too, since potentially
mm_fault_accounting() should always be called in the same context of
handle_mm_fault().  Or do you prefer me to drop it?

Thanks,

-- 
Peter Xu

