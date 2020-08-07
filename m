Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6DEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D3D7221E2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 13:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596808759;
	bh=GsMsINOwUrYodbh+1gZjJuGWX0FnIRjRsLe5PftqS9Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=soTTUilYsSbYIxORlOp5U8TsXtuS/kwYfz77FwoHJA9Oc4/2ZhOnmpQ311hFAJHyM
	 nJLQRFqXClGb9KsSe+5dz0IAJbDkB7BAO+OiCB7tiYffTrCE00zEUW9pTtjv3lkp8E
	 5fIsN7lFUHsCy7EmKs19v8FPBfks+MUQlhHAoiIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgHGN6A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 09:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgHGN5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 09:57:44 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3191C061574;
        Fri,  7 Aug 2020 06:57:43 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t23so2321061ljc.3;
        Fri, 07 Aug 2020 06:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=GsMsINOwUrYodbh+1gZjJuGWX0FnIRjRsLe5PftqS9Y=;
        b=LAYdrLE18Y6Z9pFhpwKemwVYQtGrkZEn0bB8iNXLvmV+hH9X9A7iaNQsCwiFsyEj4b
         /X2+gh5lt+QllIUYPYH9+NKRfzeGpGvIy9saZ+BIZAmP645aVjdX8iRSffHcW2zUcx7C
         N+dlC2BpARVeztxtDswhlCh8EdXsG+MKVoMMxlOxUbPGlJRGB/urPCdETpWj6zNwTGqN
         gEAxE8ASN9Spn9Eb0CYrlNcRoBVUhlLXmvStr2gn3w5671jnt19OiLTuPZUg+7fEFEMi
         O18wySiFr0ZN2Qu0BxI72uA51LI1yzGLv7SldZ+ZuiOz4Mhi8Vt4B/LGc6BZ4Vx++O1H
         VKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=GsMsINOwUrYodbh+1gZjJuGWX0FnIRjRsLe5PftqS9Y=;
        b=nrSfLBwpjWVDECYiweD89S1OQKsv6r7UpVg09L8If7edeERxJCqFCrgMc+5aQlIbQ1
         MTdQPrOwJcpGJUp0pJWANiqWb2y76smW5MblS4wkverEToLxws82CTzyrrgcTQ5uWp7v
         hPsDfhISTU8c5+LAydKFxKEABwF4D+YshxVzwZYj/JanvxxQAXwHUwzC6lz8mKHyJaUz
         bGk+qprHdzzyPJfbO5JUZBo4I7fe3iP/GAPcNCiSTYMJEFJlbMpsLhLGEKs6BdkuWZ0B
         uGO4pciTCE+WMzs3xhhWZYxjuJlx4Rp7vQGET3GEBc/PMR8Ycc3SZXnyTsgG4U+cFY0f
         34qw==
X-Gm-Message-State: AOAM531DyWDCTBIvsbasQF4L59nwOulz97E15aAIFR7+5TkbqDGjBwYm
        IS1+gJj91S82ESrR4Mb7tSZe+jn6lTo=
X-Google-Smtp-Source: ABdhPJydZP9rgsASTJaEa+1o/kNJx+qckxY75jtJmI9lKpoCrqxNzNUZzRaJM/QkfNuX/rWV9czOIA==
X-Received: by 2002:a05:651c:88:: with SMTP id 8mr6678123ljq.277.1596808657281;
        Fri, 07 Aug 2020 06:57:37 -0700 (PDT)
Received: from saruman ([165.231.178.18])
        by smtp.gmail.com with ESMTPSA id v9sm4173599lja.81.2020.08.07.06.57.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Aug 2020 06:57:36 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH v2 08/41] usb: gadget: s3c: use platform resources
In-Reply-To: <20200806182059.2431-8-krzk@kernel.org>
References: <20200806181932.2253-1-krzk@kernel.org> <20200806182059.2431-8-krzk@kernel.org>
Date:   Fri, 07 Aug 2020 16:57:31 +0300
Message-ID: <87y2mqpnhw.fsf@kernel.org>
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

Krzysztof Kozlowski <krzk@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The resources are correctly initialized, so just use them
> instead of relying on hardcoded data from platform headers.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

If you want me to carry this and the following patch through my tree,
let me know. Otherwise:

Acked-by: Felipe Balbi <balbi@kernel.org>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl8tXcsACgkQzL64meEa
mQZA4w/8CJ54XLKdECc57KFHhY6lVIHanhEvJbHXAxas90EQiV8BrcUe+5jiL026
iz2wcFq9GYRTRVcR2drgUG0fVSuqYbPbETlwAWy8fyDRKfs+LfDlvH0iz3eo7P2h
Lr3OBDYEymbErFov8w1cOWNIDuRjol8ed7FWnLQfvXNd9NKXaCq9JvCBkjcBfKGT
EcB4+ZUGtY6IQ1iDVrB0tpC6Br7HiuZoVocSuN+3LQSCae/QoYD57fqujyH5ywHk
QB7XSnp9yKk1vI20X/U5J/5DbM6k3DE73A24cpf+TFKDabQcdRUiSRJm1evl12nE
hOz0cBxflsL9BUtpOpvGKYDz6GjR/KXnkKw/I9q3npkNd1ybWAIKaELoQkE/Jtni
AjaR1uzMb0X7IPDaJu7dYFYSujWjFK/WrJZxJc9O7lCrugN5aAC9nt87s56wptZq
TCfN/ot2OOtemOc2BcrwDItdiPTbdOHxkrVu886cIYbxhHDyB0+Tk18Qa9paffUC
TS3Ebq6mPDuksavbGn9aum6xz5vJiw7rwz9laTw4pTdoGvphedZAOhWQiisZaBvk
zefXWKxWnu9KWOZiLemLpmm1Ml5sohd13hmwSDt8CUiuw8+3ipooiN87wPlnXCbG
397W2xRTWYXkS0teICSXeuEMdXky1HZ8R/PD7bA6ApGmgNV60k8=
=pdwI
-----END PGP SIGNATURE-----
--=-=-=--
