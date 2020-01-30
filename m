Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38352C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F78206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="WabDaQ+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbgA3PSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:18:17 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42108 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbgA3PSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 10:18:16 -0500
Received: by mail-pl1-f195.google.com with SMTP id p9so1457704plk.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 07:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=NYvbh0EvDO+JJUvHI1Kw+aCj5n6f6RUisMfv+jrEqPU=;
        b=WabDaQ+i0RWv0Cv6UvHJUcz0N1WP3aMfcbUfawCRo720OvcWhiTwJ1iVBH8k5ZcLWG
         eSzvtnXN/BqZfpwZqxKXCFlDRK8BZLClNies16bvwsrJypJ5oNX1AIyBZJWzALHLeLfd
         6Sl8NYgZjlUBvSBzdjjXoFrCKqvByMgT+dhZGAfVEX8bSlZsFIiO5VxOmN7gFFRujZ/B
         3znM/7sck+3nTrm8vcuIQCeGZqnGRKfbkHajiQXkYquAMFLbdNvLsQqrF0/qGLV0WMQF
         CTdaAJXRegwy9gIPcl4BuI1W2PmEd5oTNb5Aqi4848b4H3S5lh8SuInCe1vJRd/x+tk7
         MxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=NYvbh0EvDO+JJUvHI1Kw+aCj5n6f6RUisMfv+jrEqPU=;
        b=BIfFLXLhy14vPSU6Z+bdevj9U2Chv0uvfm3ZGNzTTcqESPYUnnChAX8C451Wo0+33m
         F9tHBWsk5VUhqbZwz7/iynkt7N9LHbmNJmidpH66gicJbGXuA6yV5Yqq27LWytwwv9NK
         qDqtC3mUBTqOyp1lDINzRAhRjOPwU+jVTPJqlb0VJhZiVKcTcpFATXJYTvbExlRIdIPb
         6EcVC/pPihcOxozHKdsXVMSmQb8j8fYPJwX6Gi/gqesYndTXOnWVVCGLxNsPqrRLokHR
         WjqGv+a/I1L9PAX4z1tX4Fed+Jx0OJ1Ebeal1lUm443pkR9l56VjkrreaP/K9Eij99DQ
         zT4w==
X-Gm-Message-State: APjAAAXa4DbrUNRrN7qbTYNVPZMRz4VHyoC0GqN6aeB2VfcV2mULDGVB
        yp3ESMl9rwXYdPmnn3jinaYQug==
X-Google-Smtp-Source: APXvYqwM4KOS49ZarWpzY/mrMVV4MHQ6JjLFrmtp7HWEy4h2Xd9QI7sqRr5iXYHMNSL4zzjGZEtk0g==
X-Received: by 2002:a17:902:9a8c:: with SMTP id w12mr5176857plp.149.1580397496102;
        Thu, 30 Jan 2020 07:18:16 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:51ac:4d36:2f8d:8208? ([2601:646:c200:1ef2:51ac:4d36:2f8d:8208])
        by smtp.gmail.com with ESMTPSA id d22sm6733429pgg.52.2020.01.30.07.18.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 07:18:15 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/2] KVM: VMX: Extend VMX's #AC handding
Date:   Thu, 30 Jan 2020 07:18:14 -0800
Message-Id: <4A8E14B3-1914-4D0C-A43A-234717179408@amacapital.net>
References: <20200130121939.22383-3-xiaoyao.li@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20200130121939.22383-3-xiaoyao.li@intel.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 30, 2020, at 4:24 AM, Xiaoyao Li <xiaoyao.li@intel.com> wrote:
>=20
> =EF=BB=BFThere are two types of #AC can be generated in Intel CPUs:
> 1. legacy alignment check #AC;
> 2. split lock #AC;
>=20
> Legacy alignment check #AC can be injected to guest if guest has enabled
> alignemnet check.
>=20
> When host enables split lock detection, i.e., split_lock_detect!=3Doff,
> guest will receive an unexpected #AC when there is a split_lock happens in=

> guest since KVM doesn't virtualize this feature to guest.
>=20
> Since the old guests lack split_lock #AC handler and may have split lock
> buges. To make guest survive from split lock, applying the similar policy
> as host's split lock detect configuration:
> - host split lock detect is sld_warn:
>   warning the split lock happened in guest, and disabling split lock
>   detect around VM-enter;
> - host split lock detect is sld_fatal:
>   forwarding #AC to userspace. (Usually userspace dump the #AC
>   exception and kill the guest).

A correct userspace implementation should, with a modern guest kernel, forwa=
rd the exception. Otherwise you=E2=80=99re introducing a DoS into the guest i=
f the guest kernel is fine but guest userspace is buggy.

What=E2=80=99s the intended behavior here?=
