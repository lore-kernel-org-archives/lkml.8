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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4B8C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E2A0215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orjZ5zvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgIHIq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729993AbgIHIqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:46:21 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248A4C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 01:46:21 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k15so10370224pfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 01:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=iUr/Su9o46jDL8dJ97KU/SAIedxE8wYUU6GmXx2CUe4=;
        b=orjZ5zvYHX979PfoKGpK6WspSuFOTkxwX+tutMgFqQql4M7UyfLeQxMK5lPexMjT95
         ut0MocRiWDV0e0jPYbfYYfuqNmzVPI31yAL6SXg3ItxY3hRT9MoKEAaThjHivXZl5Uby
         I+tt5L/77G4e6MLCU0itxGoXrulmY7LWH9ewfXKrW77ybimd45poRnO/QqTW5nu6rSmV
         On2jwLueoyDZItDZFJGbqt+xk23C+xK2+42z/3wpK4ZgPQcSXYMTO3UoZDpROXy0qJDM
         17XmYsDJoW0aBquPs0QgONe+OebBLtBf7dtVlnfUna13qSd6AjJVIQRGn+DLJqoP58Hb
         138g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=iUr/Su9o46jDL8dJ97KU/SAIedxE8wYUU6GmXx2CUe4=;
        b=dYXf3vIg/jCd+0Sh1xpy87LuSKSjeuuIWjwyAtWjEHJwj91+rE6wG0SyBQzNBvvUdt
         CgfOTfgB0KgsGgyaZJFp4jKESmOtj6/WcWMSveBmAChBsqUYHSvrB31KGi5+VzkHQsgW
         FnYiwhho+CwdhsNpqNuXlrDxqP1SKZA4D3FdP1ZLprZvrUiltPtKCH2K9YIbyrdnGLol
         MrV5QYgN/08H9rSSnhE9AWMJziowOaafaatTJ7KihxwtK2GOyFqxi8Htwp17J44pG6j4
         +jLiSwW3xv7QLn0FnVDPVRDmSwlBdJcWm6PK+DMeJ8AvjP8MMABfMXjwxlO2dRPfEGxg
         JbOQ==
X-Gm-Message-State: AOAM53333W+okDOmxtbbbka/7hWp4PbW3eUZBO9cwPTeaTytw4tPJibM
        SUgwOj82jinPO8uT8i1QpUHmWhxRJLY=
X-Google-Smtp-Source: ABdhPJyOVyOCMnX/Do5FoHS/0+ie/pYHozaQjsvIasZ99RXIt7QLRxoOzJZqK1cCqM7u0UKA66JdPw==
X-Received: by 2002:a17:902:b493:b029:d0:cbe1:e782 with SMTP id y19-20020a170902b493b02900d0cbe1e782mr196976plr.41.1599554780729;
        Tue, 08 Sep 2020 01:46:20 -0700 (PDT)
Received: from localhost ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id e125sm3802182pfe.154.2020.09.08.01.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 01:46:20 -0700 (PDT)
Date:   Tue, 08 Sep 2020 18:46:15 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v1 3/5] powerpc/fault: Reorder tests in bad_kernel_fault()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <7baae4086cbb9ffb08c933b065ff7d29dbc03dd6.1596734104.git.christophe.leroy@csgroup.eu>
        <ef827b73770a7b155079393f8d8430e10a99ec94.1596734104.git.christophe.leroy@csgroup.eu>
In-Reply-To: <ef827b73770a7b155079393f8d8430e10a99ec94.1596734104.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1599554731.otayyrz92r.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of August 7, 2020 3:15 am:
> Check address earlier to simplify the following test.

Good logic reduction.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/mm/fault.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 9ef9ee244f72..525e0c2b5406 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -210,17 +210,17 @@ static bool bad_kernel_fault(struct pt_regs *regs, =
unsigned long error_code,
>  		return true;
>  	}
> =20
> -	if (!is_exec && address < TASK_SIZE && (error_code & DSISR_PROTFAULT) &=
&
> +	// Kernel fault on kernel address is bad
> +	if (address >=3D TASK_SIZE)
> +		return true;
> +
> +	if (!is_exec && (error_code & DSISR_PROTFAULT) &&
>  	    !search_exception_tables(regs->nip)) {
>  		pr_crit_ratelimited("Kernel attempted to access user page (%lx) - expl=
oit attempt? (uid: %d)\n",
>  				    address,
>  				    from_kuid(&init_user_ns, current_uid()));
>  	}
> =20
> -	// Kernel fault on kernel address is bad
> -	if (address >=3D TASK_SIZE)
> -		return true;
> -
>  	// Fault on user outside of certain regions (eg. copy_tofrom_user()) is=
 bad
>  	if (!search_exception_tables(regs->nip))
>  		return true;
> --=20
> 2.25.0
>=20
>=20
