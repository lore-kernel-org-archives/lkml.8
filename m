Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA39C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 22:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A7C20786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 22:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=vt-edu.20150623.gappssmtp.com header.i=@vt-edu.20150623.gappssmtp.com header.b="ycqfRuFq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgHRWvi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 18:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbgHRWvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 18:51:22 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E015C061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 15:51:21 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 62so19930363qkj.7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 15:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-id:content-transfer-encoding:date:message-id;
        bh=cCk2A10+8NwKiJYA8zzK211FT3IM4T7BdSrv9r1GyNw=;
        b=ycqfRuFqaWqYVHV9cOmFncmCOiYao4bWXC/Ppfx1WD9WsdimLs1UVWVD9XJQ7jRyDJ
         UJ7YtEs5CFLQ4s57CXfVpcTRQciEqTGf31twX1VuituPRJAvcPZkL0kdJsnedrZ6brbB
         C9SGUTx2vRNZiRcFjpj0c18A8YtpngzQNX+KPf9t66WPdS+JJPwuwRrqu4u6aDIYnuVX
         akrz6oaT1k8f2mwSxw/2qE0RAZiuCKJOGZuNEAzS7z2gZJuG8eQHK9Uv6YCvd0amTIeg
         FwBgw5E3dj6sGbOWJ4rGEKGYB6zwR3Q/FkR/1qtuFLKt25X65o+A+n43aBMTKVfPVfVq
         Exrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-id:content-transfer-encoding:date:message-id;
        bh=cCk2A10+8NwKiJYA8zzK211FT3IM4T7BdSrv9r1GyNw=;
        b=psIOxdCa9LHE6NuMaVaNS8b4O88EOj/bmy9qRHjlpDYF+pPS2Ugcbor5uIBAs0MXkU
         vcu3cS+hQvhW1sXHStZpF4LJTzjnv+5p9tujIGlPwCP6MLsPqeD7P4qYzEBNSiCeAwt4
         hiWaJM75OizaK79tbGEuqEYLZTJp3xWomOblu+TV+chPH6oXhg4+xZAvn0AwLMxOhV0j
         q9zv+6IIyxk3R1VKthxwYE0dDxv34kgo/P01eaVnlkkok/kBzbxUvMnjIChr9UtU29zU
         eh5V/L9BjPt8TL3tUD6mtXrp9vzpkVTfHuAb6gonfGMAnAjLj7nBdsracPi2tJRNcHGn
         FmAQ==
X-Gm-Message-State: AOAM532ZKWK0J4j3GzaqKvD+A10vDV1C2vpWVzucBL3NDQepiDYmAcmt
        Eyhr3AgIrGHAHPN6kk6SKNHbQw==
X-Google-Smtp-Source: ABdhPJyDhdi6OEFL5z++U2br/ZlgbM4jP2xMaxEwZEwI2UuX4UIdIsLOAozYV0CRwy9N5mM8xn84eg==
X-Received: by 2002:a05:620a:1429:: with SMTP id k9mr18852143qkj.273.1597791080791;
        Tue, 18 Aug 2020 15:51:20 -0700 (PDT)
Received: from turing-police ([2601:5c0:c000:a8c1::359])
        by smtp.gmail.com with ESMTPSA id 103sm24330752qta.31.2020.08.18.15.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 15:51:19 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
To:     Guenter Roeck <linux@roeck-us.net>,
        Mark Starovoytov <mstarovoitov@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        "David S. Miller" <davem@davemloft.net>
cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        mingo@redhat.com, paulmck@kernel.org, peterz@infradead.org,
        rostedt@goodmis.org, tglx@linutronix.de, will@kernel.org
Subject: Re: [PATCH] Revert "seqlock: lockdep assert non-preemptibility on seqcount_t write"
In-reply-to: <bcf94ea2-05e6-2212-f732-b9a79a142f7e@roeck-us.net>
References: <20200810085954.GA1591892@kroah.com> <20200810095428.2602276-1-a.darwish@linutronix.de> <20200810100502.GA2406768@kroah.com>
 <bcf94ea2-05e6-2212-f732-b9a79a142f7e@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <169453.1597791077.1@turing-police>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 18 Aug 2020 18:51:18 -0400
Message-ID: <169454.1597791078@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Aug 2020 07:10:32 -0700, Guenter Roeck said:
> > 	ERROR: modpost: "__bad_udelay" [drivers/net/ethernet/aquantia/atlanti=
c/atlantic.ko] undefined!
> > =

>
> I don't think that is new. If anything, it is surprising that builds don=
't fail more
> widely because of it. AFAICS it was introduced back in 2018 (a hot 50-ms=
 delay loop
> really isn't such a good idea).

Well...it wasn't broken in next-20200720.  A bit of poking with nm,
and building hw_atl/hw_atl_b0.s, it looks like the culprit is this commit:

commit 8dcf2ad39fdb2d183b7bd4307c837713e3150b9a
Author: Mark Starovoytov <mstarovoitov@marvell.com>
Date:   Mon Jul 20 21:32:44 2020 +0300

    net: atlantic: add hwmon getter for MAC temperature

specifically this chunk around line 1634 of hw_atl/hw_atl_b0.c:


+       err =3D readx_poll_timeout_atomic(hw_atl_b0_ts_ready_and_latch_hig=
h_get,
+                                       self, val, val =3D=3D 1, 10000U, 5=
00000U);

And doing a 'git revert' makes the build work....
