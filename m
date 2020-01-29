Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00649C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0D920708
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="AB5tIAhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgA2JRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 04:17:35 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38395 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgA2JRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 04:17:33 -0500
Received: by mail-vs1-f68.google.com with SMTP id r18so9964951vso.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 01:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bNAC2+oIozcnNbPThp/wFML15nI58BBOU0+BFe2CZdw=;
        b=AB5tIAhPfSaTUA30b2rz5nRhgwFARjT/wGDh/jXm589vlqC83Oc2T6QUmOtSTs4C5U
         ii0gtU5y/tXxYG4+s59v464GcBzW2yVF52O6FaIHNmHPSfvGeolEnZh9s/1doMOx+4ZW
         JApBsw9NjruJop5KT1CwDLLMmh2eBLTMAr9L0IG74JFKCDAOy2tXQchChyx57VDDMZBp
         BCK5Ibw1MbOG2iMXVUyNWT43B9G8aEMkiu0TSmf6O0OpD2fT9ThSeXva5TZzS/5aZ3uM
         Ec6OkU8ADPyWrUvHheawMHJP+tlU84XeAMlDQLZfVQo5B8rtWkrCXiso33tdrfEfrms3
         9skQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bNAC2+oIozcnNbPThp/wFML15nI58BBOU0+BFe2CZdw=;
        b=PqGaS5DlMMO/h/OZH0/yCqnXpsBg88uKaonfgxU9tiAiBies0x5m/5W/M3fdcXP0IU
         FFzcs5VDCsYaM9XvGrssHY8rilmDO76hw013a/zrI3YZ02AXT+68s16SAAK8SHkWtx6r
         2YLCBft5jaBBswgYW0P1wP5wzeOgV7hMxIB1z9hsniMb4T/hq6bwheMyac+/R7HQgQ+3
         gQAB9PA7/C2PjXIwbolV7SwT0ToVIE9BX2yhtH2NjwwB9SJQKleMdxsTaS1PC6I3kT9r
         VN5X5RtenpripyW4zSMg8WuDCOn/dpEiWo4iM+sxQf56pmRI7Q8rvPWL+G5NqYYOfRZ8
         Sl2g==
X-Gm-Message-State: APjAAAVl+y8HkaQbfjcGmm1rgqsC3VJRXvgwrQ11bcUPsQrU+UsnWNTI
        rLaWzZz4Yjf6EVRA6lTFR1qok08qE47IhorKSrF4HQ==
X-Google-Smtp-Source: APXvYqyT9AjfuxiZkQLTBthqWh9Qhawn64PCRqSKs9oxee+UzBlV+bTnb4G3Vj19hooUj+iG1WxQj29hKiFWdU6MeZg=
X-Received: by 2002:a67:f683:: with SMTP id n3mr15974310vso.117.1580289452828;
 Wed, 29 Jan 2020 01:17:32 -0800 (PST)
MIME-Version: 1.0
References: <20200128190913.23086-1-geert+renesas@glider.be> <CAOtvUMfoND5iJi7p9YRb6C3To6FGTKGBSoD+cBhkHnLXSppKEw@mail.gmail.com>
In-Reply-To: <CAOtvUMfoND5iJi7p9YRb6C3To6FGTKGBSoD+cBhkHnLXSppKEw@mail.gmail.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Wed, 29 Jan 2020 11:17:22 +0200
Message-ID: <CAOtvUMdWHPsGMbwkOwoGzAkeD=Vko=gD=wCn02pfEM9pmNWsfw@mail.gmail.com>
Subject: Re: [PATCH] [RFC] crypto: ccree - fix retry handling in cc_send_sync_request()
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 11:11 AM Gilad Ben-Yossef <gilad@benyossef.com> wrote:
>
> On Tue, Jan 28, 2020 at 9:09 PM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> >
> > If cc_queues_status() indicates that the queue is full,
> > cc_send_sync_request() should loop and retry.
> >
> > However, cc_queues_status() returns either 0 (for success), or -ENOSPC
> > (for queue full), while cc_send_sync_request() checks for real errors by
> > comparing with -EAGAIN.  Hence -ENOSPC is always considered a real
> > error, and the code never retries the operation.
> >
> > Fix this by just removing the check, as cc_queues_status() never returns
> > any other error value than -ENOSPC.
>

OK, it took me a minute but I now see what you mean... your patch does
the right thing.

Acked-by: Gilad Ben-Yossef <gilad@benyossef.com>

Gilad
