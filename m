Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA24C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABAEF2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u1MGfil8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgGMFxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 01:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgGMFxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 01:53:21 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D27AC061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 22:53:21 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id t11so5520109pfq.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 22:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:references:in-reply-to:mime-version:message-id
         :content-transfer-encoding;
        bh=uecLSSMQGQtX8OytHhkOZFnvFTK3OHFUY42nNLg3ABE=;
        b=u1MGfil8qHxrkbmrq1SmKUEnko9AGmDv47/jmi8HKQ0vphBT/9ulAAQxIbKhnlPyby
         bRiw4T/khixQOpD16g4LZuIn7Ev9omDdAw8P3FfKgBU3iEVGnDupb7JTEtvmWq4+FY2K
         eLvR/rR8SuRLfdW3mxfYUjsXlTvtgBIS1LU2YbkrrfH6rPnWGse8bvwKu3bVNDkSqJDh
         to//Yy9HTPjRcsZL4xshJCJtDvnfjzDEdfs4Up2flgDjCE3QxITLdhs4SHLa9IbZTLiS
         cqPughCR86yg2hcRGdzC6nA1Wdhu/594jlBz78Ak3oVAYu216AzSzr1Zp9WJuzjuysB5
         4hDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=uecLSSMQGQtX8OytHhkOZFnvFTK3OHFUY42nNLg3ABE=;
        b=GMnBU1HMRL67VIzYYoqYJlCqBmxCYIgjb+klK2+Wxmh/WBqNfg7a3suPpGKB5i6hyg
         GxuSWUuSzD9ziGr8kTjd9V3U7cBiLc+8Ex/NQ403tgWitivl3V03RSpqQe8lh61CqSqH
         Mu4o6bLqfbPBvYPwcqGOzTvuB0DzWo72zTwyTXMtjww6fKiIlw+XKgxA3euFdBNp0PKj
         Q6GDVt1TNe+rXFnzjWw+aY5YDoyXlgb3xlDrWVVpXBviaXKLpO3p2hNoU7XawRBXA0BF
         Ja+Y/CEECm+opbNKUYPwpeN1losxJjbnsVKIdxGL5mrMkanNqesMJovzzi634/V/yJeb
         VpLQ==
X-Gm-Message-State: AOAM530E0GBGP1Tm1BirZVB1J8e2ovu7yaDa177FdRux36uJgdbcR7Kk
        tW2TcAp3lbDw1TyglD98Y64=
X-Google-Smtp-Source: ABdhPJzXw0ZbytaGBaYMr9UpjIoCHbbFgUMOxvQbACypUaCUiUauG1Mf/GrpNgizVfWr1PJRjeFKNA==
X-Received: by 2002:a63:3d01:: with SMTP id k1mr65375789pga.71.1594619600683;
        Sun, 12 Jul 2020 22:53:20 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id j16sm12090719pgb.33.2020.07.12.22.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 22:53:20 -0700 (PDT)
Date:   Mon, 13 Jul 2020 15:53:14 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/3] powerpc/powernv/idle: Exclude mfspr on HID1, 4, 5
 on P9 and above
To:     benh@kernel.crashing.org, ego@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mikey@neuling.org, mpe@ellerman.id.au, paulus@samba.org,
        pratik.r.sampat@gmail.com,
        Pratik Rajesh Sampat <psampat@linux.ibm.com>,
        ravi.bangoria@linux.ibm.com, svaidy@linux.ibm.com
References: <20200710052207.12003-1-psampat@linux.ibm.com>
        <20200710052207.12003-2-psampat@linux.ibm.com>
In-Reply-To: <20200710052207.12003-2-psampat@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1594619577.gadjg7e4y7.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Pratik Rajesh Sampat's message of July 10, 2020 3:22 pm:
> POWER9 onwards the support for the registers HID1, HID4, HID5 has been
> receded.
> Although mfspr on the above registers worked in Power9, In Power10
> simulator is unrecognized. Moving their assignment under the
> check for machines lower than Power9

Seems like a good fix.

Thanks,
Nick

>=20
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/idle.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platfor=
ms/powernv/idle.c
> index 2dd467383a88..19d94d021357 100644
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
>  			if (!cpu_has_feature(CPU_FTR_ARCH_300)) {
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
