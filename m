Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02092C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC462073E
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 20:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ZDPei6NV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgGEUY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 16:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgGEUY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 16:24:29 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1111CC061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 13:24:29 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id w17so58092ply.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 13:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=UNv1FtQw07Y+6DvJhbUM8tkILifRGFFER9tl3Nd2ADQ=;
        b=ZDPei6NVUktCIoayOtsijmugfpSdL6Mw50ZscR1s9Uf48QTfCWbmoFdH3D4GIgRbgq
         AcIG4aNorBcVVpInJYX104kgCKbBw31h1+Jl65z2GRhGMTcZxnfysC5i+6nLEJl6PUxM
         3AN5yYEdXcLgstvrC4Nlgb26Io344c85X6RoizwEAJwm45mXOXnL3XIKvtJeNZ6auJq+
         VkvbO9cqW05DC5xCCewPxwgoVOTt/9+Fc5UxRSaxuRBrfphdZjM6YxDiOL46Xy+QyScT
         OlneAJbxb20KLZUDt8Sc9OmBKpqTZtSnrb//c/fGKGySlCSc++9sQi7RfLO57bVhZUpl
         CwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=UNv1FtQw07Y+6DvJhbUM8tkILifRGFFER9tl3Nd2ADQ=;
        b=pqzaT/TKxUV9suqUVMeoOLbVInynsTUSqoAvjScQ9BNhkBm7LughgV6l6MbC3POFOu
         sC1Ov14OtetZ5QXxA/aJZVYoJuGG5JI2fF7KDfEoBNyrepygLw5jHzN/+ix8AIeskJ4m
         qQ+Q1DZ+Ho0JBEGxUfd4IydjR1AEiLF9b1rwdIOePgLNEucoltwsal5MLPJPv1TPEOTY
         NdSCzWaz3e2uVpTJemqh6PP42o8EYwQrULdBj3fJc6SwlS91Daz3l0KpT0Qf63AcKb8N
         dZq9MdiwUc2PfADfaldeIspISFTVRDZmmOcViVLVUeoG9QngSyAkPPQKF686ueMhmwE3
         Nb+Q==
X-Gm-Message-State: AOAM531A2xrB2HNcbk33YhdH4EMurPoA/IYxDowg6ftJPtkL6ka69/Z0
        76fjy5p+Wt002zvulk/LTThooOA5cUI=
X-Google-Smtp-Source: ABdhPJyLo5wH8V2WQjgDiuLMPrVNDRKLJO8fUuXmr24gc6pMfuxAQAnXCwWrtL0gLRZ/rK08Rxp4pQ==
X-Received: by 2002:a17:90b:380b:: with SMTP id mq11mr12012297pjb.46.1593980668382;
        Sun, 05 Jul 2020 13:24:28 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:b424:f00a:4c70:7a71? ([2601:646:c200:1ef2:b424:f00a:4c70:7a71])
        by smtp.gmail.com with ESMTPSA id r6sm16913281pfl.142.2020.07.05.13.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2020 13:24:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [tip: x86/urgent] x86/entry/32: Fix XEN_PV build dependency
Date:   Sun, 5 Jul 2020 13:24:26 -0700
Message-Id: <5B8B5845-1145-43BC-B790-B1D1A7B42B28@amacapital.net>
References: <159397824429.4006.6604251447325788449.tip-bot2@tip-bot2>
Cc:     linux-tip-commits@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>
In-Reply-To: <159397824429.4006.6604251447325788449.tip-bot2@tip-bot2>
To:     linux-kernel@vger.kernel.org, Juergen Gross <jgross@suse.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 5, 2020, at 12:44 PM, tip-bot2 for Ingo Molnar <tip-bot2@linutronix=
.de> wrote:
>=20
> =EF=BB=BFThe following commit has been merged into the x86/urgent branch o=
f tip:
>=20
> Commit-ID:     a4c0e91d1d65bc58f928b80ed824e10e165da22c
> Gitweb:        https://git.kernel.org/tip/a4c0e91d1d65bc58f928b80ed824e10e=
165da22c
> Author:        Ingo Molnar <mingo@kernel.org>
> AuthorDate:    Sun, 05 Jul 2020 21:33:11 +02:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Sun, 05 Jul 2020 21:39:23 +02:00
>=20
> x86/entry/32: Fix XEN_PV build dependency
>=20
> xenpv_exc_nmi() and xenpv_exc_debug() are only defined on 64-bit kernels,
> but they snuck into the 32-bit build via <asm/identry.h>, causing the link=

> to fail:
>=20
>  ld: arch/x86/entry/entry_32.o: in function `asm_xenpv_exc_nmi':
>  (.entry.text+0x817): undefined reference to `xenpv_exc_nmi'
>=20
>  ld: arch/x86/entry/entry_32.o: in function `asm_xenpv_exc_debug':
>  (.entry.text+0x827): undefined reference to `xenpv_exc_debug'
>=20
> Only use them on 64-bit kernels.

J=C3=BCrgen, can you queue a revert for when PV32 goes away?

>=20
> Fixes: f41f0824224e: ("x86/entry/xen: Route #DB correctly on Xen PV")
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
> arch/x86/include/asm/idtentry.h | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtent=
ry.h
> index eeac6dc..f3d7083 100644
> --- a/arch/x86/include/asm/idtentry.h
> +++ b/arch/x86/include/asm/idtentry.h
> @@ -553,7 +553,7 @@ DECLARE_IDTENTRY_RAW(X86_TRAP_MC,    exc_machine_check=
);
>=20
> /* NMI */
> DECLARE_IDTENTRY_NMI(X86_TRAP_NMI,    exc_nmi);
> -#ifdef CONFIG_XEN_PV
> +#if defined(CONFIG_XEN_PV) && defined(CONFIG_X86_64)
> DECLARE_IDTENTRY_RAW(X86_TRAP_NMI,    xenpv_exc_nmi);
> #endif
>=20
> @@ -563,7 +563,7 @@ DECLARE_IDTENTRY_DEBUG(X86_TRAP_DB,    exc_debug);
> #else
> DECLARE_IDTENTRY_RAW(X86_TRAP_DB,    exc_debug);
> #endif
> -#ifdef CONFIG_XEN_PV
> +#if defined(CONFIG_XEN_PV) && defined(CONFIG_X86_64)
> DECLARE_IDTENTRY_RAW(X86_TRAP_DB,    xenpv_exc_debug);
> #endif
>=20
