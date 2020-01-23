Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4541C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 17:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9960021734
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 17:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="hc21+PSt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgAWRSY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 12:18:24 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35948 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729188AbgAWRSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 12:18:24 -0500
Received: by mail-oi1-f196.google.com with SMTP id c16so3634365oic.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 09:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XnQrSbFLZoFzkSjXwKmxPlg8vAGR4Rz7FX09nL1MowQ=;
        b=hc21+PStvyHAkZivbzfWmA/5ihjJevnx3O/tdQzDwujLUH2jxifbQNtwgbRO76pWhB
         Il8sLvHmktBy4VkGrH/ej+5PuXOlCziFAsmd69uOrq3Byko2073ruAuvZCWqvGzTQMlI
         r4BULczhgrkpj2ln6AC+idZbtEaXPsqmIDleo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XnQrSbFLZoFzkSjXwKmxPlg8vAGR4Rz7FX09nL1MowQ=;
        b=MNkVvDFVqviBs+m2xAkFhkqrOKufr8uJkelVqM0RN7fm9933e8EZOFqocSvZpSFbyg
         lyPB07u69VIb+2asv2GDNOOrpQR46M5NVNpq6CBIbhlV1y4++UE4gJvjisQICViuXcu6
         1WkoFzS7eQkgA4g0jqLb02QJRdR2PvER32r+3dObMsUAFnP/n57iPftp4q/Q2oc6ht0U
         5SySpvaW4T48qyshUUB1JIrhJ/NMt6Ol6IYGo/184azmmB4SYP+5gluC4usFIDU1j0zR
         VCOxo1J4pZCYUO0yzgLK9UFT6cO6l3oZyjHInS9gis4yiaUw+RAJzX0WP9P/ahv6ZyJ2
         VZNA==
X-Gm-Message-State: APjAAAU/jpXs6uxsxYEouF6TtavIbp5ycgNa+HdpMKLao4kiqiSDxVYW
        /89ROdlpd55Iw6+Oh0TgYGV+E9SlMaOfgdVawew1iA==
X-Google-Smtp-Source: APXvYqzalvtZo7H5iCHOLugbV07Wh+3lDL0ZFS+9bcfQzmkeyCF3b8BK8no3VDOS4OA6O0SMek4Z40BUq4KlKxXKVtk=
X-Received: by 2002:aca:b60a:: with SMTP id g10mr10878162oif.102.1579799903847;
 Thu, 23 Jan 2020 09:18:23 -0800 (PST)
MIME-Version: 1.0
References: <20200123165934.9584-1-lmb@cloudflare.com> <20200123165934.9584-3-lmb@cloudflare.com>
 <20200123171612.stdwtlpqibkydz2s@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20200123171612.stdwtlpqibkydz2s@kafai-mbp.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 23 Jan 2020 17:18:12 +0000
Message-ID: <CACAyw999DErydNaDVgczYtqzSP09hnXtmwwJ0kocjisfRdVhxQ@mail.gmail.com>
Subject: Re: [PATCH bpf 2/4] selftests: bpf: ignore RST packets for reuseport tests
To:     Martin Lau <kafai@fb.com>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jan 2020 at 17:16, Martin Lau <kafai@fb.com> wrote:
>
> On Thu, Jan 23, 2020 at 04:59:31PM +0000, Lorenz Bauer wrote:
> > The reuseport tests currently suffer from a race condition: RST
> > packets count towards DROP_ERR_SKB_DATA, since they don't contain
> > a valid struct cmd. Tests will spuriously fail depending on whether
> > check_results is called before or after the RST is processed.
> >
> > Exit the BPF program early if FIN is set.
> Make sense.
> Is it a RST or FIN?  The earlier commit message said RST.

FIN, sorry. I'll update in a follow up.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
