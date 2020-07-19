Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF512C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0E9421741
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uT2+zaTb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgGSX5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 19:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgGSX5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 19:57:48 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF12C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:57:48 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id t11so8138719pfq.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:references:in-reply-to:mime-version:message-id
         :content-transfer-encoding;
        bh=dSG09n2oHE5/NB8epYDiKNjgxgruVUEVoorNceuh6EY=;
        b=uT2+zaTbOowRyb+wAcQBYeUv45J/Uf3EtbdGezLqWCyzpuGEB8+JT+Bo9PbbWD6ZxT
         HtYgGwE6dkaBwIHbqKPqZw0CdpdMT8kJsUlOWH9kWg5v8oIM9UvKNbC03RX1ortX/ZMv
         Nl5Mck8Sn6oyAGelsP0GV48owyO7tKxHiiCkAvRGCbgmhblyKlMu5qgDEj2wvmSS1/fr
         W9wt3MPRdoyWV48fo5ooyqv4REhSo+evd6JGB2OJc1Ps4rKzt0bBhvPc3Pdv2qCB1gws
         d+MInfYr4ER9i5NEAx9Vpkbdt0oS//B2gOF3ggn/opFZP9oTjZLy0z7KxtwPGWxYpQqY
         iq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=dSG09n2oHE5/NB8epYDiKNjgxgruVUEVoorNceuh6EY=;
        b=Py1uQHuTsK20RmRfWMu3OPKYI7C+My4EUiMLBeN2Bc+Je84KVxPuqy/mzQAYuXxub4
         G+b20OpSAgZIjEDe8ENj1CDpxqniAhVjzecMEn4YyxyexCmYIMlJ3gzEKOskHLtJbkkl
         t6kmxjRNp+I3GkAdcKd5jwYekd4d2egLL13CdpjlqoJ4NqxiJi1vqse1vvsUtKYiT1KK
         IzKE95J/ivoeLzdH8/GjIbJo0w/EksBem4gfIR2YlozzBD9X7UX6P/YGOdbDpbmrCzLF
         6Lc9ck/DqogmqeMBtN/wZA8GKeOwfyMbeBUeVQJ/KalbMya0IjfaLvjgvPtkxiHm4Vx/
         itwg==
X-Gm-Message-State: AOAM5313PkA7sCJFUOMMMzxWIvp+LNCB7/yj5r91DJOAwBnaGPzdlj1S
        sOaKMB3Ji45+ODPdto16bp26GCHj
X-Google-Smtp-Source: ABdhPJyI+/k+zJZfCdHxZO6/LF9WqA4DVLP/ohb4RpMu/hW1sdcyHhyDxZjyDRVsACRz0GEb/hiEQg==
X-Received: by 2002:a62:7790:: with SMTP id s138mr16509948pfc.65.1595203068075;
        Sun, 19 Jul 2020 16:57:48 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id b11sm14802158pfr.179.2020.07.19.16.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 16:57:47 -0700 (PDT)
Date:   Mon, 20 Jul 2020 09:57:41 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 2/3] powerpc/powernv/idle: Rename
 pnv_first_spr_loss_level variable
To:     benh@kernel.crashing.org, ego@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mikey@neuling.org, mpe@ellerman.id.au, paulus@samba.org,
        pratik.r.sampat@gmail.com,
        Pratik Rajesh Sampat <psampat@linux.ibm.com>,
        svaidy@linux.ibm.com
References: <20200717185306.60607-1-psampat@linux.ibm.com>
        <20200717185306.60607-3-psampat@linux.ibm.com>
In-Reply-To: <20200717185306.60607-3-psampat@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1595202681.bt4670u7q7.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Pratik Rajesh Sampat's message of July 18, 2020 4:53 am:
> Replace the variable name from using "pnv_first_spr_loss_level" to
> "pnv_first_fullstate_loss_level".
>=20
> As pnv_first_spr_loss_level is supposed to be the earliest state that
> has OPAL_PM_LOSE_FULL_CONTEXT set, however as shallow states too loose
> SPR values, render an incorrect terminology.

It also doesn't lose "full" state at this loss level though. From the=20
architecture it could be called "hv state loss level", but in POWER10=20
even that is not strictly true.


>=20
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/idle.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platfor=
ms/powernv/idle.c
> index f62904f70fc6..d439e11af101 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -48,7 +48,7 @@ static bool default_stop_found;
>   * First stop state levels when SPR and TB loss can occur.
>   */
>  static u64 pnv_first_tb_loss_level =3D MAX_STOP_STATE + 1;
> -static u64 pnv_first_spr_loss_level =3D MAX_STOP_STATE + 1;
> +static u64 pnv_first_fullstate_loss_level =3D MAX_STOP_STATE + 1;
> =20
>  /*
>   * psscr value and mask of the deepest stop idle state.
> @@ -657,7 +657,7 @@ static unsigned long power9_idle_stop(unsigned long p=
sscr, bool mmu_on)
>  		  */
>  		mmcr0		=3D mfspr(SPRN_MMCR0);
>  	}
> -	if ((psscr & PSSCR_RL_MASK) >=3D pnv_first_spr_loss_level) {
> +	if ((psscr & PSSCR_RL_MASK) >=3D pnv_first_fullstate_loss_level) {
>  		sprs.lpcr	=3D mfspr(SPRN_LPCR);
>  		sprs.hfscr	=3D mfspr(SPRN_HFSCR);
>  		sprs.fscr	=3D mfspr(SPRN_FSCR);
> @@ -741,7 +741,7 @@ static unsigned long power9_idle_stop(unsigned long p=
sscr, bool mmu_on)
>  	 * just always test PSSCR for SPR/TB state loss.
>  	 */
>  	pls =3D (psscr & PSSCR_PLS) >> PSSCR_PLS_SHIFT;
> -	if (likely(pls < pnv_first_spr_loss_level)) {
> +	if (likely(pls < pnv_first_fullstate_loss_level)) {
>  		if (sprs_saved)
>  			atomic_stop_thread_idle();
>  		goto out;
> @@ -1088,7 +1088,7 @@ static void __init pnv_power9_idle_init(void)
>  	 * the deepest loss-less (OPAL_PM_STOP_INST_FAST) stop state.
>  	 */
>  	pnv_first_tb_loss_level =3D MAX_STOP_STATE + 1;
> -	pnv_first_spr_loss_level =3D MAX_STOP_STATE + 1;
> +	pnv_first_fullstate_loss_level =3D MAX_STOP_STATE + 1;
>  	for (i =3D 0; i < nr_pnv_idle_states; i++) {
>  		int err;
>  		struct pnv_idle_states_t *state =3D &pnv_idle_states[i];
> @@ -1099,8 +1099,8 @@ static void __init pnv_power9_idle_init(void)
>  			pnv_first_tb_loss_level =3D psscr_rl;
> =20
>  		if ((state->flags & OPAL_PM_LOSE_FULL_CONTEXT) &&
> -		     (pnv_first_spr_loss_level > psscr_rl))
> -			pnv_first_spr_loss_level =3D psscr_rl;
> +		     (pnv_first_fullstate_loss_level > psscr_rl))
> +			pnv_first_fullstate_loss_level =3D psscr_rl;
> =20
>  		/*
>  		 * The idle code does not deal with TB loss occurring
> @@ -1111,8 +1111,8 @@ static void __init pnv_power9_idle_init(void)
>  		 * compatibility.
>  		 */
>  		if ((state->flags & OPAL_PM_TIMEBASE_STOP) &&
> -		     (pnv_first_spr_loss_level > psscr_rl))
> -			pnv_first_spr_loss_level =3D psscr_rl;
> +		     (pnv_first_fullstate_loss_level > psscr_rl))
> +			pnv_first_fullstate_loss_level =3D psscr_rl;
> =20
>  		err =3D validate_psscr_val_mask(&state->psscr_val,
>  					      &state->psscr_mask,
> @@ -1158,7 +1158,7 @@ static void __init pnv_power9_idle_init(void)
>  	}
> =20
>  	pr_info("cpuidle-powernv: First stop level that may lose SPRs =3D 0x%ll=
x\n",
> -		pnv_first_spr_loss_level);
> +		pnv_first_fullstate_loss_level);
> =20
>  	pr_info("cpuidle-powernv: First stop level that may lose timebase =3D 0=
x%llx\n",
>  		pnv_first_tb_loss_level);
> --=20
> 2.25.4
>=20
>=20
