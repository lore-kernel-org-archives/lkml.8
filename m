Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4F2C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D642206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 21:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Axf1OEeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgCXVgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 17:36:11 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35215 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgCXVgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 17:36:10 -0400
Received: by mail-qk1-f194.google.com with SMTP id k13so253112qki.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 14:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=93/FB7ol55vSgD/HRCVh2KETeDGi6r4Pd0YQUbdWTlI=;
        b=Axf1OEeXKYY8VzXBqvEWnClgkFMQfiXniMah/2Ndmt7xhh48rFtPi/hyqqO2kWtUOz
         ETePc0n+kom5hAAFV4uWm/4Yg/xX9DZw3Pp4CeNedQIAL1UmMrUX266H+NpBwnkfZqbA
         IFDeTKiyNGkTI5TO5cDkXtspGNnHjpCwWa85w4a2ct1ic/Skf4nuI1xYfmesEVvKEWob
         QLTimHIHpv4NjwIRwg1e3bYiHup/AtU99FIMeEuOxk0DbdwtEwEfUzcdt24z5bBclI4+
         fy1bLIW/cN90NfDTeHZVhHB3i2X7ImiyiclCqzMHyw1hwUbEVrkIRGFzjcarJIUwCy06
         0+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=93/FB7ol55vSgD/HRCVh2KETeDGi6r4Pd0YQUbdWTlI=;
        b=UgCMDkm3XFrfb4hqJNY/qOe+H+UnjNUIFBwVwPqT+B7HFKnqYsV7tIz7xwd4nR3iSy
         fcObrJaPw9iZfbDUWC5UoIi2aThbXmfACHi2B9QVVLTxBtWjteoSd9fSZbRtv5kX1wuh
         E6mhTYvEu413ISiEks1kFWTm2Jtv+3koAoAsA2JNNstccu2W9wmrbgSxZW6vTdGNt43d
         ruOHGyQh5xWaQd6wAuuJuDKUT6D/S3019Hsex/dHRTuISriFiStPzBDs1G2fxzyBs1dN
         vMtaLtRNXYoMAoKC2ZqZ7r9LW0vF+VZK3IfO9RCmGfCDweFVTNMXCyEYM+NqyMYXuXAD
         gXzg==
X-Gm-Message-State: ANhLgQ04ccs8qs4nxzQLNqcFZgh39J3AxlXWRQBUJn5EMre+SdBFOrSM
        MZm0tqE5BYNf+sxGKJI/q08=
X-Google-Smtp-Source: ADFU+vsWqZneu/zBKDWfsCou26DWaJm5UY5OvOCYnFaIh3qlMzhSeB+VjqeTpgeAAeBF/VEbhWEgVg==
X-Received: by 2002:ae9:e892:: with SMTP id a140mr26791587qkg.274.1585085769227;
        Tue, 24 Mar 2020 14:36:09 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id h138sm14101140qke.86.2020.03.24.14.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 14:36:08 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 24 Mar 2020 17:36:07 -0400
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@alien8.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] Documentation/changes: Raise minimum supported binutils
 version to 2.23
Message-ID: <20200324213606.GA3220053@rani.riverdale.lan>
References: <20200114165135.GK31032@zn.tnic>
 <20200115002131.GA3258770@rani.riverdale.lan>
 <20200115122458.GB20975@zn.tnic>
 <20200316160259.GN26126@zn.tnic>
 <20200323204454.GA2611336@zx2c4.com>
 <202003231350.7D35351@keescook>
 <CAK7LNARMBkc666kZ9jOG9sSThzA69JvKi++WZXMtCP9ddyqcBw@mail.gmail.com>
 <CAK7LNARDb4SmQ2Y94CHAzP2qh_Ju7pu-w7kb0XKdP=2P-T+njQ@mail.gmail.com>
 <20200324153847.GA2870597@rani.riverdale.lan>
 <CAK7LNAQeeUt6L7xkk2UHE3v6b0e+iD1cx6_JSrZKEYxt2bEhHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNAQeeUt6L7xkk2UHE3v6b0e+iD1cx6_JSrZKEYxt2bEhHQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 02:31:17AM +0900, Masahiro Yamada wrote:
> On Wed, Mar 25, 2020 at 12:38 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > Which architecture? x86 at least doesn't even build with <= 2.22, but
> > adding workarounds for that shows _text as section-relative (T in nm
> > output).
> 
> 
> The reporter found this for PowerPC,
> but I think this could happen on any architecture.
> 
> https://patchwork.kernel.org/patch/11430243/
> 
> 

Ok, the powerpc linker script defines _text outside any output section,
so it is indeed the same issue as with _etext on x86.
