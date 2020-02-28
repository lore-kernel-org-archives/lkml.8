Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F119C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DD6246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="UwLKK6xz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgB1Laa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:30:30 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41702 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgB1Laa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:30:30 -0500
Received: by mail-qt1-f194.google.com with SMTP id l21so1718409qtr.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 03:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :cc:to;
        bh=TyGvF4gDQhRWGSQu6uFitGsvvO6sV6I67VJLT7zuiLc=;
        b=UwLKK6xzIQfHkJ5u+SoYL3T1cU+Axozkd75UgiioAa1uAyWTULsnVt4eoa1/bqHrN3
         bq3HPwd4rKijx3Pt2Jtx08kyTrAJtJWp5pALmdV2/wtCVWIy3nR6MLPWgHqDlxbNlqZa
         L7iq3V8ur2vI8JWArFuO5eD5zqSenHPRtdkHOZEoH4rU4po2jUtMBFJqtkhHTHC1H3DR
         MlPYHOeKKdx6W7yBEN9ivOwFNZTZhU4WUjsXU/ZWy5tO84ca/vH/s7J5ooA5OBHCac+Z
         9Z+t/IthYEfFA3BPLAFFFIP58WltJ2fEHPdacpQpXXxgsezTjO327DX1TfOBPQN7xEcM
         FQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:cc:to;
        bh=TyGvF4gDQhRWGSQu6uFitGsvvO6sV6I67VJLT7zuiLc=;
        b=nRiWhSSPsNs/su6Lvh5oCY1fTrVbu9x/mO/AYEblP9WhNgicYZ5nHueKysOyJCRWxQ
         v2x3FUQznPNJ7aLOZN0yJjA5TxPwxU8qZ0Q7qNqBQmPQ0NQoV7zraL3L8gyGp2EgqsY9
         c7Gr4bVlXKmWWM1NGejMB0YgLL3bA2tTBxvt4wZEjIg+6XJh1YXYO8I6vU6MVH0czeJU
         Ah/fINiR44hQPImr1+YR1FLhpKeuLXBTbzwekosIyRjNfm305xqcW6meyBzP5yt3ncTy
         Ev2c3GW4NC6tbW1g9Dg9WdIa8GaIBDdUU5+ohXbQWhE/t7WFfNjKkvlkTx90hi2/mDPF
         KW9A==
X-Gm-Message-State: APjAAAVeP9b0IBxpSC5NQIuYcrYH04GCE+1yw55GJDdDquOvf6L2UHaJ
        vXyCnQ1V6BJ6ToS8ZAHn6e6MqQ==
X-Google-Smtp-Source: APXvYqwJcrooKjN0GU6+b+NXsZ6xnHvQo/OCzxdp13t+dJETeObi56ivSf5q5BJftKIGvimMix1W6w==
X-Received: by 2002:ac8:9e:: with SMTP id c30mr3800792qtg.359.1582889428464;
        Fri, 28 Feb 2020 03:30:28 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a6sm3438231qkn.104.2020.02.28.03.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 03:30:27 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Date:   Fri, 28 Feb 2020 06:30:26 -0500
Subject: Re: [PATCH] mm/swap: annotate data races for lru_rotate_pvecs
Message-Id: <463BBB2A-8F9A-4CF1-80AE-677ACD21A3C6@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
To:     Marco Elver <elver@google.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 28, 2020, at 5:49 AM, Marco Elver <elver@google.com> wrote:
>=20
> Note that, the fact that the writer has local interrupts disabled for
> the write is irrelevant because it's the interrupt that triggered
> while the read was happening that led to the concurrent write.

I was just to explain that concurrent writers are rather unlikely as people m=
ay ask.

>=20
> I assume you ran this with CONFIG_KCSAN_INTERRUPT_WATCHER=3Dy?  The
> option is disabled by default (see its help-text). I don't know if we
> want to deal with data races due to interrupts right now, especially
> those that just result in 'data_race' annotations. Thoughts?

Yes, I somehow got quite a bit clean runs lately thanks to the fix/annotatio=
ns efforts for the last a few weeks (still struggling with the flags things a=
 bit), so I am naturally expanding the testing coverage here.

Right now the bottleneck is rather some subsystem maintainers are not so kee=
n to deal with data races (looking forward to seeing more education opportun=
ities for all), but the MM subsystem is not one of them.=
