Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12496C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 19:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1231207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 19:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLhv31za"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbgEVTRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 15:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731000AbgEVTRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 15:17:44 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2381C061A0E;
        Fri, 22 May 2020 12:17:43 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id j145so10250182oib.5;
        Fri, 22 May 2020 12:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8FXe1gKRRAtqdzdgqSYRUue1n+MxbAKrARpETxEvke4=;
        b=hLhv31zaLwJbsDWkqcR+uUquyLZA4eqx4k2ILKPopdfqawOpaA4THoSNV7ClFXRkby
         M9kM65oBO5h2A4k7zNA4hxGHFOHHs4XR6N/+0mlMtCP4Ga+h8gUUUmrNCcREz7fhZ/aP
         bUMuUtnDUZbwC5HrGnN6DLUFbdbMhJVZiEVpJoHJe/VYxgo9BBv6jLFCQJRtO9lWoB81
         1oxMIII0r84TM5bZ857K8BXQf/YW7A7YrSL55Y4aiHZdbahjv684X4MctKJLdtjUkemg
         kCHfOy66xiM/+NyzOMybSNGz2TnAprh/nLZblqaOaFmREn46+Tux6uqyDHHvN8aiYtcO
         QgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8FXe1gKRRAtqdzdgqSYRUue1n+MxbAKrARpETxEvke4=;
        b=V4huV7Hew4Q7OKHRr9DgL+WMlQ9wuMbD0T/YWgVJa5IBe52Q+ZCn1sbTnmBOLZ3uxG
         xWYVencoMWiiP/F5sk9GekB9OkAxM5M+aifkHYpLtcpP+V2ke5WLF3s/vbGoFs70nJ5B
         0uNVnivNDV6Kc6Rbv1drA6I8wOYv8+ipH1Gst7npNoX+/CacN2rRR2javzNM8YcrduVL
         1VegsziGsrWs9ZOz77KYmKsuwqgEYNj8ySb8EzdRsZRswvIFwkz1ZwOgKdmZBFmbXPB5
         pJ+n1nYfuVZyNTT1Tsingvqiw74IJw+5VuKAjsc3EjmSoWV0n96gpsJedoYadlBZpz14
         3WHA==
X-Gm-Message-State: AOAM532H1L5+VWM9yDJwZ7LQoQJIW5hUHWVWzpW0x6/p1dbzgLMpJa46
        HiyRrvlerQUwauDZYiFNlqApHlle5Mma1pJb9e0=
X-Google-Smtp-Source: ABdhPJxLsbBs1BIQiwf3yrEMRyglXcvTSvInXbYBQaH8pUHTHImNSKUEoMYhqqR/qfnZBTqtJ8So7qCNEEfKFcshj68=
X-Received: by 2002:aca:d496:: with SMTP id l144mr3832091oig.72.1590175063323;
 Fri, 22 May 2020 12:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <3c51bea5-b7f5-f64d-eaf2-b4dcba82ce16@infradead.org>
In-Reply-To: <3c51bea5-b7f5-f64d-eaf2-b4dcba82ce16@infradead.org>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Fri, 22 May 2020 12:17:32 -0700
Message-ID: <CAM_iQpV62Vt2yXS9oYrkP-_e1wViYRQ05ASEu4hnB0BsLxEp4w@mail.gmail.com>
Subject: Re: [PATCH -net-next] net: psample: depends on INET
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Yotam Gigi <yotam.gi@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 12:03 PM Randy Dunlap <rdunlap@infradead.org> wrote=
:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix psample build error when CONFIG_INET is not set/enabled.
> PSAMPLE should depend on INET instead of NET since
> ip_tunnel_info_opts() is only present for CONFIG_INET.
>
> ../net/psample/psample.c: In function =E2=80=98__psample_ip_tun_to_nlattr=
=E2=80=99:
> ../net/psample/psample.c:216:25: error: implicit declaration of function =
=E2=80=98ip_tunnel_info_opts=E2=80=99; did you mean =E2=80=98ip_tunnel_info=
_opts_set=E2=80=99? [-Werror=3Dimplicit-function-declaration]

Or just make this tunnel support optional. psample does not
require it to function correctly.

Thanks.
