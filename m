Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8549C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81F6217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 08:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NPtaUJUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgBMIov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 03:44:51 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46459 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729406AbgBMIou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 03:44:50 -0500
Received: by mail-qt1-f193.google.com with SMTP id e21so3787398qtp.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 00:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KOSVM3SCrmejITCMr3GluXgYMymHjzYiqiilJMCtfIo=;
        b=NPtaUJUrHrgkXufReVIevgow9DgZl2OKuyPO8hT6d+F7xLGlqPXjQh/3lcHQQlw6Ai
         P7LyDIUQM8v6bMydOpYp6lGLTQTuYskdEkSfgYDRV5OSzBxsf8y001ygJgNSwxx5/YON
         32oVmuKlslI3S7NGNaaCgn4PrGeySYRDP1pThEOrV0H4dszmfQ+mjkn2ioQTX4FHGxih
         T5dVeKVECRVjebE+UEmRT4VG18wci/MtxXD+cvaHnE2y53WnfOwOo5VX/ShWB4rcRk6h
         JIRRGUPe6raHp0YkROsKIBiTGim39fD2i6vuzecV+d+bDQBVi3ve4KvoxWWtWOEksW7G
         gm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KOSVM3SCrmejITCMr3GluXgYMymHjzYiqiilJMCtfIo=;
        b=uacuJ+RkFjeauo93uHQnE40nDSY03sSBKsy6VqnVvIOQFmnlFtVqygElDndnQG5I7D
         Nfc6XmL3VtlzgtuhkCu6lcGuese+PJz41kgQwCoPqpXq7zi7jZm/a4EsLgCVVYoriPuC
         tlY4Pj1DYqVFyJPDXZrALXbRrtD/p0I6Vjs+Yh8isIrgGnYOgHJWrmM0FB34F3nh5mwI
         UL34X3NGNX5aXhUm7hLFtMQfNEho+DnWC4JjPH1RxxcU+0GpelQw9IWeEDrSCLquxMTn
         9iuIiu4msn97G4NtpuryHn3/8m16KuoMSPEabxjASon2QAz6Njiz3fcmcMxH64C8JtHX
         D8XQ==
X-Gm-Message-State: APjAAAWYRjHvhN4VUBCaZ0uWp98Dj5oFgISMDarZEvgjR/4/BV3ac4v0
        6JVKiF3lOY3KkoD5hCF3vOKnR4WphrboKP9KK0OJUQ==
X-Google-Smtp-Source: APXvYqwTXPB+FUSQKadoYbcOvs7B3qGJ4Mo5mlSnKnJ0BfgU7IBIkH5raq8Z2SPywrGqXYc2w/C48w5J6X39jBMYPTg=
X-Received: by 2002:aed:36a5:: with SMTP id f34mr10288280qtb.57.1581583489053;
 Thu, 13 Feb 2020 00:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20200210225806.249297-1-trishalfonso@google.com>
 <13b0ea0caff576e7944e4f9b91560bf46ac9caf0.camel@sipsolutions.net>
 <CAKFsvUKaixKXbUqvVvjzjkty26GS+Ckshg2t7-+erqiN2LVS-g@mail.gmail.com> <e8a45358b273f0d62c42f83d99c1b50a1608929d.camel@sipsolutions.net>
In-Reply-To: <e8a45358b273f0d62c42f83d99c1b50a1608929d.camel@sipsolutions.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 13 Feb 2020 09:44:37 +0100
Message-ID: <CACT4Y+ZB3QwzeogxVFVXW_z=eE2n5fQxj7iYq9-Jw68zdS=mUA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] UML: add support for KASAN under x86_64
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Patricia Alfonso <trishalfonso@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 9:19 AM Johannes Berg <johannes@sipsolutions.net> wrote:
>
> On Wed, 2020-02-12 at 16:37 -0800, Patricia Alfonso wrote:
> >
> > > That also means if I have say 512MB memory allocated for UML, KASAN will
> > > use an *additional* 64, unlike on a "real" system, where KASAN will take
> > > about 1/8th of the available physical memory, right?
> > >
> > Currently, the amount of shadow memory allocated is a constant based
> > on the amount of user space address space in x86_64 since this is the
> > host architecture I have focused on.
>
> Right, but again like below - that's just mapped, not actually used. But
> as far as I can tell, once you actually start running and potentially
> use all of your mem=1024 (MB), you'll actually also use another 128MB on
> the KASAN shadow, right?
>
> Unlike, say, a real x86_64 machine where if you just have 1024 MB
> physical memory, the KASAN shadow will have to fit into that as well.

Depends on what you mean by "real" :)
Real user-space ASAN will also reserve 1/8th of 47-bit VA on start
(16TB). This implementation seems to be much closer to user-space ASAN
rather than to x86_64 KASAN (in particular it seems to be mostly
portable across archs and is not really x86-specific, which is good).
I think it's reasonable and good, but the implementation difference
with other kernel arches may be worth noting somewhere in comments.
