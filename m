Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCD6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95DFD217A0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="q6KwgYq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394922AbgFSQ2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394919AbgFSQ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 12:28:06 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD365C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:28:06 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id jz3so4273712pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 09:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=jpB5wP3PIwE7dFDxzA5CoClVFh2E2ceSqx2mQLiEpAM=;
        b=q6KwgYq2vJOzzV4VWWfYDK11E4HZJbayuZOECWOWVrLf2XcwA/z8IQbFCYxno5VfOK
         0l4z1k7x95m+biDZW25sxSwp7Mtv0jgFM0woNZ0PSlX1hE416H8DkB8v63U0DQhaguxN
         WrYgoKF9xIWJCSVoC9u4whW5+1fGB1OnaHYoHh0+PLKLTmMYlZCCMAKa0N7BGZ7ymNeB
         XYBbx5godAom4qRjt6gxwrvmOweFAW6zq1spjDhV046ar6wKQNrhWPhDkHoxVwabXRpW
         1aXFiofSt2N5/GnL9eNGFuMpGWIiEl2YRK1kUyz6O2scaIoKHZb5UcRv+grUUhFTQNdv
         cP6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=jpB5wP3PIwE7dFDxzA5CoClVFh2E2ceSqx2mQLiEpAM=;
        b=jbOUQ3JXay3dXgxAyKcZVFPpxHawjaCo6OWbkCOngjeWaGTS34lQ+u4K84nEJ21cic
         KZlOtg1X2lADBH6c3S8jxUm1ePw/yKXG3J9g2Lf2mPMre6J0AQXFiw1yBToz7VvZ0Txf
         hCSw709H7cdY54L4huwZ7yt4op7X6Qx+XRt44F044muBDqkn2FVM+aX2xSQEGNss3Y9c
         CsDYvmjrb1H2LCRVZ2skUPF/IZh5Td0mUY5MM+31KCpGeBEBHlfAxNGzsnDacQEds/OO
         GTpLbl7WCpgTJrvMa6CDjG4QlqeEBPjnXmfJDr8i+NOLkPhcG2oPThgzG8I4IPmkc4PO
         KSlQ==
X-Gm-Message-State: AOAM532jLg1HZC1Qw8GfLnn7dvYo2WuYRXhom43AwTUmewRTWBWmZeBH
        /ghuJTdQH8CVMuikt0ud6ZW4NA==
X-Google-Smtp-Source: ABdhPJwxb0GvnZCeBO+xcJmUodHQQzsR50V8+c3pEMTT9u4we77eeEOQI22XI+hn7cDSVdnszRPzPQ==
X-Received: by 2002:a17:90a:aa88:: with SMTP id l8mr4376953pjq.145.1592584086180;
        Fri, 19 Jun 2020 09:28:06 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:ac67:5f51:c66e:4fa6? ([2601:646:c200:1ef2:ac67:5f51:c66e:4fa6])
        by smtp.gmail.com with ESMTPSA id c1sm5982052pfo.197.2020.06.19.09.28.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2020 09:28:05 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] Ability to read the MKTME status from userspace
Date:   Fri, 19 Jun 2020 09:28:03 -0700
Message-Id: <7D245565-78D4-4587-AD5E-3D4E945D5A94@amacapital.net>
References: <20200619161752.GG32683@zn.tnic>
Cc:     Richard Hughes <hughsient@gmail.com>,
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
In-Reply-To: <20200619161752.GG32683@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jun 19, 2020, at 9:17 AM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> =EF=BB=BFOn Fri, Jun 19, 2020 at 08:48:47AM -0700, Andy Lutomirski wrote:
>> Boris, it wouldn=E2=80=99t be totally crazy for cpuinfo to learn to
>> distinguish between =E2=80=9Cyour platform has this feature but Linux
>> isn=E2=80=99t using it=E2=80=9D and =E2=80=9Cyour platform doesn=E2=80=99=
t have this feature
>> in the first place=E2=80=9D. And I suppose there=E2=80=99s this extra sil=
ly state
>> =E2=80=9Cyour platform has this feature, but your firmware didn=E2=80=99t=
 enable
>> it=E2=80=9D. This would be a big job.
>=20
> Well, I believe all the kernel can do is supply bits of information -
> just like MSRs - and depending on the settings of those bits, userspace
> can decide what the situation is. For example:
>=20
> bit 0 - CPUID support
> bit 1 - BIOS enabled
> bit 2 - quirk applied
> bit 3 - microcode fixes present
> ...
>=20
> and so on.
>=20

Indeed.

> It needs a proper definition though and userspace to say, yes, we want
> that and that is useful for us.

Maybe the right approach is to just keep this kind of use in mind for when w=
e inevitably redo cpu features when Intel ships their hybrid Atom/Core machi=
nes.

>=20
> Where it ends up is then beside the point - /proc/cpuinfo,
> /sys/devices/system/cpu, whatever...
>=20
> --=20
> Regards/Gruss,
>    Boris.
>=20
> https://people.kernel.org/tglx/notes-about-netiquette
