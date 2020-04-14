Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD3DC3815B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF28A2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 18:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586888851;
	bh=Y5f94rGXyvxM7q1IoU22He/0fWYgi6eYHPW6GepYqCY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q4XCtz4eOehgxG64glHCZmpkzScM9bpdYJx+IKdVCtOtKhuoa/4Bnb+RGFN1lmXJV
	 E+j08WRDhpjJE2swsqaojOnCbi74gMWunudjWKy9oB346FoqwYxfygqxSSM68CieIT
	 8VacQGaUNQn47sQyVgdIM0AO2Gjp3Saz2njnenA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503940AbgDNS1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:27:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503938AbgDNS1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 14:27:25 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2507BC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:27:24 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id l11so566418lfc.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=39725/N1RjmePGAGcC5L2gkhHxlD8TbK9gL3md/ZFx8=;
        b=CklwolPhhQ8hL0pe0esgaXAWhzOphc+1ipdU/gtsCdbnIN8BptD7ncJ7Ip2B+9ZNIz
         vFn/n2SF727a3t5AeH8HNVUtkc4iDjzx7d4aFtPu1v6a4Pj2VtCbnLyg/RmKavbz+gss
         DDIxPHkXG5BPEFZw9Xl5Mv4iABaWzzjBotJ0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=39725/N1RjmePGAGcC5L2gkhHxlD8TbK9gL3md/ZFx8=;
        b=Iz4yGtZFIRbIXaiQdsG1VLXO6thJPtAE6oJBJZrK2+VkWJ+6N+OyzSY9InFsddeW3b
         W+OPMxf8fLaaH3K8Bjs/NbLmOY8+KKjy5Izu9Viu0UyOL4JV7ZDcAefidt+O0EUH48T7
         gU4XdSxE529ynXKvw/+OdPU00KQllwxYOFEwtzzYsRInkuH6qFxxs73tH+jW1XCak8ya
         YXtmXvTRPKYaHvHhQjfCG3kjzOgXyHG+TI/iXDM2Z+5IaOIlIo/vIDERHTKmASB6bGTB
         BMXIzPkANdaP5f/OB3eJHQ8ZE/E2FtcBH0ib9YkDVi2HESBvKFoVsJWApcTkn+RMzwuu
         DVZw==
X-Gm-Message-State: AGi0PuYAW/pFgFnp5GKUMGr4PwbGkswEIMJ0lWbna9L6CC5Yuvk5xiTY
        QezZjkLGB04p7R84qHm1go05hQNPcrU=
X-Google-Smtp-Source: APiQypLKjicnaMFs+ZXRHRlZSvO83xliuqdehKb2Bfxxx0/wgrUyjJm6WDhEeW0XEZiTrMePyDxIJQ==
X-Received: by 2002:a19:e049:: with SMTP id g9mr681608lfj.198.1586888841755;
        Tue, 14 Apr 2020 11:27:21 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id s7sm10741834lfb.40.2020.04.14.11.27.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 11:27:20 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id q19so859745ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 11:27:20 -0700 (PDT)
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr859604ljp.204.1586888840289;
 Tue, 14 Apr 2020 11:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <CADDKRnBdM_T1W=iECrt89hmAmbRRyskGhS4d3ozTz1nWj_i_qQ@mail.gmail.com>
 <CAMj1kXGuMjHi=E6cVGGpwrKF_-KXcj0VRcvAdFS_vmwV7PudCQ@mail.gmail.com>
In-Reply-To: <CAMj1kXGuMjHi=E6cVGGpwrKF_-KXcj0VRcvAdFS_vmwV7PudCQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Apr 2020 11:27:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi-s0mmLAVg-aSmNU55=cE8ES7mC=Mc3Wn62P8W9VjY-A@mail.gmail.com>
Message-ID: <CAHk-=wi-s0mmLAVg-aSmNU55=cE8ES7mC=Mc3Wn62P8W9VjY-A@mail.gmail.com>
Subject: Re: Kernel V5.7-rc1 doesn't boot (EFI?)
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 3:50 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> [*] GRUB on x86 turns out not to zero initialize BSS when it invokes
> the EFI stub as a PE/COFF executable

The fix seems to be to put all globals in the .data section, even if
they don't have initializers.

That seems very fragile. Very easy to forget to not declare some
static variable with __efistub_global.

Could we not make the EFI stub code zero out the BSS itself? Perhaps
setting a warning flag (for a later printout) if it wasn't already
zero, so that people could point fingers are buggy loaders..

             Linus
