Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F300BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C69A620771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 09:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595324586;
	bh=Bcjce0RSi5cAzugVx+NeI/QfodEd9VLTjD9tWZICZgU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=r+g7EdcXwceHqGQaQ6D/7ronCfeV6fwMrZSoL2TjO8Iat2jic5rtOyEK1vbBpQNDa
	 FsQV4HpXt5ZSLy9Oqh9igqng6Bb39vRBSBwr/YbF6KyGkO+ztI6UlTMjwVt6bQDiMk
	 k1b9ddTwKaGiooimaMwx5yItD3WgDmkspFG413gA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGUJnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 05:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGUJnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 05:43:05 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A40FC061794;
        Tue, 21 Jul 2020 02:43:04 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id q4so23425067lji.2;
        Tue, 21 Jul 2020 02:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Bcjce0RSi5cAzugVx+NeI/QfodEd9VLTjD9tWZICZgU=;
        b=csQ2h+t9/4bNMtFl20Jjm8Zy8IkQ0DVCWJ9xhRepggj3XwNjA1zV2aAOux6iX9mjUs
         lddDYyEZeTuDmZaVz9tQVvAlrsDs5zIEqmM/F0RrgAmnNRjMb/4XaaiyShFmHm69WZTh
         MYqybCeZ+7KVBztFmMdFCOHupgLGiP5FFeyu+nPuteNgS9ISab+QtAAA/uuu6QTelLgW
         c2XGN5z/jYFwGVmKhiPAvAYFA37I9hxqO19+dlwS+362TRD1KV9ibQGzYHCc0v2GzCFq
         FHWiuhlrageaKZJSfgN8Zs/Sm/EVKUrJLv8kvutZC3XReTurmROsNzQRjmXAGzamDTBn
         DCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=Bcjce0RSi5cAzugVx+NeI/QfodEd9VLTjD9tWZICZgU=;
        b=Q0ENozNdyf7SInOLHN8NqQ8/9x09xo4jFdZSuxc1pvX6XznhiVio6tTE7hcFQnxFvD
         ly6OGfXA89MUCsczLFyK1xcJnW4PIxcGMtTGF0X0JMhO/65LXbikWIftdb3N5eTU4CxQ
         u+hNRLjhf49b4rl2MaJLUsvX1ti52A4xm3+IRdnLXgZp+qNg5Wgw7RehO8J9eZOeKz3S
         FHdv5PorXkGxcwb1TXhRlTQZJlqbf+oGVhy3V2vb7rAB4OtwwX7i0i3uE4AKSJ+zCvFI
         N3rlTdqY8HIgvpOl1VwJlLfIWNC/O/iSIdzu9MJxhHK5f1moHSmJa/UupT5qinpf2d4A
         JJLg==
X-Gm-Message-State: AOAM531I0pU+IZpDDZqVRVHu7D6n4oKxo1b0vmeXTRampLfskVj+Husi
        F88tUeyRU2nrREhYC/sNOaA=
X-Google-Smtp-Source: ABdhPJxMAgGCe0cQOZaYb/3wDk2OTcBA7dPCflgu/NLzSq165ySZN9nZtSsFvVkOnnyS4JAFyqhZ3A==
X-Received: by 2002:a2e:730c:: with SMTP id o12mr11930894ljc.165.1595324582604;
        Tue, 21 Jul 2020 02:43:02 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id b81sm2944612lfg.60.2020.07.21.02.43.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Jul 2020 02:43:01 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [v3 PATCH] usb: gadget: bdc: use readl_poll_timeout() to simplify code
In-Reply-To: <1594622881-6563-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1594622881-6563-1-git-send-email-chunfeng.yun@mediatek.com>
Date:   Tue, 21 Jul 2020 12:42:56 +0300
Message-ID: <87eep5p5jz.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Chunfeng Yun <chunfeng.yun@mediatek.com> writes:
> Use readl_poll_timeout() to poll register status
>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

I had a lot of trouble to apply this patch, could you avoid base64
encoding on the patch body next time?

Thanks

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl8WuKAACgkQzL64meEa
mQbgQw/8D5MApknAagQ1QHV5vnpIQ0lR2Lv6nf7GyipydG0ROriUsdYZx0WIXYp8
O2pMl9dzA5QI4MDMIwS8T8/iC7SZS30b9+5jNM3gIyIMgVirenhgMVHV6CJhbuMv
76KpmPx87FGVgpW42X9YXfuSUqBjK9DeXt9QzRDJj7rho0jh6OQpVzwoy1dI1Hcq
Qrdy96W+vG4XGfkdZRROLw9dkAzqLC2R7uhq2kWRKje4rYDKNV/bvj/MQ4K2fxu9
3YbPPp+CMvTTsLuqIEyGy3FkQrXDRHB1miM7Ii9yAbmGTeNDpdtXPFCZV3evfCBI
/xzTmUTcAkHlmlDP8O4/I2HsYsdqKbrBbbCYO1Sf8dKa5IeeXNc3dNGVtrKHlJgA
x2p3Iy/Bydhyh3eEYnM4EOCX92vhu3CTCq9zzXF20pGtzbzqrItZcCIQ5uAiv1W5
uEF/zyHg28QU6q1slo+nVWHwP+m4DDp6y3eFQfy5JejeJDUUUhMeFAqMTH9gSK3V
5R1DC0hx6p9oLAGiXTzXzLa781ynVfQ3/7z4hLXpez8zXK4Vu7duiV7KSOSMKcyb
Ai4gl+Iwloo0jkDk10vIZGMTvibbXeFkRxlZEV7OFGJn3I+SOEzQzKfiWKyhvBkA
2vuAB0ozj32RV0IN8Ogzrc6m1z+yh+B77DOt1Lpx4BTL/daY5Ks=
=4+GP
-----END PGP SIGNATURE-----
--=-=-=--
