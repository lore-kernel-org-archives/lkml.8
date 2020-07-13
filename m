Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F47C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC202073A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLpKw3Ti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgGMFwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 01:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgGMFwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 01:52:38 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDF8C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 22:52:38 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gc9so5683468pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 22:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:references:in-reply-to:mime-version:message-id
         :content-transfer-encoding;
        bh=1g5CpkW5g19NH7L4na2u1vVUqGf97lrb2CGDc2dyZx8=;
        b=BLpKw3TiXHTJqBqCZHyHndC9VH1Jk+siRyflMEwA9lfIW0ljPm3z+kua7k8r8h2r9D
         7Q1Ve1mo/2xofyH7xzw9hOM4ZqqVniqUMTC+dt31zz7DvfME7yNN76nb8pPq8ZwwCvkJ
         sz5uZIpZQgaKDu+cwv67kJ3YqZxN6DOYnRKteqU1+mLdMV41m9dxExejibd2JtrldRgx
         GkCcg4TpSA3fuP/isuM8fnEHbQzgmuYxNIHppAJDZstEsp6+C299HBl4lN+oCo1moQy/
         awidGujuoQEcNYbG/dJAv59qkcgBYdvzHhWZZLgmV8fu7oSbu6UtJLxpyJqKED4XFZiU
         Jjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=1g5CpkW5g19NH7L4na2u1vVUqGf97lrb2CGDc2dyZx8=;
        b=pTGol41gQeR1yvVxJSCZvlwcUW9LJaVTWrn+gaC5ti6TeYXHIVuDflmS5AknNGkiAE
         KdRxlUlE1Ov+KBFigdfSSRC2mnTtjZmgLL4Xure18RVMHixxvVF5xM3QreytPT5x6tVM
         kPT8AmK1o3Ts65RfTczkKK3xLwPESSxJQ/XEBzBojBI1/+uo+zkPXGA8J6TV+BOULP12
         S+5eet0mixo1IPVh5Y4z4udms3H0NdN84cUI7kqyErKQC1N2R17Lu+eaNRYQEJi4vvet
         hJAvEz6cvayO1n2FckeSoE05UibA7Fq1+4o+V6GthQ9pltRL8jbd36m3vafZW6qdvqTP
         yetw==
X-Gm-Message-State: AOAM530yHwhmSX8qvQJZYvEh0qINg7Wt6WLgFZ+OrFXjCNRr47RyPGO/
        5c36bn0nqI5lA2OJUWMWzOU=
X-Google-Smtp-Source: ABdhPJzNlN+UTfhJpAjndfBHmIz8UvriuXIlBCDB+iE0tc7L5nG9+29/pVwfDCQeflXXnb0KY3+nhw==
X-Received: by 2002:a17:90a:d314:: with SMTP id p20mr16705888pju.99.1594619558055;
        Sun, 12 Jul 2020 22:52:38 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id o8sm12166432pgb.23.2020.07.12.22.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 22:52:37 -0700 (PDT)
Date:   Mon, 13 Jul 2020 15:52:32 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 2/3] powerpc/powernv/idle: save-restore DAWR0, DAWRX0
 for P10
To:     benh@kernel.crashing.org, ego@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mikey@neuling.org, mpe@ellerman.id.au, paulus@samba.org,
        pratik.r.sampat@gmail.com,
        Pratik Rajesh Sampat <psampat@linux.ibm.com>,
        ravi.bangoria@linux.ibm.com, svaidy@linux.ibm.com
References: <20200710052207.12003-1-psampat@linux.ibm.com>
        <20200710052207.12003-3-psampat@linux.ibm.com>
In-Reply-To: <20200710052207.12003-3-psampat@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1594619458.45vrahx59w.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Pratik Rajesh Sampat's message of July 10, 2020 3:22 pm:
> Additional registers DAWR0, DAWRX0 may be lost on Power 10 for
> stop levels < 4.
> Therefore save the values of these SPRs before entering a  "stop"
> state and restore their values on wakeup.

Hmm, where do you get this from? Documentation I see says DAWR is lost
on POWER9 but not P10.

Does idle thread even need to save DAWR, or does it get switched when
going to a thread that has a watchpoint set?

Thanks,
Nick

>=20
> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/idle.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platfor=
ms/powernv/idle.c
> index 19d94d021357..f2e2a6a4c274 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -600,6 +600,8 @@ struct p9_sprs {
>  	u64 iamr;
>  	u64 amor;
>  	u64 uamor;
> +	u64 dawr0;
> +	u64 dawrx0;
>  };
> =20
>  static unsigned long power9_idle_stop(unsigned long psscr, bool mmu_on)
> @@ -687,6 +689,10 @@ static unsigned long power9_idle_stop(unsigned long =
psscr, bool mmu_on)
>  	sprs.iamr	=3D mfspr(SPRN_IAMR);
>  	sprs.amor	=3D mfspr(SPRN_AMOR);
>  	sprs.uamor	=3D mfspr(SPRN_UAMOR);
> +	if (cpu_has_feature(CPU_FTR_ARCH_31)) {
> +		sprs.dawr0 =3D mfspr(SPRN_DAWR0);
> +		sprs.dawrx0 =3D mfspr(SPRN_DAWRX0);
> +	}
> =20
>  	srr1 =3D isa300_idle_stop_mayloss(psscr);		/* go idle */
> =20
> @@ -710,6 +716,10 @@ static unsigned long power9_idle_stop(unsigned long =
psscr, bool mmu_on)
>  		mtspr(SPRN_IAMR,	sprs.iamr);
>  		mtspr(SPRN_AMOR,	sprs.amor);
>  		mtspr(SPRN_UAMOR,	sprs.uamor);
> +		if (cpu_has_feature(CPU_FTR_ARCH_31)) {
> +			mtspr(SPRN_DAWR0, sprs.dawr0);
> +			mtspr(SPRN_DAWRX0, sprs.dawrx0);
> +		}
> =20
>  		/*
>  		 * Workaround for POWER9 DD2.0, if we lost resources, the ERAT
> --=20
> 2.25.4
>=20
>=20
