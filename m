Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5835FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F69F2065D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 20:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgGHUkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 16:40:16 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:49249 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGHUkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 16:40:16 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M2gt5-1ju50T3qcZ-004A83 for <linux-kernel@vger.kernel.org>; Wed, 08 Jul
 2020 22:40:15 +0200
Received: by mail-qt1-f181.google.com with SMTP id o38so35677203qtf.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 13:40:14 -0700 (PDT)
X-Gm-Message-State: AOAM5324GAEK2H2XCcZP1DPEmZD/gL/bRzJUDhoS6DB7JL9ftC8USyj3
        Ulj7a90X3SsnByClmaa/WoQOlLmJOnMYMoWIh6M=
X-Google-Smtp-Source: ABdhPJxVshF+U3r0gn5rmOST+fkT/QJKFu6gn6v4QeGU1ba/2/kikiYWoKzhATrXM/rm062mwwxkFjzR8eqJ/4aZ2s0=
X-Received: by 2002:ac8:4ccb:: with SMTP id l11mr60572390qtv.18.1594240813840;
 Wed, 08 Jul 2020 13:40:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200708122248.52771-1-cristian.marussi@arm.com> <20200708122248.52771-4-cristian.marussi@arm.com>
In-Reply-To: <20200708122248.52771-4-cristian.marussi@arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 8 Jul 2020 22:39:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0V7TpCV_VOhRAN7V1Bo2_3UXs6pcv-bVLOg1+x=H4buQ@mail.gmail.com>
Message-ID: <CAK8P3a0V7TpCV_VOhRAN7V1Bo2_3UXs6pcv-bVLOg1+x=H4buQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] firmware: arm_scmi: Remove fixed size typing from
 event reports
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:0MjAE0t/nh+RyghLxR/wjXHTqkQJSIGRcLNs9/H4bZI95qLvYd/
 hdWyisNxffDD+dkEvFFNZekRx4/lqY61C3BMfgJFYFBlcodPpckwriTSL7uYS/ZWta+vUGa
 C3D3n13MkjEAdtTVcKsUZ7aG7nwWt5ZkqPDTpJyCvyAzTtzC8KhFLQnB+PcTxOUr6HbmH4H
 IcQLUVbnihoZqj1ODQeUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/oZYBYYJcms=:HH6JwJOM2NXdGts46aohGQ
 48km0dpc1OtSPAJzhXnaWwdhTVc/0XwUCDMsOcs9AP+X2RU0zplz4q4QiKI8m6mNKFJ1sYTwS
 1CWjRVXUAzyDgkyc4LjooHQ74+ODJ7ak+Tsr1/QizlquyYRivnhZTn4GuGbTrQN2cs1dFcSuR
 Z4jcMI5FwCoD7eqk6rV86JPbfViI+1PKZnnICqXKLzojmBIy6BIl+yrY59P3pkhx865zuFRav
 wXjS2kVNwQfS7F0ulYgv2r1QG+zAsFdFAYurdKioXut2VJ9MpWN3Nv9TI6QoPZxMOqKE15Vk8
 bnxksMhG/Jci8dkQwpJxD79SD3F12BPOCmE6t4HDpaMLfOW/TO3VcvyqZTkuZ3l0pH2kdlpBA
 ntvPzh0ihjbPk/Mh/4+3T85/JRKc/7/qjC75vbdDcCYS/WFfLRboUohViXmcwqjSeQ3l2zDvt
 OgwFA9VqcU2P68QKQ+17BB35BsBepLVQc4H4MnukJITLlc6TvjG6IMeHNTWzND6g2sDXdv0bt
 lAhSlpp5hT8mfTkVh9Eea/WEDec8bZvl+Jkkt3uVyAxlK9fnXvVBjcIkeyweRF46Y0qvmxuX7
 olx92DBvs7aGOM3ZPqwPxpagFFB2TZAMrtGazvAl+u+mv6Bx8idEnEsRD9Tqk/kl+VjCVKct8
 U+INDmlEIyvBkKaP04wz+sZjN1wRWuRQSlD0aB6HUbvwmUM72iWdRV5DJAjovPD4qrFsPyP89
 TN3Jn+PJ+hp35BlQnhREUNDwDnPrxuYHtkPYdYmDnOMWvKaquFIV8Nikjn9P8aRGNDMFjTsUV
 Eq2xCkIn8uCrQnC1Q/5sxceklm/BOoS0lVsQJNpAjQ9clTQDePyDKuGWr7r6h1yLCyv+pqS
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 2:25 PM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> Event reports are used to convey information describing events to the
> registered user-callbacks: they are necessarily derived from the underlying
> raw SCMI events' messages but they are not meant to expose or directly
> mirror any of those messages data layout, which belong to the protocol
> layer.
>
> Using fixed size fields mirroring messages structure is at odd with this:
> get rid of them using more generic, equivalent, typing.
>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Ok, I was expecting you would go with fixed-size structures without
implied padding, but either way makes it more consistent, so this
version is good, too.

       Arnd
