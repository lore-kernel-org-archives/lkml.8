Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD8FC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6EA205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j/7A9n9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732735AbgCPVqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 17:46:54 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38010 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732652AbgCPVqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 17:46:54 -0400
Received: by mail-oi1-f195.google.com with SMTP id k21so19550480oij.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 14:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8CmJdYSWZIQfBnyBWznqXYCsdYq1set93wjMdh18cA4=;
        b=j/7A9n9udAPuW0A7tdnVweJRoLL6C1o7VCxHekl+tc/1HgnFl56F8oh9VduUj/blwA
         OVElcmFAxrzvggJbLldz62aywA/xO7e9YeZqg+BIqo40zw+9VjVlNmmpH1j3rp79a26H
         6OiyHpP8fRXx+/51nbdVqZjQ+K0gK0Fru5hmb/r31i2VbJtRz1VfHXxm0ZcXBdTLRjLm
         caGeK9eyeNN3MDVo0Esj93LGqyHlHpHKkM3IQyXFCz/Z0tGDb9HDSp41Do2vDyZmVbLK
         3GLCp/R/BMQmPuPa8kS0fQKg1in9K6D68xtP0DOSDgQBcOaZwPjqnt192GSRccK0AVlx
         PFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8CmJdYSWZIQfBnyBWznqXYCsdYq1set93wjMdh18cA4=;
        b=Y0hnIGZ01Ja3z+XxUT3jxkMHNjmYSiHQBJPL+uLsBIE1OR4VU5dPkpGfUIc5sfdjJG
         1nE6KOqRCWoQi3yTJnFquN37lP2GZxQZ36LVged2cC7jybrGAfFEyFoKUMtcDGoRU261
         P+u4L/BghouWduxid6QeVSfvXKfmef9UxBU9Bq73Rcua3nCx9TmBU1yBKDnL82ttp9NK
         G0PvWhCoKP4R+pvaQoPFJlSsv24KpaFb9xQGJijQOwoBDcCFaW4GsbG9qNvxvHSdmQY3
         r+RdZmwWOaMfd4i1k44Zn3SqLshCwX7aF9aQgdwWX+mPBvv6hGChfoQkq3TzrY4w5LPJ
         Dkgw==
X-Gm-Message-State: ANhLgQ1c6V3XwWojbUoFGdiEQqJZtfN+SgdtwvgNAEbYV3Qg4EKf66/L
        tCqb1RLO8KtQ/V6fNrztkQjV5FG/yN7nIRP7DGR1CQ==
X-Google-Smtp-Source: ADFU+vvKEObI4d1IMgr7TgcMawiSGpw42oxTKWzBTdtRajAINP1KYreKYwIl2bzMVs8QJn5PvCWGWWqbC/WDdlX9Mkc=
X-Received: by 2002:aca:100c:: with SMTP id 12mr1188687oiq.22.1584395213181;
 Mon, 16 Mar 2020 14:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <1584340511-9870-1-git-send-email-yangpc@wangsu.com> <1584340511-9870-5-git-send-email-yangpc@wangsu.com>
In-Reply-To: <1584340511-9870-5-git-send-email-yangpc@wangsu.com>
From:   Neal Cardwell <ncardwell@google.com>
Date:   Mon, 16 Mar 2020 17:46:35 -0400
Message-ID: <CADVnQym78VNfiOHHoZK88dBqG=hJijr4041VCqRFqZAef-7PRQ@mail.gmail.com>
Subject: Re: [PATCH RESEND net-next v2 4/5] tcp: fix stretch ACK bugs in Veno
To:     Pengcheng Yang <yangpc@wangsu.com>
Cc:     Eric Dumazet <edumazet@google.com>,
        David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 2:36 AM Pengcheng Yang <yangpc@wangsu.com> wrote:
>
> Change Veno to properly handle stretch ACKs in additive
> increase mode by passing in the count of ACKed packets
> to tcp_cong_avoid_ai().
>
> Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
> ---
>  net/ipv4/tcp_veno.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Acked-by: Neal Cardwell <ncardwell@google.com>

thanks,
neal
