Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3237AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1282521532
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="zHgEAmDl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393585AbgFSPtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403965AbgFSPsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:48:55 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4CCC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 08:48:55 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u128so4638022pgu.13
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 08:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=eBb01/oa00VG0erYeXmliEIHJeFuIvvncAOcSZC6NxQ=;
        b=zHgEAmDlEjP1n/9MOShLFNzFY6jEjXCJiiFIuiWGH2jn4+2ViFpkI1O2upKYtOZwKT
         GwMu+QmD0MjUefE7OPwQV1b6Ws2DfgcL7OEXNd48zPs/VidjZMEJ9+M5CkfdS7q5JrR2
         ShyOAuPmkmhnJE7+stDV9l42QgBk8bn+HXUfYHGDblpYk30bN4GvWo1U0OJaBs0vSjaV
         fBIbfzmKF5MZl+zQkpqdIHTl2ggTCO2H47eK+wlrTrQBRBjxGoesJEqa5/0tndR52UIY
         8TMNdMHDtuwwRCtvkg4d5YyrvGSOhH0yy+obwcMvD8blCCoVaGi78XpKHlHKdnrM7XzG
         L0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=eBb01/oa00VG0erYeXmliEIHJeFuIvvncAOcSZC6NxQ=;
        b=a7FYRdwqkY08ZPSRFIdhZXi3GQCs1Jsi4s/dXaj/J+N+8FessTxqajOAIDpsXxn6kD
         yr78bHl8MzP2lNYQerNy0ZQCkziqG2AqbiG++pnOUM0hQL/uzYJQSF7GUsneIfzMDvaP
         QjwMXY65SAOcAlTm+WLde4bu6Hxo/C7UYcRSoGmvOKVZzkMJNOicp5ajEIjGfVqMDhBm
         Zao2Uhn+RQbvWQCUNwnTyoiNmhxKPy5qwDYtYA9yAMdoGQah5DZW2VhFQyXAvoSeLgHy
         4JCGCw23gGy/tL8+tbA0axxdRvv+O1tus8CX+53fR5tuGTAKfBnYkXyWy9LlYpAGBg4S
         tikg==
X-Gm-Message-State: AOAM531WAYYnm3FKFW5iyxWsDROarZjzPZzVugWACH6wgQBZptWEtI+y
        Ae6ULao9XaOYzv0uovwg/uiitw==
X-Google-Smtp-Source: ABdhPJwQ5xsKxVcbRCZcGn871eZd8n1wg3c6EV81saKWgLpKaFeve8n0hnn6P084hyKPwEAcNb3jXQ==
X-Received: by 2002:a63:931b:: with SMTP id b27mr3478183pge.135.1592581734094;
        Fri, 19 Jun 2020 08:48:54 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:ac67:5f51:c66e:4fa6? ([2601:646:c200:1ef2:ac67:5f51:c66e:4fa6])
        by smtp.gmail.com with ESMTPSA id t126sm6466988pfb.54.2020.06.19.08.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 08:48:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Ability to read the MKTME status from userspace
Date:   Fri, 19 Jun 2020 08:48:47 -0700
Message-Id: <0DD7FAE4-3976-4835-8090-80B84B737F3E@amacapital.net>
References: <CAD2FfiFRqwYGB50KK=aA0sU6uCALYneoyD=V4EfOsk-Ex=C+xg@mail.gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Daniel Gutson <daniel@eclypsium.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <CAD2FfiFRqwYGB50KK=aA0sU6uCALYneoyD=V4EfOsk-Ex=C+xg@mail.gmail.com>
To:     Richard Hughes <hughsient@gmail.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jun 19, 2020, at 6:50 AM, Richard Hughes <hughsient@gmail.com> wrote:
>=20
> =EF=BB=BFOn Fri, 19 Jun 2020 at 14:44, Borislav Petkov <bp@alien8.de> wrot=
e:
>> Yes, this is what I'm proposing with clearing the flag in /proc/cpuinfo.
>> The needed information is there:
>> 1. TME in CPUID
>> 2. TME *not* in /proc/cpuinfo
>=20
> No, it's not a boolean at all. If the platform disable is a BIOS
> configuration we don't know if TME isn't available because the CPU
> doesn't support it or because the firmware has disabled it. In the
> latter case, a firmware update or firmware configuration change might
> actually enable it. If the user installs a CPU with TME support and
> then we tell the user "your system doesn't support TME" then we're
> going to have some very confused users unless we can differentiate the
> two cases.
>=20
>> Along with proper ABI definition, design,
>> documentation and all that belongs to a proper interface with userspace.
>=20
> I don't think Daniels patch was a "final version" and I'm sure
> follow-ups can add this kind of thing. At the moment it's just people
> telling him "you don't need this" when as a potential consumer I'm
> saying we really do.

I think it=E2=80=99s reasonable for the kernel to ask why.

Is the idea that some GUI would show a big warning like =E2=80=9Cyour silly B=
IOS has TME disabled=E2=80=9D?

Boris, it wouldn=E2=80=99t be totally crazy for cpuinfo to learn to distingu=
ish between =E2=80=9Cyour platform has this feature but Linux isn=E2=80=99t u=
sing it=E2=80=9D and =E2=80=9Cyour platform doesn=E2=80=99t have this featur=
e in the first place=E2=80=9D. And I suppose there=E2=80=99s this extra sill=
y state =E2=80=9Cyour platform has this feature, but your firmware didn=E2=80=
=99t enable it=E2=80=9D.  This would be a big job.

Regardless, knowing what the actual point of this patch is would be nice.

>=20
> Richard.
