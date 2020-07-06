Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88976C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63061206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZ4A9bju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgGFVrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 17:47:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28237 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725860AbgGFVrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 17:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594072031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qRWR21MnKfXBkh6ZR/sB0rfgRbUwkmqSxMK2L6dCLXk=;
        b=SZ4A9bjussSm+Rv8xXmEJlEFye2iSk17QBSASDQIR6MZ4uVkfxZQA6SVSYyiXZvZOaCcLR
        P95dE8TPLoLgHAdi97t4iF7JJFXHZSVHpb/dE5RY7oqbWnxcfuS64lXdfBgiPnJumo2zCR
        3sxos4SSqTKAhr2hAuLk8PnedmEgE3U=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-8y8PLX1dN2a_0WaFel6BdA-1; Mon, 06 Jul 2020 17:47:10 -0400
X-MC-Unique: 8y8PLX1dN2a_0WaFel6BdA-1
Received: by mail-qt1-f198.google.com with SMTP id 71so21268877qte.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 14:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=qRWR21MnKfXBkh6ZR/sB0rfgRbUwkmqSxMK2L6dCLXk=;
        b=uaH+vuzdl9tlwEcInLOBCaCfY4HgOoK6XjFN8nIU1yvUBVylvcFzAmPBPaFigFZsYl
         JcoxAHLbXoTQDjSaBVmsmpB2BbekE8nmINIynv/HFfRu8bgLpfNUl4o209/bRVd5cCis
         erKyPqlGhDfH2F98dPrWSD1x7mkrLztuVEhQFZzEy+3zMxsD1OJ83Vnbvwp+2dEu2RVI
         GrpgbpHsKuDMoHp1Rhq0nHkvVArzTfy1BW+0NQ2wdLR5LIWuSJdwJ1AFLptCzyHjjUDA
         OkYM1cMro+NxAVgCN9igZdOrNiUD56xtsD3Z7xuY6CxGJyHlhyk0j+c9AVnBD4qFaqC2
         zr7Q==
X-Gm-Message-State: AOAM531ttHjnMxp1+kPufLEOhcx68OsjdaA6fh9QKwbeDk9m8DmExaWd
        W93O2qnofxiMHr+tHIYLWxNFpxbTp5VE3YGlSdBOt+jLKxCVN2D0mQAE1wh0CiLAin9fBdRZScS
        QxTsGLoh2joqO+rIjMqqMia0P
X-Received: by 2002:a0c:fde4:: with SMTP id m4mr33810386qvu.97.1594072029904;
        Mon, 06 Jul 2020 14:47:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCy6hty4Qry42W/2htbonA/KYvIh/mbX1sjmZEooPJokA8Od5Q4VUxAYtSb+CbGv7opx5QCg==
X-Received: by 2002:a0c:fde4:: with SMTP id m4mr33810377qvu.97.1594072029656;
        Mon, 06 Jul 2020 14:47:09 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id x34sm15083272qtd.44.2020.07.06.14.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 14:47:08 -0700 (PDT)
References: <20200706205342.21333-1-jarkko.sakkinen@linux.intel.com>
User-agent: mu4e 1.4.10; emacs 26.3
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert commit e918e570415c ("tpm_tis: Remove the HID IFX0102")
In-reply-to: <20200706205342.21333-1-jarkko.sakkinen@linux.intel.com>
Date:   Mon, 06 Jul 2020 14:47:07 -0700
Message-ID: <87k0zgwc2s.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jarkko Sakkinen @ 2020-07-06 13:53 MST:

> Removing IFX0102 from tpm_tis was not a right move because both tpm_tis
> and tpm_infineon use the same device ID. Revert the commit and add a
> remark about a bug caused by commit 93e1b7d42e1e ("[PATCH] tpm: add HID
> module parameter").
>
> Fixes: e918e570415c ("tpm_tis: Remove the HID IFX0102")
> Reported-by: Peter Huewe <peterhuewe@gmx.de>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

> ---
>  drivers/char/tpm/tpm_tis.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index c58ea10fc92f..0b214963539d 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -235,9 +235,17 @@ static int tpm_tis_pnp_init(struct pnp_dev *pnp_dev,
>  	return tpm_tis_init(&pnp_dev->dev, &tpm_info);
>  }
>  
> +/*
> + * There is a known bug caused by 93e1b7d42e1e ("[PATCH] tpm: add HID module
> + * parameter"). This commit added IFX0102 device ID, which is also used by
> + * tpm_infineon but ignored to add quirks to probe which driver ought to be
> + * used.
> + */
> +
>  static struct pnp_device_id tpm_pnp_tbl[] = {
>  	{"PNP0C31", 0},		/* TPM */
>  	{"ATM1200", 0},		/* Atmel */
> +	{"IFX0102", 0},		/* Infineon */
>  	{"BCM0101", 0},		/* Broadcom */
>  	{"BCM0102", 0},		/* Broadcom */
>  	{"NSC1200", 0},		/* National */

