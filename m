Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64470C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 06:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44D372071A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 06:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjYiMJD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgFMGte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 02:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgFMGte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 02:49:34 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2132C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 23:49:33 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f18so11248971qkh.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 23:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=x78l+4Wurav+J/Fur91yS5OJaOV9TWUDD2A/LyJnk2M=;
        b=AjYiMJD5jvxq4ec7chJEjIvsiQL91E784oo1S1YnmVPZbJwCxIrIYOEJk+8sT0jrST
         srLtT/gasywFNXUGf36NKvkRiovpCVrBCqzPqZDK+HyAVAdNT7BBLtasxHrYmjpfZEZF
         etMY6W44R2QpIx6BeSkFc8Ncm0Vi7xy/VTK/yTELYzCizUjjMfvesvrssTDWXw/JUB/Y
         iXsyLk165CcndsoALhrXB9BEozVj54cN0NsA6zQIhSLshRIfx5BmfOefwiPeeA/g/+Sv
         AAVYYNiWDeG+rR4z80ydwSmNpJcGQCkroZ7oLKZFaf26jnVCPZXKUWijmq0mTmvOH+FB
         uWRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=x78l+4Wurav+J/Fur91yS5OJaOV9TWUDD2A/LyJnk2M=;
        b=djC9rIX+RrxiyeyI8Cds2DK/T8rg7zi6HXRGBrP9tYO3ViJ8/E2kUH2NiMFIKgql+j
         wRqcQLB5iCuqBTPLan01JYpZAhxcR34CPQ5QwjD4tWH5nGJlHPerlU7pYza2mGru0EIK
         YFkOaXAB5i62o2LGMNUlvcTVU4fyqrCPTAWuM2YSwsOarHBUPozqKo2WhVB2Scj02dER
         xy2zJjS4UjBD0RIvhFslvcU8sZwquzCQJGxapVceeAsf6mFg0ie8wLuVj6WrPpBfYAis
         Jwx/GfXW0MNBogWgHzlfRRlkFhrL/BFl14IZEwoKVhIpx4NxgCkrRO5GTQvsu75rBmBb
         KCjQ==
X-Gm-Message-State: AOAM531RgGX7MsNIU0gehVkaOSEuSgrXdu0A4Ak/p+OstSypy0MfNKYp
        6Caefz0MnBYprQdlj3ccm0YGoH1W
X-Google-Smtp-Source: ABdhPJxOJAO6P2/rKc2y4Y1B3RvnqHO3Owc3JC47p8pxoXx4p43i/210mVq6B+sGouZM5g1yalVDdg==
X-Received: by 2002:a37:45d6:: with SMTP id s205mr5923761qka.79.1592030973014;
        Fri, 12 Jun 2020 23:49:33 -0700 (PDT)
Received: from [192.168.1.204] (pool-98-118-94-114.bstnma.fios.verizon.net. [98.118.94.114])
        by smtp.gmail.com with ESMTPSA id x41sm6815592qtb.76.2020.06.12.23.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 23:49:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [Patch] mtd: set master partition panic write flag
Date:   Sat, 13 Jun 2020 02:49:31 -0400
Message-Id: <CB182F6C-EB9E-4E90-BF6E-115C925FCFFE@gmail.com>
References: <20200504235403.13504-1-kdasu.kdev@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20200504235403.13504-1-kdasu.kdev@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Can you please accept this if there are no objections.

Kamal

> On May 4, 2020, at 7:54 PM, Kamal Dasu <kdasu.kdev@gmail.com> wrote:
>=20
> =EF=BB=BFCheck and set master panic write flag so that low level drivers
> can use it to take required action to ensure oops data gets written
> to assigned mtdoops device partition.
>=20
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> ---
> drivers/mtd/mtdcore.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
> index 2916674208b3..7e37ed2f38ea 100644
> --- a/drivers/mtd/mtdcore.c
> +++ b/drivers/mtd/mtdcore.c
> @@ -1235,8 +1235,8 @@ int mtd_panic_write(struct mtd_info *mtd, loff_t to,=
 size_t len, size_t *retlen,
>        return -EROFS;
>    if (!len)
>        return 0;
> -    if (!mtd->oops_panic_write)
> -        mtd->oops_panic_write =3D true;
> +    if (!master->oops_panic_write)
> +        master->oops_panic_write =3D true;
>=20
>    return master->_panic_write(master, mtd_get_master_ofs(mtd, to), len,
>                    retlen, buf);
> --=20
> 2.17.1
>=20
