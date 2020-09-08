Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607F7C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D8832166E
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TR3ZoyMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgIHIyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbgIHIyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:54:47 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E655C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 01:54:46 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id u13so9594307pgh.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 01:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=ex1fX1NtuHc8hEhYz2q3N1DA37jYJdBynWyV2dLsWOI=;
        b=TR3ZoyMeHl9eHSOWfOD8I4Sf7s2fOzVi6PM7Yj8wNN7KwJODMIpaSsYC6Pyn5tDQcH
         q4XnNo9u+LMStIowLNCwRZyQaJi3U7SeEfF5cJmL60TkxZLlpDqK/JQFVafZ9j2L8S0G
         svuCnbDrGvE+QvU2ygTyTZ+PUEbUP1PLvf9T3p0SmUKNbaay9jvhcw+cnAWNaeZfqk3K
         Sq38f2TccO+F38LQ3eQh955iFNcoJdoYHmgCEonBcsolC+jHbvoYupiSw4041bsH15PZ
         ufEnWmrlTt6c4kYjMyC5B5ICRNZBsskzBaCetk7gG0lLKAqLiyg2xQu8SYuULfEG5ulT
         vSaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=ex1fX1NtuHc8hEhYz2q3N1DA37jYJdBynWyV2dLsWOI=;
        b=EToUHFrWtac9jMRkWRgJdg4MC6Xsr7kWEV4D8YRuZjCRBnjFhIBAeCUGWALcSgtdMC
         BgLFwFiXGPasx378+AJ6pa4erw+H93tZ9/jUyqjJZ28DLKt5fGrecdHED2Wa150KW+sb
         sHTp4LALnsUV3cUpoBFp+fcN20agb7w9zsQ4DG0s8msn4t7EHeA9an/6MkcM0mjkBmhO
         XiJpo+yngm4LfJ3AdAj9zqnk2ob9a7qlxmJVZ5aCxfIBIDK0Fdl6cd2KI63+3s38u3vL
         703AgJXLZnpgS4CnWpOvlUFpg0I1Xkf29YF40pQbui8QFs+WOr0m46RRjuNhpu3/BLuO
         gs8w==
X-Gm-Message-State: AOAM5324e89trXId7iY5b3S7YDhiYOg+lEMbPAp7Mg31ZrdIep012vDo
        niWlQuXIV6c+3pVHmPu+Xq8=
X-Google-Smtp-Source: ABdhPJzaH4LSCk2cy2RdfTrz3Men6W3SL6+DCGxwzimSryedVSk8dG5ZkJVIuXI0DvpBEpBnkIFDkQ==
X-Received: by 2002:a63:490f:: with SMTP id w15mr19473095pga.323.1599555285912;
        Tue, 08 Sep 2020 01:54:45 -0700 (PDT)
Received: from localhost ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id p68sm17798313pfb.40.2020.09.08.01.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 01:54:45 -0700 (PDT)
Date:   Tue, 08 Sep 2020 18:54:40 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v1 4/5] powerpc/fault: Avoid heavy
 search_exception_tables() verification
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <7baae4086cbb9ffb08c933b065ff7d29dbc03dd6.1596734104.git.christophe.leroy@csgroup.eu>
        <b07bac7a882c69deb9e6c8f234a68b3022f29072.1596734105.git.christophe.leroy@csgroup.eu>
In-Reply-To: <b07bac7a882c69deb9e6c8f234a68b3022f29072.1596734105.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1599554783.p12klynd6d.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of August 7, 2020 3:15 am:
> search_exception_tables() is an heavy operation, we have to avoid it.
> When KUAP is selected, we'll know the fault has been blocked by KUAP.
> Otherwise, it behaves just as if the address was already in the TLBs
> and no fault was generated.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Sorry I missed reviewing this. Yes, we discussed this and decided
that it's not effective I think (and KUAP solves it properly).

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  arch/powerpc/mm/fault.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 525e0c2b5406..edde169ba3a6 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -214,24 +214,14 @@ static bool bad_kernel_fault(struct pt_regs *regs, =
unsigned long error_code,
>  	if (address >=3D TASK_SIZE)
>  		return true;
> =20
> -	if (!is_exec && (error_code & DSISR_PROTFAULT) &&
> -	    !search_exception_tables(regs->nip)) {
> +	// Read/write fault blocked by KUAP is bad, it can never succeed.
> +	if (bad_kuap_fault(regs, address, is_write)) {
>  		pr_crit_ratelimited("Kernel attempted to access user page (%lx) - expl=
oit attempt? (uid: %d)\n",
> -				    address,
> -				    from_kuid(&init_user_ns, current_uid()));
> -	}
> -
> -	// Fault on user outside of certain regions (eg. copy_tofrom_user()) is=
 bad
> -	if (!search_exception_tables(regs->nip))
> -		return true;
> -
> -	// Read/write fault in a valid region (the exception table search passe=
d
> -	// above), but blocked by KUAP is bad, it can never succeed.
> -	if (bad_kuap_fault(regs, address, is_write))
> +				    address, from_kuid(&init_user_ns, current_uid()));
>  		return true;
> +	}
> =20
> -	// What's left? Kernel fault on user in well defined regions (extable
> -	// matched), and allowed by KUAP in the faulting context.
> +	// What's left? Kernel fault on user and allowed by KUAP in the faultin=
g context.
>  	return false;
>  }
> =20
> --=20
> 2.25.0
>=20
>=20
