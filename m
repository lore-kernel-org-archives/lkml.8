Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FCBC38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92223206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="XmHGbCjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbgEFOci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 10:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbgEFOci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:32:38 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C55BFC061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 07:32:36 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l3so2065160edq.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 07:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NO33uLD6Xr6XiFPTqsufLgQrcpAR6VqVSptPcb3vCPM=;
        b=XmHGbCjY9XHs4RDllkZr7GYbW3x17Xp/d2ZM7/YMaE9ZkCbhONDDDa7HeD0HRh74bq
         YKPQO2EzhiUxtaRm3oZTt9Nv6BDImxVv3K/GPUhcLI7IrOefAffsFHHm8ywD4W6iHudl
         DxVysky4je4edF7Stgs34qe5gCbgZ/MPaICSiiGdE9juP74oXcpZZzAbnJxi27yhalhj
         DLNxC+PxvCZNtG5SbSBAWnfQKlFEtwLVI52AIoZhVB0MEGeDLvuCRuEGHenVXh6RLeoN
         TiHEnM2OzuqqixUAR0h5G+xnYX+ki23UyP6rJKLqPrD+mfb91EDxD7ZEKfmhNhlA8NkX
         tzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NO33uLD6Xr6XiFPTqsufLgQrcpAR6VqVSptPcb3vCPM=;
        b=BQt05l2+ZxO6hp9wo7MYJTsagAPytP+ZyTB9mDqosfVZ4Nawpa28cuVY2rIeugJN9C
         IEKz27N4TmdmMvN4zH+LQ0/MJE0I8RPp/uDh2HdgIGAD7C3C3fTD2/MleAJe9smes1Wx
         28kCf15xzcp5ezIR9+DDib9eeTeJYoZ8uSvBFJHIvAiFAxHcR4TJAm535LQL2gh6BqA3
         FHwJ51FrucjCi0Y8Te+0baEb3vukS0cCbAcpEH+crOK2O0J7WANFov+rjDme6uuxj1fn
         RWE06EfHxeFtIgxRcwdjmSJ5XVPWioLa1cprkdLF9WyGR5Oi+hpn/ls11rPdZpeNhcQy
         5+8g==
X-Gm-Message-State: AGi0PuafAVROjcVmJs+u+x2kI6M2UFFzvVxN7PQzk1kOkcQUmjJyf/a5
        XjNC4AnoZHMi5+MzKotbicG+tphCmB88b3LaiBALy1C5
X-Google-Smtp-Source: APiQypLadWKCh5cKd8+XAM3rxskPpXwANJdRLpqUHQap12ixTxs6zbMNEiCnqvUneUgX3f1gT3naBeyCuwqqUKi4tds=
X-Received: by 2002:aa7:cfc3:: with SMTP id r3mr7469705edy.342.1588775555412;
 Wed, 06 May 2020 07:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200505154510.93506-1-pasha.tatashin@soleen.com>
 <20200505154510.93506-3-pasha.tatashin@soleen.com> <202005051444.14B6686@keescook>
 <20200506095239.11a76a76@gandalf.local.home>
In-Reply-To: <20200506095239.11a76a76@gandalf.local.home>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 6 May 2020 10:31:59 -0400
Message-ID: <CA+CK2bB-Qim9T2NKV97HdPbSER+RR5R4_rOCZ3JZgZ5FcU05Pg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] pstore/platform: pass max_reason to kmesg dump
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        anton@enomsg.org, ccross@android.com,
        Tony Luck <tony.luck@intel.com>, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 9:52 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 5 May 2020 14:59:37 -0700
> Kees Cook <keescook@chromium.org> wrote:
>
> > > @@ -97,6 +97,8 @@ struct pstore_record {
> > >   * @read_mutex:    serializes @open, @read, @close, and @erase callbacks
> > >   * @flags: bitfield of frontends the backend can accept writes for
> > >   * @data:  backend-private pointer passed back during callbacks
> > > + * @max_reason: Used when PSTORE_FLAGS_DMESG is set. Contains the
> > > + *              kmsg_dump_reason enum value.
> >
> > Nit: please move this above @data since it has a @flags dependency.
> >
> > >   *
> > >   * Callbacks:
> > >   *
> > > @@ -180,6 +182,7 @@ struct pstore_info {
> > >
> > >     int             flags;
> > >     void            *data;
> > > +   int             max_reason;
>
> Not to mention that moving max_reason above data will fill in the hole left
> by a 32 bit int, followed by a 64 bit pointer.

Good point. I will do it in the next version.

Thank you,
Pasha

>
> -- Steve
>
>
> > >
> > >     int             (*open)(struct pstore_info *psi);
> > >     int             (*close)(struct pstore_info *psi);
