Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE20C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730A4206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="BWwwyhWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbgDHV3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:29:21 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:38727 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729692AbgDHV3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 17:29:20 -0400
Received: by mail-qv1-f65.google.com with SMTP id p60so4492828qva.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 14:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SVDtsGi6neGFRwikvRHYLrFbo8bPwU6BhE0B4MocRjo=;
        b=BWwwyhWdP4bCAjyoQRTv8OV8mtlXVPHwPlIm8qddLZj7iC674KnBH0wZ5gmU6DqS70
         C1/zjPys7SA2QSBdBBh/Vp7z8tP4MoDCZ3J7yPaCEb3aWrDPLZrEzEc/s5uDb6B3B/Zz
         Q/D2iUPkb1UdcJAn2P997ms7im6hGVN1AKeVtc8UTksahOiOgwZP7W4x2aRAkYxmqdzU
         iRMjGNH23UhxVno00at7cV4XSlx7ataddhOqFfxmG3KosI9iQ69ciGaSMtVokdO2MFwz
         mouuM4fw0+U2UEJVYG186lPlYQdy+/QTmGdmwSkRbzlnh2r3DVGyLygwJLFIOmeGB5Hs
         PMWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SVDtsGi6neGFRwikvRHYLrFbo8bPwU6BhE0B4MocRjo=;
        b=DTQHALBGrSGDMShF6h9QCv63eSzfJVnAbXV8BZ/b4XDNZcsW/SQZkEDAMf1sZUWwv6
         bJRQjkLkQDUgstDZDAaLW5ab5elOntmaK6dtmswHUkFcnpctBncWqOb0vXJP033Mf/4s
         5IpqaGtDDikkJS1tuWniC0p82XeMfoFANnoLed7PircBTdNPlSr8Yq/EHilGqrId7cc5
         UqrwwJ0yVIOHRvZKqI+y2WNGh0elB+bKhdPX2zJxSPT/S6H4v21ET1hD+kSNXKuhM3gQ
         9KcZObHw+VIbmLy6pfbWHi98tF7INg9NpeGL8zVo7hGGxV8uvQ6zEuHQWLWgFhE3yIPd
         EdGw==
X-Gm-Message-State: AGi0PuaHBamJHXUNEluyYmDoOzd+uHIEtwoyov2+6IJ6jIQF/t79eGDk
        PwnNEbSRAYHxMo6HIcZGFXB++w==
X-Google-Smtp-Source: APiQypIAPF83IDbnxE4npOa8BA/v00NSOs87AvIVV9hoWH5sYbQDJUSaLOrsAy9lYhzUtsirbdBiqw==
X-Received: by 2002:a05:6214:b21:: with SMTP id w1mr9649854qvj.69.1586381359791;
        Wed, 08 Apr 2020 14:29:19 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id i13sm12975162qtj.37.2020.04.08.14.29.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Apr 2020 14:29:18 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: KCSAN + KVM = host reset
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <fb39d3d2-063e-b828-af1c-01f91d9be31c@redhat.com>
Date:   Wed, 8 Apr 2020 17:29:18 -0400
Cc:     Elver Marco <elver@google.com>,
        "paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <017E692B-4791-46AD-B9ED-25B887ECB56B@lca.pw>
References: <E180B225-BF1E-4153-B399-1DBF8C577A82@lca.pw>
 <fb39d3d2-063e-b828-af1c-01f91d9be31c@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 8, 2020, at 5:25 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
> On 08/04/20 22:59, Qian Cai wrote:
>> Running a simple thing on this AMD host would trigger a reset right =
away.
>> Unselect KCSAN kconfig makes everything work fine (the host would =
also
>> reset If only "echo off > /sys/kernel/debug/kcsan=E2=80=9D before =
running qemu-kvm).
>=20
> Is this a regression or something you've just started to play with?  =
(If
> anything, the assembly language conversion of the AMD world switch =
that
> is in linux-next could have reduced the likelihood of such a failure,
> not increased it).

I don=E2=80=99t remember I had tried this combination before, so don=E2=80=
=99t know if it is a
regression or not.=
