Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9B1C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88CFB2078C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 09:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuLQaKEK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgD1J5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 05:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726971AbgD1J5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 05:57:15 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C3BC03C1A9;
        Tue, 28 Apr 2020 02:57:14 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r26so2168022wmh.0;
        Tue, 28 Apr 2020 02:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nTaGG7SSX6CF4kBBBpm5NDyrd8GCvd35Jt/ARBQ8h40=;
        b=PuLQaKEKCgOwpZrcw4/CMp5zUgGzGWeTnjk02IUua6RxWhxxSmd2DaDZ7XNVzz622f
         cuZs6EcC194lMtkZL0obRUG7xfsMO86WNtxZ9Y+EuwPb7qu32hl9o5UnsmyvbN3BvWmW
         x33GX43YwsBR/8wnPe9CtMGjs/01pQofEJKrbhlS9PDywrw6hVFJYdTpnXiuNaqGcs58
         gDEHbpuG+WMQdhvTL9YvLljs/TMOL0nzE+ZGkLZi6cf3XS0hdnKXY/Z7l9NwzflApDvr
         FgHrdTrcBcvEWKottFQpar35rs2G3kowCyVIjKMlJF6WFz6TyTKOES2fdc8w+YgPaxCU
         vUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nTaGG7SSX6CF4kBBBpm5NDyrd8GCvd35Jt/ARBQ8h40=;
        b=QnOxqCFP8Ax0vs79J84ADozRBqFLortlShz2psP/TI862+2fX6vpkf5X3slWGn4wY2
         ZO4xLBmwNT/lSoLWgMAyVsejigam2uyaO7Rw8FryOwGFH6ZfrrMjD7QCxfms7B4lWHNN
         AYmCwfR9U3BtfhOpDVXPXNJSqf50EOuIEqYlZ4U0BG5RQef/eYdHr9TSYUD1vk0xKogR
         mLLX0ONlXo2DAn3HYzGLiaBIbm5VZ8BPOSdsb/8hk9v9AB6RqVb66K5y2nbdFf1ZVYu0
         nNBFArQ9Tr7xuhWy46fzg1dEJN/4ZDEXlPrfruFhf/gBIPWfjjNnxk3VN/sMU0b2bS4y
         y0dA==
X-Gm-Message-State: AGi0PuYFab1RQiC1ZNoqqFREPbo/C1UzpET46kBSZQkhK9zLm2RMAw4U
        UmERxn/VQifBWQKjDnFfPOQ=
X-Google-Smtp-Source: APiQypKTnDihml0NWOVYIyeYpsaqg7Q/GMXXpVyxLjtKDVnzj6ea1nW8O4HHQSe0xjZUn6L3nk/bwg==
X-Received: by 2002:a1c:9a16:: with SMTP id c22mr3553349wme.38.1588067832658;
        Tue, 28 Apr 2020 02:57:12 -0700 (PDT)
Received: from localhost (p2E5BEDBA.dip0.t-ipconnect.de. [46.91.237.186])
        by smtp.gmail.com with ESMTPSA id o7sm2511404wmh.46.2020.04.28.02.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 02:57:11 -0700 (PDT)
Date:   Tue, 28 Apr 2020 11:57:10 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nagarjuna Kristam <nkristam@nvidia.com>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org, jonathanh@nvidia.com,
        mark.rutland@arm.com, robh+dt@kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/8] dt-bindings: phy: tegra-xusb: Add charger-detect
 property
Message-ID: <20200428095710.GA3592148@ulmo>
References: <1586939108-10075-1-git-send-email-nkristam@nvidia.com>
 <1586939108-10075-2-git-send-email-nkristam@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <1586939108-10075-2-git-send-email-nkristam@nvidia.com>
User-Agent: Mutt/1.13.1 (2019-12-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2020 at 01:55:01PM +0530, Nagarjuna Kristam wrote:
> Add nvidia,charger-detect boolean property for Tegra210 and Tegra186
> platforms. This property is used to inform driver to perform charger
> detection on corresponding USB 2 port.
>=20
> Signed-off-by: Nagarjuna Kristam <nkristam@nvidia.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> V2:
>  - Added Acked-by updates to commit message.
> ---
>  Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt | =
4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Thierry Reding <treding@nvidia.com>

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl6n/fQACgkQ3SOs138+
s6Ey8A//Q4uTEuupOy7QQCFXs3b3I4r6jVXyp7QjRGgXc7yHsnbR90IS0fm3eHsx
6sHKZXqZAyGiL31/zqCktQfQZW9pwwizNKwikn0ly6pmr77zDf9zrbL4YyY90Twb
ZNI1kpx88LcjO8rwhS/PAZF7CNzrzMx3uLabAf2oT+d95Lz1OLO+afwd82VTA23t
QDIzlQNFB3UO3yLQbQ+1WIkFsWXEqXgWiHb8F07r1vnI/FqOKhc92dEMskfVxMCH
+pHYOHxF9zqwK1zQcP9BaPtuCDP1jN63ys+xEz7KgpivxK2/Vgsv3Iak7ZdLn3Qd
myldUUl500MjfanZYuIWi0g9QFk0RLuwLuQbak/SiUW53Yh1si5YQixsIk9foiq7
kpW2HVme+iTC7zTYVppxS2sEpKVbFMKZl1eCfTF4nJvQ+nKqVEgh/7xROyN2U5TB
H8eygj9x9sc5/I1Y9GNFF+JSiLsNr/A+IAYnIO/ZRDesMo3QivT8hZLZOfMPx8et
Pkwnf5oWpUvM0X5w71jtc02jewYF4fk4tukanyQR/vdOBZU/XdUqsM+QEjEbN+s6
esBuOAIE5vntKRHJznGOX4eb4nAAI57q1HLg9WQWZssCkPxZKdLrcBePAgFvLmmj
9Rko7SMP3B5YV9s3dW1j9iQUhKzclnr/ceL+3A8Dm9KzinJ11A8=
=n51I
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
