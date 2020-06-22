Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBCAC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6A3C20732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgFVUai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:30:38 -0400
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:35320 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728361AbgFVUah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:30:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 1ACF5180431F9;
        Mon, 22 Jun 2020 20:30:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: coach14_36080fd26e35
X-Filterd-Recvd-Size: 2596
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon, 22 Jun 2020 20:30:34 +0000 (UTC)
Message-ID: <6b0649c53e853fd2a35e9996f13e702daa0d7e2f.camel@perches.com>
Subject: Re: [PATCH] trivial: fix kerneldoc comments
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <Julia.Lawall@inria.fr>, trivial@kernel.org
Cc:     kernel-janitors@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 22 Jun 2020 13:30:33 -0700
In-Reply-To: <1592854669-20606-1-git-send-email-Julia.Lawall@inria.fr>
References: <1592854669-20606-1-git-send-email-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-22 at 21:37 +0200, Julia Lawall wrote:
> Fix the parameter names in the comment to correspond to those in the
> function header.
> 
> Drop comments about return values when there is no return value.

Done by hand or script?

[]
> diff --git a/arch/mips/cavium-octeon/executive/cvmx-spi.c b/arch/mips/cavium-octeon/executive/cvmx-spi.c
[]
> @@ -69,9 +69,7 @@ static cvmx_spi_callbacks_t cvmx_spi_callbacks = {
>  /**
>   * Get current SPI4 initialization callbacks
>   *
> - * @callbacks:	Pointer to the callbacks structure.to fill
> - *
> - * Returns Pointer to cvmx_spi_callbacks_t structure.
> + * @callbacks:	Pointer to the callbacks structure, to fill.

If scripted, odd comma after structure

> diff --git a/drivers/crypto/bcm/spu.c b/drivers/crypto/bcm/spu.c
[]
> @@ -519,7 +519,7 @@ u32 spum_assoc_resp_len(enum spu_cipher_mode cipher_mode,
>   * spu_aead_ivlen() - Calculate the length of the AEAD IV to be included
>   * in a SPU request after the AAD and before the payload.
>   * @cipher_mode:  cipher mode
> - * @iv_ctr_len:   initialization vector length in bytes
> + * @iv_len:   initialization vector length in bytes
>   *
>   * In Linux ~4.2 and later, the assoc_data sg includes the IV. So no need
>   * to include the IV as a separate field in the SPU request msg.
> @@ -917,7 +917,7 @@ u16 spum_cipher_req_init(u8 *spu_hdr, struct spu_cipher_parms *cipher_parms)
>   * setkey() time in spu_cipher_req_init().
>   * @spu_hdr:         Start of the request message header (MH field)
>   * @spu_req_hdr_len: Length in bytes of the SPU request header
> - * @isInbound:       0 encrypt, 1 decrypt
> + * @is_inbound:       0 encrypt, 1 decrypt

odd alignments

etc...


