Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103A0C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 21:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D373F206CC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 21:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="zHeO+NAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgCFVFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 16:05:42 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39940 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCFVFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 16:05:42 -0500
Received: by mail-ot1-f66.google.com with SMTP id x19so3849279otp.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 13:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a1kF/OZzMQLactEcP2uvKaRdr9m2gxg0zsQwgDcUpS8=;
        b=zHeO+NASipBgaWDXKZxHQ9T6Qk7JyQTufn1LqoKL9eCvWxA6ERYUyq5brfvaGK2Q2T
         O/1XtzLEJ1OB063KrHNDlljqirAy6dSyKF1iCoBOl1Vku6umli7wybNDN4liHG6HiEkL
         iJQBdSeZVh2iwysFc31yvgGzAfDguHevXnkROYvBITGUqkec3Q6DiV6vn3qAjCSwkC6V
         7yLNzobtVea45nRJ6F+O3pxCAX7i2s3r6qp0ctkisp7YTbLrPNxHKjQpvGQULi0khAfv
         gHd+Vg6XcX50oieboKdVEQSwY9XXXxKOGwnkGWC6OtC68at4+VqDSlJ0yEpTWQIPL97W
         CziA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a1kF/OZzMQLactEcP2uvKaRdr9m2gxg0zsQwgDcUpS8=;
        b=YNvfWsHFKRv/sPRpB9jUoOpye54vxmRev0UIgv/EfatxniqPY0ny0U6Lnu72AF20ec
         mS7CpUZQt/TUIhZIOEzVJykrVk1i63n3qXtckGUoVDHI/lmlctH+M012dxx2GvaQrg/n
         b7nGSX113RQkWJx2YTiAr4Xn3JC0Xfge4+fTMED2V85VJPR/qiwngWMVqssJKxeDDD6T
         rg9fMqYtKeaFMetxBgeY9m82pm3u4CajkD4D46gRKjf4N/4u/3nFepHohJeW8s+JJOqJ
         GvnumsjC+pNh79LzzTbRAWOmLPdmEW6QgEDd6hLKz7weKiicw41QA0FxQw2s84+kMHmm
         SyhQ==
X-Gm-Message-State: ANhLgQ19mHfZ6LvqIDgK6hzGA4mFxEv7pM55gwLWMYDInnke6QgiAk5a
        hym4mj6IBq3ZYl7FI+9E/+mSUOJkwCdXgZffdpBpFA==
X-Google-Smtp-Source: ADFU+vu3caJkxN5foYyF0GPM62BSitG6fiBBhbRTadus2AVityefuk0oEkE1SzZK3vy+IUU4Bmf/G7dorCK3e8I7x8s=
X-Received: by 2002:a05:6830:1313:: with SMTP id p19mr763057otq.126.1583528741694;
 Fri, 06 Mar 2020 13:05:41 -0800 (PST)
MIME-Version: 1.0
References: <158318759687.2216124.4684754859068906007.stgit@dwillia2-desk3.amr.corp.intel.com>
 <x49a74tnt6n.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49a74tnt6n.fsf@segfault.boston.devel.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 6 Mar 2020 13:05:30 -0800
Message-ID: <CAPcyv4jCWtPf0XEHfw6GGGE80k0_wKpoaruopRFJwKcsHk18gw@mail.gmail.com>
Subject: Re: [PATCH 0/5] Manual definition of Soft Reserved memory devices
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Borislav Petkov <bp@alien8.de>,
        Wei Yang <richardw.yang@linux.intel.com>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Brice Goglin <Brice.Goglin@inria.fr>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joao Martins <joao.m.martins@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 6, 2020 at 12:07 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > Given the current dearth of systems that supply an ACPI HMAT table, and
> > the utility of being able to manually define device-dax "hmem" instances
> > via the efi_fake_mem= option, relax the requirements for creating these
> > devices. Specifically, add an option (numa=nohmat) to optionally disable
> > consideration of the HMAT and update efi_fake_mem= to behave like
> > memmap=nn!ss in terms of delimiting device boundaries.
>
> So, am I correct in deducing that your primary motivation is testing
> without hardware/firmware support?

My primary motivation is making the dax_kmem facility useful to
shipping platforms that have performance differentiated memory, but
may not have EFI-defined soft-reservations / HMAT (or
non-EFI-ACPI-platform equivalent). I'm anticipating HMAT enabled
platforms where the platform firmware policy for what is
soft-reserved, or not, is not the policy the system owner would pick.
I'd also highlight Joao's work [1] (see the TODO section) as an
indication of the demand for custom carving memory resources and
applying the device-dax memory management interface.

> This looks like a bit of a hack to
> me, and I think maybe it would be better to just emulate the HMAT using
> qemu.  I don't have a strong objection, though.

Yeah, qemu emulation does not help when you, the system owner, have a
different use case than what the bare-metal platform-firmware
envisioned for "specific-purpose memory".

[1]: https://lore.kernel.org/lkml/20200110190313.17144-1-joao.m.martins@oracle.com/
