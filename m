Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C10AC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B7B82063A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580476870;
	bh=EVZ7gvWnAO8ObBd60YbtUt6FN90G7Un0YuJYzA17AjA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=hSrXdwJ2AplUFl+2oWloUshPT2e1SfKkNFAfJALZu8gtVef0fElgKt2nEJpyC441y
	 2yyzcWDHOD+e25s6uxrSdXx0cIaUCECRgf5iS0ljVTnn69HILeE89LvXSJRLrv+nKs
	 GycdByTQ028s0PBYt7WNqvi3vvCLx6OIL0/VySxM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgAaNVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:21:09 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38775 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728579AbgAaNVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:21:09 -0500
Received: by mail-lf1-f67.google.com with SMTP id r14so4862309lfm.5;
        Fri, 31 Jan 2020 05:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=EVZ7gvWnAO8ObBd60YbtUt6FN90G7Un0YuJYzA17AjA=;
        b=P7rEeoZ9bR6Z1oevGGptf7dLFbr/FFg+dClLOSl1ViCZNRXrMaNhrdwBBbKz6HMDxP
         KIX/oiLqGpQrUhq3nK2YqEcCTd3YJEoNBMZMlDJGsipMMq2R3ieY/Z4+fqElGYqda8+s
         NNkCS3SgoQORZLnbCUHrK5pXauBS0Ao6ejdKflLCR21JowFtjjc9XXNXjqmo7W9hF0CV
         uvFOjMyhHSQN+eR15+WzApJAj44aU5fX1jsEc4mdW35OwP2E7B5tGm5QNc3bolaUmlhq
         n3R7Mts4oztgX/p26Dg1Jw+GuMedWGL8FgrZTgAi8YX9sgkUwj6auKn4evPiGKQU7pWx
         S9Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=EVZ7gvWnAO8ObBd60YbtUt6FN90G7Un0YuJYzA17AjA=;
        b=aX4I8HJHV3VHNYL//I/lzM6ug6zOXVZHYGp4BLsGHrQR0BCoWi0+oVctsrVGC87htE
         /tF7boiIYxviVz9uX9O5fkpCRdR6MDxnAuzuEbQBqEO//l3pE7mVtPL1DDuuTvKfqkWF
         Y6E+t536orjX9/ChKshwV5c2Eo0MF9zVx7JbtX2rRaYNGeGWLfPwWdirqyyylQ5QENIK
         XV2Ft+SV4A6gjU1VU4a2R/BHpzsfwzQFfjqvrqjdtsu0dtY1if0tfyD9u5pRfPC+xGTl
         wdnCWMbtCsLN5nmeYWGUgi6C46UQ9EIj8h/PN9ikVg3f5S6mFTAgsAwLisi6cRQWxapr
         tWEw==
X-Gm-Message-State: APjAAAW0Nvil5kesWX8XDd8uwy7Gq7pJpcQcRte1/kxi7iBYhLNCy/ZO
        Oe5CvuvHchQWL+bJ4qnd/Etn8MGDSTaBIQ==
X-Google-Smtp-Source: APXvYqxBwHBS8TL1hwso4HWmWDKFsziwoBeFHuoemign5Ohv5V3P0+2btm7+7Z8BI/vEKzkAYZGW2g==
X-Received: by 2002:a19:4cc6:: with SMTP id z189mr5302555lfa.171.1580476866627;
        Fri, 31 Jan 2020 05:21:06 -0800 (PST)
Received: from saruman (88-113-215-33.elisa-laajakaista.fi. [88.113.215.33])
        by smtp.gmail.com with ESMTPSA id u13sm4628454lfq.19.2020.01.31.05.21.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Jan 2020 05:21:05 -0800 (PST)
From:   Felipe Balbi <balbi@kernel.org>
To:     Dejin Zheng <zhengdejin5@gmail.com>, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: Re: [PATCH] usb: phy: tegra: make the code simple by devm_platform_ioremap_resource()
In-Reply-To: <20200127135841.17935-1-zhengdejin5@gmail.com>
References: <20200127135841.17935-1-zhengdejin5@gmail.com>
Date:   Fri, 31 Jan 2020 15:21:01 +0200
Message-ID: <874kwb92yq.fsf@kernel.org>
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

Dejin Zheng <zhengdejin5@gmail.com> writes:

> make the code simple by use devm_platform_ioremap_resource() function
> to replace platform_get_resource() and devm_ioremap().
>
> Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>

checking file drivers/usb/phy/phy-tegra-usb.c
Hunk #1 FAILED at 944.
Hunk #2 FAILED at 1054.
Hunk #3 FAILED at 1071.
3 out of 3 hunks FAILED

unfortunately, it doesn't apply.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl40Kb0ACgkQzL64meEa
mQa9oQ/+N8kMk+Fj6NEXBzM8cCr8usoHA7A7qOqstj20pLW3cE8yLXehv64Brcio
QromC9dq9QqoFEQmvK7VkZYAMu1rZJxZysZNTO/bNpVdA3mF1/yqKME92oJCg7X5
5+ouEFUQNGvyxNuWX5Uo7SycH66xZm8/vyPwK3dUNA64Ex/gqoDMJomSpdhI7PiS
VUf3Fr+BQNAJ9w5Z+IEsQj/E6dQpVITr17gt426oEQmmhzHmwHX5viypc+jys/Dn
y02SCHcx8IbzBBzNnH31pFFQ+COtT7NbBjTbkeqs0BOGaLSWpFROp/80Jnn2/4l/
d2QNytRnoy9uXpqo3zLAVAJcFakqofr6mgqoEO6FOJ3o+B0uXI3u2JHUkenAUM+v
V/ugEbWI3LHtCCGsWIZHmNtfPxQtxKXyGVEOq7KSvHFMjoVExln+kI7TOrtgZdkM
fpqvqr8uUZiDxSXr2ScF0vtlkZW5ECZPZ74aRl+iznIyYaPHy0ma6vxm12K40HGV
Xdwhdn9D/VD2Zn01rBusPn1wJoZI/E6nhEpe/6XqEEWCghusWP3UpI6u+pTGNyrY
T80o58Ay/F4vGx57vpX5iLWvwFItX3IIfVVbyoV1SlQeLLMChVfX5GaQIzLNJVdi
6naoDsgqekY33RmJ3YqRupMO/gJUu9diGEYyiow1WabipwFNz68=
=doA5
-----END PGP SIGNATURE-----
--=-=-=--
