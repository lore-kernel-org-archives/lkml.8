Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C95C7619D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 02:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EAB024671
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 02:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="e4HgxWvA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgBTCMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 21:12:08 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:33816 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbgBTCMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 21:12:07 -0500
Received: by mail-pj1-f66.google.com with SMTP id f2so663660pjq.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 18:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=/PyhTPE+SMtKRGsl6LrCxDmoHl2YSZO2+SaEd8HrIv4=;
        b=e4HgxWvAAKTZfqmi2dFsM25tOoghnH6cDy1wv48pQhuUFIk0Eza/hQDzDRdE6/BTqh
         A+IKbTYx6KftxzDHz9ivkyy7PgOs2T+lD8oiJZoYqGjT0KloGzSugiq5CnyRBnxUFkl/
         njV8YBupqhr0JzV5wJjWCRftq3eHgQHuNmM8AmRK8w06Us5GA8cPZs1gPdY1owpMEHmm
         TH/GiM/6ZJzYR69bIE05L+YpP2FAF0Z+UWc9xShFTm9772hsZdCjczGXPlYREpjawjuv
         +TkSV5/I5QkORv5ysT+gRVyt5D8nSNJ2BAUWSyy+h/i5lr92J5mampTdgSxhdXQ18PiO
         6Xcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=/PyhTPE+SMtKRGsl6LrCxDmoHl2YSZO2+SaEd8HrIv4=;
        b=UzUF4hSEZN6Sak/9Cpr37JXz+eRQJIFyVxxViKsPlL/z1zxVcLVgzxdeejhwhmQ0zJ
         TmQ+tdkJPUH0tgmfh75SOVWr+DxCs0QQM3iAN398S6OF3LBrOijgNGhHNroiTmKlu5z2
         3thHhx/5T5/+E/5F5+l5mDKnYlrtbrsXfnFEw77pKnHjplIhAk5piEH+QgiViOAddeF5
         71xyrS0zioyANL0Uj56ATSpxaWAbdDvgG7zjWH4rQb/ygSMG3miv2xXNNPctgadHjm1r
         TC2EM+HvQEYKy9F7jYm+OdcHuvDNdxWf6fFgMJvg7BIyOZw5OZgfdwEM7+/RVG6YYs9I
         JJxQ==
X-Gm-Message-State: APjAAAX94Ij9+OOQauKBL6sOMSEUPPxJz1TgZm3G4Ih1HyXh0NXNI4sZ
        MVdBx0UiTeJrABWhEvudnJA/hg==
X-Google-Smtp-Source: APXvYqx02bRQ6as41z/V+mjjmdvX7gl62uel4jF2hGW13K+OarkkoUBpuclCenlyD4ppv9we6GvxUA==
X-Received: by 2002:a17:902:bb93:: with SMTP id m19mr29632830pls.310.1582164726826;
        Wed, 19 Feb 2020 18:12:06 -0800 (PST)
Received: from [172.31.41.154] ([144.178.0.60])
        by smtp.gmail.com with ESMTPSA id o19sm948098pjr.2.2020.02.19.18.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 18:12:06 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 10/12] mm: x86: Invoke hypercall when page encryption status is changed
Date:   Wed, 19 Feb 2020 18:12:00 -0800
Message-Id: <52450536-AF7B-4206-8F05-CF387A216031@amacapital.net>
References: <CABayD+ch3XBvJgJc+uoF6JSP0qZGq2zKHN-hTc0Vode-pi80KA@mail.gmail.com>
Cc:     Ashish Kalra <ashish.kalra@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?utf-8?Q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        David Rientjes <rientjes@google.com>, x86@kernel.org,
        KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <CABayD+ch3XBvJgJc+uoF6JSP0qZGq2zKHN-hTc0Vode-pi80KA@mail.gmail.com>
To:     Steve Rutherford <srutherford@google.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 19, 2020, at 5:58 PM, Steve Rutherford <srutherford@google.com> wro=
te:
>=20
> =EF=BB=BFOn Wed, Feb 12, 2020 at 5:18 PM Ashish Kalra <Ashish.Kalra@amd.co=
m> wrote:
>>=20
>> From: Brijesh Singh <brijesh.singh@amd.com>
>>=20
>> Invoke a hypercall when a memory region is changed from encrypted ->
>> decrypted and vice versa. Hypervisor need to know the page encryption
>> status during the guest migration.
>=20
> One messy aspect, which I think is fine in practice, is that this
> presumes that pages are either treated as encrypted or decrypted. If
> also done on SEV, the in-place re-encryption supported by SME would
> break SEV migration. Linux doesn't do this now on SEV, and I don't
> have an intuition for why Linux might want this, but we will need to
> ensure it is never done in order to ensure that migration works down
> the line. I don't believe the AMD manual promises this will work
> anyway.
>=20
> Something feels a bit wasteful about having all future kernels
> universally announce c-bit status when SEV is enabled, even if KVM
> isn't listening, since it may be too old (or just not want to know).
> Might be worth eliding the hypercalls if you get ENOSYS back? There
> might be a better way of passing paravirt config metadata across than
> just trying and seeing if the hypercall succeeds, but I'm not super
> familiar with it.

I actually think this should be a hard requirement to merge this. The host n=
eeds to tell the guest that it supports this particular migration strategy a=
nd the guest needs to tell the host that it is using it.  And the guest need=
s a way to tell the host that it=E2=80=99s *not* using it right now due to k=
exec, for example.

I=E2=80=99m still uneasy about a guest being migrated in the window where th=
e hypercall tracking and the page encryption bit don=E2=80=99t match.  I gue=
ss maybe corruption in this window doesn=E2=80=99t matter?=
