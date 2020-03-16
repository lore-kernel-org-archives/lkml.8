Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33AD4C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED7120409
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hcy3ISR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732351AbgCPSWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:22:12 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38476 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732312AbgCPSWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:22:11 -0400
Received: by mail-qt1-f195.google.com with SMTP id e20so15106866qto.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 11:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cQsSz1COC2dmrRLkEbIXNT1K1qMVZomosRljDS+mD6A=;
        b=Hcy3ISR98V336uyttxciTMkX9Vxh+ToWZwB2MTvljw2GGRX7UhN6dSY0+Bf8CMNAi2
         5XcIvIPZfGJOlLs7US4IKc/1TnB+l1NHz4udv3vpv1joRNk2BpvAVR33TrfPC2wJaAoG
         z91Z2zN9R6wZ8bnGtvQAiDx3FfuSqUqv8PoI77kZeqJTBLiJERZNwHGU/TJ3jSQpoiqa
         rEeHSY06RRLLCdRK0ZlOvFlczZawVj5VNnHI6uF1saQU/ymPf3DMbh953pZAGCM3VWjh
         8IptN7djd2P/Hcm+OtbHKsqUYA/2gaxbbmGJi584m0Xxzs89ytE96l4wLBAn7+8enjdg
         DJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cQsSz1COC2dmrRLkEbIXNT1K1qMVZomosRljDS+mD6A=;
        b=k9LIJVVmBDx69YZKSJszm7wnl6W1iecZRCSK7yi/iPTaoQrR62rUxpwVncWrtu8G60
         K3qupHnM8dmXSMFirdQhZgsHONFxZoLwKAbZTafq4ICb+T9Jq6XtUjRBMg+ZR0fYp1HG
         06lIWkVw1ZIGxA+mieHRf1p/oKBOei8moq0bsiHuHYwu+AK6Rj1CwjizID0EsjfNIh/M
         9MRfeXNIEqLSe2ByB9COQURO/ntt7hPVmgQSDY7xB9JNk5U424l1LlI7a4o5SEbtcYLN
         MWZ5wqME/vbq6c4A+NQlivHJ8XLlocmZkp5FZwh1CJHNojL/GkO9/KUzWQguHPDlDyZw
         /GfA==
X-Gm-Message-State: ANhLgQ2h3r3J/rpbxzcL1fdhhwTKH+SepfXs1zBLVNIAabHhEHFfjQNK
        0p4EJCR99i3h7yn+tY2ocfU=
X-Google-Smtp-Source: ADFU+vuf6391otwGeeRyeXLdjSItwv9GfNIidsoLI3ySW06B1xx+1t3vlJw4o7NSK+1i2rdkY808Rg==
X-Received: by 2002:ac8:7a8a:: with SMTP id x10mr1424432qtr.77.1584382930479;
        Mon, 16 Mar 2020 11:22:10 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z43sm352647qtb.92.2020.03.16.11.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 11:22:10 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 16 Mar 2020 14:22:08 -0400
To:     Sergei Trofimovich <slyfox@gentoo.org>
Cc:     linux-kernel@vger.kernel.org, Jakub Jelinek <jakub@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Subject: Re: [PATCH] x86: fix early boot crash on gcc-10
Message-ID: <20200316182206.GA354531@rani.riverdale.lan>
References: <20200314164451.346497-1-slyfox@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200314164451.346497-1-slyfox@gentoo.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 14, 2020 at 04:44:51PM +0000, Sergei Trofimovich wrote:
>  arch/x86/kernel/Makefile | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 9b294c13809a..da9f4ea9bf4c 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -11,6 +11,12 @@ extra-y	+= vmlinux.lds
>  
>  CPPFLAGS_vmlinux.lds += -U$(UTS_MACHINE)
>  
> +# smpboot's init_secondary initializes stack canary.
	       ^^^^ should be start_secondary?
> +# Make sure we don't emit stack checks before it's
> +# initialized.
> +nostackp := $(call cc-option, -fno-stack-protector)
> +CFLAGS_smpboot.o := $(nostackp)
> +
>  ifdef CONFIG_FUNCTION_TRACER
>  # Do not profile debug and lowlevel utilities
>  CFLAGS_REMOVE_tsc.o = -pg
> -- 
> 2.25.1
> 
