Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C593C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 05:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35EB7207FF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 05:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sslab.ics.keio.ac.jp header.i=@sslab.ics.keio.ac.jp header.b="fHqdymfb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgDJFVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 01:21:39 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36207 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgDJFVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 01:21:39 -0400
Received: by mail-wm1-f67.google.com with SMTP id a201so1186817wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 22:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sslab.ics.keio.ac.jp; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k9bnCNibGTTNZ8RfqJKKqIRm03Js0FIJzOCaGoNQsuc=;
        b=fHqdymfbkjjLYvSs+zmDnvKHLnbVPWjV8BrXSrAyodywDHjTW3EWchSZZUi7fvMS4k
         YrhSlnC09aPDPKVbTxgSyUrAXMJBZbbpIYJYbTA3waCo2MH4Y+9C2mow1qkuESFEdug8
         5ITcoGDMvO6R5XpSNA1pmXivaUIXUEQF4Tlpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k9bnCNibGTTNZ8RfqJKKqIRm03Js0FIJzOCaGoNQsuc=;
        b=T+KtuYA9mXE/fhSsw/8Kd9Ag9ZHgsit2+xqzcfscNAx3UEyZ+fm5RA+i0cKI4SNVEl
         cj72cddPr7N2E0uNKEp39ZuNqsKlAOWWCBvWiDXxzh78JnC2tyckB3+nELWqyoi9rt1C
         V4LtD0nOKLXm735fwplg426hS+c1qF8NN/I7Yo2rV6CQXIp4eFcErkNIpdNMVtNTTIIT
         6UHyYEZdzXRiwAzvgcZ3g548Wf7BxEKH2bZjQHkM/BP0iRUkYcd8h1ZMauJpTAq/rieU
         B3rm2Xt5/+Ff6vWwkVn51Cvg3TZYsgrYPj+eqcLhBD278Pw1bQjjY7ksSNkGK1vT1e1D
         kkAg==
X-Gm-Message-State: AGi0Pub96nNrAxJVCWkzM5XFhnm2vMmoxRGmger02ffhZgPgthUeo3za
        4oC9Wf/GqXlNXKfxu2l9g406mI9ouaKf8qawfUfLcg==
X-Google-Smtp-Source: APiQypI1GNpcvuB391atB3Y+MsS7V92B8mhbmt+Th68wpnYqHV5ThzvOTFL1P1/F60xBajq5y7FUWUz7uEriVPLW89U=
X-Received: by 2002:a1c:2705:: with SMTP id n5mr3217827wmn.94.1586496097819;
 Thu, 09 Apr 2020 22:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200409150210.15488-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
 <20200409174113.28635-1-keitasuzuki.park@sslab.ics.keio.ac.jp> <20200409123203.1b5f6534@kicinski-fedora-PC1C0HJN>
In-Reply-To: <20200409123203.1b5f6534@kicinski-fedora-PC1C0HJN>
From:   Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Date:   Fri, 10 Apr 2020 14:21:26 +0900
Message-ID: <CAEYrHjmy=R0x+zAcANDcTqx2qOhoUjy0Z2okxkjX1JHC3CgZ_A@mail.gmail.com>
Subject: Re: [PATCH] nfp: Fix memory leak in nfp_resource_acquire()
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Kubota Takafumi <takafumi.kubota1012@sslab.ics.keio.ac.jp>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for reviewing.

I'll check back the runtime log and see what I can do.
Thanks.


2020=E5=B9=B44=E6=9C=8810=E6=97=A5(=E9=87=91) 4:32 Jakub Kicinski <kuba@ker=
nel.org>:
>
> On Thu,  9 Apr 2020 17:41:11 +0000 Keita Suzuki wrote:
> > This patch fixes a memory leak in nfp_resource_acquire(). res->mutex is
> > alllocated in nfp_resource_try_acquire(). However, when
> > msleep_interruptible() or time_is_before_eq_jiffies() fails, it falls
> > into err_fails path where res is freed, but res->mutex is not.
> >
> > Fix this by changing call to free to nfp_resource_release().
>
> I don't see a leak here. Maybe you could rephrase the description to
> make things clearer?
>
> AFAICS nfp_resource_try_acquire() calls nfp_cpp_mutex_free(res->mutex)
> if it's about to return an error. We can only hit msleep or time check
> if it returned an error.
