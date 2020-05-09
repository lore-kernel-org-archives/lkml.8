Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F495C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1226D2184D
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 08:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589011213;
	bh=1O47PkHhPqgCaPnb1U8RuAAVju8TXrJE2/w3v9RDbug=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=JB806EGflhr8ee5jrcMRJTG/N1uVGxR+b2q16JAg4ZTZKTY3MpErJRhRUuo+P3wyq
	 WI3yLI4VjBc54SDq1fhPKCw1JzY6jfrlUu7t+po4ZR7xc7rUHnEUoRtpkVhjYuclUg
	 72sxT9b979CMB5DCF6KoNo5wHkaHVuF/UCTjcMEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgEIIAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 04:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725850AbgEIIAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 04:00:11 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9FAC061A0C;
        Sat,  9 May 2020 01:00:11 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id r17so198900lff.9;
        Sat, 09 May 2020 01:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=1O47PkHhPqgCaPnb1U8RuAAVju8TXrJE2/w3v9RDbug=;
        b=uREhs3pYWcR0fUxz9iyr7QagA9NylxN3dLzNLCrOkywdxmuF8NGbY/bZ5Hb74A8uQ8
         kM78bD3VFlp9o1qq3xAKEitVWtT3lSDrk1FfSTNpHMk5Om6n0EfZ83Po3zMj8nDVFSDg
         fta+m2dQ5muFyBgC7vEzG4j76DNJSPdREfwIFg+GV9CYzg5h8nTtO4mWp5OCfdIKAw+v
         679hdIi8nlEsSGCR3D5pYPjr/UnCCWfxGmLVqlXtNgnRpcyTjzlTDBSVLV7EfG3SzoK+
         u+XV0pFLp6EHpaTiXf7KhyCcv/YJW7aEslPWGa0niXrtXueu0qOPBidxy8d3/DGqvur2
         nV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=1O47PkHhPqgCaPnb1U8RuAAVju8TXrJE2/w3v9RDbug=;
        b=cY9vvybdHA5LAZ0G+f85MIDUGJnsf5Qx+iKTNTAaI0dzp339+vZ3yKqM7Y60CQBehS
         22KGOnWSA4OWECsWY+9oqLIYKqYHWZ7xsTPu/A8rC86kJ1kfsWc9/zFpPIdmm/gGVqC0
         QynM0r18Gg6cx5p0moVZJzZpdZU+W2BxZ8K+c1VdqrEt2AYPeZ61hmcd4bkDBERM+Gwp
         8yYJVmkdF3qi5uJDoD2ht4i1q3z2J+hmhNt/khHTGGGThI8HbXkZfaYe1WhcgTwMxC/z
         Wy6xX9n+8tsJhhh0apv+E5tVjZUx9hITYNqQPeTANSpe1d/YN7egEzRqa3iWZ9qhXslB
         zo3g==
X-Gm-Message-State: AOAM530jLs6bgrAP3NCpVoWRVaOtCipdqHZ0dCZKEjvJ1R4j6EFtG5TF
        jLS4YkeRJSP2NYJfgTr5bws=
X-Google-Smtp-Source: ABdhPJzXIr+L+cqMht2BVYAGEPXftyPaqzeiq57Iq7hB4B+ztVcm83B0Xz/SLjIvsjYJJAlQeD/bJQ==
X-Received: by 2002:ac2:50c7:: with SMTP id h7mr4331340lfm.171.1589011209653;
        Sat, 09 May 2020 01:00:09 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id j29sm3691207lfp.90.2020.05.09.01.00.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 May 2020 01:00:09 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH USB v3 3/5] usb: raw-gadget: fix gadget endpoint selection
In-Reply-To: <459d02069dedefcc30095748f49ef4a426e15b74.1588870822.git.andreyknvl@google.com>
References: <cover.1588870822.git.andreyknvl@google.com> <459d02069dedefcc30095748f49ef4a426e15b74.1588870822.git.andreyknvl@google.com>
Date:   Sat, 09 May 2020 11:00:04 +0300
Message-ID: <873689mtbv.fsf@kernel.org>
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

Andrey Konovalov <andreyknvl@google.com> writes:

> Currently automatic gadget endpoint selection based on required features
> doesn't work. Raw Gadget tries iterating over the list of available
> endpoints and finding one that has the right direction and transfer type.
> Unfortunately selecting arbitrary gadget endpoints (even if they satisfy
> feature requirements) doesn't work, as (depending on the UDC driver) they
> might have fixed addresses, and one also needs to provide matching
> endpoint addresses in the descriptors sent to the host.
>
> The composite framework deals with this by assigning endpoint addresses
> in usb_ep_autoconfig() before enumeration starts. This approach won't work
> with Raw Gadget as the endpoints are supposed to be enabled after a
> set_configuration/set_interface request from the host, so it's too late to
> patch the endpoint descriptors that had already been sent to the host.
>
> For Raw Gadget we take another approach. Similarly to GadgetFS, we allow
> the user to make the decision as to which gadget endpoints to use.
>
> This patch adds another Raw Gadget ioctl USB_RAW_IOCTL_EPS_INFO that
> exposes information about all non-control endpoints that a currently
> connected UDC has. This information includes endpoints addresses, as well
> as their capabilities and limits to allow the user to choose the most
> fitting gadget endpoint.
>
> The USB_RAW_IOCTL_EP_ENABLE ioctl is updated to use the proper endpoint
> validation routine usb_gadget_ep_match_desc().
>
> These changes affect the portability of the gadgets that use Raw Gadget
> when running on different UDCs. Nevertheless, as long as the user relies
> on the information provided by USB_RAW_IOCTL_EPS_INFO to dynamically
> choose endpoint addresses, UDC-agnostic gadgets can still be written with
> Raw Gadget.
>
> Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---

you're adding a new IOCTL, how is this a fix?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl62YwQACgkQzL64meEa
mQbYsRAA0XJbcBgnby2EBTMYktlDmcMrOfmOE7NSASjGlft/AAZO/0yJVSEy9rE8
iPMyiw6wQ81VuMfpWzeFC9G+HTkTsqpQQ2ULWZWpJtDBFhzUL/5VWF/ZLeHg3VXT
fMuI2Cgmbj0Gy/V2pWH5MFGJtyxWKJQ0Q9QHFqSfimfcPT4dLbBbQ+HHvO+tJ8zV
3KN39YxJ5We1agxM2E2nzrCvTY8eiOl4/8a8s4N9l//8WlHc2BwWmuGq6QRPdvRE
aBElv9l4WplqDe+TXG+5Wx/vD+ezshKiAFhjlq3JdwgU4F8BsqO0BJFaLZXtUJnz
VTNqbkPmPOqEw5+QHhQQJ8N0ThJPHI4+gIXYZnQUyWHwW3G+CSYey5sFnjm0DA5M
rbmTIsSCk1VpTQjZvV9PWuF3vMO8aKLZy7UWC3DVvc82Uj1WfjI6ewn6e1M1v0wC
SquNQ1iKw5s6erCWmbYjOn+h9lEAnZgoDJpHHZzXcTpQidRAu1fRpYOdqxLEDV2y
AVQOYLV07Zvo4nDnACMUhvXxGLyeJs3gNZxIBMQQu0d+XWlRnAZAZABdUI43q/hs
1FLYj8j/PoYOqEnE2RfcMLE7jmtWnlt5v2llz4+1DF1gvY/CPL5ncRtmWNAPC9SX
dBZqt/Efo19jrHKsHXPPFqSdsm2Zc24EudCjgjyw6JujDnXVDCA=
=sI+L
-----END PGP SIGNATURE-----
--=-=-=--
