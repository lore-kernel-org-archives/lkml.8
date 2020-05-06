Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79840C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56EF22082E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 18:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b8R8BXxV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbgEFShE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 14:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729757AbgEFShD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 14:37:03 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073B5C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 11:37:02 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id x2so347478ilp.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 11:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+SQS458OK5cEDlJQ1KUWYZtsylPRbVwiBUEmh5tlCnw=;
        b=b8R8BXxVNvZvYXXiTbMCsRpDZGgc3jvvenhNrJX604kungvLvVRc62AbdokVNOPwtL
         rsRXS/vrWau/KmBiRYzSlpvSep5rCgHY76rlEU+IaIWgxIJVQD8xU4qFhWi4h7jE3k4n
         kv6CoyiAlOzD0QtEJHJzwHXn5gozFcjpIgKgAqNJPzuZuYeyy8/i5bDL6JeF+8CjhowN
         pluwVl8T/69ZoZxC+VTWtoIheJZ+zPmaVgvIQAJFd8SJInmYqtuo6HjWHzJqLinVolMf
         FUQy4XZkxdOQbHwe870KHTZDpoGKtk3I2c2KBV9lhuwoJ1yHLT59BTow9I9fuSSxU1/s
         og7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+SQS458OK5cEDlJQ1KUWYZtsylPRbVwiBUEmh5tlCnw=;
        b=sKdSXyyfwpKEEKzYRzEQhyLIX1ThyIgoHDegtfarrwwAcqkx9yTc3E6o3mReLaeK4M
         jrEYVsWSGQgaMFPnz/e6PWICJnlAT/9yppI8CEdgPlSGI9KhQO74TzIIwT2EVkv2NOyQ
         m4hdtV0Ih8fE17IP4lOIIBa06rPV6NYf12Hnem6nJhk4YF6qmIyj8LTeBHp7Nyacf/vK
         QCfly8fmNB7YRq4HFT8LgPaiWy+5hGLjsrhCWZZutXaG7vKqxY3nQGC8apbm4QHKTKim
         AOj/5zYxMBlGlQggRhHBEF69NEdv3VoypOqtSVo6OjS83yO975IDE5+2hxOyKMPdw2L7
         j3IQ==
X-Gm-Message-State: AGi0Puah0ggNJxOLbG20kUhHbyM8l1lYlXS15rdEyIPuKA+0+h7vvkt6
        OUGOEuUxFo5U5bkpjCji9vL3fkA9UM7GPYdVzOhh4Q==
X-Google-Smtp-Source: APiQypKxrod6BbhYUw9n6wJofRB8bXCS7KZdmIPqIP3eXq/lW+vUTQM0VHRaaNA1mibRTxoQfW+qS7CtmtAazGzb6bQ=
X-Received: by 2002:a92:aa48:: with SMTP id j69mr10794636ili.16.1588790221975;
 Wed, 06 May 2020 11:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200504232132.23570-1-daniel.kiper@oracle.com>
 <20200504232132.23570-13-daniel.kiper@oracle.com> <CACdnJuszO1_aNXdgKt0_5XigC-AeuBT=gKkECszk7xX2p2TpkA@mail.gmail.com>
 <20200506133306.xrzplgdt4cckgrqc@tomti.i.net-space.pl>
In-Reply-To: <20200506133306.xrzplgdt4cckgrqc@tomti.i.net-space.pl>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 6 May 2020 11:36:49 -0700
Message-ID: <CACdnJuvsx_sRG=TAQzcgF6E+xdpcR_e0QURH6AnBSwJxVbOE1A@mail.gmail.com>
Subject: Re: [GRUB PATCH RFC 12/18] i386/efi: Report UEFI Secure Boot status
 to the Linux kernel
To:     Daniel Kiper <daniel.kiper@oracle.com>
Cc:     The development of GNU GRUB <grub-devel@gnu.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        trenchboot-devel@googlegroups.com,
        "the arch/x86 maintainers" <x86@kernel.org>,
        alexander.burmashev@oracle.com,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Daniel P. Smith" <dpsmith@apertussolutions.com>,
        eric.snowberg@oracle.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        krystian.hebel@3mdeb.com, lukasz.hawrylko@linux.intel.com,
        michal.zygowski@3mdeb.com,
        "Vladimir 'phcoder' Serbinenko" <phcoder@gmail.com>,
        pirot.krol@3mdeb.com, Peter Jones <pjones@redhat.com>,
        Ross Philipson <ross.philipson@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 6:33 AM Daniel Kiper <daniel.kiper@oracle.com> wrote:
>
> On Tue, May 05, 2020 at 10:29:05AM -0700, Matthew Garrett wrote:
> > On Mon, May 4, 2020 at 4:25 PM Daniel Kiper <daniel.kiper@oracle.com> wrote:
> > >
> > > Otherwise the kernel does not know its state and cannot enable various
> > > security features depending on UEFI Secure Boot.
> >
> > I think this needs more context. If the kernel is loaded via the EFI
> > boot stub, the kernel is aware of the UEFI secure boot state. Why
> > duplicate this functionality in order to avoid the EFI stub?
>
> It seems to me that this issue was discussed here [1] and here [2].
> So, if you want me to improve the commit message I am OK with that.

Yes, I think just providing an explanation for why it's currently
necessary for you to duplicate this is reasonable.
