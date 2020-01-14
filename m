Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400BEC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 130DA24673
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 21:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="S0tONOx/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgANVkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:40:53 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:43066 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbgANVkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 16:40:52 -0500
Received: by mail-qv1-f67.google.com with SMTP id p2so6415311qvo.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 13:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=NMsxULS8JIYUQ4GpBoOy1UacwKzyAvhrhWEl22Ed1qk=;
        b=S0tONOx/3050MVDYc5FincULF6fDMlK7tHM94OpIxWu0s9AIw9lo8j/YtyVPgCORJb
         nhOLYg9mTx9Ze2Z+GMhLKneglELmrF4CihqpPADmyaRuQT6yaFxIO/cM+uyL4sWdiFD/
         R+l8MN/jjahzpcoLsVaP552uanr22llVy6X5xTvHa2+0QWbhNNXUBFTlaHrko38NrehG
         UYz9s7759/IipXVwKpLDre7Y0hhOjUP4IAFGjVlNTLEM6I7jr4VzE+APWyE5s/YZRHRV
         QBjXpKXoG3/icklK4J7qvbbfL7Kc1NhWzzCUm/YkDUmHfj5kOlyuMKDZqpQU5MzV7kzs
         ov3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=NMsxULS8JIYUQ4GpBoOy1UacwKzyAvhrhWEl22Ed1qk=;
        b=httHAgcBAkgZr1Cg3M7tmNaSYXuUFcOcH2NqaZ2fxGAGbErJACmfVq6P0GAVZTZ7Iz
         g+U9e1Yrx9hqKoLSImjWr4FXk/vgN9Trtu8YKNzA4YeAoVSe9kRZaJbZD7srhmkzPmwp
         5kPzUWzuvWiMM1O43E7dZddK68zzeXESBu287Aa5wLbipnVGxtqRcS2ef6s7Y9SnNeT0
         x77v+Lko3bFe7v7KFL6aoTAkHrIFu5/mFeaGryu5Jqaso75Fp3UcFGVyejBBSQDJPgWC
         yhgC2itwT4ATlMu0KU7WH9yc4k+l+SVyUjkl2weP//ridJ2zg850Mg72flExxthd/0ep
         0J8Q==
X-Gm-Message-State: APjAAAWVfQ+FHnd4+Sg/WRyqyK9GzI7u6UHs5yptPZc/6rwJzQj+qMtZ
        o2q3CRShsBydvcJBIuI2twOnBJTUc+KXAA==
X-Google-Smtp-Source: APXvYqzw+CGWM405M2fdbsikthFCM4NDJ0cRrCpbEhrfFGbAecsyp5jSpDNfOsmWTEB6kSvsHsxO3Q==
X-Received: by 2002:a0c:d60e:: with SMTP id c14mr18693105qvj.76.1579038051186;
        Tue, 14 Jan 2020 13:40:51 -0800 (PST)
Received: from ?IPv6:2600:1000:b029:6649:f4b1:4b94:dfb9:77cf? ([2600:1000:b029:6649:f4b1:4b94:dfb9:77cf])
        by smtp.gmail.com with ESMTPSA id a14sm91508qta.97.2020.01.14.13.40.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2020 13:40:50 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH -next] mm/hotplug: silence a lockdep splat with printk()
Date:   Tue, 14 Jan 2020 16:40:49 -0500
Message-Id: <D5CC7C52-1F08-401E-BDCA-DF617909BB9D@lca.pw>
References: <20200114210215.GQ19428@dhcp22.suse.cz>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, pmladek@suse.com,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200114210215.GQ19428@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 14, 2020, at 4:02 PM, Michal Hocko <mhocko@kernel.org> wrote:
>=20
> Yeah, that was a long discussion with a lot of lockdep false positives.
> I believe I have made it clear that the console code shouldn't depend on
> memory allocation because that is just too fragile. If that is not
> possible for some reason then it has to be mentioned in the changelog.
> I really do not want us to add kludges to the MM code just because of
> printk deficiencies unless that is absolutely inevitable.

I don=E2=80=99t know how to convince you, but both random number generator a=
nd printk() maintainers agreed to get ride of printk() with zone->lock held a=
s you can see in the approved commit mentioned in this patch description bec=
ause it is a whac-a-mole to fix other places. In other word, the patch alone=
 fixes quite a few false positives and potential real deadlocks. Maybe Andre=
w please has a look at this directly?=
