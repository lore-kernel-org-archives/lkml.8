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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8B5C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB44215A4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkL9TzTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730083AbgIHIoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729390AbgIHIow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:44:52 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2910C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 01:44:51 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id m8so4268354pgi.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 01:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=PiRn9NwzKohrwBuFF5bFBZNNmANW0xplBGn4HXUwbyY=;
        b=lkL9TzTOhf4dkeNPtCdPcsSlTqHtEC3Af69+imHnsfVc4F94f5/uTawrqMRt05G5Bf
         /qaZ53cp41K2BtaTuxHKI6SIFU2/JREPuLvrJY4NitPTxqv5gYoomX4xuz/gpgJecN3i
         eP28Rkfm6Cy4k3eh7YbN2LMnakrJcXtDXzMGn2OPeG3QPdlbAiFlVPc5etn9ivr941Fs
         SS9pgsRNxYVBWFzJUuDj78/LkJ3c2935s12UMZlGaq4+SOm8gpNG/TtrtZDdh0HwkrZM
         SRzcendWednW5KpWFaKBv4RryDecjCJmJLPB6o6ob39pQvvSgLBSfSkMTgqlEjyUrudF
         NCTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=PiRn9NwzKohrwBuFF5bFBZNNmANW0xplBGn4HXUwbyY=;
        b=TkdE1QqjhHynZJw9aihoHEd8mwMhStcCw4yWItphZIE1R63+ohXyHepZrPTmbZGu/I
         mbJq2ANbb2GFp50OmtF7yeSR5Gpztg5ObBTnB6aNghR/dVOGKKzrSX6zC65tn+EggxQI
         2PEUIa53T51/oO/aGelmp9nRKczS0/1s3vPRJccCRyeaNfSjw85bR6t4/m0VBmt8UCib
         yClA/U56l4duP4QM/lbdDwhI0BSbzAPqGJ7uUHbJTP3GYXUxrpytPQ+xIFYX4lQ8g8mh
         4iAC9IBzWzUwWUP0ygRIUn3mtVf2WT5q92Y9RjXCm/jCr/+pUOrH7YMDabTOUcpZKtss
         KNyA==
X-Gm-Message-State: AOAM533BKQafIRqC27gtcjNA+UFGQfzCtDuSS+mlD5EEpCUh83qwyUjw
        vg2upDIPNhzmIS3DrSztUhA=
X-Google-Smtp-Source: ABdhPJxVM8x5twFdRZ5+HrEYOCxGbZDu70wGmAmIaGeAjbvnI0yPo6twAe3uTH9ciTVhFg1ASQWuUw==
X-Received: by 2002:a63:6d0d:: with SMTP id i13mr19811682pgc.372.1599554691406;
        Tue, 08 Sep 2020 01:44:51 -0700 (PDT)
Received: from localhost ([203.185.249.227])
        by smtp.gmail.com with ESMTPSA id 82sm14468515pgd.6.2020.09.08.01.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 01:44:50 -0700 (PDT)
Date:   Tue, 08 Sep 2020 18:44:45 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v1 2/5] powerpc/fault: Unnest definition of
 page_fault_is_write() and page_fault_is_bad()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <7baae4086cbb9ffb08c933b065ff7d29dbc03dd6.1596734104.git.christophe.leroy@csgroup.eu>
        <4cd127f8988b7b5d3a9b24b67dbad81fef3aee7f.1596734104.git.christophe.leroy@csgroup.eu>
In-Reply-To: <4cd127f8988b7b5d3a9b24b67dbad81fef3aee7f.1596734104.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Message-Id: <1599554667.yx7o7g5m0l.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Christophe Leroy's message of August 7, 2020 3:15 am:
> To make it more readable, separate page_fault_is_write() and page_fault_i=
s_bad()
> to avoir several levels of #ifdefs

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/mm/fault.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 2efa34d7e644..9ef9ee244f72 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -363,17 +363,19 @@ static void sanity_check_fault(bool is_write, bool =
is_user,
>   */
>  #if (defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
>  #define page_fault_is_write(__err)	((__err) & ESR_DST)
> -#define page_fault_is_bad(__err)	(0)
>  #else
>  #define page_fault_is_write(__err)	((__err) & DSISR_ISSTORE)
> -#if defined(CONFIG_PPC_8xx)
> +#endif
> +
> +#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
> +#define page_fault_is_bad(__err)	(0)
> +#elif defined(CONFIG_PPC_8xx)
>  #define page_fault_is_bad(__err)	((__err) & DSISR_NOEXEC_OR_G)
>  #elif defined(CONFIG_PPC64)
>  #define page_fault_is_bad(__err)	((__err) & DSISR_BAD_FAULT_64S)
>  #else
>  #define page_fault_is_bad(__err)	((__err) & DSISR_BAD_FAULT_32S)
>  #endif
> -#endif
> =20
>  /*
>   * For 600- and 800-family processors, the error_code parameter is DSISR
> --=20
> 2.25.0
>=20
>=20
