Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DBAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B01272075E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 14:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="uNpqi2vR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgFKOwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:52:03 -0400
Received: from sonic301-21.consmr.mail.gq1.yahoo.com ([98.137.64.147]:42894
        "EHLO sonic301-21.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728059AbgFKOwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 10:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1591887121; bh=ubPouQ9Xy3jD3XhRdWP4bfCt4xkdJz6IW6/Ib5Sl8Ac=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject; b=uNpqi2vR0OsuFPmw4Ewgd7A2Y0WIDbciOaoVS3cQfC45VkmI1lmFS9h6Zy7P5vCx/vfuWLTgueAUPGfnSvDx2Ryad0pHqBgZS1vBVQLGtCcgvWhiek+P+kVBFpUBvhWKg7sqlqEEdjC9ieV41l1A9vT3BdjPTIQHBbBdCmN+cBYaJGOfqGNiNKYbDwVkRFCJh/6FLOZfjmsnGEnI+6ZMLW5j5HVP9r6UUuFgksZRZ3zT579JobdSHUVkpTdiUlgbbK7ouh+ZvzoPALmAJSaMgv9BoEowwVdUWtdTLpPI282/GDnAwmMsuEtRFk6Ib6T2rJ5TGiwDHBpNRqpzNtCbPA==
X-YMail-OSG: aZdqEXsVM1mGmKp1hG5N3D_jCXDweXcWIzN5LThAMudZ.O.zcMDgM.PP8tFNpOo
 rFJa4yVUrEZtawWtfAu8eJfhFsEqtZE.qbe65a4tHNfcWEuN9J53RRtZKYRqvdgYpFsb2A02UhZf
 OmEoKJFRV7.Cl0mR4Mm.zSd3eHuHMMV19WwZwtO87Bb3onQz_XRlkpFLm_vlM8LZbH2q5woyJe5I
 PZKRUUiHyUkVBZz1huWYdiqoTO2dHXFycjG5ohb.Pn7A6g2wc3fR64whkZB5tzYEh.SBB9RkHqn1
 K72.Qa69H1.17uHxbHificWrYVGjUDjQH_RPFe0z7pfcqHI0e1yQUhT60qvZTuopGFe3vlB83Etg
 St0LxQpofH3FXQDGnhdplArnbbR5u02qblHkI5_FiAgls9pZnHXwcU9ZCSDj1lqIz11q59uETvDR
 H2cGF76b.efEqIBBeGCoL2f039aW4OjG4iiU2Ej8UVAEqE.DGzfB7gmGNl7UFsfOv7jrVOx4I0Wa
 vgu4RUwvQUogj36DWZYyhthbS6ZYAWOn2og3rrsCAeKAU9XC.2w5lc.6WAtNqXQxSuA4V6KbRhAO
 2gxmmFEpy7Y4EvFFVPky58C8q51hmmtgIUDVhT0mpkEBEwf0DQmntbK_nziXBlFTb3mBJFSRQNPt
 144ryTHuJCEAbMD6iPa6t_w_EqV2aI9AJDlVzxwmw0HSYN2Mxq.nDZiApWwQR9lJAZAP2osHt_4T
 K11Yt881_mJAhwgJvVaXTP5awz6GonIxF4TskfTPrEdQ67gf15doqYFfEg9boliLPmpRX5C.GjuR
 bS8NGNqqWG2FWhSMo.X2clW0qZUyak1ztr7vaTILFamTrt4nMUGrL9YghzE5cgbb6r2Oz6Zc6xg1
 Yg0x7qvw1jSEYKdeKml5M3gT0.c1qYWUcjet2sRb7Se3gWXOMEtIas01T_nbecRUU.RzU.ynChma
 buNvKBHhEBn3J07RxRhnYKURe.pDitOWLa8raj._t1CuWfS1.rz2WoWnfQrBL_5yWYZxQj0ynTzx
 TGunAG.1kyMcLCKPNyIJdEG5K0TZrYjG9r4Jm7iiSf3XMgwFIEfBGBRwQOjovFLpHxSvCWq97y2B
 b570V.40jKv65bz633sZjPTF2akljszzrZoQh6hC.kjJXKdCgxuOTTJ17YLLpHozbZKP1MQm.USy
 pin5ryUmcR745O9IahIx0j03M8cYmxqUHiq9GpoqWCZQLUISCoWwZ57wXH.6s8FyZPQQecYtTOI.
 pyE2JFRnHKCsGvvMXNx3kjXEw_Arh2AzN.QrVRu92_2ceojpFIxPp7O5KlVDR5cM3yo823SICiGu
 MXluZHa8kHsqDKIr9d_egwK0FvLbJ66m66xbBD1vflHZiyWLo4NAMil_HYDKA9sVCpf5rGqFf8oX
 lRw50s7dfRbFGvA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Thu, 11 Jun 2020 14:52:01 +0000
Received: by smtp430.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID d23dec023b11027fb01c355b982896cf;
          Thu, 11 Jun 2020 14:52:00 +0000 (UTC)
Date:   Thu, 11 Jun 2020 10:51:56 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: next-0519 on thinkpad x60: sound related? window manager crash
To:     Christoph Hellwig <hch@lst.de>
Cc:     alsa-devel@alsa-project.org, bp@alien8.de, hch@infradead.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        Pavel Machek <pavel@ucw.cz>, perex@perex.cz,
        rientjes@google.com, tglx@linutronix.de, tiwai@suse.com,
        x86@kernel.org
References: <20200520111136.GA3802@amd>
        <1591545088.74ii116nf2.none@localhost> <20200608061950.GA17476@lst.de>
        <1591624340.z01ejtod28.none@localhost> <20200609114733.GA1621@lst.de>
In-Reply-To: <20200609114733.GA1621@lst.de>
MIME-Version: 1.0
Message-Id: <1591887082.rbi6gq03l0.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.16072 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christoph Hellwig's message of June 9, 2020 7:47 am:
> Alex, can you try this patch?
>=20
> diff --git a/sound/core/Kconfig b/sound/core/Kconfig
> index d4554f376160a9..10b06e575a7fc5 100644
> --- a/sound/core/Kconfig
> +++ b/sound/core/Kconfig
> @@ -192,6 +192,6 @@ config SND_VMASTER
> =20
>  config SND_DMA_SGBUF
>  	def_bool y
> -	depends on X86
> +	depends on BROKEN
> =20
>  source "sound/core/seq/Kconfig"
>=20

Sorry, this patch doesn't work for me with SME off using abfbb29297c2.=20
David's newest submitted patch works for me, which I already replied to=20
separately.

Thanks,
Alex.
