Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8C5C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2061207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iXwkuipp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgGJS53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 14:57:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46592 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726872AbgGJS52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 14:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594407447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g3vr4p3HOtOZH3FqPih/GiIpdmOKnnPMCPNV6jgpCAc=;
        b=iXwkuippkShqaB3qGR83m1zOiJGwrUNv8E3/VrrioEGK7B/WXw3U5GPLc7fiE89WLcSNZ2
        Q1RfzBSt61Afs+jc3vbhyAB/rDR6LGnY4GFAsqmqVQKZV3bv6Emk1Kf9zFtoosz0HCKrMC
        +YcvqpoqPElQaQgDaAI8+F9ozCJJV88=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-I-m6CWLHNZKm9-SDKbQUPQ-1; Fri, 10 Jul 2020 14:57:25 -0400
X-MC-Unique: I-m6CWLHNZKm9-SDKbQUPQ-1
Received: by mail-pj1-f71.google.com with SMTP id bf1so4582210pjb.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 11:57:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=g3vr4p3HOtOZH3FqPih/GiIpdmOKnnPMCPNV6jgpCAc=;
        b=p1KlPi7QO6uX2zVAdomJzucWPqLMN30g9wbL5IQkv0Gzys1VBrT7niyP5aNbgln2Y8
         UXBZafLEWWnOLYXEkwE603mE/t++FQX5beUwr+li3XWAh93Da5nUX9UDVTolkBmTH7sk
         +LZdC3WWi94GQG5FHzUoDqw8WdUxO4IkbJCn6d+xGpfziGD0idZO5GAQegxs55qEyD0L
         o8XX1C7+634lj4+i7Ya/W/9x2rhV5Eu/zogEvdXrml7SEGgbBjA+/p+EypsEMcjSfO4S
         3CM4MCyTcmu8VAcbi4aXJ49NineIcQFuMMW8ZJwii/vAurmcqthA2GoecHGUjYfV3W4l
         9yOQ==
X-Gm-Message-State: AOAM532bBhbUeajB0z9rmLtee8zYjJ/h4LvgFPcugJK0VcDGM4Z2kKqd
        Z/xhcRudAZwAOGAJMFBxcWknMgkGQWKWsvvAQTj0PYFBZoSOOqafMwtwTGYD4svNyQpvYQqY1Dy
        3sGHrhG3n3sal5BfexUefX/rt
X-Received: by 2002:a17:902:9f96:: with SMTP id g22mr15845522plq.306.1594407444710;
        Fri, 10 Jul 2020 11:57:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/tVx6cQ9PiRSX4L09kZ6HuM+5mJq1HjYk1MsqxC65kL5z0rrT8cvGQ00NqVS3PFpZ66gdNg==
X-Received: by 2002:a17:902:9f96:: with SMTP id g22mr15845508plq.306.1594407444386;
        Fri, 10 Jul 2020 11:57:24 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id y7sm6084764pgk.93.2020.07.10.11.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 11:57:23 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BA49D1808CD; Fri, 10 Jul 2020 20:57:17 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Joe Perches <joe@perches.com>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Daniel Borkmann <daniel@iogearbox.net>, ast@kernel.org,
        davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
        john.fastabend@gmail.com, mchehab+huawei@kernel.org,
        robh@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: XDP: restrict N: and K:
In-Reply-To: <a91354960fc97437bd872fa22a2ce1c60bda3e25.camel@perches.com>
References: <20200709194257.26904-1-grandmaster@al2klimov.de> <d7689340-55fc-5f3f-60ee-b9c952839cab@iogearbox.net> <19a4a48b-3b83-47b9-ac48-e0a95a50fc5e@al2klimov.de> <7d4427cc-a57c-ca99-1119-1674d509ba9d@iogearbox.net> <a2f48c734bdc6b865a41ad684e921ac04b221821.camel@perches.com> <875zavjqnj.fsf@toke.dk> <458f6e74-b547-299a-4255-4c1e20cdba1b@al2klimov.de> <a91354960fc97437bd872fa22a2ce1c60bda3e25.camel@perches.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 10 Jul 2020 20:57:17 +0200
Message-ID: <87tuyfi4fm.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Perches <joe@perches.com> writes:

> On Fri, 2020-07-10 at 20:18 +0200, Alexander A. Klimov wrote:
>>=20
>> Am 10.07.20 um 18:12 schrieb Toke H=C3=B8iland-J=C3=B8rgensen:
>> > Joe Perches <joe@perches.com> writes:
>> >=20
>> > > On Fri, 2020-07-10 at 17:14 +0200, Daniel Borkmann wrote:
>> > > > On 7/10/20 8:17 AM, Alexander A. Klimov wrote:
>> > > > > Am 09.07.20 um 22:37 schrieb Daniel Borkmann:
>> > > > > > On 7/9/20 9:42 PM, Alexander A. Klimov wrote:
>> > > > > > > Rationale:
>> > > > > > > Documentation/arm/ixp4xx.rst contains "xdp" as part of "ixdp=
465"
>> > > > > > > which has nothing to do with XDP.
>> > > []
>> > > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
>> > > []
>> > > > > > > @@ -18708,8 +18708,8 @@ F:    include/trace/events/xdp.h
>> > > > > > >    F:    kernel/bpf/cpumap.c
>> > > > > > >    F:    kernel/bpf/devmap.c
>> > > > > > >    F:    net/core/xdp.c
>> > > > > > > -N:    xdp
>> > > > > > > -K:    xdp
>> > > > > > > +N:    (?:\b|_)xdp(?:\b|_)
>> > > > > > > +K:    (?:\b|_)xdp(?:\b|_)
>> > > > > >=20
>> > > > > > Please also include \W to generally match on non-alphanumeric =
char given you
>> > > > > > explicitly want to avoid [a-z0-9] around the term xdp.
>> > > > > Aren't \W, ^ and $ already covered by \b?
>> > > >=20
>> > > > Ah, true; it says '\b really means (?:(?<=3D\w)(?!\w)|(?<!\w)(?=3D=
\w))', so all good.
>> > > > In case this goes via net or net-next tree:
>> > >=20
>> > > This N: pattern does not match files like:
>> > >=20
>> > > 	samples/bpf/xdp1_kern.c
>> > >=20
>> > > and does match files like:
>> > >=20
>> > > 	drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
>> > >=20
>> > > Should it?
>> >=20
>> > I think the idea is that it should match both?
>> In *your* opinion: Which of these shall it (not) match?
>
> Dunno, but it doesn't match these files.
> The first 5 are good, the rest probably should.

Yup, I agree, all but the first 5 should be matched...

-Toke

> $ git ls-files | grep xdp | grep -v -P '(?:\b|_)xdp(?:\b|_)'
> Documentation/hwmon/xdpe12284.rst
> arch/arm/mach-ixp4xx/ixdp425-pci.c
> arch/arm/mach-ixp4xx/ixdp425-setup.c
> arch/arm/mach-ixp4xx/ixdpg425-pci.c
> drivers/hwmon/pmbus/xdpe12284.c
> samples/bpf/xdp1_kern.c
> samples/bpf/xdp1_user.c
> samples/bpf/xdp2_kern.c
> samples/bpf/xdp2skb_meta.sh
> samples/bpf/xdp2skb_meta_kern.c
> samples/bpf/xdpsock.h
> samples/bpf/xdpsock_kern.c
> samples/bpf/xdpsock_user.c
> tools/testing/selftests/bpf/progs/xdping_kern.c
> tools/testing/selftests/bpf/test_xdping.sh
> tools/testing/selftests/bpf/xdping.c
> tools/testing/selftests/bpf/xdping.h

