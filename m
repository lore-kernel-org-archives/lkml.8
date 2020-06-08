Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA03C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 02:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A1162075A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 02:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="hbSl9fSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728618AbgFHCPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 22:15:49 -0400
Received: from sonic306-48.consmr.mail.gq1.yahoo.com ([98.137.68.111]:41344
        "EHLO sonic306-48.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726662AbgFHCPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 22:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1591582547; bh=LeNZHONdlm6bcYug9q3xuSIHrVN5iUaoxaV6Ago7nbU=; h=Date:From:Subject:To:Cc:References:In-Reply-To:From:Subject; b=hbSl9fSAaV+D3pugnsrFXMzN8fmQUT/2+N/GnpbslnifsZal7YrZOMPxmAsYqEX9cVCNw3kPhLQIUXd2ImeZOy85ixESRKVKOiJ/T1y1B0f8+PK/Lbu/RbGkvvAgqvj2+m8FIPGlWuirFh4ajkKZnpFDcAqodR/Ksc3122TRYKEI0BecV4Lk+eYZuEQQLbUk6OFlg26TlqUYGMl5mFcd1dJgBjkj06biu0Tulbh4fuzPC1IbUE2f32VhYc1qOdgEWNtYZ/GmVHAAB5yTsHUP9gSt7h1vSQ9YKuO3c9VStNbsU6kO9cgWDyY+56Dk+zW5fggGjJVVfZeBFIOM3aABEQ==
X-YMail-OSG: N_6BpMEVRDvd.miR6A7lED5GPdAEx7ojsA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Mon, 8 Jun 2020 02:15:47 +0000
Received: by smtp431.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 3b13a0cd26292fd40daa8b7a3122671d;
          Mon, 08 Jun 2020 02:13:45 +0000 (UTC)
Date:   Sun, 07 Jun 2020 22:13:42 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: 82fef0ad811f "x86/mm: unencrypted non-blocking DMA allocations
 use coherent pools" was Re: next-0519 on thinkpad x60: sound related? window
 manager crash
To:     David Rientjes <rientjes@google.com>
Cc:     alsa-devel@alsa-project.org, bp@alien8.de, hch@infradead.org,
        hch@lst.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, Pavel Machek <pavel@ucw.cz>, perex@perex.cz,
        tglx@linutronix.de, tiwai@suse.com, x86@kernel.org
References: <20200520111136.GA3802@amd>
        <1591545088.74ii116nf2.none@localhost> <20200607163803.GA10303@duo.ucw.cz>
        <alpine.DEB.2.22.394.2006071209470.84952@chino.kir.corp.google.com>
        <1591570155.2tn9o40h95.none@localhost>
        <alpine.DEB.2.22.394.2006071756040.138746@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.22.394.2006071756040.138746@chino.kir.corp.google.com>
MIME-Version: 1.0
Message-Id: <1591582140.kcn3hpk42g.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.16072 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from David Rientjes's message of June 7, 2020 8:57 pm:
> Thanks for trying it out, Alex.  Would you mind sending your .config and=20
> command line?  I assume either mem_encrypt=3Don or=20
> CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is enabled.
>=20
> Could you also give this a try?
>=20
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -99,10 +99,11 @@ static inline bool dma_should_alloc_from_pool(struct =
device *dev, gfp_t gfp,
>  static inline bool dma_should_free_from_pool(struct device *dev,
>  					     unsigned long attrs)
>  {
> -	if (IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
> +	if (!IS_ENABLED(CONFIG_DMA_COHERENT_POOL))
> +		return false;
> +	if (force_dma_unencrypted(dev))
>  		return true;
> -	if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) &&
> -	    !force_dma_unencrypted(dev))
> +	if (attrs & DMA_ATTR_NO_KERNEL_MAPPING)
>  		return false;
>  	if (IS_ENABLED(CONFIG_DMA_DIRECT_REMAP))
>  		return true;
>=20

This patch doesn't work for me either. It has since occurred to me that=20
while I do have CONFIG_AMD_MEM_ENCYRPT=3Dy, I have=20
CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT=3Dn, because it was broken with=20
amdgpu (unfortunately a downgrade from radeon in this respect). Tried it=20
again just now and it looks like it's now able to enable KMS, but all it=20
displays is serious-looking errors.

Sorry for not mentioning that earlier. I'll send you my .config and=20
command line off-list.

Thanks,
Alex.
