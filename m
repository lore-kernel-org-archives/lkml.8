Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C733C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 00:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECF2421744
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 00:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OaExb+xE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgGTABY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 20:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgGTABY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 20:01:24 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227BEC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 17:01:24 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so9475239pgf.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 17:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:references:in-reply-to:mime-version:message-id
         :content-transfer-encoding;
        bh=Qp/O47B+/PTH5X4r1WOkvdClsD8CXSU1831njywVtAo=;
        b=OaExb+xEqxuCJzRAkbSTE7/vjzqXUxq0pS5W7iEGg3sQSK7pKf41wbBSVIuJDpORU0
         5FlO6/kh4s4F57PcL+uXBcfem6TRvn6uYQelzWm8U/ppLVZPQXH8e4ZcSxiaGro+a1eZ
         TZX4IrosFE9de4fHS1QpS4Wb5yZW4hmz+AzHAPmmXz2vpnpmOqP6JdFboPpwngh+XHEE
         vwQ0CQFfoxP0kpYEmERctaoqftHj6ymkgTfHbAwiN+A2OFQEZ/i7o9SBgN4lTtjNJUKE
         uuNBY9bCjd9IvAh+L8Ugd89CCS2JdzBywV/ENymGAV2itR5dCxel1E3OSiqdnsFEVbIa
         6OyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=Qp/O47B+/PTH5X4r1WOkvdClsD8CXSU1831njywVtAo=;
        b=j1fEbto6e1sHo9Rezatd94Tk1bf6aud98ClQVKg47YdFL0PKyvypUExHUp2DwTyOiU
         kDR3DEUW9qvA6161ST25fRxJ7gFeQH8l4q+7MWiyh2yYKXxRbtk2r/zSaLkJTYJwlT13
         +lI0IYOO8eOCohN+ZIaxx5/ItelSByGSYfG3M2dPcYuFXQisPRn5aFbudpY+s/uBaOgV
         RcOT3X5pIkwQNCDQ2ES7TZY8QXZi+jR8Drr+gZuzjlyfmvDLXyYm+O0bP0xmKXOAcZfZ
         HkLlr6NNIZXZYRpcBUa40MsgjqHJy2qD7xYtEg7n8bxTnP6XvdHp9MdYxWH30D67su74
         J5CQ==
X-Gm-Message-State: AOAM531xD1TXEoTE+rh0hFu51M1ScWQARBekcQm+L1GG54Os8RQmRQ7C
        IszAcFEoqGaUzvvUi0TYE0c=
X-Google-Smtp-Source: ABdhPJxYwegdwxjg9r4YggaJjpy8/UCuo3gHlm19zg8v0ePWpunlzjf/YTaJClvq282r5JEsBMdI4Q==
X-Received: by 2002:a05:6a00:2294:: with SMTP id f20mr17462713pfe.126.1595203283725;
        Sun, 19 Jul 2020 17:01:23 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id y6sm9807212pji.2.2020.07.19.17.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 17:01:23 -0700 (PDT)
Date:   Mon, 20 Jul 2020 10:01:17 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 3/3] powerpc/powernv/idle: Exclude mfspr on HID1,4,5 on
 P9 and above
To:     benh@kernel.crashing.org, ego@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mikey@neuling.org, mpe@ellerman.id.au, paulus@samba.org,
        pratik.r.sampat@gmail.com,
        Pratik Rajesh Sampat <psampat@linux.ibm.com>,
        svaidy@linux.ibm.com
References: <20200717185306.60607-1-psampat@linux.ibm.com>
        <20200717185306.60607-4-psampat@linux.ibm.com>
In-Reply-To: <20200717185306.60607-4-psampat@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1595203265.suaijimybo.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Pratik Rajesh Sampat's message of July 18, 2020 4:53 am:
> POWER9 onwards the support for the registers HID1, HID4, HID5 has been
> receded.
> Although mfspr on the above registers worked in Power9, In Power10
> simulator is unrecognized. Moving their assignment under the
> check for machines lower than Power9
>=20
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  arch/powerpc/platforms/powernv/idle.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platfor=
ms/powernv/idle.c
> index d439e11af101..d24d6671f3e8 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -73,9 +73,6 @@ static int pnv_save_sprs_for_deep_states(void)
>  	 */
>  	uint64_t lpcr_val	=3D mfspr(SPRN_LPCR);
>  	uint64_t hid0_val	=3D mfspr(SPRN_HID0);
> -	uint64_t hid1_val	=3D mfspr(SPRN_HID1);
> -	uint64_t hid4_val	=3D mfspr(SPRN_HID4);
> -	uint64_t hid5_val	=3D mfspr(SPRN_HID5);
>  	uint64_t hmeer_val	=3D mfspr(SPRN_HMEER);
>  	uint64_t msr_val =3D MSR_IDLE;
>  	uint64_t psscr_val =3D pnv_deepest_stop_psscr_val;
> @@ -117,6 +114,9 @@ static int pnv_save_sprs_for_deep_states(void)
> =20
>  			/* Only p8 needs to set extra HID regiters */
>  			if (!pvr_version_is(PVR_POWER9)) {
> +				uint64_t hid1_val =3D mfspr(SPRN_HID1);
> +				uint64_t hid4_val =3D mfspr(SPRN_HID4);
> +				uint64_t hid5_val =3D mfspr(SPRN_HID5);
> =20
>  				rc =3D opal_slw_set_reg(pir, SPRN_HID1, hid1_val);
>  				if (rc !=3D 0)
> --=20
> 2.25.4
>=20
>=20
